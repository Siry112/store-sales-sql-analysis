-- =====================================================
-- Store Sales SQL Analysis
--
-- This file contains analytical queries answering
-- business questions about store performance.
--
-- Techniques used:
-- JOIN
-- GROUP BY
-- CTE
-- Window functions
-- Ranking
-- =====================================================

-- 1. Total revenue
SELECT
    SUM(oi.unit_price * oi.quantity) AS total_revenue
FROM order_items oi;


-- 2. Revenue per category
SELECT
    p.category AS category,
    SUM(oi.unit_price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN products p
    ON p.product_id = oi.product_id
GROUP BY p.category;


-- 3. Top 3 customers by lifetime revenue
WITH customers_total AS (
    SELECT
        c.customer_name AS customer_name,
        c.country AS country,
        SUM(oi.unit_price * oi.quantity) AS lifetime_revenue
    FROM order_items oi
    JOIN orders o
        ON o.order_id = oi.order_id
    JOIN customers c
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_name, c.country
)
SELECT
    customer_name,
    country,
    lifetime_revenue
FROM customers_total
ORDER BY lifetime_revenue DESC
LIMIT 3;


-- 4. Top product per country
WITH country_revenue AS (
    SELECT
        c.country AS country,
        p.product_name AS product_name,
        SUM(oi.unit_price * oi.quantity) AS total_revenue
    FROM order_items oi
    JOIN products p
        ON p.product_id = oi.product_id
    JOIN orders o
        ON o.order_id = oi.order_id
    JOIN customers c
        ON c.customer_id = o.customer_id
    GROUP BY c.country, p.product_name
),
ranked_country AS (
    SELECT
        country,
        product_name,
        total_revenue,
        RANK() OVER (
            PARTITION BY country
            ORDER BY total_revenue DESC
        ) AS rnk
    FROM country_revenue
)
SELECT
    country,
    product_name,
    total_revenue
FROM ranked_country
WHERE rnk = 1;


-- 5. Customer share of country revenue
WITH country_revenue AS (
    SELECT
        c.country AS country,
        c.customer_name AS customer_name,
        SUM(oi.unit_price * oi.quantity) AS lifetime_revenue
    FROM order_items oi
    JOIN orders o
        ON o.order_id = oi.order_id
    JOIN customers c
        ON c.customer_id = o.customer_id
    GROUP BY c.country, c.customer_name
)
SELECT
    country,
    customer_name,
    lifetime_revenue,
    ROUND(
        lifetime_revenue * 100.00
        / SUM(lifetime_revenue) OVER (PARTITION BY country),
        2
    ) AS share_of_country_revenue
FROM country_revenue;


-- 6. Running revenue per customer
WITH customer_revenue AS (
    SELECT
        c.customer_name AS customer_name,
        o.order_date AS order_date,
        SUM(oi.unit_price * oi.quantity) AS order_revenue
    FROM order_items oi
    JOIN orders o
        ON o.order_id = oi.order_id
    JOIN customers c
        ON c.customer_id = o.customer_id
    GROUP BY c.customer_name, o.order_date
)
SELECT
    customer_name,
    order_date,
    order_revenue,
    SUM(order_revenue) OVER (
        PARTITION BY customer_name
        ORDER BY order_date
    ) AS running_revenue
FROM customer_revenue;


-- 7. Average order value
WITH revenue_per_order AS (
    SELECT
        oi.order_id AS order_id,
        SUM(oi.unit_price * oi.quantity) AS order_revenue
    FROM order_items oi
    GROUP BY oi.order_id
)
SELECT
    ROUND(AVG(order_revenue), 2) AS avg_order_value
FROM revenue_per_order;


-- 8. Average order value per country
WITH orders_total AS (
    SELECT
        oi.order_id AS order_id,
        c.country AS country,
        SUM(oi.unit_price * oi.quantity) AS order_revenue
    FROM order_items oi
    JOIN orders o
        ON o.order_id = oi.order_id
    JOIN customers c
        ON c.customer_id = o.customer_id
    GROUP BY oi.order_id, c.country
)
SELECT
    country,
    ROUND(AVG(order_revenue), 2) AS avg_order_value
FROM orders_total
GROUP BY country;


-- 9. Average order value per customer
WITH customers_total AS (
    SELECT
        oi.order_id AS order_id,
        c.customer_name AS customer_name,
        SUM(oi.unit_price * oi.quantity) AS order_revenue
    FROM order_items oi
    JOIN orders o
        ON o.order_id = oi.order_id
    JOIN customers c
        ON c.customer_id = o.customer_id
    GROUP BY oi.order_id, c.customer_name
)
SELECT
    customer_name,
    ROUND(AVG(order_revenue), 2) AS avg_order_value
FROM customers_total
GROUP BY customer_name;