-- Problem: Customers Who Bought All Products
-- URL: https://leetcode.com/problems/customers-who-bought-all-products/
--
-- Task:
-- Find customer ids who bought ALL products in the Product table.
--
-- Approach: GROUP BY + HAVING with subquery
-- 1. GROUP BY customer_id to group all purchases per customer.
-- 2. COUNT(DISTINCT product_key) counts unique products each customer bought.
--    DISTINCT is important — Customer table may have duplicate rows,
--    same customer can buy same product multiple times.
-- 3. Compare with total product count using subquery:
--    (SELECT COUNT(*) FROM product)
-- 4. If counts match → customer bought all products.
--
-- Note on subquery alias:
-- This subquery is inside HAVING, not FROM — no alias needed here.
-- Alias is only required for subqueries in the FROM clause.

SELECT
  customer_id
FROM customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM product);