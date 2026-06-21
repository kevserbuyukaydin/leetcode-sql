-- Problem: Customers Who Never Order
-- URL: https://leetcode.com/problems/customers-who-never-order/
--
-- Task:
-- Find all customers who never placed any order.
--
-- Approach: LEFT JOIN + WHERE IS NULL
-- 1. LEFT JOIN Customers with Orders on customerId — this keeps ALL
--    customers, even those with no matching order.
-- 2. For customers with no orders, the joined order columns (o.id) will
--    be NULL since there's no match.
-- 3. WHERE o.id IS NULL filters for exactly those customers — the ones
--    who never placed an order.
--
-- Note: If we wanted customers WHO DID order (with INNER JOIN), and a
-- customer has multiple orders, their name would repeat once per order.
-- DISTINCT would be needed to get unique customer names in that case.
-- This isn't an issue here since we're filtering for customers with
-- NO matching rows at all.

SELECT 
  c.name AS customers
FROM customers c
LEFT JOIN orders o
       ON c.id = o.customerId
WHERE o.id IS NULL;