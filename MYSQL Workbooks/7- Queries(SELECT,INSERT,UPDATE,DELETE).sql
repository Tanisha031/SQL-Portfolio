--                                                       STEP 1: Create database
CREATE DATABASE IF NOT EXISTS Country_DB;
USE Country_DB;

--                                                       STEP 2: Create table
CREATE TABLE Countries (
    country_id INT,
    country_name VARCHAR(50),
    capital VARCHAR(50),
    population INT
);

--                                                    STEP 3: INSERT INTO (single row)
INSERT INTO Countries
VALUES (1, 'Pakistan', 'Islamabad', 240000000);

--                                                    STEP 4: INSERT Multiple Rows
INSERT INTO Countries 
VALUES
(2, 'India', 'New Delhi', 1400000000),
(3, 'China', 'Beijing', 1420000000),
(4, 'Turkey', 'Ankara', 85000000),
(5, 'Saudi Arabia', 'Riyadh', 36000000),
(6, 'United Arab Emirates', 'Abu Dhabi', 10000000),
(7, 'Qatar', 'Doha', 3000000),
(6, 'United Arab Emirates', 'Abu Dhabi', 10000000),   -- duplicate
(7, 'Qatar', 'Doha', 3000000),                         -- duplicate
(4, 'Turkey', 'Ankara', 85000000);   -- duplicate rows for practice


--                                                       STEP 5: SELECT Statement
SELECT * FROM Countries;

-- Show selected columns
SELECT country_name, capital
FROM Countries;

--                                                       STEP 6: UPDATE Statement

SET SQL_SAFE_UPDATES = 0;               -- For DELETE/UPDATE (0 - Disable, 1 - Enable)
UPDATE Countries
SET population = 250000000
WHERE country_name = 'Pakistan';
SET SQL_SAFE_UPDATES = 1;

-- Check updated data
SELECT * FROM Countries;

--                                                        STEP 7: DELETE Statement

SET SQL_SAFE_UPDATES = 0;               -- For DELETE/UPDATE (0 - Disable, 1 - Enable)
DELETE FROM Countries
WHERE country_name = 'China';
SET SQL_SAFE_UPDATES = 1;

-- Check after delete
SELECT * FROM Countries;

--                                                        STEP 8: DELETE Duplicate Rows
DELETE c1
FROM Countries c1
JOIN Countries c2
ON c1.country_id = c2.country_id
AND c1.country_name = c2.country_name
AND c1.capital = c2.capital
AND c1.population = c2.population
AND c1.country_id > c2.country_id;

-- Final table
SELECT * FROM Countries;