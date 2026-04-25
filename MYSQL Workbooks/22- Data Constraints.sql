-- SQL CONSTRAINTS
CREATE DATABASE Company;
USE Company;

CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,                 -- PRIMARY KEY constraint
    DeptName VARCHAR(100) NOT NULL UNIQUE,  -- NOT NULL + UNIQUE (also Alternate Key)
    Location VARCHAR(100) DEFAULT 'Head Office'  -- DEFAULT constraint
);

CREATE TABLE Employees (
    EmpID INT,                             			 -- Part of Composite Key
    Email VARCHAR(100) UNIQUE,              		 -- UNIQUE constraint (Alternate Key)
    Name VARCHAR(100) NOT NULL,          			 -- NOT NULL constraint
    Age INT CHECK (Age >= 18),          			 -- CHECK constraint
    Salary DECIMAL(10,2) CHECK (Salary > 0),		 -- CHECK constraint
    DeptID INT,                           			 -- Foreign Key
    Gender CHAR(1) DEFAULT 'M',           			 -- DEFAULT constraint
    PRIMARY KEY (EmpID, DeptID),         			 -- Composite Primary Key
    FOREIGN KEY (DeptID) REFERENCES Departments(DeptID)	-- Foreign Key constraint
);

-- SAMPLE DATA INSERT

INSERT INTO Departments (DeptID, DeptName, Location)
VALUES 
(1, 'HR', 'Karachi'),
(2, 'IT', DEFAULT),
(3, 'Finance', 'Lahore');

INSERT INTO Employees (EmpID, Email, Name, Age, Salary, DeptID, Gender)
VALUES
(101, 'ali@example.com', 'Ali', 25, 50000, 1, 'M'),
(102, 'sara@example.com', 'Sara', 30, 70000, 2, 'F'),
(103, 'ahmed@example.com', 'Ahmed', 28, 60000, 1, DEFAULT);

-- 1. JOIN QUERY (Employees + Departments)
-- Shows employee details with their department name
SELECT 
    E.EmpID, E.Name, E.Email, E.Age, E.Salary, D.DeptName, 
    D.Location FROM Employees E
	JOIN Departments D
    ON E.DeptID = D.DeptID;

-- 2. FILTER + CONDITION QUERY (CHECK constraint usage idea)
-- Show employees with salary greater than 50000
SELECT  EmpID, Name, Salary
FROM Employees
WHERE Salary > 50000;

-- 3. AGGREGATE QUERY (GROUP BY)
-- Count number of employees in each department

SELECT  DeptID, COUNT(EmpID) AS TotalEmployees
FROM Employees
GROUP BY DeptID;

-- NOTES:
-- Primary Key = uniquely identifies each row
-- Foreign Key = links two tables
-- Composite Key = combination of two columns as PK
-- Unique Key = ensures no duplicates (alternate key)
-- NOT NULL = prevents empty values
-- CHECK = enforces condition rules
-- DEFAULT = auto value if not provided