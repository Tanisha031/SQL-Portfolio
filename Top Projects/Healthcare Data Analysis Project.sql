-- CREATE DATABASE
CREATE DATABASE healthcare_data;
USE healthcare_data;

-- CREATE HOSPITAL TABLE
CREATE TABLE hospitals (
    hospital_id INT PRIMARY KEY,
    hospital_name VARCHAR(100),
    city VARCHAR(50),
    province VARCHAR(50)
);

-- CREATE DEPARTMENT TABLE
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

-- CREATE PATIENTS TABLE
CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(100),
    gender VARCHAR(10),
    age INT,
    diagnosis VARCHAR(100),
    admission_date DATE,
    discharge_date DATE,
    hospital_id INT,
    department_id INT,
    bill_amount DECIMAL(10,2),
    FOREIGN KEY (hospital_id) REFERENCES hospitals(hospital_id),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- INSERT HOSPITAL DATA
INSERT INTO hospitals VALUES
(1, 'Jinnah Hospital', 'Karachi', 'Sindh'),
(2, 'Civil Hospital', 'Karachi', 'Sindh'),
(3, 'Mayo Hospital', 'Lahore', 'Punjab'),
(4, 'PIMS', 'Islamabad', 'ICT'),
(5, 'Lady Reading Hospital', 'Peshawar', 'KP');

-- INSERT DEPARTMENT DATA
INSERT INTO departments VALUES
(101, 'Cardiology'),
(102, 'Neurology'),
(103, 'Orthopedics'),
(104, 'Emergency'),
(105, 'General Medicine');

-- INSERT PATIENT DATA
INSERT INTO patients VALUES
(1001, 'Ahmed Khan', 'Male', 45, 'Hypertension', '2026-03-01', '2026-03-05', 1, 101, 15000),
(1002, 'Sara Ali', 'Female', 32, 'Migraine', '2026-03-02', '2026-03-03', 3, 102, 8000),
(1003, 'Bilal Raza', 'Male', 60, 'Fracture', '2026-03-04', '2026-03-08', 2, 103, 22000),
(1004, 'Ayesha Noor', 'Female', 27, 'Fever', '2026-03-05', '2026-03-06', 4, 105, 5000),
(1005, 'Usman Tariq', 'Male', 50, 'Heart Disease', '2026-03-06', '2026-03-10', 5, 101, 30000),
(1006, 'Fatima Khan', 'Female', 38, 'Hypertension', '2026-03-07', '2026-03-09', 1, 101, 18000);

-- TOTAL PATIENTS REPORT
SELECT COUNT(*) AS total_patients
FROM patients;

-- CITY WISE PATIENT REPORT
SELECT 
    h.city,
    COUNT(p.patient_id) AS total_patients
FROM patients p
JOIN hospitals h
ON p.hospital_id = h.hospital_id
GROUP BY h.city
ORDER BY total_patients DESC;

-- DEPARTMENT WISE PATIENT LOAD
SELECT 
    d.department_name,
    COUNT(p.patient_id) AS patient_count
FROM patients p
JOIN departments d
ON p.department_id = d.department_id
GROUP BY d.department_name
ORDER BY patient_count DESC;

-- DISEASE FREQUENCY REPORT
SELECT 
    diagnosis,
    COUNT(*) AS total_cases
FROM patients
GROUP BY diagnosis
ORDER BY total_cases DESC;

-- HOSPITAL REVENUE REPORT
SELECT 
    h.hospital_name,
    SUM(p.bill_amount) AS total_revenue
FROM patients p
JOIN hospitals h
ON p.hospital_id = h.hospital_id
GROUP BY h.hospital_name
ORDER BY total_revenue DESC;

-- AVERAGE LENGTH OF STAY
SELECT 
    patient_name,
    DATEDIFF(discharge_date, admission_date) AS stay_days
FROM patients;

-- LONGEST STAY PATIENTS
SELECT 
    patient_name,
    diagnosis,
    DATEDIFF(discharge_date, admission_date) AS stay_days
FROM patients
ORDER BY stay_days DESC;

-- AGE GROUP ANALYSIS
SELECT
    CASE
        WHEN age < 18 THEN 'Child'
        WHEN age BETWEEN 18 AND 40 THEN 'Young Adult'
        WHEN age BETWEEN 41 AND 60 THEN 'Adult'
        ELSE 'Senior'
    END AS age_group,
    COUNT(*) AS patient_count
FROM patients
GROUP BY age_group;

-- REVENUE RANKING
SELECT
    h.hospital_name,
    SUM(p.bill_amount) AS revenue,
    RANK() OVER (
        ORDER BY SUM(p.bill_amount) DESC
    ) AS revenue_rank
FROM patients p
JOIN hospitals h
ON p.hospital_id = h.hospital_id
GROUP BY h.hospital_name;