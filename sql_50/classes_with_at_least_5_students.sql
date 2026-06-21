-- Problem: Classes With at Least 5 Students
-- URL: https://leetcode.com/problems/classes-with-at-least-5-students/
--
-- Task:
-- Find all classes that have at least 5 students enrolled.
--
-- Approach: GROUP BY + HAVING
-- 1. GROUP BY class to group all students by their class.
-- 2. COUNT(student) counts how many students are in each class.
-- 3. HAVING filters groups AFTER aggregation — this is the key concept.
--
-- WHERE vs HAVING:
-- WHERE filters individual rows BEFORE aggregation happens.
-- HAVING filters GROUPS after aggregation (GROUP BY) has been applied.
-- We can't use WHERE here because COUNT(student) doesn't exist until
-- after grouping — WHERE COUNT(student) >= 5 would fail because WHERE
-- runs before COUNT is calculated.
--
-- Note: "at least 5" means >= 5, not > 5 (which would exclude classes
-- with exactly 5 students).

SELECT
  class
FROM courses
GROUP BY class
HAVING COUNT(student) >= 5;