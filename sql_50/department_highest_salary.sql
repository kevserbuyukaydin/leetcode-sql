-- Problem: Department Highest Salary
-- URL: https://leetcode.com/problems/department-highest-salary/
--
-- Task:
-- Find employees who have the highest salary in each department.
-- If multiple employees share the highest salary in a department,
-- all of them should be included.
--
-- Approach: DENSE_RANK() with PARTITION BY + CTE
-- 1. JOIN Employee and Department tables.
-- 2. Use DENSE_RANK() with PARTITION BY departmentId to rank salaries
--    within each department separately — rank resets to 1 for each
--    new department.
-- 3. Wrap this in a CTE (WITH clause) so we can filter on the rank
--    afterward. DENSE_RANK() is only used for filtering, not displayed
--    in the final output — that's why we need a CTE/subquery to
--    separate the ranking calculation from the final SELECT.
-- 4. Filter for salary_rank = 1 to get the highest earner(s) per department.
--
-- Note: GROUP BY + MAX(salary) alone would only give the salary value,
-- not which employee(s) earned it — especially problematic when multiple
-- employees tie for the highest salary. DENSE_RANK() solves this by
-- keeping each employee as a separate row while ranking them.

WITH ranked_salaries AS (
  SELECT 
    d.name AS department,
    e.name AS employee,
    e.salary AS salary,
    DENSE_RANK() OVER (PARTITION BY e.departmentId ORDER BY e.salary DESC) AS salary_rank
  FROM employee e
  INNER JOIN department d
          ON e.departmentId = d.id
)

SELECT 
  department, 
  employee, 
  salary
FROM ranked_salaries
WHERE salary_rank = 1;