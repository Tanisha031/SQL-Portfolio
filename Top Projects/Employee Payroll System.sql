-- Create Database
CREATE DATABASE EmpPayrollDB;
USE EmpPayrollDB;

-- TABLE: Employees
CREATE TABLE Employees (
    employee_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    employee_name VARCHAR(255) NOT NULL,
    department VARCHAR(100),
    position VARCHAR(100),
    hire_date DATE,
    base_salary DECIMAL(10, 2) NOT NULL
);

-- TABLE: Attendance
CREATE TABLE Attendance (
    attendance_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    attendance_date DATE,
    status ENUM('Present', 'Absent', 'Leave'),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- TABLE: Salaries
CREATE TABLE Salaries (
    salary_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    base_salary DECIMAL(10, 2) NOT NULL,
    bonus DECIMAL(10, 2),
    deductions DECIMAL(10, 2),
    month VARCHAR(20),
    year INT,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- TABLE: Payroll
CREATE TABLE Payroll (
    payroll_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    total_salary DECIMAL(10, 2),
    payment_date DATE,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- SAMPLE DATA INSERTION
INSERT INTO Employees (employee_name, department, position, hire_date, base_salary) VALUES 
('Alan Vince', 'Finance', 'Manager', '2020-01-15', 50000.00),
('Alex Kent', 'HR', 'HR Specialist', '2019-03-10', 40000.00),
('Jennith Kery', 'Sales', 'Sales Executive', '2023-10-01', 30000.00);

INSERT INTO Attendance (employee_id, attendance_date, status) VALUES 
(1, '2023-09-01', 'Present'),
(2, '2023-09-01', 'Leave'),
(1, '2023-09-02', 'Present');

INSERT INTO Salaries (employee_id, base_salary, bonus, deductions, month, year) VALUES 
(1, 50000.00, 5000.00, 2000.00, 'September', 2023),
(2, 40000.00, 3000.00, 1000.00, 'September', 2023);

INSERT INTO Payroll (employee_id, total_salary, payment_date) VALUES 
(1, 53000.00, '2023-09-30');

-- QUERIES 
-- Add new employee
INSERT INTO Employees (employee_name, department, position, hire_date, base_salary)
VALUES ('Jennith Kery', 'Sales', 'Sales Executive', '2023-10-01', 30000.00);

-- Update employee salary
SET SQL_SAFE_UPDATES = 0;
UPDATE Employees
SET base_salary = 55000.00
WHERE employee_id = 1;

-- Delete employee
DELETE FROM Employees
WHERE employee_id = 3;

-- View employees
SELECT * FROM Employees;

-- Track attendance
SELECT * FROM Attendance;

-- Salary calculation
SELECT employee_id, (base_salary + bonus - deductions) AS total_salary
FROM Salaries
WHERE employee_id = 1 AND month = 'September' AND year = 2023;

-- Insert payroll record
INSERT INTO Payroll (employee_id, total_salary, payment_date)
VALUES (1, 53000.00, '2023-09-30');

-- Generate payslip
SELECT e.employee_name, s.base_salary, s.bonus, s.deductions, p.total_salary, p.payment_date
FROM Employees e
JOIN Salaries s ON e.employee_id = s.employee_id
JOIN Payroll p ON e.employee_id = p.employee_id
WHERE e.employee_id = 1 AND s.month = 'September' AND s.year = 2023;

-- Payroll summary
SELECT e.employee_name, p.total_salary, p.payment_date
FROM Payroll p
JOIN Employees e ON p.employee_id = e.employee_id;

-- Department wise listing
SELECT department, employee_name
FROM Employees
ORDER BY department, employee_name;

-- Attendance summary
SELECT employee_id,
       SUM(CASE WHEN status = 'Present' THEN 1 ELSE 0 END) AS present_days,
       SUM(CASE WHEN status = 'Absent' THEN 1 ELSE 0 END) AS absent_days,
       SUM(CASE WHEN status = 'Leave' THEN 1 ELSE 0 END) AS leave_days
FROM Attendance
WHERE attendance_date BETWEEN '2023-09-01' AND '2023-09-30'
GROUP BY employee_id;

-- Employees above salary threshold
SELECT employee_name, base_salary
FROM Employees
WHERE base_salary > 50000;

-- Total deductions per employee
SELECT employee_id, SUM(deductions) AS total_deductions
FROM Salaries
WHERE month = 'September' AND year = 2023
GROUP BY employee_id;

-- Average salary per department
SELECT department, AVG(base_salary) AS average_salary
FROM Employees
WHERE department = 'Sales'
GROUP BY department;

-- Attendance on specific date
SELECT e.employee_name, a.status
FROM Employees e
JOIN Attendance a ON e.employee_id = a.employee_id
WHERE a.attendance_date = '2023-09-15';

-- Employees with no attendance in September
SELECT e.employee_name
FROM Employees e
LEFT JOIN Attendance a 
ON e.employee_id = a.employee_id
AND MONTH(a.attendance_date) = 9 AND YEAR(a.attendance_date) = 2023
WHERE a.attendance_id IS NULL;

-- Payroll by department
SELECT e.department, SUM(p.total_salary) AS total_salary_paid
FROM Payroll p
JOIN Employees e ON p.employee_id = e.employee_id
WHERE p.payment_date BETWEEN '2023-09-01' AND '2023-09-30'
GROUP BY e.department;

-- Employees with bonus
SELECT e.employee_name, s.bonus
FROM Employees e
JOIN Salaries s ON e.employee_id = s.employee_id
WHERE s.bonus > 0 AND s.month = 'September' AND s.year = 2023;

-- Employees with deductions
SELECT e.employee_name, s.deductions
FROM Employees e
JOIN Salaries s ON e.employee_id = s.employee_id
WHERE s.deductions > 0 AND s.month = 'September' AND s.year = 2023;

-- Highest salary employee
SELECT employee_name, base_salary
FROM Employees
ORDER BY base_salary DESC
LIMIT 1;

-- Yearly salary report
SELECT e.employee_name,
       SUM(s.base_salary + s.bonus - s.deductions) AS yearly_salary
FROM Employees e
JOIN Salaries s ON e.employee_id = s.employee_id
WHERE s.year = 2023
GROUP BY e.employee_name;
SET SQL_SAFE_UPDATES = 1;