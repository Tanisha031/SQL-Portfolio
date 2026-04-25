CREATE DATABASE InventoryDB;
USE InventoryDB;

CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT
);

CREATE TABLE Suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100),
    contact VARCHAR(20)
);

CREATE TABLE Stock_In (
    stock_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    supplier_id INT,
    quantity INT,
    date_received DATE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id)
);

INSERT INTO Products (product_name, category, price, stock_quantity) VALUES
('Laptop','Electronics',80000,10),
('Mouse','Electronics',1500,50),
('Keyboard','Electronics',3000,30),
('Chair','Furniture',7000,15),
('Table','Furniture',12000,8);

INSERT INTO Suppliers (supplier_name, contact) VALUES
('ABC Traders','03001111111'),
('XYZ Suppliers','03002222222'),
('Tech Hub','03003333333'),
('Office Mart','03004444444'),
('Global Supply','03005555555');

INSERT INTO Stock_In (product_id, supplier_id, quantity, date_received) VALUES
(1,1,5,'2024-02-01'),
(2,2,10,'2024-02-02'),
(3,3,8,'2024-02-03'),
(4,4,6,'2024-02-04'),
(5,5,4,'2024-02-05');

-- View all products
SELECT * FROM Products;

-- Low stock products (< 20)
SELECT * FROM Products
WHERE stock_quantity < 20;

-- Total stock by category
SELECT category, SUM(stock_quantity) AS total_stock
FROM Products
GROUP BY category;

-- Join: Product with Supplier
SELECT p.product_name, s.supplier_name, si.quantity
FROM Stock_In si
JOIN Products p ON si.product_id = p.product_id
JOIN Suppliers s ON si.supplier_id = s.supplier_id;