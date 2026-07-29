-- Step 3: Data Cleaning
-- Nulls Check

SELECT * FROM ecommerce_sales 
WHERE order_id IS NULL 
OR revenue IS NULL;

--Duplicate check 
SELECT order_id, COUNT(*) FROM ecommerce_sales 
GROUP BY order_id 
HAVING COUNT(*) > 1;

-- Date range sanity check
SELECT 
	MIN(order_date) AS min_order_date,
	MAX(order_date) AS max_order_date
FROM ecommerce_sales;

-- Revenue formula validation
SELECT
	quantity * unit_price AS Cost
FROM ecommerce_sales;