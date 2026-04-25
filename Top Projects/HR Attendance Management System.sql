-- CREATE DATABASE
CREATE DATABASE IF NOT EXISTS HR_Attendance_System;
USE HR_Attendance_System;

-- CREATE TABLE 
-- DEPARTMENT TABLE
CREATE TABLE Department (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL UNIQUE
);

-- EMPLOYEE TABLE
CREATE TABLE Employee (
    employee_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(150) UNIQUE,
    phone VARCHAR(20),
    hire_date DATE,
    job_title VARCHAR(100),
    department_id INT,
    status ENUM('Active', 'Inactive') DEFAULT 'Active',
    FOREIGN KEY (department_id) REFERENCES Department(department_id)
);

-- ATTENDANCE TABLE
CREATE TABLE Attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    attendance_date DATE NOT NULL,
    check_in TIME,
    check_out TIME,
    status ENUM('Present', 'Absent', 'Leave', 'Late') DEFAULT 'Present',
    working_hours DECIMAL(5,2),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

-- LEAVE MANAGEMENT TABLE
CREATE TABLE Leave_Requests (
    leave_id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT,
    start_date DATE,
    end_date DATE,
    leave_type VARCHAR(50),
    status ENUM('Pending', 'Approved', 'Rejected') DEFAULT 'Pending',
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

-- INSERT SAMPLE DATA (DEPARTMENTS)
INSERT INTO Department (department_name)
VALUES 
('HR'),
('Finance'),
('IT'),
('Sales');

-- INSERT SAMPLE DATA (EMPLOYEES)
INSERT INTO Employee (full_name, email, phone, hire_date, job_title, department_id)
VALUES
('Ali Khan', 'ali@company.com', '03001234567', '2023-01-10', 'HR Executive', 1),
('Sara Ahmed', 'sara@company.com', '03011234567', '2022-05-15', 'Accountant', 2),
('John Smith', 'john@company.com', '03021234567', '2024-02-01', 'Software Engineer', 3),
('Ayesha Noor', 'ayesha@company.com', '03031234567', '2023-08-20', 'Sales Officer', 4);

-- INSERT SAMPLE ATTENDANCE
INSERT INTO Attendance (employee_id, attendance_date, check_in, check_out, status, working_hours)
VALUES
(1, '2026-04-01', '09:00:00', '17:00:00', 'Present', 8.0),
(1, '2026-04-02', '09:15:00', '17:00:00', 'Late', 7.75),
(2, '2026-04-01', '09:05:00', '17:00:00', 'Present', 7.95),
(3, '2026-04-01', NULL, NULL, 'Absent', 0),
(4, '2026-04-01', '09:00:00', '16:30:00', 'Present', 7.5);

-- SAMPLE LEAVE REQUESTS
INSERT INTO Leave_Requests (employee_id, start_date, end_date, leave_type, status)
VALUES
(2, '2026-04-10', '2026-04-12', 'Annual Leave', 'Approved'),
(3, '2026-04-15', '2026-04-16', 'Sick Leave', 'Pending');

-- USEFUL QUERIES 

-- Employee Attendance Report
SELECT 
    e.full_name,
    a.attendance_date,
    a.check_in,
    a.check_out,
    a.status,
    a.working_hours
FROM Employee e
JOIN Attendance a ON e.employee_id = a.employee_id
ORDER BY a.attendance_date;

-- Monthly Attendance Summary
SELECT 
    e.full_name,
    COUNT(CASE WHEN a.status = 'Present' THEN 1 END) AS present_days,
    COUNT(CASE WHEN a.status = 'Absent' THEN 1 END) AS absent_days,
    COUNT(CASE WHEN a.status = 'Late' THEN 1 END) AS late_days
FROM Employee e
LEFT JOIN Attendance a ON e.employee_id = a.employee_id
GROUP BY e.full_name;

-- Department Wise Employee Count
SELECT 
    d.department_name,
    COUNT(e.employee_id) AS total_employees
FROM Department d
LEFT JOIN Employee e ON d.department_id = e.department_id
GROUP BY d.department_name;

-- Leave Status Report
SELECT 
    e.full_name,
    l.leave_type,
    l.start_date,
    l.end_date,
    l.status
FROM Employee e
JOIN Leave_Requests l ON e.employee_id = l.employee_id;