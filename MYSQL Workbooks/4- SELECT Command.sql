-- STEP 1: Create database
CREATE DATABASE IF NOT EXISTS Test;

-- STEP 2: Select database
USE Test;

-- STEP 3: Create Employees table
CREATE TABLE Employee (
    emp_id INT,
    name VARCHAR(50),
    age INT,
    department VARCHAR(50),
    salary INT
);

-- STEP 4: Insert sample data
INSERT INTO Employee VALUES
(1, 'Ali', 25, 'HR', 50000),
(2, 'Sara', 30, 'IT', 70000),
(3, 'Ahmed', 35, 'Finance', 80000),
(4, 'Fatima', 40, 'IT', 90000),
(5, 'Zara', 28, 'HR', 55000);

-- STEP 5: Show all data
SELECT * FROM Employee;

-- STEP 6: Show specific columns
SELECT name, age FROM Employee;

-- STEP 7: Filter data using WHERE
SELECT name, age
FROM Employee
WHERE age >= 30;

-- STEP 8: Sort data in descending order
SELECT name, age
FROM Employee
ORDER BY age DESC;

-- STEP 9: Show top 3 highest salaries
SELECT name, salary
FROM Employee
ORDER BY salary DESC
LIMIT 3;

-- STEP 10: Average salary by department
SELECT department,
       AVG(salary) AS average_salary
FROM Employee
GROUP BY department;