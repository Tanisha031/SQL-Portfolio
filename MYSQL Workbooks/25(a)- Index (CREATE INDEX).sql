-- Create Database
CREATE DATABASE Company1;
USE Company1;

-- 1. CREATE SAMPLE TABLE
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);

-- 2. INSERT SAMPLE DATA
INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, Department, Salary, HireDate)
VALUES
(1, 'Ali', 'Khan', 'ali.khan@email.com', 'IT', 75000, '2022-01-10'),
(2, 'Sara', 'Ahmed', 'sara.ahmed@email.com', 'HR', 60000, '2021-05-15'),
(3, 'John', 'Smith', 'john.smith@email.com', 'Finance', 90000, '2020-07-20'),
(4, 'Ayesha', 'Malik', 'ayesha.malik@email.com', 'IT', 80000, '2023-03-01'),
(5, 'David', 'Brown', 'david.brown@email.com', 'Marketing', 65000, '2022-09-12');


-- ===================================================== 3. CREATE INDEXES ========================================================

-- Index on single column (fast search on Department)
CREATE INDEX idx_department
ON Employees (Department);

-- Index on Salary (useful for filtering/range queries)
CREATE INDEX idx_salary
ON Employees (Salary);

-- Composite index (used when querying multiple columns together)
CREATE INDEX idx_department_salary
ON Employees (Department, Salary);

-- Unique index (ensures no duplicate emails)
CREATE UNIQUE INDEX idx_unique_email
ON Employees (Email);


-- 4. EXAMPLE QUERIES USING INDEX

-- 1. Filter by Department
SELECT *
FROM Employees
WHERE Department = 'IT';


-- 2. Salary greater than 70000
SELECT FirstName, LastName, Salary
FROM Employees
WHERE Salary > 70000;


-- 3. Order by Salary (Descending)
SELECT *
FROM Employees
ORDER BY Salary DESC;


-- 4. Composite condition (Department + Salary)
SELECT *
FROM Employees
WHERE Department = 'IT'
AND Salary > 70000;


-- 5. Search by Email (Unique Index use case)
SELECT EmployeeID, FirstName, Email
FROM Employees
WHERE Email = 'sara.ahmed@email.com';