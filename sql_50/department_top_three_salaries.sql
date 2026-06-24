-- Problem: Department Top Three Salaries
-- URL: https://leetcode.com/problems/department-top-three-salaries/
--
-- Task:
-- Find employees who earn one of the top 3 unique salaries in their department.
-- Multiple employees with the same salary all qualify.
--
-- Approach: CTE + DENSE_RANK() with PARTITION BY
-- 1. CTE calculates DENSE_RANK() for each employee within their department.
--    PARTITION BY departmentId → rank resets to 1 for each department.
--    ORDER BY salary DESC → highest salary gets rank 1.
--    DENSE_RANK() vs RANK(): DENSE_RANK() doesn't skip ranks after ties.
--    Example: 90000=1, 85000=2, 85000=2, 70000=3 (not 4)
-- 2. WHERE salary_rank <= 3 filters top 3 unique salary levels.
-- 3. LEFT JOIN keeps all employees — even those whose department
--    might not exist in Department table (though unlikely with FK).
--
-- Why CTE is needed:
-- Window functions are computed AFTER WHERE — so we cannot write
-- WHERE salary_rank <= 3 directly in the same query.
-- CTE (or subquery) lets us filter on the computed rank.
--
-- Alternative approach: correlated subquery (without DENSE_RANK):
-- WHERE (SELECT COUNT(DISTINCT e2.salary) FROM employee e2
--        WHERE e2.departmentId = e.departmentId
--        AND e2.salary >= e.salary) <= 3
-- This works but is slower — subquery runs once per row.

WITH ranked_salaries AS (
  SELECT 
    d.name AS department,
    e.name AS employee,
    e.salary,
    DENSE_RANK() OVER (
        PARTITION BY departmentId
        ORDER BY salary DESC
    ) AS salary_rank
  FROM employee e
  LEFT JOIN department d
         ON e.departmentId = d.id
)

SELECT 
  department,
  employee,
  salary
FROM ranked_salaries
WHERE salary_rank <= 3
ORDER BY department, salary DESC;