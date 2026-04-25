-- Use database
USE join_practice_db;

-- Drop old table if already exists
DROP TABLE IF EXISTS Employees;

-- Create Employees table
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    manager_id INT
);

-- Insert sample data
INSERT INTO Employees (emp_id, emp_name, manager_id)
VALUES
(1, 'Ali', NULL),      -- Top manager
(2, 'Sara', 1),
(3, 'Ahmed', 1),
(4, 'Fatima', 2),
(5, 'Hina', 2);

--  ============================================== SELF JOIN ==================================================

-- Query 1: Show employee with manager name
SELECT 
    e.emp_id,
    e.emp_name AS employee_name,
    m.emp_name AS manager_name
FROM Employees e
LEFT JOIN Employees m
ON e.manager_id = m.emp_id;

-- Query 2: Show employees under manager Sara
SELECT 
    e.emp_name AS employee_name,
    m.emp_name AS manager_name
FROM Employees e
INNER JOIN Employees m
ON e.manager_id = m.emp_id
WHERE m.emp_name = 'Sara';


-- QUERY 3: Count employees under each manager
SELECT 
    m.emp_name AS manager_name,
    COUNT(e.emp_id) AS total_employees
FROM Employees e
INNER JOIN Employees m
ON e.manager_id = m.emp_id
GROUP BY m.emp_name;