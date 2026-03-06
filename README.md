# Store Sales SQL Analysis

SQL analytics project exploring revenue, customers and product performance in an e-commerce dataset.

The goal of the project is to practice analytical SQL techniques such as joins, aggregations, window functions, and multi-step transformations.

## Dataset

The dataset contains four tables:

- customers
- products
- orders
- order_items

Revenue is calculated using:

quantity * unit_price

## Analysis Questions

The SQL analysis answers several business questions:

1. Total revenue of the store
2. Revenue per product category
3. Top 3 customers by lifetime revenue
4. Top product per country
5. Customer share of country revenue
6. Running revenue per customer
7. Average order value
8. Average order value per country
9. Average order value per customer

## SQL Concepts Used

- JOIN
- GROUP BY
- CTE (Common Table Expressions)
- Window functions
- RANK
- Aggregate functions (SUM, AVG)

## Project Structure

store-sales-sql-analysis
│
├─ data
│ └─ dataset.sql

├─ sql
│ └─ analysis.sql

└─ README.md

## Purpose

This project is part of my learning journey in data analytics and SQL.  
It focuses on understanding **data granularity, aggregations, and analytical queries**.
