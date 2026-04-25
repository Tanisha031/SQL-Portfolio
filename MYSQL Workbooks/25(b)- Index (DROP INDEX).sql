-- Use the database
USE test;

-- 1. CREATE TABLE 
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR(10),
    Age INT,
    City VARCHAR(50),
    BloodGroup VARCHAR(5),
    AdmissionDate DATE
);

-- 2. INSERT SAMPLE DATA
INSERT INTO Patients (PatientID, FirstName, LastName, Gender, Age, City, BloodGroup, AdmissionDate)
VALUES
(1, 'Ahmed', 'Ali', 'Male', 30, 'Karachi', 'B+', '2024-01-10'),
(2, 'Sara', 'Khan', 'Female', 25, 'Lahore', 'A+', '2024-02-15'),
(3, 'Usman', 'Ahmed', 'Male', 40, 'Karachi', 'O+', '2023-12-05'),
(4, 'Ayesha', 'Malik', 'Female', 35, 'Islamabad', 'AB+', '2024-03-20'),
(5, 'Hassan', 'Raza', 'Male', 28, 'Karachi', 'B-', '2024-01-25');

-- 3. CREATE INDEXES

-- Index on City (fast filtering)
CREATE INDEX idx_city
ON Patients (City);

-- Index on Age (range queries)
CREATE INDEX idx_age
ON Patients (Age);

-- Composite index (City + Age)
CREATE INDEX idx_city_age
ON Patients (City, Age);

-- Index on BloodGroup
CREATE INDEX idx_bloodgroup
ON Patients (BloodGroup);

-- 4. SAMPLE QUERIES (TO USE INDEX)

SELECT *
FROM Patients
WHERE City = 'Karachi';

SELECT FirstName, Age
FROM Patients
WHERE Age > 30;

SELECT *
FROM Patients
WHERE City = 'Karachi' AND Age > 25;

-- ====================================================== DROP INDEX (PRACTICE) ==========================================================

-- DROP INDEX PRACTICE (5 QUERIES)
-- Table: Patients

-- 1. Drop index on City
DROP INDEX idx_city
ON Patients;

-- 2. Drop index on Age
DROP INDEX idx_age
ON Patients;

-- 3. Drop composite index (City + Age)
DROP INDEX idx_city_age
ON Patients;

-- 4. Drop index on BloodGroup
DROP INDEX idx_bloodgroup
ON Patients;

-- =========================
-- NOTE:
-- SQL SERVER & MYSQL → DROP INDEX idx_name ON table;
-- POSTGRESQL → DROP INDEX idx_name;
-- =========================