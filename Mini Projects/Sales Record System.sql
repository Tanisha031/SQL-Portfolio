CREATE DATABASE SalesDB;
USE SalesDB;

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE Sales (
    sale_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,
    sale_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);

INSERT INTO Customers (name, phone, email) VALUES
('Ali','03001111111','ali@gmail.com'),
('Sara','03002222222','sara@gmail.com'),
('Usman','03003333333','usman@gmail.com'),
('Ayesha','03004444444','ayesha@gmail.com'),
('Bilal','03005555555','bilal@gmail.com');

INSERT INTO Products (product_name, price) VALUES
('Laptop',80000),
('Mouse',1500),
('Keyboard',3000),
('Monitor',25000),
('Printer',20000);

INSERT INTO Sales (customer_id, product_id, quantity, sale_date) VALUES
(1,1,1,'2024-03-01'),
(2,2,2,'2024-03-02'),
(3,3,1,'2024-03-03'),
(4,4,1,'2024-03-04'),
(5,5,1,'2024-03-05');

-- View all sales
SELECT * FROM Sales;

-- Total sales amount per product
SELECT p.product_name, SUM(s.quantity * p.price) AS total_sales
FROM Sales s
JOIN Products p ON s.product_id = p.product_id
GROUP BY p.product_name;

-- Sales per customer
SELECT c.name, COUNT(s.sale_id) AS total_orders
FROM Sales s
JOIN Customers c ON s.customer_id = c.customer_id
GROUP BY c.name;

-- Latest sales
SELECT * FROM Sales
ORDER BY sale_date DESC;