-- Problem: Find Followers Count
-- URL: https://leetcode.com/problems/find-followers-count/
--
-- Task:
-- For each user, return the number of followers.
-- Order by user_id ascending.
--
-- Approach: GROUP BY + COUNT
-- Simple aggregation — group by user_id and count follower_ids.
-- (user_id, follower_id) is the primary key so no duplicates exist,
-- COUNT(follower_id) and COUNT(*) give the same result here.

SELECT 
  user_id,
  COUNT(follower_id) AS followers_count
FROM followers
GROUP BY user_id
ORDER BY user_id ASC;