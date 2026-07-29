CREATE TABLE ecommerce_sales (
    order_id INT PRIMARY KEY,
    order_date TEXT,
    customer_id INT,
    product_category VARCHAR(100),
    region VARCHAR(100),
    quantity INT,
    unit_price DECIMAL(10,2),
    discount DECIMAL(5,2),
    payment_method VARCHAR(50),
    delivery_days INT,
    customer_rating DECIMAL(3,1),
    revenue DECIMAL(12,2)
);
