-- Use existing database
USE join_practice_db;

-- Drop tables if already exist (optional for fresh practice)
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

-- ================================================== LEFT JOIN ==============================================

-- Query 1: Show all employees with department names
SELECT 
    e.emp_name,
    d.dept_name
FROM Employees e
LEFT JOIN Departments d
ON e.dept_id = d.dept_id;

-- Query 2: Show employees without valid departments
SELECT 
    e.emp_id,
    e.emp_name
FROM Employees e
LEFT JOIN Departments d
ON e.dept_id = d.dept_id
WHERE d.dept_id IS NULL;

-- Query 3: Count employees department-wise
SELECT 
    d.dept_name,
    COUNT(e.emp_id) AS total_employees
FROM Employees e
LEFT JOIN Departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name;
