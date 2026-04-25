--  CREATE DATABASE
CREATE DATABASE IF NOT EXISTS organization_db;
USE organization_db;

-- CREATE TABLES (Two Departments)

CREATE TABLE employees_hr (
    emp_id INT,
    emp_name VARCHAR(50),
    city VARCHAR(50),
    salary INT
);

CREATE TABLE employees_it (
    emp_id INT,
    emp_name VARCHAR(50),
    city VARCHAR(50),
    salary INT
);

-- INSERT DATA INTO HR
INSERT INTO employees_hr VALUES
(101, 'Ali',   'London', 50000),
(102, 'Sara',  'Rome',   60000),
(103, 'Ahmed', 'Madrid', 55000),
(104, 'John',  'Paris',  70000);

-- INSERT DATA INTO IT
-- =========================
INSERT INTO employees_it VALUES
(103, 'Ahmed', 'Madrid', 55000),
(104, 'John',  'Paris',  70000),
(105, 'Zara',  'Berlin', 48000),
(106, 'David', 'Rome',   72000);

-- ================================================   Exampes   ==============================================

-- 1. UNION (Remove duplicates)
-- Combine HR + IT employees
SELECT emp_id, emp_name, city, salary
FROM employees_hr
UNION
SELECT emp_id, emp_name, city, salary
FROM employees_it;

-- 2. UNION ALL (Keeps duplicates)
SELECT emp_id, emp_name, city, salary
FROM employees_hr
UNION ALL
SELECT emp_id, emp_name, city, salary
FROM employees_it;

-- 3. INTERSECT (MySQL alternative using INNER JOIN)
-- Common employees in HR and IT
SELECT hr.emp_id, hr.emp_name, hr.city, hr.salary
FROM employees_hr hr
INNER JOIN employees_it it
ON hr.emp_id = it.emp_id;

-- 4. EXCEPT (MySQL alternative using LEFT JOIN)
-- Employees in HR but NOT in IT
SELECT hr.emp_id, hr.emp_name, hr.city, hr.salary
FROM employees_hr hr
LEFT JOIN employees_it it
ON hr.emp_id = it.emp_id
WHERE it.emp_id IS NULL;

-- 5. REVERSE EXCEPT (IT but NOT HR)
SELECT it.emp_id, it.emp_name, it.city, it.salary
FROM employees_it it
LEFT JOIN employees_hr hr
ON it.emp_id = hr.emp_id
WHERE hr.emp_id IS NULL;

-- 6. PRACTICAL BUSINESS USE CASE
-- Find all employees working in organization (no duplicates)
SELECT emp_id, emp_name, city, salary
FROM employees_hr
UNION
SELECT emp_id, emp_name, city, salary
FROM employees_it;
