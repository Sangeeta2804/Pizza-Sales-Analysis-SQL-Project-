SELECT * from pizza_sales_raw;


UPDATE pizza_sales_raw
SET total_price = quantity * unit_price;


--1. Check Null Values
SELECT *
FROM pizza_sales_raw
WHERE order_date IS NULL
   OR pizza_name IS NULL
   OR quantity IS NULL;


--2. Handle Null Values

UPDATE pizza_sales_raw
SET quantity = 1
WHERE quantity IS NULL;

UPDATE pizza_sales_raw
SET pizza_category = 'Unknown'
WHERE pizza_category IS NULL;  

--3. Remove Duplicates

WITH CTE AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY order_id ORDER BY order_id) AS rn
    FROM pizza_sales_raw
)
DELETE FROM CTE WHERE rn > 1;

--4. Fix Incorrect Values

-- Negative or zero quantity
UPDATE pizza_sales_raw
SET quantity = 1
WHERE quantity <= 0;

-- Incorrect prices
UPDATE pizza_sales_raw
SET unit_price = 10
WHERE unit_price <= 0;

--5. Standardization
UPDATE pizza_sales_raw
SET pizza_size = UPPER(pizza_size);

SELECT * from pizza_sales_raw;


--Create Clean Table (Final Layer)

IF OBJECT_ID('dbo.pizza_sales_cleaned', 'U') IS NOT NULL
    DROP TABLE dbo.pizza_sales_cleaned;

SELECT * INTO pizza_sales_cleaned
FROM pizza_sales_raw;

SELECT * FROM pizza_sales_cleaned;

select * from pizza_sales_cleaned
where pizza_category = 'Unknown';



--Data Analysis Queries
--1. Total Revenue

SELECT SUM(total_price) AS total_revenue
FROM pizza_sales_clean;

--2. Top Selling Pizza

SELECT TOP 5 pizza_name,
       SUM(quantity) AS total_qty
FROM pizza_sales_clean
GROUP BY pizza_name
ORDER BY total_qty DESC;


--3. Sales by Category

SELECT pizza_category,
       SUM(total_price) AS revenue
FROM pizza_sales_clean
GROUP BY pizza_category;


--4. Monthly Sales Trend


SELECT MONTH(order_date) AS month_number,
       DATENAME(MONTH, order_date) AS month_name,   -- This makes it readable (Jan, Feb...)
       SUM(total_price) AS revenue,
       CAST(SUM(total_price) AS DECIMAL(18,2)) AS monthly_revenue
FROM pizza_sales_cleaned
GROUP BY MONTH(order_date),
         DATENAME(MONTH, order_date);



--create views for analysis

GO

-- 1. Total Revenue View
CREATE OR ALTER VIEW vw_TotalRevenue AS
SELECT CAST(SUM(total_price) AS DECIMAL(18,2)) AS total_revenue
FROM pizza_sales_cleaned;

-- 2. Top 5 Selling Pizzas View
GO

CREATE OR ALTER VIEW vw_TopSellingPizzas AS
SELECT TOP 5 
    pizza_name, 
    SUM(quantity) AS total_quantity
FROM pizza_sales_cleaned
GROUP BY pizza_name
ORDER BY total_quantity DESC;



-- 3. Sales by Category View
GO
CREATE OR ALTER VIEW vw_SalesByCategory AS
SELECT 
    pizza_category, 
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS category_revenue
FROM pizza_sales_cleaned
GROUP BY pizza_category;

-- When querying this view, order the results in the outer query:
-- SELECT * FROM vw_SalesByCategory ORDER BY category_revenue DESC;


-- 4. Monthly Sales Trends View
GO

CREATE OR ALTER VIEW vw_MonthlySales AS
SELECT  
    MONTH(order_date) AS month_number, 
    DATENAME(MONTH, order_date) AS month_name,   -- This makes it readable (Jan, Feb...)
    CAST(SUM(total_price) AS DECIMAL(18,2)) AS monthly_revenue
FROM pizza_sales_cleaned
GROUP BY MONTH(order_date), DATENAME(MONTH, order_date);

-- Query example for ordered results:
-- SELECT * FROM vw_MonthlySales ORDER BY month_number;