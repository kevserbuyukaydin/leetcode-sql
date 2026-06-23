-- Problem: Immediate Food Delivery II
-- URL: https://leetcode.com/problems/immediate-food-delivery-ii/
--
-- Task:
-- Find the percentage of immediate orders (order_date = customer_pref_delivery_date)
-- among the first orders of all customers. Round to 2 decimal places.
--
-- Approach: CTE + INNER JOIN
--
-- Step 1: Find each customer's first order date using MIN(order_date) in a CTE.
-- Step 2: JOIN delivery table with CTE to get only first order rows.
-- Step 3: Calculate immediate percentage.
--
-- Why CTE over subquery?
-- Both have the same performance in PostgreSQL 12+.
-- CTE is more readable and can be reused multiple times in the query.
--
-- Note on 100.0:
-- Multiplying by 100.0 (float literal) ensures decimal division.
-- Using integer 100 would cause integer division and lose decimal precision.

-- ------------------------------------------------------------
-- Approach 1: FILTER (recommended)
-- Cleaner and PostgreSQL-specific.
-- COUNT(*) FILTER → counts only rows matching the condition.

WITH first_orders AS (
  SELECT 
    customer_id, 
    MIN(order_date) AS first_order_date
  FROM delivery
  GROUP BY customer_id
)

SELECT 
  ROUND(
    COUNT(*) FILTER (WHERE d.order_date = d.customer_pref_delivery_date) * 100.0 / COUNT(*),
    2
  ) AS immediate_percentage
FROM delivery d
INNER JOIN first_orders f
        ON d.customer_id = f.customer_id
       AND d.order_date = f.first_order_date;

-- ------------------------------------------------------------
-- Approach 2: CASE WHEN (more portable across SQL dialects)

WITH first_orders AS (
  SELECT 
    customer_id, 
    MIN(order_date) AS first_order_date
  FROM delivery
  GROUP BY customer_id
)

SELECT 
  ROUND(
    SUM(CASE WHEN d.order_date = d.customer_pref_delivery_date THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
    2
  ) AS immediate_percentage
FROM delivery d
INNER JOIN first_orders f
        ON d.customer_id = f.customer_id
       AND d.order_date = f.first_order_date;

-- ELSE 0 vs no ELSE in this query:
-- With ELSE 0:
--   Non-matching rows return 0
--   SUM(0, 0, 0) → 0 (never NULL)
--
-- Without ELSE:
--   Non-matching rows return NULL
--   SUM(NULL, NULL, NULL) → NULL
--   ROUND(NULL, 2) → NULL (unexpected result!)
--
-- Since we use ROUND() without COALESCE here,
-- ELSE 0 is important to prevent NULL propagating into ROUND().