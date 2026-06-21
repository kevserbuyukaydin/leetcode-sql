-- Problem: Managers with at Least 5 Direct Reports
-- URL: https://leetcode.com/problems/managers-with-at-least-5-direct-reports/
--
-- Task:
-- Find managers who have at least 5 employees directly reporting to them.
--
-- Approach: Self JOIN + GROUP BY + HAVING
-- 1. Self JOIN the Employee table to itself — e1 represents the manager,
--    e2 represents employees reporting to that manager (e2.managerId = e1.id).
-- 2. GROUP BY e1.id, e1.name to group all direct reports per manager.
-- 3. COUNT(e2.id) counts how many employees report to each manager.
-- 4. HAVING filters for managers with >= 5 direct reports — this happens
--    after aggregation, so we can use COUNT() in the condition (unlike WHERE).
--
-- Note: LEFT JOIN is used (not INNER JOIN) so that managers with zero
-- reports would still appear in the grouped result with COUNT = 0 —
-- though in practice they get filtered out by HAVING >= 5 anyway.

SELECT
  e1.name
FROM employee e1
LEFT JOIN employee e2
       ON e1.id = e2.managerId
GROUP BY e1.id, e1.name
HAVING COUNT(e2.id) >= 5;