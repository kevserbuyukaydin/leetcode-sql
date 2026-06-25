-- Problem: Triangle Judgement
-- URL: https://leetcode.com/problems/triangle-judgement/
--
-- Task:
-- For each row, determine if the three line segments can form a triangle.
--
-- Approach: CASE WHEN
-- Triangle rule: each side must be less than the sum of the other two.
--   x + y > z
--   x + z > y
--   y + z > x
-- All three conditions must be true simultaneously → use AND.
-- If any condition fails → not a triangle.

SELECT 
  x,
  y,
  z,
  CASE 
    WHEN x + y > z 
     AND x + z > y 
     AND y + z > x 
    THEN 'Yes'
    ELSE 'No'
  END AS triangle
FROM triangle;