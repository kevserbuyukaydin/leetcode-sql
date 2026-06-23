-- Problem: Duplicate Emails
-- URL: https://leetcode.com/problems/duplicate-emails/
--
-- Task:
-- Find all duplicate emails in the Person table.
--
-- Performance comparison (best to worst):
-- 1. GROUP BY + HAVING → most efficient, single pass
-- 2. Subquery (IN)     → slightly less efficient, runs subquery separately
-- 3. Self JOIN         → least efficient here, produces duplicate rows
--                        requiring DISTINCT to clean up

-- ------------------------------------------------------------
-- Approach 1: GROUP BY + HAVING (recommended)
-- Time: O(n) | Most efficient approach.
-- Groups emails and filters those appearing more than once.
-- No DISTINCT needed — GROUP BY already returns each email once.
--
-- Note: COUNT(email) is used instead of COUNT(*) —
-- COUNT(*) would count NULL values too, COUNT(email) ignores them.
-- (Though email is guaranteed NOT NULL here, it's a good habit.)

SELECT 
  email AS "Email"
FROM person
GROUP BY email
HAVING COUNT(email) > 1;

-- ------------------------------------------------------------
-- Approach 2: Subquery with IN
-- Inner subquery finds duplicate emails (GROUP BY returns each once).
-- Outer query fetches all rows matching those emails from the full table —
-- this is why DISTINCT is needed: a@b.com appears twice in person table,
-- both rows match IN condition, so without DISTINCT it would appear twice.

SELECT 
  DISTINCT email AS "Email"
FROM person
WHERE email IN (
  SELECT email
  FROM person
  GROUP BY email
  HAVING COUNT(email) > 1
);

-- ------------------------------------------------------------
-- Approach 3: Self JOIN
-- Join the table with itself on same email but different id.
-- p1.id=1 matches p2.id=3, AND p1.id=3 matches p2.id=1 —
-- same pair produces two rows, so DISTINCT is required.
-- Less efficient than GROUP BY for this use case.

SELECT 
  DISTINCT p1.email AS "Email"
FROM person p1
INNER JOIN person p2
        ON p1.email = p2.email
       AND p1.id != p2.id;