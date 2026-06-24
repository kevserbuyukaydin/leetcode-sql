-- Problem: Students and Examinations
-- URL: https://leetcode.com/problems/students-and-examinations/
--
-- Task:
-- Find the number of times each student attended each exam.
-- Every student-subject combination must appear, even with 0 attendances.
--
-- Approach: CROSS JOIN + LEFT JOIN
-- 1. CROSS JOIN Students with Subjects — creates every possible
--    student-subject combination (e.g. 3 students × 3 subjects = 9 rows).
-- 2. LEFT JOIN Examinations on BOTH student_id AND subject_name —
--    both conditions are required. Only student_id would incorrectly
--    match a student's Physics row with their Math exam entry.
-- 3. COUNT(e.student_id) — counts only non-NULL values.
--    If student didn't attend, e.student_id is NULL → counted as 0.
--    COUNT(*) would count NULL rows as 1 → incorrect.
-- 4. SELECT subj.subject_name (not e.subject_name) — e.subject_name
--    is NULL when student didn't attend, subj.subject_name is always filled.
-- 5. GROUP BY student_id, student_name, subj.subject_name.
--    student_name must be in GROUP BY even though student_id is unique —
--    PostgreSQL requires all non-aggregate SELECT columns in GROUP BY.

SELECT
  st.student_id,
  st.student_name,
  subj.subject_name,
  COUNT(e.student_id) AS attended_exams
FROM students st
CROSS JOIN subjects subj
LEFT JOIN examinations e
       ON st.student_id = e.student_id
       AND subj.subject_name = e.subject_name
GROUP BY st.student_id, st.student_name, subj.subject_name;