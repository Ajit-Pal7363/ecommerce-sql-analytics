-- Step 5 Business Questions --

--A.Revenue & Sales Performance
--Total revenue and total orders overall.
SELECT 
	SUM(revenue) AS total_revenue,
	COUNT(*) AS total_orders
FROM ecommerce_sales;

--Month-wise (or year-wise) revenue trend. (DATE_TRUNC, GROUP BY)
SELECT
	EXTRACT(YEAR FROM order_date) AS years,
	EXTRACT(MONTH FROM order_date) AS months,
	SUM(revenue) AS total_revenue
FROM ecommerce_sales
GROUP BY
	EXTRACT(YEAR FROM order_date),
	EXTRACT(MONTH FROM order_date)
	ORDER BY years,months;

-- Which product category generates the highest total revenue?
SELECT
	product_category,
	SUM(revenue) AS total_revenue
FROM ecommerce_sales
GROUP BY product_category
ORDER BY total_revenue DESC
LIMIT 1;

-- Which region generates the highest total revenue?
SELECT
	region,
	SUM(revenue) AS total_revenue
FROM ecommerce_sales
GROUP BY region
ORDER BY total_revenue DESC
LIMIT 1;

-- Top 10 highest-revenue single orders.
SELECT
	order_id,
 	revenue
FROM ecommerce_sales
ORDER BY revenue DESC
LIMIT 10;

-- Average order value (AOV) overall and by region.
SELECT
	region,
	ROUND(SUM(revenue) / COUNT(*), 2) AS avg_order_value
FROM ecommerce_sales
GROUP BY region;

-- B.Product & Category Analysis

--Revenue and quantity sold per product category.
SELECT
	product_category,
	SUM(revenue) AS total_revenue,
	SUM(quantity) AS total_quantity
FROM ecommerce_sales
GROUP BY product_category
ORDER BY total_quantity DESC;

-- Which category has the highest average discount given?
SELECT
    product_category,
    ROUND(AVG(discount), 2) AS avg_discount
FROM ecommerce_sales
GROUP BY product_category
ORDER BY avg_discount DESC
LIMIT 1;

-- Category-wise average unit price vs average revenue per order.
SELECT
    product_category,
    ROUND(AVG(UNIT_PRICE), 2) AS avg_unit_price,
	ROUND(AVG(revenue), 2) AS avg_revenue
FROM ecommerce_sales
GROUP BY product_category
ORDER BY avg_unit_price DESC;

-- Which category has the best average customer rating?
SELECT
    product_category,
    ROUND(AVG(customer_rating), 2) AS avg_customer_rating
FROM ecommerce_sales
GROUP BY product_category
ORDER BY avg_customer_rating DESC
LIMIT 1;

-- C. Customer Behavior

--Top 10 customers by total spend. (GROUP BY customer_id, ORDER BY, LIMIT)
SELECT
	customer_id,
	SUM(revenue) AS total_spend
FROM ecommerce_sales
GROUP BY customer_id
ORDER BY total_spend DESC
LIMIT 10;

-- Number of repeat customers (customers with more than 1 order). (HAVING COUNT > 1)
SELECT
    COUNT(*) AS repeat_customers
FROM (
    SELECT
        customer_id
    FROM ecommerce_sales
    GROUP BY customer_id
    HAVING COUNT(DISTINCT order_id) > 1
) AS repeat_customer;

-- List of Repeated Customers
SELECT
    customer_id,
    COUNT(*) AS total_orders
FROM ecommerce_sales
GROUP BY customer_id
HAVING COUNT(*) > 1
ORDER BY total_orders DESC;

-- Average revenue per customer (overall single figure — total revenue divided by unique customers).
SELECT
	ROUND(SUM(revenue) / COUNT(DISTINCT customer_id), 2) AS avg_revenue_per_customer
FROM ecommerce_sales;

-- Average revenue per order, broken down by customer (per-customer breakdown, 989 rows).
SELECT
	customer_id,
	ROUND(AVG(revenue),2) AS average_revenue
FROM ecommerce_sales
GROUP BY customer_id
ORDER BY customer_id;

-- Customer rating distribution — how many orders fall in each rating bucket (1-2, 2-3, etc.)?
SELECT
    CASE
        WHEN customer_rating >= 1 AND customer_rating < 2 THEN '1-2'
        WHEN customer_rating >= 2 AND customer_rating < 3 THEN '2-3'
        WHEN customer_rating >= 3 AND customer_rating < 4 THEN '3-4'
        WHEN customer_rating >= 4 AND customer_rating < 5 THEN '4-5'
        WHEN customer_rating = 5 THEN '5'
    END AS rating_bucket,
    COUNT(*) AS total_orders
FROM ecommerce_sales
GROUP BY rating_bucket
ORDER BY rating_bucket;

-- D. Regional Analysis

--Region-wise order count, total revenue, and average discount — side by side. (GROUP BY with multiple aggregates)
SELECT
	region,
	COUNT(order_id) AS order_count,
	SUM(revenue) AS total_revenue,
	ROUND(AVG(discount),2) AS avg_discount
FROM ecommerce_sales
GROUP BY region;

-- Which region has the fastest average delivery time?
SELECT
	region,
	ROUND(AVG(delivery_days),2) AS avg_delivery_time
FROM ecommerce_sales
GROUP BY region
ORDER BY avg_delivery_time ASC
LIMIT 1;

-- Region + category combination that generates the most revenue. (GROUP BY two columns)
SELECT
	region,
	product_category,
	SUM(revenue) AS total_revenue
FROM ecommerce_sales
GROUP BY region, product_category
ORDER BY total_revenue DESC;

-- E. Payment Method Analysis

-- Revenue and order count split by payment_method.
SELECT
	payment_method,
	SUM(revenue) AS total_revenue,
	COUNT(order_id) AS order_count
FROM ecommerce_sales
GROUP BY payment_method;

-- Does payment method affect customer rating? (avg rating per payment method)
SELECT
	payment_method,
	ROUND(AVG(customer_rating),2) AS avg_customer_rating
FROM ecommerce_sales
GROUP BY payment_method;

-- F. Delivery Performance

-- Relationship between delivery_days and customer_rating — 
-- does slower delivery lead to lower ratings? (GROUP BY delivery_days, AVG rating)
SELECT
	delivery_days,
	ROUND(AVG(customer_rating),2) AS avg_rating,
	COUNT(*) AS total_orders
FROM ecommerce_sales
GROUP BY delivery_days
ORDER BY delivery_days;

-- Bonus/advanced (optional, agar window functions practice karni ho):

-- Running total of revenue over time (SUM() OVER, window function)
SELECT
	revenue,
	SUM(revenue) OVER(ORDER BY order_date) AS running_total
FROM ecommerce_sales;

--Rank customers by spend within each region (RANK() OVER PARTITION BY)
SELECT
	customer_id,
	region,
	SUM(revenue) AS total_spend,
	DENSE_RANK() OVER(PARTITION BY region
						ORDER BY SUM(revenue) DESC) AS customer_rank
FROM ecommerce_sales
GROUP BY region, customer_id
ORDER BY region, customer_rank;

-- Month-over-month revenue growth % (LAG())
WITH monthly_revenue AS
(
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        SUM(revenue) AS total_revenue
    FROM ecommerce_sales
    GROUP BY DATE_TRUNC('month', order_date)
)

SELECT
    month,
    total_revenue,
    LAG(total_revenue) OVER(ORDER BY month) AS prev_month_revenue,
    ROUND(
        (
            (total_revenue - LAG(total_revenue) OVER(ORDER BY month))
            * 100.0
        )
        /
        LAG(total_revenue) OVER(ORDER BY month),
        2
    ) AS mom_growth_percent
FROM monthly_revenue
ORDER BY month;
