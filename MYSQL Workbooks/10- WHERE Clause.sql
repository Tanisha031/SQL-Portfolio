-- 1) Create database
CREATE DATABASE pakistan_db;

-- 2) Use the database
USE pakistan_db;

-- 3) Create table for cities
CREATE TABLE pakistan_cities (
    city_id INT PRIMARY KEY,
    city_name VARCHAR(50),
    province VARCHAR(50),
    population INT,
    literacy_rate DECIMAL(5,2),
    area_km DECIMAL(7,2)
);

-- 4) Insert sample data
INSERT INTO pakistan_cities (city_id, city_name, province, population, literacy_rate, area_km) VALUES
(1, 'Karachi', 'Sindh', 16000000, 75, 3780),
(2, 'Lahore', 'Punjab', 13000000, 78, 1772),
(3, 'Islamabad', 'Islamabad', 1200000, 88, 906),
(4, 'Peshawar', 'KPK', 2400000, 70, 1257),
(5, 'Quetta', 'Balochistan', 1000000, 68, 2653),
(6, 'Faisalabad', 'Punjab', 3200000, 74, 597),
(7, 'Multan', 'Punjab', 1800000, 71, 372),
(8, 'Hyderabad', 'Sindh', 1500000, 72, 625),
(9, 'Sukkur', 'Sindh', 450000, 70, 300),
(10, 'Abbottabad', 'KPK', 160000, 85, 198);

-- WHERE Clause Example 1
-- Show all cities in Sindh
SELECT * 
FROM pakistan_cities
WHERE province = 'Sindh';

-- WHERE Clause Example 2
-- Show cities with population greater than 2 million
SELECT * 
FROM pakistan_cities
WHERE population > 2000000;

-- WHERE Clause Example 3
-- Show cities with literacy rate greater than 75
SELECT * 
FROM pakistan_cities
WHERE literacy_rate > 75;

-- WHERE Clause Example 4
-- Show cities with area less than 1000 km
SELECT * 
FROM pakistan_cities
WHERE area_km < 1000;

-- WHERE Clause Example 5
-- Show cities from Punjab
SELECT * 
FROM pakistan_cities
WHERE province = 'Punjab';

-- WHERE Clause Example 6
-- Show city with exact name Karachi
SELECT * 
FROM pakistan_cities
WHERE city_name = 'Karachi';

-- WHERE Clause Example 7
-- Show cities with population between 1 million and 5 million
SELECT * 
FROM pakistan_cities
WHERE population BETWEEN 1000000 AND 5000000;

-- WHERE Clause Example 8
-- Cities in Punjab with population greater than 2 million
SELECT *
FROM pakistan_cities
WHERE province = 'Punjab'
AND population > 2000000;

-- WHERE Clause Example 9
-- Cities in Sindh OR Punjab
SELECT *
FROM pakistan_cities
WHERE province = 'Sindh'
OR province = 'Punjab';

-- WHERE Clause Example 10
-- Cities NOT in Sindh
SELECT *
FROM pakistan_cities
WHERE province != 'Sindh';

-- WHERE Clause Example 11
-- Cities with names starting with 'K'
SELECT *
FROM pakistan_cities
WHERE city_name LIKE 'K%';

-- WHERE Clause Example 12
-- Cities in selected provinces using IN
SELECT *
FROM pakistan_cities
WHERE province IN ('Sindh', 'KPK');

-- WHERE Clause Example 13
-- Cities with literacy rate between 70 and 80
SELECT *
FROM pakistan_cities
WHERE literacy_rate BETWEEN 70 AND 80;

-- WHERE Clause Example 14
-- Cities with area more than 500 and population less than 2 million
SELECT *
FROM pakistan_cities
WHERE area_km > 500
AND population < 2000000;