# Pizza-Sales-Analysis-SQL-Project-
This project analyzes pizza sales data using SQL to uncover key business insights such as revenue trends, customer preferences, and top-performing products. The goal is to support data-driven decision-making for improving sales and operations.

# Project Overview:

This project analyzes pizza sales data using SQL to uncover key business insights such as revenue trends, customer preferences, and top-performing products. The goal is to support data-driven decision-making for improving sales and operations.

# Objectives:
Analyze overall sales performance
Identify top-selling pizzas and categories
Understand customer ordering patterns
Evaluate revenue trends over time

# Tools & Technologies:
SQL (MySQL / PostgreSQL)
Data Cleaning & Transformation
Aggregate Functions
Joins & Subqueries
Window Functions
Pricing information

# Key Analysis Performed:

## 1. Sales Performance:
Total Revenue Generated
Total Orders & Quantity Sold
Average Order Value

## 2. Product Analysis
Top 5 Best-Selling Pizzas
Worst Performing Pizzas
Revenue by Pizza Category

## 3. Time-Based Analysis
Sales by Day / Month
Peak Ordering Hours
Order Trends Over Time

## 4. Customer Behavior
Most Preferred Pizza Size
Order Frequency Patterns

# Key Insights
Large-sized pizzas contribute the highest revenue
A few top pizzas drive the majority of sales (Pareto principle)
Peak sales occur during evening hours
Weekends generate higher revenue compared to weekdays

 # Query Examples:

 -- Total Revenue
SELECT SUM(total_price) AS total_revenue
FROM order_details;

-- Top 5 Best Selling Pizzas
SELECT pizza_name, SUM(quantity) AS total_sold
FROM order_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY pizza_name
ORDER BY total_sold DESC
LIMIT 5;
