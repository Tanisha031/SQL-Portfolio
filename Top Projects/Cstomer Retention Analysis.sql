-- 1. CREATE DATABASE
CREATE DATABASE IF NOT EXISTS customer_retention_db;
USE customer_retention_db;

-- 2. CREATE CUSTOMERS TABLE
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    signup_date DATE,
    city VARCHAR(50)
);

-- 3. CREATE ORDERS TABLE
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    product VARCHAR(100),
    amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- 4. INSERT SAMPLE CUSTOMERS DATA
INSERT INTO customers VALUES
(1, 'Ali Khan', '2024-01-01', 'Karachi'),
(2, 'Sara Ahmed', '2024-01-05', 'Lahore'),
(3, 'John Smith', '2024-02-10', 'Dubai'),
(4, 'Ayesha Malik', '2024-02-15', 'Karachi'),
(5, 'David Lee', '2024-03-01', 'Abu Dhabi'),
(6, 'Fatima Noor', '2024-03-10', 'Lahore'),
(7, 'Hassan Ali', '2024-04-01', 'Karachi'),
(8, 'Emily Brown', '2024-04-05', 'Dubai');

-- 5. INSERT SAMPLE ORDERS DATA
INSERT INTO orders VALUES
(101, 1, '2024-01-10', 'Laptop', 1200),
(102, 1, '2024-02-15', 'Mouse', 25),
(103, 1, '2024-03-10', 'Keyboard', 45),
(104, 2, '2024-01-20', 'Phone', 800),
(105, 2, '2024-03-22', 'Cover', 15),
(106, 3, '2024-02-12', 'Tablet', 600),
(107, 4, '2024-02-20', 'Monitor', 300),
(108, 4, '2024-03-25', 'HDMI Cable', 10),
(109, 5, '2024-03-05', 'Camera', 900),
(110, 5, '2024-04-10', 'Tripod', 50),
(111, 6, '2024-03-15', 'Shoes', 120),
(112, 7, '2024-04-10', 'Bag', 80),
(113, 8, '2024-04-12', 'Laptop', 1500),
(114, 8, '2024-05-10', 'Mouse', 30);

-- 6. BASIC CUSTOMER PURCHASE COUNT
SELECT 
    c.customer_id,
    c.customer_name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_spent
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;

-- 7. REPEAT CUSTOMERS (RETENTION INDICATOR)
SELECT 
    customer_id,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 1;

-- 8. CHURNED CUSTOMERS (NO ORDERS AFTER FIRST)
SELECT 
    c.customer_id,
    c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

-- 9. FIRST PURCHASE DATE PER CUSTOMER
SELECT 
    customer_id,
    MIN(order_date) AS first_purchase_date
FROM orders
GROUP BY customer_id;

-- 10. CUSTOMER LIFETIME VALUE (CLV)
SELECT 
    c.customer_id,
    c.customer_name,
    SUM(o.amount) AS lifetime_value
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY lifetime_value DESC;

-- 11. MONTHLY RETENTION VIEW
SELECT 
    DATE_FORMAT(o.order_date, '%Y-%m') AS order_month,
    COUNT(DISTINCT o.customer_id) AS active_customers,
    SUM(o.amount) AS revenue
FROM orders o
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY order_month;

-- 12. RETENTION COHORT
WITH first_purchase AS (
    SELECT 
        customer_id,
        MIN(order_date) AS first_order_date
    FROM orders
    GROUP BY customer_id
)
SELECT 
    fp.customer_id,
    DATE_FORMAT(fp.first_order_date, '%Y-%m') AS cohort_month,
    COUNT(o.order_id) AS repeat_orders
FROM first_purchase fp
JOIN orders o 
    ON fp.customer_id = o.customer_id
GROUP BY fp.customer_id, cohort_month
ORDER BY cohort_month;

-- 13. TOP RETAINED CUSTOMERS
SELECT 
    customer_id,
    COUNT(order_id) AS total_orders,
    SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id
ORDER BY total_orders DESC, total_spent DESC;