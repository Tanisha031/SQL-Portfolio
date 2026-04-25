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

-- WITH Clause Example 1
-- Show all cities from Sindh using CTE
WITH sindh_cities AS (
    SELECT *
    FROM pakistan_cities
    WHERE province = 'Sindh'
)
SELECT * FROM sindh_cities;

-- WITH Clause Example 2
-- Cities with population greater than 2 million
WITH large_cities AS (
    SELECT city_name, population
    FROM pakistan_cities
    WHERE population > 2000000
)
SELECT * FROM large_cities;

-- WITH Clause Example 3
-- Cities with literacy rate above 75
WITH high_literacy AS (
    SELECT city_name, literacy_rate
    FROM pakistan_cities
    WHERE literacy_rate > 75
)
SELECT *
FROM high_literacy;

-- WITH Clause Example 4
-- Average population by province
WITH province_avg AS (
    SELECT province, AVG(population) AS avg_population
    FROM pakistan_cities
    GROUP BY province
)
SELECT * FROM province_avg;

-- WITH Clause Example 5
-- Cities with area greater than average area
WITH avg_area AS (
    SELECT AVG(area_km) AS average_area
    FROM pakistan_cities
)
SELECT * FROM pakistan_cities
WHERE area_km > (SELECT average_area FROM avg_area);

-- WITH Clause Example 6
-- Top populated cities
WITH top_population AS (
    SELECT city_name, population
    FROM pakistan_cities
    WHERE population > 1000000
)
SELECT * FROM top_population
ORDER BY population DESC;

-- WITH Clause Example 7
-- Punjab cities with literacy above 70
WITH punjab_literacy AS (
    SELECT *
    FROM pakistan_cities
    WHERE province = 'Punjab'
)
SELECT * FROM punjab_literacy
WHERE literacy_rate > 70;