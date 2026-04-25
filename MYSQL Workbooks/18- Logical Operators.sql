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
INSERT INTO employee VALUES
(101, 'Ali',     'London', 'UK',    50000),
(102, 'Sara',    'Rome',   'Italy', 60000),
(103, 'Ahmed',   'Madrid', 'Spain', 55000),
(104, 'John',    'London', 'UK',    70000),
(105, 'Ayesha',  'Paris',  'France',65000),
(106, 'David',   'Rome',   'Italy', 72000),
(107, 'Zara',    'Berlin', 'Germany',48000),
(108, 'Hassan',  'Madrid', 'Spain', 80000);

--                                                        1. AND OPERATOR
SELECT *
FROM employee
WHERE emp_city = 'London' AND emp_country = 'UK';

--                                                        2. OR OPERATOR
SELECT *
FROM employee
WHERE emp_city = 'London' OR emp_city = 'Paris';

--                                                        3. IN OPERATOR
SELECT *
FROM employee
WHERE emp_city IN ('London', 'Rome', 'Madrid');

--                                                        4. NOT OPERATOR
SELECT *
FROM employee
WHERE emp_city NOT IN ('London', 'Rome');

--                                                       5. NOT LIKE OPERATOR
SELECT *
FROM employee
WHERE emp_city NOT LIKE 'M%';

--                                                        7. LIKE OPERATOR
SELECT *
FROM employee
WHERE emp_city LIKE 'L%';   -- cities starting with L

SELECT *
FROM employee
WHERE emp_name LIKE '_a%';  -- 2nd letter is 'a'

--                                                       8. BETWEEN OPERATOR
SELECT *
FROM employee
WHERE salary BETWEEN 50000 AND 70000;

--                                                       9. ALL OPERATOR
SELECT *
FROM employee
WHERE salary > ALL (
    SELECT salary
    FROM employee
    WHERE emp_city = 'Rome'
);

--                                                      10. ANY OPERATOR
SELECT *
FROM employee
WHERE salary > ANY (
    SELECT salary
    FROM employee
    WHERE emp_city = 'Madrid'
);

--                                                      11. SOME OPERATOR
-- SOME is same as ANY
SELECT *
FROM employee
WHERE salary > SOME (
    SELECT salary
    FROM employee
    WHERE emp_city = 'Madrid'
);

--                                                      12. EXISTS OPERATOR
SELECT emp_name
FROM employee e
WHERE EXISTS (
    SELECT 1
    FROM employee
    WHERE emp_city = 'London'
);

-- Correlated EXISTS example
SELECT emp_name
FROM employee e
WHERE EXISTS (
    SELECT 1
    FROM employee e2
    WHERE e2.emp_city = e.emp_city
    AND e2.salary > 70000
);
