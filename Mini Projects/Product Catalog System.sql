CREATE DATABASE ProductDB;
USE ProductDB;

CREATE TABLE Categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100)
);

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2),
    stock INT,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

INSERT INTO Categories (category_name) VALUES
('Electronics'),
('Clothing'),
('Furniture'),
('Books'),
('Toys');

INSERT INTO Products (product_name, price, stock, category_id) VALUES
('Laptop',80000,10,1),
('Shirt',2000,25,2),
('Chair',7000,15,3),
('Novel',500,40,4),
('Toy Car',800,20,5);

-- View all products
SELECT * FROM Products;

-- Products with category
SELECT p.product_name, c.category_name
FROM Products p
JOIN Categories c ON p.category_id = c.category_id;

-- Total stock
SELECT SUM(stock) AS total_stock FROM Products;

-- Expensive products (> 5000)
SELECT * FROM Products
WHERE price > 5000;