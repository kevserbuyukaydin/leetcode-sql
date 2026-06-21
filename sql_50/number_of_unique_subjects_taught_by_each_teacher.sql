-- Problem: Number of Unique Subjects Taught by Each Teacher
-- URL: https://leetcode.com/problems/number-of-unique-subjects-taught-by-each-teacher/
--
-- Task:
-- Calculate the number of unique subjects each teacher teaches.
--
-- Approach: GROUP BY + COUNT(DISTINCT)
-- 1. GROUP BY teacher_id to group all rows per teacher.
-- 2. COUNT(DISTINCT subject_id) counts only unique subject_ids per teacher —
--    this matters because a teacher can teach the same subject in
--    multiple departments, and that should only count once.
-- 3. ORDER BY cnt DESC sorts by the alias directly (no need to repeat
--    the full COUNT expression).
--
-- Example: Teacher 1 teaches subject 2 in both dept 3 and dept 4 —
-- without DISTINCT, this would be counted twice. COUNT(DISTINCT subject_id)
-- correctly counts it once.

SELECT 
  teacher_id,
  COUNT(DISTINCT subject_id) AS cnt
FROM teacher
GROUP BY teacher_id
ORDER BY cnt DESC;