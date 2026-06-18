-- Problem: Average Selling Price
-- URL: https://leetcode.com/problems/average-selling-price/
-- 
-- Approach:
-- 1. LEFT JOIN Prices with UnitsSold on product_id and purchase_date BETWEEN start_date and end_date.
--    This ensures products with no sales are also included.
-- 2. Calculate total revenue: SUM(units * price)
-- 3. Calculate total units: SUM(units)
-- 4. Divide to get average. Use NULLIF to prevent division by zero.
-- 5. Use COALESCE to return 0 for products with no sales.
-- 6. Cast to DECIMAL to avoid integer division, then ROUND to 2 decimal places.
--
-- Note: In PostgreSQL, any mathematical operation involving NULL automatically produces NULL.

SELECT 
  p.product_id,
  ROUND(
    COALESCE(
      SUM(u.units * p.price)::DECIMAL / NULLIF(SUM(u.units), 0),
      0
    ), 2
  ) AS average_price 
FROM prices p
LEFT JOIN unitssold u
       ON p.product_id = u.product_id
      AND u.purchase_date BETWEEN p.start_date AND p.end_date
GROUP BY p.product_id