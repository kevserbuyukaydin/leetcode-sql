-- Problem: List the Products Ordered in a Period
-- URL: https://leetcode.com/problems/list-the-products-ordered-in-a-period/
--
-- Task:
-- Find products with at least 100 units ordered in February 2020.
--
-- Approach: INNER JOIN + EXTRACT + GROUP BY + HAVING
-- 1. INNER JOIN Products with Orders on product_id.
-- 2. WHERE with EXTRACT filters only February 2020 orders.
--    EXTRACT is preferred over BETWEEN for month filtering —
--    no need to know the exact number of days in the month.
-- 3. GROUP BY product_id, product_name — product_name must be included
--    since it's in SELECT but not an aggregate function.
-- 4. SUM(o.unit) → total units ordered per product.
-- 5. HAVING SUM(o.unit) >= 100 → filters after aggregation.
--    WHERE cannot be used here since COUNT/SUM don't exist until after GROUP BY.
-- 6. ORDER BY unit ASC → sort by total units ascending.

SELECT 
  p.product_name,
  SUM(o.unit) AS unit
FROM products p
INNER JOIN orders o
        ON p.product_id = o.product_id
WHERE EXTRACT(YEAR FROM o.order_date) = 2020
  AND EXTRACT(MONTH FROM o.order_date) = 2
GROUP BY p.product_id, p.product_name
HAVING SUM(o.unit) >= 100
ORDER BY unit ASC;