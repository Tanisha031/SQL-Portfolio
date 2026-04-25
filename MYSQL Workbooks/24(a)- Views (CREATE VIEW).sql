-- 1. Create Healthcare Database
CREATE DATABASE HealthcareDB;
USE HealthcareDB;

-- 2. Create Tables
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,                          -- Patient Table
    Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    Disease VARCHAR(100)
);

CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,                           -- Doctor Table
    Name VARCHAR(100),
    Specialization VARCHAR(100)
);

CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,                      -- Appointments
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- 3. Insert Sample Data

INSERT INTO Patients VALUES
(1, 'Ali Khan', 30, 'Male', 'Diabetes'),
(2, 'Sara Ahmed', 25, 'Female', 'Flu'),
(3, 'John Smith', 40, 'Male', 'Hypertension');

INSERT INTO Doctors VALUES
(101, 'Dr. Hassan', 'Cardiologist'),
(102, 'Dr. Ayesha', 'General Physician');

INSERT INTO Appointments VALUES
(1001, 1, 101, '2026-04-10', 'Completed'),
(1002, 2, 102, '2026-04-11', 'Pending'),
(1003, 3, 101, '2026-04-12', 'Scheduled');

-- ====================================== CREATE VIEW =============================================
-- 
-- 4. CREATE VIEW (IMPORTANT PART)

-- View: Patient Appointment Details (JOIN Example). This view combines patients, doctors, and appointments:

CREATE VIEW Patient_Appointment_View AS
SELECT 
    p.PatientID,
    p.Name AS PatientName,
    p.Age,
    p.Gender,
    p.Disease,
    d.Name AS DoctorName,
    d.Specialization,
    a.AppointmentDate,
    a.Status
FROM Patients p
JOIN Appointments a ON p.PatientID = a.PatientID
JOIN Doctors d ON a.DoctorID = d.DoctorID;

-- =============================================  CREATE VIEW ===============================

-- Use database (if needed)
USE HealthcareDB;

-- 1. Get all Diabetes patients
SELECT *
FROM Patient_Appointment_View
WHERE Disease = 'Diabetes';

-- 2. Count total appointments per doctor
SELECT 
    DoctorName,
    COUNT(*) AS TotalAppointments
FROM Patient_Appointment_View
GROUP BY DoctorName;

-- 3. Show only pending appointments
SELECT *
FROM Patient_Appointment_View
WHERE Status = 'Pending';

-- 4. Patients older than 30
SELECT *
FROM Patient_Appointment_View
WHERE Age > 30;

-- 5. Latest appointments first
SELECT *
FROM Patient_Appointment_View
ORDER BY AppointmentDate DESC;

-- 6. Fetching complete patient, doctor, and appointment details from the view
SELECT * FROM Patient_Appointment_View;