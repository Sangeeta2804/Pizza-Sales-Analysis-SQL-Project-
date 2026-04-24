## Pizza Sales Data Analysis — SQL

An end-to-end SQL data pipeline built on Microsoft SQL Server (T-SQL) — covering data cleaning, transformation, and business analytics on a real-world pizza sales dataset. The project follows a structured layered architecture: Raw → Cleaned → Reporting Views.

## Project Objective
To transform raw, uncleaned pizza sales data into actionable business insights by building a reliable SQL pipeline that handles data quality, standardization, and KPI reporting — all without any external tools.

## Project Structure

pizza-sales-sql/
│
├── pizza_sales_analysis.sql   # Complete SQL script (all phases)
└── README.md                  # Project documentation

## Pipeline Overview
pizza_sales_raw  →  [Cleaning & Transformation]  →  pizza_sales_cleaned  →  Reporting Views

 ## Data Cleaning Steps

Detected and handled NULL values in critical columns (order_date, pizza_name, quantity)
Imputed defaults for missing fields (quantity = 1, pizza_category = 'Unknown')
Removed duplicate records using CTE + ROW_NUMBER() OVER (PARTITION BY order_id)
Fixed invalid data — negative/zero quantities and prices replaced with safe defaults
Standardized pizza_size values to UPPERCASE for consistency


## Business KPIs Analyzed

#### KPISQL - Technique Used
Total Revenue - SUM(), CAST(AS DECIMAL)
Top 5 Best-Selling Pizzas - TOP 5, GROUP BY, ORDER BY
Revenue by Pizza - CategoryGROUP BY, SUM()
Monthly Sales - TrendMONTH(), DATENAME(), GROUP BY

## Reporting Views Created

#### View Name - Purpose
vw_TotalRevenue  - Aggregated total revenue across all 
ordersvw_TopSellingPizzas  -  Top 5 pizzas ranked by units sold
vw_SalesByCategory  -  Revenue breakdown by pizza category
vw_MonthlySales  -  Month-wise revenue trend for time-series analysis

## Tech Stack
###$ Tool  -  Usage
Microsoft SQL Server  -  Database engine
T-SQL  -  Querying, cleaning, transformation
SQL ViewsReusable reporting layer  -  
CTEs  -  Deduplication logic
Window Functions  -  ROW_NUMBER() OVER (PARTITION BY ...)

## Key SQL Concepts Demonstrated

CTE with ROW_NUMBER() for deduplication
IF OBJECT_ID ... DROP TABLE for safe schema management
SELECT INTO for clean table creation
CREATE OR ALTER VIEW for maintainable reporting
DATENAME() + MONTH() for time-based aggregation
CAST(AS DECIMAL) for precise financial reporting

## How to Run

1. Clone this repository
2. Open SQL Server Management Studio (SSMS)
3. Create a database and import your raw pizza sales data as pizza_sales_raw
4. Execute pizza_sales_analysis.sql — run it top to bottom
5. Query the views for instant reporting:


``` sql

SELECT * FROM vw_MonthlySales    ORDER BY month_number;
SELECT * FROM vw_SalesByCategory ORDER BY category_revenue DESC;
SELECT * FROM vw_TopSellingPizzas;
SELECT total_revenue FROM vw_TotalRevenue;






