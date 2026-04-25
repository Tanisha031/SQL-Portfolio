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


-- =============================================== RIGHT JOIN ==========================================

-- Example 1: Show all departments with employee names
SELECT 
    d.dept_name,
    e.emp_name
FROM Employees e
RIGHT JOIN Departments d
ON e.dept_id = d.dept_id;

-- Example 2: Show only departments with no employees
SELECT 
    d.dept_id,
    d.dept_name
FROM Employees e
RIGHT JOIN Departments d
ON e.dept_id = d.dept_id
WHERE e.emp_id IS NULL;

-- Example 3: Count employees in each department
SELECT 
    d.dept_name,
    COUNT(e.emp_id) AS total_employees
FROM Employees e
RIGHT JOIN Departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name;