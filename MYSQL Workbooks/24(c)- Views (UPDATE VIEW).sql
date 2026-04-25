-- Use DATABASE
CREATE DATABASE HealthcareData;
USE HealthcareData;

-- CREATE TABLES
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT,
    Gender VARCHAR(10),
    Disease VARCHAR(100)
);

CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY,
    Name VARCHAR(100),
    Specialization VARCHAR(100)
);

CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- INSERT SAMPLE DATA

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

-- First Check If Data Is Really Inserted

SELECT * FROM Patients;
SELECT * FROM Doctors;
SELECT * FROM Appointments;

-- ================================================ CREATE/REPLACE =============================================
-- In MySQL (including MySQL Workbench), there is no direct UPDATE VIEW command. Instead, you REPLACE the view using CREATE OR REPLACE VIEW.

-- CREATE VIEW
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

-- 6. Fetching complete patient, doctor, and appointment details from the view
--                                     ====== UPDATE VIEW ======
-- UPDATE VIEW (MODIFY VIEW)

CREATE OR REPLACE VIEW Patient_Appointment_View AS
SELECT 
    p.PatientID,
    p.Name AS PatientName,
    p.Age,
    p.Gender,
    p.Disease,
    d.DoctorID,          -- NEW COLUMN ADDED
    d.Name AS DoctorName,
    d.Specialization,
    a.AppointmentDate,
    a.Status
FROM Patients p
JOIN Appointments a ON p.PatientID = a.PatientID
JOIN Doctors d ON a.DoctorID = d.DoctorID;


-- USE VIEW (QUERIES)

-- 1. Get all data
SELECT * FROM Patient_Appointment_View;

-- 2. Diabetes patients
SELECT *
FROM Patient_Appointment_View
WHERE Disease = 'Diabetes';

-- 3. Count appointments per doctor
SELECT 
    DoctorName,
    COUNT(*) AS TotalAppointments
FROM Patient_Appointment_View
GROUP BY DoctorName;

-- 4. Pending appointments
SELECT *
FROM Patient_Appointment_View
WHERE Status = 'Pending';

-- 5. Patients older than 30
SELECT *
FROM Patient_Appointment_View
WHERE Age > 30;

-- 6. Latest appointments first
SELECT *
FROM Patient_Appointment_View
ORDER BY AppointmentDate DESC;