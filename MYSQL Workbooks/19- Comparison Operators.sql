-- CREATE DATABASE & TABLE
CREATE DATABASE IF NOT EXISTS company_db;
USE company_db;

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    emp_city VARCHAR(50),
    emp_country VARCHAR(50),
    salary INT
);

-- INSERT SAMPLE DATA
-- =========================
INSERT INTO employee VALUES
(101, 'Ali',     'London', 'UK',     50000),
(102, 'Sara',    'Rome',   'Italy',  60000),
(103, 'Ahmed',   'Madrid', 'Spain',  55000),
(104, 'John',    'London', 'UK',     70000),
(105, 'Ayesha',  'Paris',  'France', 65000),
(106, 'David',   'Rome',   'Italy',  72000),
(107, 'Zara',    'Berlin', 'Germany',48000),
(108, 'Hassan',  'Madrid', 'Spain',  80000);


--                        1. GREATER THAN ( > )
SELECT *
FROM employee
WHERE salary > 60000;

--                        2. GREATER THAN OR EQUAL ( >= )
SELECT *
FROM employee
WHERE salary >= 60000;

--                        3. LESS THAN ( < )
SELECT *
FROM employee
WHERE salary < 60000;

--                        4. LESS THAN OR EQUAL ( <= )
SELECT *
FROM employee
WHERE salary <= 60000;

--                        5. EQUAL TO ( = )
SELECT *
FROM employee
WHERE emp_city = 'London';

--                         6. NOT EQUAL TO ( <> )
SELECT *
FROM employee
WHERE emp_city <> 'London';

--                         7. COMBINED PRACTICE (INTERVIEW STYLE)
SELECT *
FROM employee
WHERE salary >= 60000
  AND emp_city <> 'Rome';

--                         8. RANGE CHECK USING COMPARISON OPS
SELECT *
FROM employee
WHERE salary >= 50000
  AND salary <= 70000;