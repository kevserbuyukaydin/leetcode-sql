-- Problem: Project Employees I
-- URL: https://leetcode.com/problems/project-employees-i/
--
-- Approach:
-- 1. JOIN Project with Employee on employee_id.
-- 2. Group by project_id.
-- 3. Calculate AVG(experience_years) for each project.
-- 4. Round to 2 decimal places.
--
-- Notes:
-- AVG in PostgreSQL automatically returns NUMERIC — no need for ::DECIMAL cast.
-- LEFT JOIN and INNER JOIN return the same result here since every employee_id
-- in Project table is guaranteed to exist in Employee table (foreign key constraint).
-- experience_years is guaranteed NOT NULL, so no COALESCE or NULLIF needed.

SELECT
  p.project_id, 
  ROUND(
    AVG(e.experience_years), 
    2
  ) AS average_years
FROM project p
LEFT JOIN employee e
       ON p.employee_id = e.employee_id
GROUP BY p.project_id