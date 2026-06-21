-- Problem: Rank Scores
-- URL: https://leetcode.com/problems/rank-scores/
--
-- Task:
-- Rank scores from highest to lowest. Tied scores get the same rank,
-- and there should be no gaps in ranking after a tie (no holes).
--
-- Approach: DENSE_RANK() window function
-- DENSE_RANK() assigns ranks without skipping numbers after ties —
-- this is exactly what's needed here.
--
-- Note: RANK() vs DENSE_RANK()
-- RANK() skips numbers after ties: 1, 1, 3, 4, 4, 6
-- DENSE_RANK() does not skip: 1, 1, 2, 3, 3, 4
-- This problem explicitly requires no gaps, so DENSE_RANK() is correct.
--
-- The ORDER BY inside OVER() determines how ranks are calculated.
-- The ORDER BY outside (after GROUP BY/FROM) determines the display
-- order of the final result — both are needed here.

SELECT 
  score, 
  DENSE_RANK() OVER (ORDER BY score DESC) AS rank
FROM scores
ORDER BY score DESC;