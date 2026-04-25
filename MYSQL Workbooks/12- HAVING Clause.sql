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

-- HAVING Clause Example 1
-- Provinces with total population greater than 3 million
SELECT province, SUM(population) AS total_population
FROM pakistan_cities
GROUP BY province
HAVING SUM(population) > 3000000;

-- HAVING Clause Example 2
-- Provinces with average literacy rate above 75
SELECT province, AVG(literacy_rate) AS avg_literacy
FROM pakistan_cities
GROUP BY province
HAVING AVG(literacy_rate) > 75;

-- HAVING Clause Example 3
-- Provinces having more than 2 cities
SELECT province, COUNT(city_id) AS total_cities
FROM pakistan_cities
GROUP BY province
HAVING COUNT(city_id) > 2;

-- HAVING Clause Example 4
-- Provinces with average area greater than 1000
SELECT province, AVG(area_km) AS avg_area
FROM pakistan_cities
GROUP BY province
HAVING AVG(area_km) > 1000;

-- HAVING Clause Example 5
-- Provinces with minimum literacy rate less than 70
SELECT province, MIN(literacy_rate) AS min_literacy
FROM pakistan_cities
GROUP BY province
HAVING MIN(literacy_rate) < 70;

-- HAVING Clause Example 6
-- Provinces with maximum population above 5 million
SELECT province, MAX(population) AS max_population
FROM pakistan_cities
GROUP BY province
HAVING MAX(population) > 5000000;

-- HAVING Clause Example 7
-- Provinces where total area is more than 2000
SELECT province, SUM(area_km) AS total_area
FROM pakistan_cities
GROUP BY province
HAVING SUM(area_km) > 2000;