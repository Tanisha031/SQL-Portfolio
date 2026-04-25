CREATE DATABASE WarehouseDB;
USE WarehouseDB;

-- Table: Employees 
CREATE TABLE Employees (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    role VARCHAR(50),
    phone VARCHAR(20)
);

-- Table: Products
CREATE TABLE Products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50)
);

-- Table: Warehouse Entries (IN/OUT logs)
CREATE TABLE Entry_Log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    employee_id INT,
    entry_type VARCHAR(10), -- IN or OUT
    quantity INT,
    entry_date DATE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- Employees
INSERT INTO Employees (name, role, phone) VALUES
('Ali Khan','Manager','03001111111'),
('Sara Ahmed','Supervisor','03002222222'),
('Usman Ali','Worker','03003333333'),
('Ayesha Noor','Clerk','03004444444'),
('Bilal Ahmed','Worker','03005555555');

-- Products
INSERT INTO Products (product_name, category) VALUES
('Laptop','Electronics'),
('Mouse','Electronics'),
('Chair','Furniture'),
('Table','Furniture'),
('Printer','Electronics');

-- Entry Logs
INSERT INTO Entry_Log (product_id, employee_id, entry_type, quantity, entry_date) VALUES
(1,1,'IN',10,'2024-01-01'),
(2,2,'IN',20,'2024-01-02'),
(3,3,'OUT',5,'2024-01-03'),
(4,4,'IN',15,'2024-01-04'),
(5,5,'OUT',3,'2024-01-05');

-- View all entry logs
SELECT * FROM Entry_Log;

-- View all products
SELECT * FROM Products;

-- View all employees
SELECT * FROM Employees;

-- Join: Show product name with entry details
SELECT p.product_name, e.entry_type, e.quantity, e.entry_date
FROM Entry_Log e
JOIN Products p ON e.product_id = p.product_id;

-- Join: Show employee handling each entry
SELECT emp.name, p.product_name, e.entry_type, e.quantity
FROM Entry_Log e
JOIN Employees emp ON e.employee_id = emp.employee_id
JOIN Products p ON e.product_id = p.product_id;

-- Total IN quantity per product
SELECT p.product_name, SUM(e.quantity) AS total_in
FROM Entry_Log e
JOIN Products p ON e.product_id = p.product_id
WHERE e.entry_type = 'IN'
GROUP BY p.product_name;

-- Total OUT quantity per product
SELECT p.product_name, SUM(e.quantity) AS total_out
FROM Entry_Log e
JOIN Products p ON e.product_id = p.product_id
WHERE e.entry_type = 'OUT'
GROUP BY p.product_name;

-- Current stock (IN - OUT)
SELECT 
    p.product_name,
    SUM(CASE WHEN e.entry_type = 'IN' THEN e.quantity ELSE 0 END) -
    SUM(CASE WHEN e.entry_type = 'OUT' THEN e.quantity ELSE 0 END) AS current_stock
FROM Entry_Log e
JOIN Products p ON e.product_id = p.product_id
GROUP BY p.product_name;

-- Entries handled by a specific employee (example: employee_id = 1)
SELECT * FROM Entry_Log
WHERE employee_id = 1;

-- Latest entries
SELECT * FROM Entry_Log
ORDER BY entry_date DESC;

-- Count total entries by type
SELECT entry_type, COUNT(*) AS total_entries
FROM Entry_Log
GROUP BY entry_type;