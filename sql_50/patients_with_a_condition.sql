-- Problem: Patients With a Condition
-- URL: https://leetcode.com/problems/patients-with-a-condition/
--
-- Task:
-- Find patients who have Type I Diabetes (condition starts with DIAB1).
-- conditions column contains space-separated codes (e.g. "DIAB100 MYOP").
--
-- Approach: LIKE pattern matching
-- DIAB1 can appear at the start of the string OR after a space
-- (since conditions can contain multiple codes separated by spaces).
--
-- conditions LIKE 'DIAB1%'   → matches when DIAB1 is the FIRST code
-- conditions LIKE '% DIAB1%' → matches when DIAB1 appears after a space
--                              (i.e., not the first code in the string)
--
-- Why both conditions are needed:
-- "DIAB100 MYOP" → matches first pattern (starts with DIAB1)
-- "ACNE DIAB100" → matches second pattern (DIAB1 after a space)
-- Using only 'DIAB1%' would miss "ACNE DIAB100".
-- Using only '%DIAB1%' (no space) would incorrectly match codes like
-- "XDIAB100" where DIAB1 is a substring but not a separate code.
--
-- Note: explicit column names are used instead of SELECT * —
-- better practice for readability and resilience to schema changes,
-- though performance difference here is negligible since all columns
-- are needed anyway.

SELECT 
  patient_id,
  patient_name,
  conditions
FROM patients 
WHERE conditions LIKE 'DIAB1%'   
   OR conditions LIKE '% DIAB1%';