-- Problem: Last Person to Fit in the Bus
-- URL: https://leetcode.com/problems/last-person-to-fit-in-the-bus/
--
-- Task:
-- Find the last person who can board the bus without the total weight
-- exceeding 1000 kg. People board in order of their turn.
--
-- Approach: CTE + Window Function (SUM OVER)
-- 1. CTE calculates cumulative weight for each person using
--    SUM(weight) OVER (ORDER BY turn).
--    ORDER BY turn tells PostgreSQL to sum from the first turn
--    up to the current row — this is the default window behavior:
--    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW.
-- 2. Filter cumulative_weight <= 1000 to get all people who can board.
-- 3. ORDER BY total_weight DESC + LIMIT 1 → get the last person.
--
-- Why not use WHERE in the same query as window function?
-- Window functions are computed AFTER WHERE — filtering before
-- the window function would break the cumulative sum calculation.
-- CTE solves this by computing the window first, then filtering.

WITH cumulative AS (
  SELECT
    person_name,
    SUM(weight) OVER (ORDER BY turn) AS total_weight
  FROM queue
)

SELECT 
  person_name
FROM cumulative
WHERE total_weight <= 1000
ORDER BY total_weight DESC
LIMIT 1;