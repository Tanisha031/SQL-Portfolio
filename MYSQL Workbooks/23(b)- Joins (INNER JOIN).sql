-- Use database
USE join_practice_db;

-- Drop old tables if already exist
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;

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

-- ==================================================== INNER JOIN =====================================================

-- Query 1: Show employee names with departments
SELECT 
    e.emp_name,
    d.dept_name
FROM Employees e
INNER JOIN Departments d
ON e.dept_id = d.dept_id;

-- Query 2: Count employees in each department
SELECT 
    d.dept_name,
    COUNT(e.emp_id) AS total_employees
FROM Employees e
INNER JOIN Departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- Query 3: Show only Finance department employees
SELECT 
    e.emp_name,
    d.dept_name
FROM Employees e
INNER JOIN Departments d
ON e.dept_id = d.dept_id
WHERE d.dept_name = 'Finance';