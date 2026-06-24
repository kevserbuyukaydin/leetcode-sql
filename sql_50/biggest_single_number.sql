-- Problem: Biggest Single Number
-- URL: https://leetcode.com/problems/biggest-single-number/
--
-- Task:
-- Find the largest number that appears only once in the table.
-- If no such number exists, return null.
--
-- Approach: Subquery + MAX
-- 1. Inner query finds all numbers appearing exactly once using
--    GROUP BY + HAVING COUNT = 1.
-- 2. Outer query applies MAX() to get the largest single number.
--    If no single numbers exist, MAX() automatically returns NULL —
--    no extra null check needed.
--
-- Note on subquery alias:
-- In PostgreSQL, subqueries in the FROM clause MUST have an alias.
-- 'AS single_numbers' is required — omitting it causes a syntax error.
-- The alias name itself doesn't matter, but it must be present.

SELECT 
  MAX(num) AS num
FROM (
  SELECT num
  FROM mynumbers
  GROUP BY num
  HAVING COUNT(num) = 1
) AS single_numbers;