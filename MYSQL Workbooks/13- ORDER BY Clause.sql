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

-- ORDER BY Clause Example 1
-- Sort cities by city name in ascending order
SELECT *
FROM pakistan_cities
ORDER BY city_name ASC;

-- ORDER BY Clause Example 2
-- Sort cities by population in descending order
SELECT *
FROM pakistan_cities
ORDER BY population DESC;

-- ORDER BY Clause Example 3
-- Sort cities by literacy rate from highest to lowest
SELECT *
FROM pakistan_cities
ORDER BY literacy_rate DESC;

-- ORDER BY Clause Example 4
-- Sort cities by area from smallest to largest
SELECT *
FROM pakistan_cities
ORDER BY area_km ASC;

-- ORDER BY Clause Example 5
-- Sort by province name alphabetically
SELECT *
FROM pakistan_cities
ORDER BY province ASC;

-- ORDER BY Clause Example 6
-- Sort by province first, then population descending
SELECT *
FROM pakistan_cities
ORDER BY province ASC, population DESC;

-- ORDER BY Clause Example 7
-- Sort by literacy rate ascending and area descending
SELECT *
FROM pakistan_cities
ORDER BY literacy_rate ASC, area_km DESC;