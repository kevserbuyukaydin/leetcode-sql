-- Problem: Fix Names in a Table
-- URL: https://leetcode.com/problems/fix-names-in-a-table/
--
-- Task:
-- Fix user names so only the FIRST character of the entire name
-- is uppercase and the rest are lowercase.
--
-- Note on INITCAP:
-- INITCAP capitalizes the first letter of EACH word — not just the first.
-- Example: 'MaRRy aNN' → INITCAP → 'Marry Ann' (expected: 'Marry ann')
-- So INITCAP is NOT suitable for this problem.
--
-- Correct approach: SUBSTRING to split first character and the rest,
-- then UPPER/LOWER for casing, then concatenate.

-- ------------------------------------------------------------
-- Approach 1: || (string concatenation operator)
-- Native PostgreSQL operator for string concatenation.
-- SUBSTRING(name, 1, 1) → first character → UPPER
-- SUBSTRING(name, 2)    → from second character to end → LOWER

SELECT 
  user_id,
  UPPER(SUBSTRING(name, 1, 1)) || LOWER(SUBSTRING(name, 2)) AS name
FROM users
ORDER BY user_id;

-- ------------------------------------------------------------
-- Approach 2: CONCAT function
-- Same logic as Approach 1 but using CONCAT() instead of ||.
-- More readable for those unfamiliar with || operator.

SELECT 
  user_id,
  CONCAT(
    UPPER(SUBSTRING(name, 1, 1)),
    LOWER(SUBSTRING(name, 2))
  ) AS name
FROM users
ORDER BY user_id;