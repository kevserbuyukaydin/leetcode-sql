-- Problem: Group Sold Products By The Date
-- URL: https://leetcode.com/problems/group-sold-products-by-the-date/
--
-- Task:
-- For each sell_date, find the number of different products sold
-- and their names sorted lexicographically, separated by commas.
--
-- Approach: GROUP BY + STRING_AGG
-- 1. GROUP BY sell_date → group all sales by date.
-- 2. COUNT(DISTINCT product) → count unique products per date.
-- 3. STRING_AGG(DISTINCT product, ',' ORDER BY product ASC) →
--    concatenates unique product names into a comma-separated string,
--    sorted alphabetically — all in a single function call.
--
-- Why STRING_AGG is the best approach here:
-- It handles DISTINCT, sorting, and concatenation in one step.
-- Alternative: ARRAY_AGG + ARRAY_TO_STRING — more verbose, less readable.
-- STRING_AGG is PostgreSQL-specific but cleaner for this use case.

SELECT 
  sell_date,
  COUNT(DISTINCT product) AS num_sold,
  STRING_AGG(DISTINCT product, ',' ORDER BY product ASC) AS products
FROM activities
GROUP BY sell_date
ORDER BY sell_date;