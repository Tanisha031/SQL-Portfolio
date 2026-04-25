-- CREATE DATABASE
CREATE DATABASE sales_analysis_project;
USE sales_analysis_project;

-- CREATE CUSTOMERS TABLE
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(50),
    segment VARCHAR(50)
);

-- CREATE PRODUCTS TABLE
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

-- CREATE SALES TABLE
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    sale_date DATE,
    region VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- INSERT CUSTOMER DATA
INSERT INTO customers VALUES
(1, 'Ali Khan', 'Dubai', 'Corporate'),
(2, 'Sara Ahmed', 'Abu Dhabi', 'Retail'),
(3, 'John Smith', 'Sharjah', 'Corporate'),
(4, 'Ayesha Malik', 'Dubai', 'Retail');

-- INSERT PRODUCT DATA
INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 3500.00),
(102, 'Mobile Phone', 'Electronics', 2200.00),
(103, 'Printer', 'Office Supplies', 800.00),
(104, 'Desk Chair', 'Furniture', 600.00);

-- INSERT SALES DATA
INSERT INTO sales VALUES
(1001, 1, 101, 2, '2026-01-10', 'Dubai'),
(1002, 2, 102, 1, '2026-01-12', 'Abu Dhabi'),
(1003, 3, 103, 3, '2026-01-15', 'Sharjah'),
(1004, 4, 104, 4, '2026-01-18', 'Dubai'),
(1005, 1, 102, 2, '2026-02-01', 'Dubai'),
(1006, 2, 101, 1, '2026-02-05', 'Abu Dhabi');

-- TOTAL SALES REPORT
SELECT 
    s.sale_id,
    c.customer_name,
    p.product_name,
    s.quantity,
    p.price,
    (s.quantity * p.price) AS total_sales
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN products p ON s.product_id = p.product_id;

-- MONTHLY SALES TREND
SELECT 
    MONTH(sale_date) AS sales_month,
    SUM(quantity * p.price) AS monthly_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY MONTH(sale_date)
ORDER BY sales_month;

-- REGION WISE SALES
SELECT 
    region,
    SUM(quantity * p.price) AS total_revenue
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY region
ORDER BY total_revenue DESC;

-- TOP SELLING PRODUCTS
SELECT 
    p.product_name,
    SUM(s.quantity) AS total_units_sold
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_units_sold DESC;

-- CUSTOMER SEGMENT REPORT
SELECT 
    c.segment,
    SUM(s.quantity * p.price) AS total_sales
FROM sales s
JOIN customers c ON s.customer_id = c.customer_id
JOIN products p ON s.product_id = p.product_id
GROUP BY c.segment;

-- WINDOW FUNCTION FOR RANKING PRODUCTS
SELECT 
    p.product_name,
    SUM(s.quantity * p.price) AS revenue,
    RANK() OVER (ORDER BY SUM(s.quantity * p.price) DESC) AS sales_rank
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name;