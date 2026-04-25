-- CREATE DATABASE
CREATE DATABASE inventory_management_project;
USE inventory_management_project;

-- CREATE PRODUCTS TABLE
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    supplier_name VARCHAR(100),
    reorder_level INT,
    unit_price DECIMAL(10,2)
);

-- CREATE WAREHOUSE STOCK TABLE
CREATE TABLE inventory_stock (
    stock_id INT PRIMARY KEY,
    product_id INT,
    warehouse_location VARCHAR(50),
    stock_quantity INT,
    last_updated DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- CREATE SALES MOVEMENT TABLE
CREATE TABLE stock_movement (
    movement_id INT PRIMARY KEY,
    product_id INT,
    movement_type VARCHAR(20),
    quantity INT,
    movement_date DATE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- INSERT PRODUCTS
INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 'Tech Supplies LLC', 10, 3500.00),
(102, 'Keyboard', 'Accessories', 'Input Devices LLC', 20, 120.00),
(103, 'Printer', 'Office Equipment', 'Office Pro LLC', 8, 800.00),
(104, 'Monitor', 'Electronics', 'Display Hub LLC', 15, 950.00),
(105, 'Desk Chair', 'Furniture', 'Workspace LLC', 12, 600.00);

-- INSERT INVENTORY STOCK
INSERT INTO inventory_stock VALUES
(1, 101, 'Dubai Warehouse', 18, '2026-04-01'),
(2, 102, 'Dubai Warehouse', 35, '2026-04-01'),
(3, 103, 'Sharjah Warehouse', 5, '2026-04-01'),
(4, 104, 'Dubai Warehouse', 11, '2026-04-01'),
(5, 105, 'Abu Dhabi Warehouse', 7, '2026-04-01');

-- INSERT STOCK MOVEMENTS
INSERT INTO stock_movement VALUES
(1, 101, 'OUT', 2, '2026-03-25'),
(2, 102, 'OUT', 5, '2026-03-26'),
(3, 103, 'OUT', 3, '2026-03-27'),
(4, 104, 'IN', 10, '2026-03-28'),
(5, 105, 'OUT', 4, '2026-03-29'),
(6, 101, 'IN', 5, '2026-03-30');

-- CURRENT STOCK REPORT
SELECT 
    p.product_name,
    i.warehouse_location,
    i.stock_quantity,
    p.reorder_level
FROM inventory_stock i
JOIN products p 
ON i.product_id = p.product_id;

-- LOW STOCK ALERT REPORT
SELECT 
    p.product_name,
    i.stock_quantity,
    p.reorder_level
FROM inventory_stock i
JOIN products p
ON i.product_id = p.product_id
WHERE i.stock_quantity <= p.reorder_level;

-- STOCK VALUE REPORT
SELECT 
    p.product_name,
    i.stock_quantity,
    p.unit_price,
    (i.stock_quantity * p.unit_price) AS stock_value
FROM inventory_stock i
JOIN products p
ON i.product_id = p.product_id
ORDER BY stock_value DESC;

-- STOCK MOVEMENT REPORT
SELECT 
    p.product_name,
    s.movement_type,
    s.quantity,
    s.movement_date
FROM stock_movement s
JOIN products p
ON s.product_id = p.product_id
ORDER BY s.movement_date;

-- FAST MOVING PRODUCTS
SELECT 
    p.product_name,
    SUM(s.quantity) AS total_movement
FROM stock_movement s
JOIN products p
ON s.product_id = p.product_id
WHERE s.movement_type = 'OUT'
GROUP BY p.product_name
ORDER BY total_movement DESC;

-- WAREHOUSE WISE STOCK SUMMARY
SELECT 
    warehouse_location,
    SUM(stock_quantity) AS total_stock
FROM inventory_stock
GROUP BY warehouse_location;

-- REORDER STATUS USING CASE
SELECT 
    p.product_name,
    i.stock_quantity,
    p.reorder_level,
    CASE
        WHEN i.stock_quantity <= p.reorder_level THEN 'Reorder Required'
        ELSE 'Stock Sufficient'
    END AS inventory_status
FROM inventory_stock i
JOIN products p
ON i.product_id = p.product_id;

-- PRODUCT RANKING BY STOCK VALUE
SELECT
    p.product_name,
    (i.stock_quantity * p.unit_price) AS stock_value,
    RANK() OVER (
        ORDER BY (i.stock_quantity * p.unit_price) DESC
    ) AS stock_rank
FROM inventory_stock i
JOIN products p
ON i.product_id = p.product_id;