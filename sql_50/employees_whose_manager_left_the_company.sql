-- Problem: Employees Whose Manager Left the Company
-- URL: https://leetcode.com/problems/employees-whose-manager-left-the-company/
--
-- Task:
-- Find employees with salary < 30000 whose manager left the company.
-- A manager left if their employee_id no longer exists in the table,
-- but the employee still has their manager_id set.
--
-- Approach: Self LEFT JOIN + IS NULL check
-- 1. LEFT JOIN Employees with itself — e1 = employee, e2 = manager.
--    e2 will be NULL if the manager no longer exists in the table.
-- 2. WHERE e1.salary < 30000 → salary condition.
-- 3. AND e1.manager_id IS NOT NULL → excludes employees who never had
--    a manager (manager_id = NULL). These are different from employees
--    whose manager LEFT — they simply never had one.
-- 4. AND e2.employee_id IS NULL → manager_id exists but no matching
--    row in the table → manager left the company.
--
-- Why LEFT JOIN instead of NOT IN?
-- NOT IN can produce unexpected results when manager_id contains NULL
-- values — any comparison with NULL returns NULL (not true/false).
-- LEFT JOIN + IS NULL handles NULL safely.

SELECT
  e1.employee_id
FROM employees e1
LEFT JOIN employees e2
       ON e1.manager_id = e2.employee_id
WHERE e1.salary < 30000
  AND e1.manager_id IS NOT NULL
  AND e2.employee_id IS NULL
ORDER BY e1.employee_id ASC;