-- Problem: Percentage of Users Attended a Contest
-- URL: https://leetcode.com/problems/percentage-of-users-attended-a-contest/
--
-- Approach 1: LEFT JOIN with Users table
-- Joining Register with Users, grouping by contest_id and calculating percentage.
-- Note: INNER JOIN would also work here since every user_id in Register
-- is guaranteed to exist in Users table.
--
-- Percentage formula: COUNT(user_id) * 100.0 / total_users
-- Multiplying by 100.0 (float literal) ensures decimal division automatically —
-- no need for ::NUMERIC or ::DECIMAL cast.
-- If 100 (integer) were used instead, integer division would occur and decimals would be lost.

SELECT 
  r.contest_id,
  ROUND(COUNT(r.user_id) * 100.0 / (SELECT COUNT(*) FROM users), 2) AS percentage
FROM register r
LEFT JOIN users u
       ON r.user_id = u.user_id
GROUP BY r.contest_id  
ORDER BY percentage DESC, r.contest_id ASC;

-- ------------------------------------------------------------

-- Approach 2: Without JOIN
-- Since Register table already contains user_id, JOIN is unnecessary.
-- Only Register table is sufficient.

SELECT 
  contest_id,
  ROUND(COUNT(user_id) * 100.0 / (SELECT COUNT(*) FROM users), 2) AS percentage
FROM register
GROUP BY contest_id  
ORDER BY percentage DESC, contest_id ASC;