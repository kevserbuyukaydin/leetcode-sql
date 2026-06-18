-- Problem: Queries Quality and Percentage
-- URL: https://leetcode.com/problems/queries-quality-and-percentage/
--
-- Approach:
-- 1. GROUP BY query_name to calculate metrics per query.
-- 2. Filter out NULL query_name rows with WHERE query_name IS NOT NULL.
-- 3. Calculate quality: AVG(rating / position)
--    rating and position are both integers — integer division would lose decimals.
--    Casting rating to ::numeric ensures decimal division.
-- 4. Calculate poor_query_percentage:
--    COUNT(CASE WHEN rating < 3 THEN 1 END) * 100.0 / COUNT(rating)
--    CASE WHEN returns 1 when rating < 3, otherwise returns NULL (no ELSE needed).
--    COUNT ignores NULL values — so only rows with rating < 3 are counted.
--    If no rows have rating < 3, COUNT returns 0 (not NULL) — result is 0, not NULL.
--    This is a key difference between COUNT and SUM: COUNT always returns 0 for empty sets.
--    Multiplying by 100.0 ensures decimal division.
-- 5. ROUND both values to 2 decimal places.

SELECT
  query_name,
  ROUND(AVG(rating::numeric / position), 2) AS quality,
  ROUND(
    COUNT(CASE WHEN rating < 3 THEN 1 END) * 100.0 / COUNT(rating),
    2
  ) AS poor_query_percentage
FROM queries
WHERE query_name IS NOT NULL
GROUP BY query_name;