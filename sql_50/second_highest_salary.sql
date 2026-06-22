-- Problem: Second Highest Salary
-- URL: https://leetcode.com/problems/second-highest-salary/
--
-- Task:
-- Find the second highest distinct salary from the Employee table.
-- Return null if there is no second highest salary.
--
-- Note on NULL handling:
-- If no salary is less than the maximum (only one distinct salary exists),
-- MAX() returns NULL automatically — no extra null check needed.

-- ------------------------------------------------------------
-- Approach 1: Subquery in WHERE clause
-- Simple and concise. Inner query finds the max salary,
-- outer query finds the highest salary below that value.

SELECT
  MAX(salary) AS "SecondHighestSalary"
FROM employee
WHERE salary < (SELECT MAX(salary) FROM employee);

-- ------------------------------------------------------------
-- Approach 2: CTE (WITH clause)
-- Separates the max salary calculation into a named CTE.
-- Useful when the subquery needs to be reused or is more complex.
-- Both approaches produce identical results.
--
-- Note: When using multiple tables/CTEs, specify the table name
-- if column names are ambiguous. Here salary and max_sal are
-- unambiguous so no prefix needed.

WITH max_salary AS (
  SELECT MAX(salary) AS max_sal FROM employee
)
SELECT MAX(salary) AS "SecondHighestSalary"
FROM employee, max_salary
WHERE salary < max_sal;