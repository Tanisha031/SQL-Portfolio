-- ONLINE STORE DATABASE
CREATE DATABASE OnlineStoreDB;
USE OnlineStoreDB;

-- TABLES
-- Products
CREATE TABLE Products (
    product_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(25) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    category VARCHAR(50)
);

-- Customers
CREATE TABLE Customers (
    customer_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(25) NOT NULL,
    email VARCHAR(25) UNIQUE NOT NULL,
    phone_number VARCHAR(15),
    address VARCHAR(55)
);

-- Orders
CREATE TABLE Orders (
    order_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE NOT NULL,
    status ENUM('Pending', 'Completed', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Payment
CREATE TABLE Payments (
    payment_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    payment_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_status ENUM('Paid', 'Unpaid') DEFAULT 'Unpaid',
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- Inventory
CREATE TABLE Inventory (
    inventory_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    stock_quantity INT DEFAULT 0,
    last_updated DATE DEFAULT (CURRENT_DATE),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

-- SAMPLE DATA

INSERT INTO Products (name, description, price, category) VALUES 
('Laptop', 'A high-performance laptop', 1200.00, 'Electronics'),
('Headphones', 'Wireless noise-cancelling headphones', 200.00, 'Electronics'),
('Book', 'Inspirational novel', 15.00, 'Books');

INSERT INTO Customers (name, email, phone_number, address) VALUES 
('John Doe', 'john@example.com', '1234567890', '123 Main St'),
('Jane Smith', 'jane@example.com', '0987654321', '456 Elm St');

INSERT INTO Orders (customer_id, order_date, status) VALUES 
(1, '2024-10-21', 'Pending'),
(2, '2024-10-20', 'Completed');

INSERT INTO Payments (order_id, payment_date, amount, payment_status) VALUES 
(1, '2024-10-21', 1200.00, 'Paid'),
(2, '2024-10-20', 200.00, 'Paid');

INSERT INTO Inventory (product_id, stock_quantity, last_updated) VALUES 
(1, 50, '2024-10-20'),
(2, 100, '2024-10-19'),
(3, 200, '2024-10-18');


-- QUERIES
-- 1. View all products
SELECT * FROM Products;

-- 2. Check product availability
SELECT name, stock_quantity
FROM Products p
JOIN Inventory i ON p.product_id = i.product_id
WHERE stock_quantity > 0;

-- 3. Get customer details
SELECT * FROM Customers WHERE customer_id = 1;

-- 4. Orders with payment status
SELECT o.order_id, o.order_date, p.payment_status
FROM Orders o
JOIN Payments p ON o.order_id = p.order_id;

-- 5. Pending payments
SELECT * FROM Payments WHERE payment_status = 'Unpaid';

-- 6. Total sales per product
SELECT p.name, SUM(pay.amount) AS total_sales
FROM Products p
JOIN Orders o ON p.product_id = o.order_id
JOIN Payments pay ON o.order_id = pay.order_id
GROUP BY p.product_id;

-- 7. Completed orders last month
SELECT * FROM Orders
WHERE status = 'Completed'
AND order_date > CURDATE() - INTERVAL 1 MONTH;

-- 8. Inventory restocking
SELECT name, stock_quantity
FROM Products p
JOIN Inventory i ON p.product_id = i.product_id
WHERE stock_quantity < 20;

-- 9. Customers with multiple orders
SELECT c.name, COUNT(o.order_id) AS order_count
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING order_count > 1;

-- 10. Average order value
SELECT AVG(amount) AS avg_order_value FROM Payments;

-- 11. Highest paying customer
SELECT c.name, SUM(p.amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Payments p ON o.order_id = p.order_id
GROUP BY c.customer_id
ORDER BY total_spent DESC
LIMIT 1;

-- 12. Total sales per month
SELECT 
    MONTH(payment_date) AS month_number,
    SUM(amount) AS total_sales
FROM Payments
GROUP BY MONTH(payment_date)
ORDER BY month_number;

-- 13. Orders by date range
SELECT * FROM Orders
WHERE order_date BETWEEN '2024-10-01' AND '2024-10-31';

-- 14. Cancelled orders
SELECT * FROM Orders WHERE status = 'Cancelled';

-- 15. Customers with unpaid orders
SELECT c.name, p.payment_status
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Payments p ON o.order_id = p.order_id
WHERE p.payment_status = 'Unpaid';

-- 16. Top 3 most sold products
SELECT p.name, SUM(i.stock_quantity) AS total_sold
FROM Orders o
JOIN Products p ON o.order_id = p.product_id
JOIN Inventory i ON p.product_id = i.product_id
WHERE o.status = 'Completed'
GROUP BY p.product_id
ORDER BY total_sold DESC
LIMIT 3;

-- 17. Inactive customers (6 months)
SELECT c.name, MAX(o.order_date) AS last_order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING MAX(o.order_date) < CURDATE() - INTERVAL 6 MONTH
OR MAX(o.order_date) IS NULL;

-- 18. Products without orders
SELECT p.name
FROM Products p
LEFT JOIN Orders o ON p.product_id = o.order_id
WHERE o.order_id IS NULL;

-- 19. Revenue by category
SELECT p.category, SUM(pay.amount) AS total_revenue
FROM Products p
JOIN Orders o ON p.product_id = o.order_id
JOIN Payments pay ON o.order_id = pay.order_id
GROUP BY p.category
ORDER BY total_revenue DESC;

-- 20. High risk customers
SELECT c.name, COUNT(o.order_id) AS canceled_orders
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
WHERE o.status = 'Cancelled'
GROUP BY c.customer_id
HAVING COUNT(o.order_id) > 2;

-- 21. Avg payment time
SELECT c.name, AVG(DATEDIFF(pay.payment_date, o.order_date)) AS avg_payment_time
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Payments pay ON o.order_id = pay.order_id
GROUP BY c.customer_id;

-- 22. Products ordered by >5 customers
SELECT p.name, COUNT(DISTINCT o.customer_id) AS unique_customers
FROM Products p
JOIN Orders o ON p.product_id = o.order_id
GROUP BY p.product_id
HAVING COUNT(DISTINCT o.customer_id) > 5;

-- 23. Monthly sales growth
SELECT 
    MONTH(payment_date) AS month,
    SUM(amount) AS total_sales
FROM Payments
GROUP BY MONTH(payment_date);

-- 24. Customer retention
SELECT c.name,
       COUNT(DISTINCT MONTH(o.order_date)) AS active_months
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id
HAVING active_months > 1;

-- 25. Overdue payments
SELECT o.order_id,
       c.name,
       pay.payment_status,
       DATEDIFF(CURDATE(), o.order_date) AS days_since_order
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN Payments pay ON o.order_id = pay.order_id
WHERE pay.payment_status = 'Unpaid'
AND DATEDIFF(CURDATE(), o.order_date) > 30;