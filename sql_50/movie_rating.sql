-- Problem: Movie Rating
-- URL: https://leetcode.com/problems/movie-rating/
--
-- Task:
-- 1. Find the user who rated the most movies (alphabetically smaller on tie).
-- 2. Find the movie with the highest average rating in February 2020
--    (alphabetically smaller on tie).
-- Return both results in a single column named 'results'.
--
-- Approach: Two separate queries combined with UNION ALL
-- Each query uses GROUP BY + ORDER BY with aggregate functions.
-- UNION ALL (not UNION) is used since the two results are different
-- types (user name vs movie title) — no duplicate concern.
--
-- Why parentheses around each query?
-- When using ORDER BY + LIMIT inside UNION, each subquery must be
-- wrapped in parentheses — otherwise PostgreSQL can't parse correctly.
--
-- Note on UNION column naming:
-- In UNION, the column name is taken from the FIRST query.
-- 'AS results' only needs to be specified in the first SELECT —
-- the second query's column name is ignored.
--
-- Note on ORDER BY with aggregate functions:
-- ORDER BY COUNT(*) and ORDER BY AVG(r.rating) can be used directly
-- without aliasing — PostgreSQL allows aggregate functions in ORDER BY.

(
  SELECT
    u.name AS results
  FROM movierating r
  LEFT JOIN users u
         ON r.user_id = u.user_id
  GROUP BY r.user_id, u.name
  ORDER BY COUNT(*) DESC, u.name ASC
  LIMIT 1
)
UNION ALL
(
  SELECT
    m.title
  FROM movierating r
  LEFT JOIN movies m
         ON r.movie_id = m.movie_id
  WHERE EXTRACT(YEAR FROM r.created_at) = 2020
    AND EXTRACT(MONTH FROM r.created_at) = 2
  GROUP BY r.movie_id, m.title
  ORDER BY AVG(r.rating) DESC, m.title ASC
  LIMIT 1
);