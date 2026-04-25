-- Use database
USE join_practice_db;

-- Drop old tables if already exist
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;

-- Create Employees table
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50)
);

-- Create Departments table
CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Insert sample data into Employees
INSERT INTO Employees (emp_id, emp_name)
VALUES
(1, 'Ali'),
(2, 'Sara'),
(3, 'Ahmed');

-- Insert sample data into Departments
INSERT INTO Departments (dept_id, dept_name)
VALUES
(101, 'HR'),
(102, 'Finance'),
(103, 'IT');

-- ============================================== CROSS JOIN =====================================================
-- QUERY 1: Show all possible employee-department combinations
SELECT 
    e.emp_name,
    d.dept_name
FROM Employees e
CROSS JOIN Departments d;

-- QUERY 2: Count total combinations
SELECT 
    COUNT(*) AS total_combinations
FROM Employees e
CROSS JOIN Departments d;

-- QUERY 3: Show combinations only for Sara
SELECT 
    e.emp_name,
    d.dept_name
FROM Employees e
CROSS JOIN Departments d
WHERE e.emp_name = 'Sara';