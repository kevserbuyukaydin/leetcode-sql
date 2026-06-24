-- Problem: Product Sales Analysis III
-- URL: https://leetcode.com/problems/product-sales-analysis-iii/
--
-- Task:
-- For each product, find all sales entries from its first year of sale.
-- Return product_id, first_year, quantity, and price.
--
-- Approach: CTE + INNER JOIN
-- 1. CTE finds the first year each product was sold using MIN(year).
-- 2. INNER JOIN Sales with CTE on both product_id and year = first_year
--    to get only the first year sales rows.
--
-- Why not GROUP BY alone?
-- GROUP BY product_id with MIN(year) gives us the first year,
-- but we also need quantity and price from the same row.
-- These columns can't be selected without aggregate functions in GROUP BY.
-- JOIN solves this by fetching the actual row data after identifying
-- the first year in the CTE.

WITH first_sale_years AS (
  SELECT 
    product_id, 
    MIN(year) AS first_year
  FROM sales
  GROUP BY product_id
)

SELECT 
  s.product_id,
  s.year AS first_year,
  s.quantity,
  s.price
FROM sales s
INNER JOIN first_sale_years f
        ON s.product_id = f.product_id
       AND s.year = f.first_year;