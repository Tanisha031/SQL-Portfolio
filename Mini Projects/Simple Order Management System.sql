CREATE DATABASE OrderDB;
USE OrderDB;

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(50),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    product_name VARCHAR(100),
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

INSERT INTO Customers (name, phone, email) VALUES
('Ali','03001111111','ali@gmail.com'),
('Sara','03002222222','sara@gmail.com'),
('Usman','03003333333','usman@gmail.com'),
('Ayesha','03004444444','ayesha@gmail.com'),
('Bilal','03005555555','bilal@gmail.com');

INSERT INTO Orders (customer_id, order_date, total_amount, status) VALUES
(1,'2024-07-01',5000,'Delivered'),
(2,'2024-07-02',3000,'Pending'),
(3,'2024-07-03',4500,'Delivered'),
(4,'2024-07-04',2000,'Cancelled'),
(5,'2024-07-05',3500,'Delivered');

INSERT INTO Order_Items (order_id, product_name, quantity, price) VALUES
(1,'Laptop',1,5000),
(2,'Mouse',2,1500),
(3,'Keyboard',1,2000),
(4,'Monitor',1,2000),
(5,'Printer',1,3500);

-- View all orders
SELECT * FROM Orders;

-- Total revenue
SELECT SUM(total_amount) AS revenue FROM Orders;

-- Orders by status
SELECT status, COUNT(*) AS total
FROM Orders
GROUP BY status;

-- Join: Customer + Orders
SELECT c.name, o.order_date, o.total_amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id;