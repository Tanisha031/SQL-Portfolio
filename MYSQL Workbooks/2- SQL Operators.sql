USE sql_datatypes;

-- 1)                                                  Arithmetic Operators

CREATE TABLE Employees (
    EmpID INT,
    EmpName VARCHAR(50),
    Salary INT,
    Bonus INT
);
INSERT INTO Employees (EmpID, EmpName, Salary, Bonus)
VALUES
(1, 'Amit', 40000, 5000),
(2, 'Neha', 50000, 7000),
(3, 'Ravi', 30000, 3000);

SELECT 
    EmpName,
    Salary,
    Bonus,
    Salary + Bonus AS Total_Income,
    Salary - Bonus AS After_Bonus_Deduction,
    Salary * 0.10 AS Ten_Percent_Salary,
    Salary / 12 AS Monthly_Salary,
    Salary % 10000 AS Salary_Remainder
FROM Employees;

--                                                 2) Comparison Operators

CREATE TABLE Students (
    ID INT,
    Name VARCHAR(50),
    Marks INT
);

INSERT INTO Students VALUES
(1, 'Amit', 85),
(2, 'Neha', 70),
(3, 'Ravi', 55);

SELECT *
FROM Students
WHERE Marks >= 70;
CREATE TABLE Students (
    ID INT,
    Name VARCHAR(50),
    Marks INT
);

INSERT INTO Students VALUES
(1, 'Amit', 85),
(2, 'Neha', 70),
(3, 'Ravi', 55);

SELECT *
FROM Students
WHERE Marks >= 70;

--                                                          3) Logical Operators
CREATE TABLE Students_Logical (
    ID INT,
    Name VARCHAR(50),
    Marks INT,
    Age INT
);

INSERT INTO Students_Logical VALUES
(1, 'Amit', 85, 18),
(2, 'Neha', 70, 19),
(3, 'Ravi', 55, 17);

SELECT *
FROM Students_Logical
WHERE Marks >= 70 AND Age >= 18;

--                                                 4) Bitwise Operators
CREATE TABLE Users (
    UserID INT,
    UserName VARCHAR(50),
    Permissions INT
);

INSERT INTO Users (UserID, UserName, Permissions) VALUES
(1, 'Amit', 1),
(2, 'Neha', 3),
(3, 'Ravi', 7);

-- Check Write permission
SELECT *
FROM Users
WHERE Permissions & 2 = 2;

-- Add Execute permission
UPDATE Users
SET Permissions = Permissions | 4
WHERE UserName = 'Neha';

-- Remove Read permission
UPDATE Users
SET Permissions = Permissions & ~1
WHERE UserName = 'Ravi';

-- Toggle Write permission
UPDATE Users
SET Permissions = Permissions ^ 2
WHERE UserName = 'Amit';

-- Show final permissions
SELECT * FROM Users;

--                                                              5) Compound Operators
CREATE TABLE Employees_Compound (
    EmpID INT,
    EmpName VARCHAR(50),
    Salary INT
);

INSERT INTO Employees_Compound VALUES
(1, 'Amit', 40000),
(2, 'Neha', 50000),
(3, 'Ravi', 30000);

-- Increase salary by 5000
UPDATE Employees_Compound
SET Salary = Salary + 5000;

-- Reduce salary by 2000
UPDATE Employees_Compound
SET Salary = Salary - 2000
WHERE EmpName = 'Ravi';

-- Double salary
UPDATE Employees_Compound
SET Salary = Salary * 2
WHERE EmpName = 'Neha';

-- Divide salary
UPDATE Employees_Compound
SET Salary = Salary / 2
WHERE EmpName = 'Amit';

-- Modulus example
UPDATE Employees_Compound
SET Salary = Salary % 10000;

SELECT * FROM Employees_Compound;

--                                                          6) Special Operators
CREATE TABLE Students_Special (
    ID INT,
    Name VARCHAR(50),
    Marks INT
);

INSERT INTO Students_Special VALUES
(1, 'Amit', 85),
(2, 'Neha', 70),
(3, 'Ravi', 55),
(4, 'Kiran', NULL);

-- BETWEEN
SELECT * FROM Students_Special
WHERE Marks BETWEEN 60 AND 90;

-- IN
SELECT * FROM Students_Special
WHERE Name IN ('Amit', 'Ravi');

-- LIKE
SELECT * FROM Students_Special
WHERE Name LIKE 'N%';

-- IS NULL
SELECT * FROM Students_Special
WHERE Marks IS NULL;

-- EXISTS
SELECT * FROM Students_Special s
WHERE EXISTS (
    SELECT * FROM Students_Special
    WHERE Marks > 80
);
