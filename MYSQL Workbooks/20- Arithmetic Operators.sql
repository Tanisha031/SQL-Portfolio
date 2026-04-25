-- 1. CREATE DATABASE & TABLE
CREATE DATABASE IF NOT EXISTS company_db;
USE company_db;

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT,
    bonus INT
);

-- 2. INSERT SAMPLE DATA
INSERT INTO employee VALUES
(101, 'Ali',    50000, 5000),
(102, 'Sara',   60000, 7000),
(103, 'Ahmed',  55000, 6000),
(104, 'John',   70000, 8000),
(105, 'Ayesha', 65000, 6500);

--                  1. ADDITION (+)

-- Calculate total salary (salary + bonus)
SELECT emp_name, salary, bonus,
       salary + bonus AS total_income
FROM employee;

--                  2. SUBTRACTION (-)

-- Calculate remaining salary after tax deduction
SELECT emp_name, salary,
       salary - 5000 AS after_tax_salary
FROM employee;

--                 3. MULTIPLICATION (*)

-- Calculate yearly salary (salary * 12)
SELECT emp_name, salary,
       salary * 12 AS yearly_salary
FROM employee;

--                  4. DIVISION (/)

-- Divide salary into 4 parts
SELECT emp_name, salary,
       salary / 4 AS quarterly_salary
FROM employee;

--                 5. MODULUS (%)

-- Find remainder when salary is divided by 3
SELECT emp_name, salary,
       salary % 3 AS salary_remainder
FROM employee;

--                6. COMBINED ARITHMETIC EXPRESSION

-- (salary + bonus) * 12 yearly package
SELECT emp_name, salary, bonus,
       (salary + bonus) * 12 AS yearly_package
FROM employee;