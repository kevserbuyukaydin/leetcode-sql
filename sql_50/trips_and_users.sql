-- Problem: Trips and Users (Taxi Cancellation Rate)
-- URL: https://leetcode.com/problems/trips-and-users/
--
-- Task:
-- Find the cancellation rate of requests with unbanned users each day
-- between 2013-10-01 and 2013-10-03. Round to 2 decimal places.
--
-- Key points:
-- Both client AND driver must be unbanned.
-- Users table is joined TWICE — once for client, once for driver.
-- Cancellation = status LIKE 'cancelled%' (cancelled_by_driver or cancelled_by_client)
--
-- Why LEFT JOIN but filter with WHERE banned = 'No'?
-- LEFT JOIN keeps all trips initially, then WHERE filters out banned users.
-- Could also use INNER JOIN since we're filtering anyway — same result here.

-- ------------------------------------------------------------
-- Approach 1: FILTER + COUNT (PostgreSQL-specific)
-- COUNT(*) FILTER counts only cancelled trips.
-- Dividing by COUNT(*) gives cancellation rate.
-- ::numeric cast ensures decimal division.

SELECT
  t.request_at AS "Day",
  ROUND(
    COUNT(*) FILTER (WHERE t.status LIKE 'cancelled%')::numeric / COUNT(*),
    2
  ) AS "Cancellation Rate"
FROM trips t
LEFT JOIN users cl ON t.client_id = cl.users_id
LEFT JOIN users dr ON t.driver_id = dr.users_id
WHERE cl.banned = 'No'
  AND dr.banned = 'No'
  AND t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY t.request_at;

-- ------------------------------------------------------------
-- Approach 2: AVG + CASE WHEN (recommended, more portable)
-- AVG automatically divides by the number of rows in the group —
-- no need to write COUNT(*) as denominator separately.
-- CASE WHEN returns 1.0 for cancelled, 0 for completed.
-- ELSE 0 is important: without it, completed rows return NULL,
-- and AVG(NULL, NULL) = NULL instead of 0.00.
--
-- AVG(1.0, 0, 0) = 0.33
-- AVG(NULL, 0, 0) = 0.00  (NULL ignored) — but result still correct here
-- AVG(NULL, NULL, NULL) = NULL — this is why ELSE 0 matters

SELECT
  t.request_at AS "Day",
  ROUND(
    AVG(CASE WHEN t.status LIKE 'cancelled%' THEN 1.0 ELSE 0 END),
    2
  ) AS "Cancellation Rate"
FROM trips t
LEFT JOIN users cl ON t.client_id = cl.users_id
LEFT JOIN users dr ON t.driver_id = dr.users_id
WHERE cl.banned = 'No'
  AND dr.banned = 'No'
  AND t.request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY t.request_at;