
-- STEP 1: Create and select database

CREATE DATABASE IF NOT EXISTS Table_Practice_DB;
USE Table_Practice_DB;

--                                                        STEP 2: CREATE TABLE

CREATE TABLE IF NOT EXISTS Employees2 (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);
-- Insert sample data
INSERT INTO Employees2 VALUES
(1, 'Ali', 'HR', 50000),
(2, 'Sara', 'IT', 70000),
(3, 'Ahmed', 'Finance', 80000);

-- View data
SELECT * FROM Employees2;

CREATE TABLE Employees_Copy AS
SELECT * FROM Employees2;

SELECT * FROM Employees_Copy;

--                                                  STEP 4: TEMP TABLE
-- Exists only for current session

CREATE TEMPORARY TABLE Temp_Employees AS
SELECT * FROM Employees2;

SELECT * FROM Temp_Employees;

--                                                 STEP 5: ALTER TABLE
-- Add a new column

ALTER TABLE Employees2
ADD email VARCHAR(100);

SELECT * FROM Employees2;

--                                                 STEP 6: RENAME TABLE

RENAME TABLE Employees2 TO Employee_Info;

SELECT * FROM Employee_Info;

--                                                  STEP 7: TRUNCATE TABLE
-- Removes all rows but keeps table structure
TRUNCATE TABLE Employees_Copy;

SELECT * FROM Employees_Copy;

--                                                   STEP 8: DROP TABLE
-- Deletes table permanently
DROP TABLE Temp_Employees;