-- Create database
CREATE DATABASE join_practice_db;
USE join_practice_db;

-- Create Employees table
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT
);

-- Create Departments table
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Insert data into Employees
INSERT INTO Employees (emp_id, emp_name, dept_id)
VALUES
(1, 'Ali', 101),
(2, 'Sara', 102),
(3, 'Ahmed', 103),
(4, 'Fatima', NULL);

-- Insert data into Departments
INSERT INTO Departments (dept_id, dept_name)
VALUES
(101, 'HR'),
(102, 'Finance'),
(104, 'IT');

-- =========================================== OUTER JOIN (using UNION) =========================================
-- MySQL does not support OUTER JOIN directly, so we use LEFT JOIN + RIGHT JOIN + UNION

-- Example 1: Show all employees and all departments.
SELECT 
    e.emp_id,
    e.emp_name,
    d.dept_id,
    d.dept_name
FROM Employees e
LEFT JOIN Departments d
ON e.dept_id = d.dept_id
UNION
SELECT 
    e.emp_id,
    e.emp_name,
    d.dept_id,
    d.dept_name
FROM Employees e
RIGHT JOIN Departments d
ON e.dept_id = d.dept_id;

-- Example 2: Show only unmatched records.
SELECT 
    e.emp_id,
    e.emp_name,
    d.dept_name
FROM Employees e
LEFT JOIN Departments d
ON e.dept_id = d.dept_id
WHERE d.dept_id IS NULL
UNION
SELECT 
    e.emp_id,
    e.emp_name,
    d.dept_name
FROM Employees e
RIGHT JOIN Departments d
ON e.dept_id = d.dept_id
WHERE e.emp_id IS NULL;

-- Example 3: Count total records from full outer join.
SELECT COUNT(*) AS total_rows
FROM (
    SELECT 
        e.emp_id,
        e.emp_name,
        d.dept_name
    FROM Employees e
    LEFT JOIN Departments d
    ON e.dept_id = d.dept_id
    UNION
    SELECT 
        e.emp_id,
        e.emp_name,
        d.dept_name
    FROM Employees e
    RIGHT JOIN Departments d
    ON e.dept_id = d.dept_id
) AS outer_join_result;
