-- Problem: The Number of Employees Which Report to Each Employee
-- URL: https://leetcode.com/problems/the-number-of-employees-which-report-to-each-employee/
--
-- Task:
-- Find all managers (employees with at least 1 direct report),
-- their report count, and the average age of their reports rounded
-- to the nearest integer.
--
-- Approach: Self JOIN + GROUP BY
-- 1. Self JOIN Employees table — e1 = manager, e2 = employee reporting to e1.
--    (e2.reports_to = e1.employee_id)
-- 2. INNER JOIN automatically excludes employees with no reports
--    (no matching rows in e2).
-- 3. GROUP BY e1.employee_id, e1.name — group by both since name must
--    be in GROUP BY or aggregate function. Since each employee_id has
--    exactly one name, adding name to GROUP BY is safe and clean.
-- 4. COUNT(e2.employee_id) → number of direct reports per manager.
-- 5. ROUND(AVG(e2.age)) → average age rounded to nearest integer.
--    ROUND with no decimal argument defaults to 0 decimal places.

SELECT 
  e1.employee_id,
  e1.name,
  COUNT(e2.employee_id) AS reports_count,
  ROUND(AVG(e2.age)) AS average_age
FROM employees e1
INNER JOIN employees e2
        ON e1.employee_id = e2.reports_to
GROUP BY e1.employee_id, e1.name
ORDER BY e1.employee_id ASC;