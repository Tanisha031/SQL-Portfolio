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

-- GROUP BY Clause Example 1
-- Count total cities in each province
SELECT province, COUNT(city_id) AS total_cities
FROM pakistan_cities
GROUP BY province;

-- GROUP BY Clause Example 2
-- Total population of each province
SELECT province, SUM(population) AS total_population
FROM pakistan_cities
GROUP BY province;

-- GROUP BY Clause Example 3
-- Average literacy rate by province
SELECT province, AVG(literacy_rate) AS avg_literacy
FROM pakistan_cities
GROUP BY province;

-- GROUP BY Clause Example 4
-- Maximum population city count by province
SELECT province, MAX(population) AS highest_population
FROM pakistan_cities
GROUP BY province;

-- GROUP BY Clause Example 5
-- Minimum literacy rate by province
SELECT province, MIN(literacy_rate) AS lowest_literacy
FROM pakistan_cities
GROUP BY province;

-- GROUP BY Clause Example 6
-- Average area by province
SELECT province, AVG(area_km) AS avg_area
FROM pakistan_cities
GROUP BY province;

-- GROUP BY Clause Example 7
-- Total area covered by cities in each province
SELECT province, SUM(area_km) AS total_area
FROM pakistan_cities
GROUP BY province;