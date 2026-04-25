-- ================================
-- CUSTOMER FEEDBACK ANALYSIS PROJECT
-- ================================

-- 1️⃣ Create Database
CREATE DATABASE IF NOT EXISTS customer_feedback_db;
USE customer_feedback_db;

-- 2️⃣ Create Table
DROP TABLE IF EXISTS customer_feedback;

CREATE TABLE customer_feedback (
    feedback_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    region VARCHAR(50),
    product_type VARCHAR(50),
    rating INT,
    feedback_text TEXT,
    complaint_category VARCHAR(50),
    resolution_time_days INT,
    feedback_date DATE
);

-- 3️⃣ Insert Sample Data
INSERT INTO customer_feedback 
(customer_id, region, product_type, rating, feedback_text, complaint_category, resolution_time_days, feedback_date)
VALUES
(101, 'North', 'Internet', 5, 'Excellent service and fast connection', 'None', 0, '2025-04-01'),
(102, 'South', 'Mobile', 2, 'Very slow support response', 'Service Delay', 5, '2025-04-03'),
(103, 'East', 'Internet', 1, 'Connection drops frequently', 'Technical Issue', 7, '2025-04-04'),
(104, 'West', 'TV', 4, 'Good service but late installation', 'Installation Delay', 3, '2025-04-05'),
(105, 'North', 'Mobile', 3, 'Average experience', 'Billing Issue', 2, '2025-04-06'),
(106, 'South', 'Internet', 2, 'Poor customer support', 'Service Delay', 6, '2025-04-07'),
(107, 'East', 'TV', 5, 'Great picture quality', 'None', 0, '2025-04-08'),
(108, 'West', 'Mobile', 1, 'Wrong billing amount charged', 'Billing Issue', 8, '2025-04-09');

-- ================================
-- ANALYSIS QUERIES
-- ================================

-- Total Feedback
SELECT COUNT(*) AS total_feedback
FROM customer_feedback;

-- Average Rating (CSAT)
SELECT ROUND(AVG(rating),2) AS average_rating
FROM customer_feedback;

-- Feedback by Region
SELECT region, COUNT(*) AS total_feedback
FROM customer_feedback
GROUP BY region;

-- Feedback by Product Type
SELECT product_type, COUNT(*) AS total_feedback
FROM customer_feedback
GROUP BY product_type;

-- Sentiment Analysis
SELECT 
    feedback_id,
    rating,
    CASE 
        WHEN rating >= 4 THEN 'Positive'
        WHEN rating = 3 THEN 'Neutral'
        ELSE 'Negative'
    END AS sentiment
FROM customer_feedback;

-- Complaint Category Count
SELECT complaint_category, COUNT(*) AS complaint_count
FROM customer_feedback
WHERE complaint_category <> 'None'
GROUP BY complaint_category
ORDER BY complaint_count DESC;

-- Average Resolution Time by Complaint
SELECT complaint_category,
       ROUND(AVG(resolution_time_days),2) AS avg_resolution_time
FROM customer_feedback
WHERE complaint_category <> 'None'
GROUP BY complaint_category;

-- High Risk Customers (Rating <=2)
SELECT *
FROM customer_feedback
WHERE rating <= 2;

-- Overall KPI Summary
SELECT 
    COUNT(*) AS total_feedback,
    ROUND(AVG(rating),2) AS avg_rating,
    SUM(CASE WHEN rating >= 4 THEN 1 ELSE 0 END) AS positive_feedback,
    SUM(CASE WHEN rating = 3 THEN 1 ELSE 0 END) AS neutral_feedback,
    SUM(CASE WHEN rating <= 2 THEN 1 ELSE 0 END) AS negative_feedback,
    ROUND(AVG(resolution_time_days),2) AS avg_resolution_time
FROM customer_feedback;

-- Optional: Index for Performance
CREATE INDEX idx_region ON customer_feedback(region);
CREATE INDEX idx_rating ON customer_feedback(rating);