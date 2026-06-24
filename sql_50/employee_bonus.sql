-- Problem: Employee Bonus
-- URL: https://leetcode.com/problems/employee-bonus/
--
-- Task:
-- Find employees whose bonus is less than 1000 or who have no bonus at all.
--
-- Approach: LEFT JOIN + WHERE with NULL check
-- 1. LEFT JOIN Employee with Bonus on empId — keeps all employees,
--    even those with no bonus entry in the Bonus table.
-- 2. WHERE b.bonus < 1000 OR b.bonus IS NULL:
--    - b.bonus < 1000 → employees with a bonus below 1000
--    - b.bonus IS NULL → employees with no bonus record (NULL after LEFT JOIN)
--
-- Note on Foreign Key:
-- Bonus.empId is a foreign key to Employee.empId — this means every empId
-- in Bonus MUST exist in Employee, but NOT every Employee must have a Bonus.
-- This is why LEFT JOIN is needed — INNER JOIN would exclude employees
-- with no bonus entry entirely.
--
-- Note on NULL comparison:
-- WHERE b.bonus < 1000 does NOT catch NULL values —
-- any comparison with NULL returns NULL (neither true nor false).
-- So OR b.bonus IS NULL must be added explicitly.

SELECT 
  e.name,
  b.bonus
FROM employee e
LEFT JOIN bonus b
       ON e.empId = b.empId
WHERE b.bonus < 1000 
   OR b.bonus IS NULL;