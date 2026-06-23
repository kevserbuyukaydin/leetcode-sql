-- Problem: Monthly Transactions I
-- URL: https://leetcode.com/problems/monthly-transactions-i/
--
-- Task:
-- For each month and country, find:
-- total number of transactions and their total amount,
-- number of approved transactions and their total amount.
--
-- Note on COUNT(id) vs COUNT(*):
-- COUNT(id) ignores NULL id values.
-- COUNT(*) counts all rows regardless of NULL.
-- Since id is a primary key (never NULL), both give the same result here.
-- General rule: use COUNT(*) for row count, COUNT(col) when NULLs matter.

-- ------------------------------------------------------------
-- Approach 1: FILTER (recommended)
-- Time: O(n) | Most readable and efficient PostgreSQL approach.
-- FILTER is PostgreSQL-specific but cleaner than CASE WHEN.
-- COALESCE handles two NULL scenarios:
-- 1. No approved transactions in the group → FILTER finds no rows → SUM returns NULL
-- 2. All approved transaction amounts are NULL → SUM returns NULL
--    (SUM ignores individual NULLs but returns NULL when ALL values are NULL)
-- In both cases, COALESCE converts NULL to 0.

SELECT
  TO_CHAR(trans_date, 'YYYY-MM') AS month,
  country,
  COUNT(id) AS trans_count,
  COUNT(*) FILTER (WHERE state = 'approved') AS approved_count,
  SUM(amount) AS trans_total_amount,
  COALESCE(SUM(amount) FILTER (WHERE state = 'approved'), 0) AS approved_total_amount
FROM transactions
GROUP BY 
  TO_CHAR(trans_date, 'YYYY-MM'), country
ORDER BY
  month ASC;

-- ------------------------------------------------------------
-- Approach 2: CASE WHEN
-- More portable across different SQL dialects (MySQL, SQLite, etc.)
-- SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) always returns
-- 0 instead of NULL when no approved rows exist — COALESCE not needed
-- for approved_count. But kept for approved_total_amount consistency.
--
-- FILTER vs CASE WHEN:
-- FILTER → PostgreSQL only, faster, cleaner
-- CASE WHEN → works in all SQL dialects, more verbose

SELECT
  TO_CHAR(trans_date, 'YYYY-MM') AS month,
  country,
  COUNT(id) AS trans_count,
  SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) AS approved_count,
  SUM(amount) AS trans_total_amount,
  COALESCE(SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END), 0) AS approved_total_amount
FROM transactions
GROUP BY 
  TO_CHAR(trans_date, 'YYYY-MM'), country
ORDER BY
  month ASC;