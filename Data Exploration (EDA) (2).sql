-- Step 4: Data Exploration (EDA) --

-- Total Revenue
SELECT
	SUM(revenue) AS total_revenue
FROM ecommerce_sales;

-- Total Orders
SELECT
	COUNT(*) AS total_orders
FROM ecommerce_sales;

-- Date Range
SELECT
	MIN(order_date) AS min_date,
	MAX(order_date) AS max_date
FROM ecommerce_sales;

-- Distinct Values by Product Categories
SELECT
	DISTINCT product_category
FROM ecommerce_sales;

-- Distinct Values by Region
SELECT
	DISTINCT region
FROM ecommerce_sales;

-- Distinct Values by Payemnt Method
SELECT
	DISTINCT payment_method
FROM ecommerce_sales;

-- Altogether 
SELECT
    COUNT(DISTINCT product_category) AS total_categories,
    COUNT(DISTINCT region) AS total_regions,
    COUNT(DISTINCT payment_method) AS total_payment_methods
FROM ecommerce_sales;

-- Row count per category
SELECT
	product_category,
	COUNT(*) AS row_count
FROM ecommerce_sales
GROUP BY product_category
ORDER BY row_count DESC;

-- Row count per region
SELECT
	region,
	COUNT(*) AS row_count
FROM ecommerce_sales
GROUP BY region
ORDER BY row_count DESC;

-- Basic stats: AVG, MIN, MAX for unit_price, revenue, discount, delivery_days, customer_rating
SELECT
	ROUND(AVG(unit_price),2) AS average_unit_price,
	MIN(unit_price) AS minimum_unit_price,
	MAX(unit_price) AS maximum_unit_price
FROM ecommerce_sales;

-- Basic stats: AVG, MIN, MAX for revenue
SELECT
	ROUND(AVG(revenue),2) AS average_revenue,
	MIN(revenue) AS minimum_revenue,
	MAX(revenue) AS maximum_revenue
FROM ecommerce_sales;

-- Basic stats: AVG, MIN, MAX for discount
SELECT
	ROUND(AVG(discount),2) AS average_discount,
	MIN(discount) AS minimum_discount,
	MAX(discount) AS maximum_discount
FROM ecommerce_sales;

-- Basic stats: AVG, MIN, MAX for Delivery Days
SELECT
	ROUND(AVG(delivery_days),2) AS average_delivery_days,
	MIN(delivery_days) AS minimum_delivery_days,
	MAX(delivery_days) AS maximum_delivery_days
FROM ecommerce_sales;

-- Basic stats: AVG, MIN, MAX for Customer Rating
SELECT
	ROUND(AVG(customer_rating),2) AS average_customer_rating,
	MIN(customer_rating) AS minimum_customer_rating,
	MAX(customer_rating) AS maximum_customer_rating
FROM ecommerce_sales;
