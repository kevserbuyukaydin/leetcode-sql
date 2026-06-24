-- Problem: Confirmation Rate
-- URL: https://leetcode.com/problems/confirmation-rate/
--
-- Task:
-- Find the confirmation rate of each user.
-- Confirmation rate = confirmed messages / total messages.
-- Users with no confirmation requests have a rate of 0.
-- Round to 2 decimal places.
--
-- Approach: LEFT JOIN + AVG + CASE WHEN
-- 1. LEFT JOIN Signups with Confirmations on user_id — keeps all users
--    even those with no confirmation requests (NULL rows from Confirmations).
-- 2. CASE WHEN converts each row to:
--    - 1.0 if action = 'confirmed'
--    - 0 if action = 'timeout' OR NULL (user with no requests)
-- 3. AVG calculates the ratio naturally — no need for COUNT separately.
-- 4. ROUND to 2 decimal places.
--
-- Why CASE WHEN instead of FILTER?
-- Users with no requests have NULL action after LEFT JOIN.
-- CASE WHEN handles NULL → 0, so AVG correctly returns 0.00 for them.
-- FILTER would exclude NULL rows entirely, giving wrong results.
--
-- Why 1.0 instead of 1?
-- Using 1.0 (float) ensures decimal division inside AVG.
-- Using integer 1 could cause integer division and lose precision.

SELECT 
  s.user_id,
  ROUND(AVG(CASE WHEN c.action = 'confirmed' THEN 1.0 ELSE 0 END), 2) AS confirmation_rate
FROM signups s
LEFT JOIN confirmations c
       ON s.user_id = c.user_id
GROUP BY s.user_id;