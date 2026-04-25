-- 1. CREATE DATABASE
CREATE DATABASE IF NOT EXISTS Retail;
USE Retail;

-- 2. TABLES STRUCTURE
-- Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    gender VARCHAR(10),
    city VARCHAR(50),
    join_date DATE
);

-- Products Table
CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_price DECIMAL(10,2),
    cost_price DECIMAL(10,2)
);

-- Employees Table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    hire_date DATE
);

-- Sales Table
CREATE TABLE Sales (
    sale_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    product_id INT,
    employee_id INT,
    quantity INT,
    sale_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- SAMPLE DATA INSERTION
-- Customers
INSERT INTO Customers (full_name, gender, city, join_date) VALUES
('Ali Khan', 'Male', 'Karachi', '2024-01-10'),
('Sara Ahmed', 'Female', 'Lahore', '2024-02-15'),
('Usman Tariq', 'Male', 'Dubai', '2024-03-01'),
('Ayesha Malik', 'Female', 'Karachi', '2024-03-20');

-- Products
INSERT INTO Products (product_name, category, unit_price, cost_price) VALUES
('Laptop', 'Electronics', 1200.00, 900.00),
('Mobile Phone', 'Electronics', 800.00, 600.00),
('Office Chair', 'Furniture', 150.00, 100.00),
('Table', 'Furniture', 200.00, 130.00);

-- Employees
INSERT INTO Employees (employee_name, department, hire_date) VALUES
('John Smith', 'Sales', '2023-01-01'),
('David Brown', 'Sales', '2023-06-10');

-- Sales
INSERT INTO Sales (customer_id, product_id, employee_id, quantity, sale_date) VALUES
(1, 1, 1, 2, '2025-01-05'),
(2, 2, 1, 1, '2025-01-10'),
(3, 3, 2, 5, '2025-01-12'),
(4, 4, 2, 3, '2025-01-15'),
(1, 2, 1, 1, '2025-02-01'),
(2, 1, 2, 1, '2025-02-05');

-- VIEWS
-- Profit Analysis View
CREATE VIEW vw_profit_analysis AS
SELECT 
    s.sale_id,
    p.product_name,
    s.quantity,
    p.unit_price,
    p.cost_price,
    (p.unit_price - p.cost_price) * s.quantity AS profit
FROM Sales s
JOIN Products p ON s.product_id = p.product_id;

-- Top Selling Products
CREATE VIEW vw_top_products AS
SELECT 
    p.product_name,
    SUM(s.quantity) AS total_sold
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

-- Monthly Sales Report
CREATE VIEW vw_monthly_sales AS
SELECT 
    DATE_FORMAT(s.sale_date, '%Y-%m') AS sales_month,
    SUM(s.quantity * p.unit_price) AS monthly_revenue
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY sales_month;

-- Employee Performance
CREATE VIEW vw_employee_performance AS
SELECT 
    e.employee_name,
    SUM(s.quantity * p.unit_price) AS total_sales
FROM Sales s
JOIN Employees e ON s.employee_id = e.employee_id
JOIN Products p ON s.product_id = p.product_id
GROUP BY e.employee_name;

-- Queries
-- Check all data in tables
SELECT * FROM Customers;
SELECT * FROM Products;
SELECT * FROM Employees;
SELECT * FROM Sales;

-- Total revenue generated
SELECT 
    SUM(s.quantity * p.unit_price) AS total_revenue
FROM Sales s
JOIN Products p ON s.product_id = p.product_id;

-- Total profit calculation
SELECT 
    SUM((p.unit_price - p.cost_price) * s.quantity) AS total_profit
FROM Sales s
JOIN Products p ON s.product_id = p.product_id;

-- Top 3 best-selling products
SELECT 
    p.product_name,
    SUM(s.quantity) AS total_sold
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 3;

-- Sales by city (customer insight KPI)
SELECT 
    c.city,
    SUM(s.quantity * p.unit_price) AS city_sales
FROM Sales s
JOIN Customers c ON s.customer_id = c.customer_id
JOIN Products p ON s.product_id = p.product_id
GROUP BY c.city
ORDER BY city_sales DESC;

-- Employee performance ranking
SELECT 
    e.employee_name,
    SUM(s.quantity * p.unit_price) AS total_sales
FROM Sales s
JOIN Employees e ON s.employee_id = e.employee_id
JOIN Products p ON s.product_id = p.product_id
GROUP BY e.employee_name
ORDER BY total_sales DESC;

-- Monthly sales
SELECT 
    DATE_FORMAT(s.sale_date, '%Y-%m') AS month,
    SUM(s.quantity * p.unit_price) AS monthly_revenue
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY month
ORDER BY month;

-- Average order value (AOV KPI)
SELECT 
    AVG(order_total) AS avg_order_value
FROM (
    SELECT 
        s.sale_id,
        SUM(s.quantity * p.unit_price) AS order_total
    FROM Sales s
    JOIN Products p ON s.product_id = p.product_id
    GROUP BY s.sale_id
) AS sub;

-- Find high-value customers (VIP customers)
SELECT 
    c.full_name,
    SUM(s.quantity * p.unit_price) AS total_spent
FROM Sales s
JOIN Customers c ON s.customer_id = c.customer_id
JOIN Products p ON s.product_id = p.product_id
GROUP BY c.full_name
HAVING total_spent > 1000
ORDER BY total_spent DESC;

-- Find product profitability ranking
SELECT 
    p.product_name,
    SUM((p.unit_price - p.cost_price) * s.quantity) AS profit
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY profit DESC;

-- Full sales report (very important)
SELECT 
    s.sale_id,
    c.full_name AS customer,
    p.product_name,
    e.employee_name,
    s.quantity,
    s.sale_date,
    (s.quantity * p.unit_price) AS total_sale_value
FROM Sales s
JOIN Customers c ON s.customer_id = c.customer_id
JOIN Products p ON s.product_id = p.product_id
JOIN Employees e ON s.employee_id = e.employee_id;
