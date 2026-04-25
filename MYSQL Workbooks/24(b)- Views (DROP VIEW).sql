-- 1. CREATE DATABASE
CREATE DATABASE HospitalDB;
USE HospitalDB;

-- 2. CREATE TABLES

-- Patients Table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    Disease VARCHAR(100)
);

-- Doctors Table
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Specialization VARCHAR(100)
);

-- Appointments Table
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- 3. INSERT SAMPLE DATA

INSERT INTO Patients VALUES
(1, 'Ali Khan', 30, 'Male', 'Diabetes'),
(2, 'Sara Ahmed', 25, 'Female', 'Flu'),
(3, 'John Smith', 45, 'Male', 'Heart Disease'),
(4, 'Ayesha Noor', 35, 'Female', 'Hypertension');

INSERT INTO Doctors VALUES
(101, 'Dr. Hassan', 'Cardiologist'),
(102, 'Dr. Ayesha', 'General Physician'),
(103, 'Dr. Imran', 'Endocrinologist');

INSERT INTO Appointments VALUES
(1001, 1, 103, '2026-04-10', 'Completed'),
(1002, 2, 102, '2026-04-11', 'Pending'),
(1003, 3, 101, '2026-04-12', 'Scheduled'),
(1004, 4, 101, '2026-04-13', 'Completed');

-- 4. CREATE VIEW

CREATE VIEW Hospital_Overview AS
SELECT 
    p.PatientID,
    p.Name AS PatientName,
    p.Age,
    p.Gender,
    p.Disease,
    d.DoctorID,
    d.Name AS DoctorName,
    d.Specialization,
    a.AppointmentDate,
    a.Status
FROM Patients p
JOIN Appointments a ON p.PatientID = a.PatientID
JOIN Doctors d ON a.DoctorID = d.DoctorID;

-- 5. USE VIEW (TEST OUTPUT)

SELECT * FROM Hospital_Overview;

-- 6. ANALYTICAL QUERIES ON VIEW

-- 1. Diabetes patients only
SELECT *
FROM Hospital_Overview
WHERE Disease = 'Diabetes';

-- 2. Count appointments per doctor
SELECT 
    DoctorName,
    COUNT(*) AS TotalAppointments
FROM Hospital_Overview
GROUP BY DoctorName;


-- ============================================== DROP VIEW =========================================================
-- 7. DROP VIEW
DROP VIEW IF EXISTS Hospital_Overview;

-- 8. VERIFY VIEW IS DELETED
SHOW FULL TABLES IN HospitalDB WHERE TABLE_TYPE = 'VIEW';