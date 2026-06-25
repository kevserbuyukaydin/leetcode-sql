-- Problem: Count Salary Categories
-- URL: https://leetcode.com/problems/count-salary-categories/
--
-- Task:
-- Count the number of bank accounts in each salary category.
-- All three categories must appear in the result, even with 0 accounts.
--
-- Approach: UNION ALL with FILTER
-- Three separate queries, one per category, combined with UNION ALL.
-- UNION ALL (not UNION) is used because:
--   - There are no duplicate rows between queries
--   - UNION ALL is faster — no duplicate checking needed
--
-- Why FILTER instead of CASE WHEN + COUNT?
-- COUNT(CASE WHEN condition THEN 1 ELSE 0 END) counts ALL rows
-- because ELSE 0 returns 0 (not NULL), and COUNT counts 0 as a value.
-- COUNT(*) FILTER (WHERE condition) only counts matching rows — correct!
--
-- Why hardcoded category strings?
-- 'Low Salary' AS category creates a constant value column.
-- This ensures all three categories always appear in the result,
-- even when no accounts exist in that category (COUNT returns 0).

SELECT 
  'Low Salary' AS category, 
  COUNT(*) FILTER (WHERE income < 20000) AS accounts_count
FROM accounts

UNION ALL

SELECT 
  'Average Salary' AS category, 
  COUNT(*) FILTER (WHERE income BETWEEN 20000 AND 50000) AS accounts_count
FROM accounts

UNION ALL

SELECT 
  'High Salary' AS category, 
  COUNT(*) FILTER (WHERE income > 50000) AS accounts_count
FROM accounts;