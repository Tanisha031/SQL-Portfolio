-- CREATE DATABASE
CREATE DATABASE customer_segmentation;
USE customer_segmentation;

-- CREATE CUSTOMERS TABLE
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    gender VARCHAR(10),
    age INT,
    city VARCHAR(50),
    join_date DATE
);

-- CREATE ORDERS TABLE
CREATE TABLE customer_orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    order_amount DECIMAL(10,2),
    product_category VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- INSERT CUSTOMERS
INSERT INTO customers VALUES
(1, 'Ahmed Khan', 'Male', 28, 'Karachi', '2025-01-10'),
(2, 'Sara Ali', 'Female', 34, 'Lahore', '2025-02-15'),
(3, 'Bilal Raza', 'Male', 41, 'Islamabad', '2025-03-05'),
(4, 'Ayesha Noor', 'Female', 25, 'Dubai', '2025-03-18'),
(5, 'Usman Tariq', 'Male', 37, 'Sharjah', '2025-04-01');

-- INSERT ORDERS
INSERT INTO customer_orders VALUES
(1001, 1, '2026-03-01', 15000, 'Electronics'),
(1002, 1, '2026-03-10', 8000, 'Accessories'),
(1003, 2, '2026-03-05', 22000, 'Furniture'),
(1004, 3, '2026-03-08', 12000, 'Electronics'),
(1005, 4, '2026-03-12', 30000, 'Electronics'),
(1006, 4, '2026-03-20', 15000, 'Furniture'),
(1007, 5, '2026-03-25', 9000, 'Accessories');

-- TOTAL SPEND PER CUSTOMER
SELECT
    c.customer_id,
    c.customer_name,
    SUM(o.order_amount) AS total_spend
FROM customers c
JOIN customer_orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spend DESC;

-- ORDER FREQUENCY REPORT
SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN customer_orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC;

-- CUSTOMER SEGMENTATION BASED ON SPEND
SELECT
    c.customer_name,
    SUM(o.order_amount) AS total_spend,
    CASE
        WHEN SUM(o.order_amount) >= 30000 THEN 'High Value'
        WHEN SUM(o.order_amount) BETWEEN 15000 AND 29999 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_segment
FROM customers c
JOIN customer_orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_spend DESC;

-- CITY WISE CUSTOMER REVENUE
SELECT
    c.city,
    SUM(o.order_amount) AS total_revenue
FROM customers c
JOIN customer_orders o
ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_revenue DESC;

-- PRODUCT CATEGORY PREFERENCE
SELECT
    product_category,
    COUNT(*) AS total_orders
FROM customer_orders
GROUP BY product_category
ORDER BY total_orders DESC;

-- AGE GROUP SEGMENTATION
SELECT
    CASE
        WHEN age < 30 THEN 'Young'
        WHEN age BETWEEN 30 AND 40 THEN 'Adult'
        ELSE 'Senior'
    END AS age_group,
    COUNT(*) AS customer_count
FROM customers
GROUP BY age_group;

-- TOP CUSTOMERS RANKING
SELECT
    c.customer_name,
    SUM(o.order_amount) AS total_spend,
    RANK() OVER (
        ORDER BY SUM(o.order_amount) DESC
    ) AS customer_rank
FROM customers c
JOIN customer_orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

-- REPEAT CUSTOMER ANALYSIS
SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    CASE
        WHEN COUNT(o.order_id) > 1 THEN 'Repeat Customer'
        ELSE 'One-Time Customer'
    END AS customer_type
FROM customers c
JOIN customer_orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;