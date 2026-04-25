-- CREATE DATABASE
CREATE DATABASE supply_chain;
USE supply_chain;

-- CREATE SUPPLIERS TABLE
CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100),
    city VARCHAR(50),
    lead_time_days INT
);

-- CREATE PRODUCTS TABLE
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    unit_cost DECIMAL(10,2)
);

-- CREATE ORDERS TABLE
CREATE TABLE orders_data (
    order_id INT PRIMARY KEY,
    product_id INT,
    supplier_id INT,
    order_date DATE,
    expected_delivery DATE,
    actual_delivery DATE,
    quantity INT,
    warehouse VARCHAR(50),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

-- INSERT SUPPLIERS
INSERT INTO suppliers VALUES
(1, 'Alpha Logistics', 'Dubai', 5),
(2, 'Gulf Supply LLC', 'Sharjah', 7),
(3, 'Pak Trade Hub', 'Karachi', 6),
(4, 'Emirates Distribution', 'Abu Dhabi', 4);

-- INSERT PRODUCTS
INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 3200.00),
(102, 'Monitor', 'Electronics', 900.00),
(103, 'Keyboard', 'Accessories', 100.00),
(104, 'Office Chair', 'Furniture', 550.00);

-- INSERT ORDERS
INSERT INTO orders_data VALUES
(1001, 101, 1, '2026-03-01', '2026-03-06', '2026-03-05', 10, 'Dubai WH'),
(1002, 102, 2, '2026-03-02', '2026-03-09', '2026-03-11', 15, 'Sharjah WH'),
(1003, 103, 3, '2026-03-03', '2026-03-09', '2026-03-08', 50, 'Karachi WH'),
(1004, 104, 4, '2026-03-04', '2026-03-08', '2026-03-08', 20, 'Dubai WH'),
(1005, 101, 2, '2026-03-05', '2026-03-12', '2026-03-14', 8, 'Abu Dhabi WH');

-- TOTAL PROCUREMENT COST
SELECT 
    o.order_id,
    p.product_name,
    o.quantity,
    p.unit_cost,
    (o.quantity * p.unit_cost) AS total_cost
FROM orders_data o
JOIN products p
ON o.product_id = p.product_id;

-- SUPPLIER PERFORMANCE REPORT
SELECT
    s.supplier_name,
    COUNT(o.order_id) AS total_orders
FROM orders_data o
JOIN suppliers s
ON o.supplier_id = s.supplier_id
GROUP BY s.supplier_name
ORDER BY total_orders DESC;

-- LEAD TIME ANALYSIS
SELECT
    order_id,
    DATEDIFF(actual_delivery, order_date) AS actual_lead_time
FROM orders_data;

-- DELAY REPORT
SELECT
    order_id,
    expected_delivery,
    actual_delivery,
    DATEDIFF(actual_delivery, expected_delivery) AS delay_days
FROM orders_data
WHERE actual_delivery > expected_delivery;

-- WAREHOUSE WISE ORDER VOLUME
SELECT
    warehouse,
    SUM(quantity) AS total_quantity
FROM orders_data
GROUP BY warehouse
ORDER BY total_quantity DESC;

-- PRODUCT WISE PROCUREMENT COST
SELECT
    p.product_name,
    SUM(o.quantity * p.unit_cost) AS procurement_cost
FROM orders_data o
JOIN products p
ON o.product_id = p.product_id
GROUP BY p.product_name
ORDER BY procurement_cost DESC;

-- ON TIME DELIVERY KPI
SELECT
    COUNT(CASE WHEN actual_delivery <= expected_delivery THEN 1 END) * 100.0 / COUNT(*) AS on_time_delivery_percentage
FROM orders_data;

-- SUPPLIER RANKING
SELECT
    s.supplier_name,
    COUNT(o.order_id) AS total_orders,
    RANK() OVER (
        ORDER BY COUNT(o.order_id) DESC
    ) AS supplier_rank
FROM orders_data o
JOIN suppliers s
ON o.supplier_id = s.supplier_id
GROUP BY s.supplier_name;