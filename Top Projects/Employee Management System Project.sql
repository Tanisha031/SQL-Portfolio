-- Create Database
CREATE DATABASE employee_management;
USE employee_management;

-- Create Tables
-- Department Table
CREATE TABLE departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL,
    location VARCHAR(100)
);

-- Employees Table
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    hire_date DATE,
    job_title VARCHAR(100),
    salary DECIMAL(10,2),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Attendance Table
CREATE TABLE attendance (
    att_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    att_date DATE,
    status ENUM('Present', 'Absent', 'Leave'),
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- Salary History Table
CREATE TABLE salary_history (
    salary_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_id INT,
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    change_date DATE,
    FOREIGN KEY (emp_id) REFERENCES employees(emp_id)
);

-- Insert Sample Data
-- Departments
INSERT INTO departments (dept_name, location)
VALUES 
('HR', 'Dubai'),
('IT', 'Sharjah'),
('Finance', 'Abu Dhabi'),
('Sales', 'Dubai');

-- Employees
INSERT INTO employees (first_name, last_name, email, phone, hire_date, job_title, salary, dept_id)
VALUES
('Ali', 'Khan', 'ali@example.com', '03001234567', '2023-01-10', 'HR Manager', 8000, 1),
('Sara', 'Ahmed', 'sara@example.com', '03007654321', '2022-05-15', 'Software Engineer', 12000, 2),
('John', 'Smith', 'john@example.com', '03001112233', '2021-08-20', 'Accountant', 9000, 3),
('Ayesha', 'Malik', 'ayesha@example.com', '03004445566', '2023-03-05', 'Sales Executive', 7000, 4);

-- Attendance
INSERT INTO attendance (emp_id, att_date, status)
VALUES
(1, '2026-04-01', 'Present'),
(2, '2026-04-01', 'Present'),
(3, '2026-04-01', 'Absent'),
(4, '2026-04-01', 'Present');

-- Queries
-- 1. Employee List with Department
SELECT 
    e.emp_id,
    e.first_name,
    e.last_name,
    d.dept_name,
    e.job_title,
    e.salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id;

-- 2. Department-wise Employee Count
SELECT 
    d.dept_name,
    COUNT(e.emp_id) AS total_employees
FROM departments d
LEFT JOIN employees e ON d.dept_id = e.dept_id
GROUP BY d.dept_name;

-- 3. Highest Salary Employee
SELECT *
FROM employees
ORDER BY salary DESC
LIMIT 1;

-- 4. Average Salary by Department
SELECT 
    d.dept_name,
    AVG(e.salary) AS avg_salary
FROM employees e
JOIN departments d ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- 5. Attendance Report (Present Count)
SELECT 
    e.first_name,
    e.last_name,
    COUNT(a.status) AS days_present
FROM employees e
JOIN attendance a ON e.emp_id = a.emp_id
WHERE a.status = 'Present'
GROUP BY e.emp_id;

-- 6. Employees Joined in Last 1 Year
SELECT *
FROM employees
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

-- 7. Salary Change Tracking
SELECT 
    e.first_name,
    e.last_name,
    s.old_salary,
    s.new_salary,
    s.change_date
FROM salary_history s
JOIN employees e ON s.emp_id = e.emp_id