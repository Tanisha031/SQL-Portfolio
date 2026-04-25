CREATE DATABASE HospitalDB;
USE HospitalDB;

CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    gender VARCHAR(10),
    age INT,
    phone VARCHAR(20),
    address VARCHAR(200)
);

CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    specialization VARCHAR(100)
);

CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    diagnosis TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

INSERT INTO Patients (name, gender, age, phone, address) VALUES
('Ali Khan','Male',30,'03001111111','Karachi'),
('Sara Ahmed','Female',28,'03002222222','Lahore'),
('Usman Ali','Male',35,'03003333333','Islamabad'),
('Ayesha Noor','Female',25,'03004444444','Karachi'),
('Bilal Ahmed','Male',40,'03005555555','Peshawar');

INSERT INTO Doctors (name, specialization) VALUES
('Dr. Ahmed','Cardiology'),
('Dr. Sara','Dermatology'),
('Dr. Ali','Neurology'),
('Dr. Khan','Orthopedic'),
('Dr. Noor','Pediatrics');

INSERT INTO Appointments (patient_id, doctor_id, appointment_date, diagnosis) VALUES
(1,1,'2024-04-01','Checkup'),
(2,2,'2024-04-02','Skin Issue'),
(3,3,'2024-04-03','Headache'),
(4,4,'2024-04-04','Fracture'),
(5,5,'2024-04-05','Fever');

-- View all patients
SELECT * FROM Patients;

-- Appointments with doctor names
SELECT p.name AS patient, d.name AS doctor, a.appointment_date
FROM Appointments a
JOIN Patients p ON a.patient_id = p.patient_id
JOIN Doctors d ON a.doctor_id = d.doctor_id;

-- Count patients by city
SELECT address, COUNT(*) AS total_patients
FROM Patients
GROUP BY address;

-- Find all appointments for a specific doctor
SELECT * FROM Appointments
WHERE doctor_id = 1;