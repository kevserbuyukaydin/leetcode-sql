-- Problem: Employees Earning More Than Their Managers
-- URL: https://leetcode.com/problems/employees-earning-more-than-their-managers/
--
-- Task:
-- Find employees who earn more than their managers.
--
-- Note: managerId can be NULL (employees with no manager).
-- INNER JOIN automatically excludes NULL managerId rows —
-- no extra NULL check needed.

-- ------------------------------------------------------------
-- Approach 1: Self JOIN
-- Join the Employee table with itself.
-- e1 = employee, e2 = manager (e1.managerId = e2.id)
-- Filter directly in JOIN condition with e1.salary > e2.salary.
--
-- Performance: Generally faster — database processes both tables
-- together in a single pass.

SELECT 
  e1.name AS "Employee"
FROM employee e1
INNER JOIN employee e2
        ON e1.managerId = e2.id 
       AND e1.salary > e2.salary;

-- ------------------------------------------------------------
-- Approach 2: Correlated Subquery
-- For each employee row, a subquery fetches the manager's salary
-- and compares it with the employee's salary.
--
-- Performance: Slower on large tables — the subquery runs once
-- for EACH row in the outer query (correlated subquery).
-- Self JOIN is preferred for better performance.

SELECT 
  name AS "Employee"
FROM employee e1
WHERE salary > (
  SELECT 
    salary 
  FROM employee 
  WHERE id = e1.managerId
);