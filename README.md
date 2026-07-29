# 🛒 E-Commerce SQL Analysis

# 📌 Project Overview

This project analyzes 5,000 e-commerce transaction records using PostgreSQL to uncover revenue trends, customer behavior, product performance, and delivery/payment patterns. The goal is to turn raw order data into actionable business insights using SQL.

🎯 Business Problem

An e-commerce company wants to understand its historical order data — which product categories and regions drive the most revenue, how customers prefer to pay, how delivery performance affects customer satisfaction, and where the business should focus to improve revenue and customer experience. This project uses SQL to answer these questions directly from the transactional database.

📂 Dataset Information
Source: Simulated e-commerce sales dataset (ecommerce_sales_analytics_5000.csv)
Size: 5,000 rows, 12 columns
Quality: No missing values, no duplicate order IDs

Column	Description
order_id	Unique identifier for each order
order_date	Date the order was placed
customer_id	Unique identifier for each customer
product_category	Beauty, Clothing, Electronics, or Home
region	North, South, East, or West
quantity	Number of units purchased
unit_price	Price per unit (before discount)
discount	Discount applied, as a fraction (e.g. 0.10 = 10%)
payment_method	Wallet, Card, or COD
delivery_days	Number of days taken to deliver the order
customer_rating	Customer's rating of the order (1.0–5.0)
revenue	Final revenue for the order (quantity × unit_price × (1 − discount))

🛠️ Tools Used
PostgreSQL — database and query engine
pgAdmin / DBeaver — SQL client for writing and running queries
GitHub — version control and project hosting

Project Structure
ecommerce-sql-analytics/
│
├── README.md
├── data/
│   └── ecommerce_sales_analytics_5000.csv
├── sql/
│   ├── 01_table_creation.sql
│   ├── 02_data_cleaning.sql
│   ├── 03_data_exploration.sql
│   └── 04_business_questions.sql
└── outputs/
    └── screenshots/

🧹 Data Cleaning Steps

Before analysis, the dataset was validated for quality using the following checks:

Null check — confirmed no NULL values across all 12 columns.
Duplicate check — confirmed all order_id values are unique.
Date range check — order dates span from Jan 2022 to Sep 2035; confirmed as a simulated multi-year dataset with no invalid date formats.
Revenue formula validation — verified revenue ≈ quantity × unit_price × (1 − discount) holds across all rows, confirming internal consistency of the data.
Range/outlier check — confirmed all values fall within expected bounds (e.g. customer_rating between 1–5, discount between 0–0.35, no negative quantities).
See sql/02_data_cleaning.sql for the full queries.

Data Exploration

Initial exploration was performed to understand the shape of the dataset before answering business questions — total orders, total revenue, date range, and distinct values for product_category, region, and payment_method, along with basic summary statistics (min, max, average) for price, revenue, discount, delivery days, and rating. See sql/03_data_exploration.sql.

📊 Business Questions & SQL Analysis

All 20 business questions are answered in sql/04_business_questions.sql, grouped into six categories:

Revenue & Sales Performance — total revenue, monthly trend, top categories/regions, AOV
Product & Category Analysis — revenue/quantity by category, discount patterns, ratings by category
Customer Behavior — top customers, repeat customers, average spend, rating distribution
Regional Analysis — revenue and delivery performance by region
Payment Method Analysis — revenue split and rating by payment method
Delivery Performance — relationship between delivery time and customer rating

💡Business Insights

(Replace with your actual findings after running the queries — examples below)

[Category] contributes the largest share of total revenue.
[Region] has the highest average delivery time and the lowest average customer rating.
The top 10% of customers account for a disproportionate share of total revenue.
[Payment method] has the highest average customer rating despite lower order volume.
Recommendations

(Replace with recommendations based on your actual insights — examples below)

Focus marketing spend on [region/category] where revenue potential is untapped.
Investigate delivery delays in [region] to improve customer satisfaction scores.
Consider incentivizing [payment method] given its higher customer satisfaction.

## 👨‍💻 Author

**Ajit Pal**

Aspiring **Data Analyst** with hands-on experience in **SQL, PostgreSQL, Python, Pandas, NumPy, Excel, and Power BI**. Passionate about transforming raw data into meaningful business insights through data cleaning, analysis, and visualization.

### 📬 Connect with Me

- 💼 LinkedIn: https://www.linkedin.com/in/YOUR-LINKEDIN-AjitPal
- 💻 GitHub: https://github.com/YOUR-GITHUB-Ajit-Pal7363
- 📧 Email: ajitnpal7363@gmail.com
