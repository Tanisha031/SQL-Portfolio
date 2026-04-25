CREATE DATABASE HospitalData;
USE HospitalData;

-- ==============================
-- TABLES
-- ==============================

-- 1. Department
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(45)
);

-- 2. Role
CREATE TABLE Role (
    RoleID INT PRIMARY KEY,
    RoleDesc VARCHAR(45)
);

-- 3. Employee
CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY,
    EmployeeNumber VARCHAR(45),
    EmailID VARCHAR(45),
    Password VARCHAR(45),
    CreatedBy INT,
    CreatedOn DATETIME
);

-- 4. EmployeeDetails
CREATE TABLE EmployeeDetails (
    EmployeeDetailsID INT PRIMARY KEY,
    FirstName VARCHAR(45),
    LastName VARCHAR(45),
    DateOfBirth DATE,
    Gender VARCHAR(45),
    PhoneNumber VARCHAR(45),
    RoleID INT,
    CreatedOn DATETIME,
    ModifiedOn DATETIME,
    EmployeeID INT,
    FOREIGN KEY (RoleID) REFERENCES Role(RoleID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- 5. EmployeeDepartment (MANY TO MANY)
CREATE TABLE EmployeeDepartment (
    EmployeeID INT,
    DepartmentID INT,
    IsActive BIT,
    PRIMARY KEY (EmployeeID, DepartmentID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID)
);

-- 6. Patient
CREATE TABLE Patient (
    PatientID INT PRIMARY KEY,
    PatientRegNo VARCHAR(45),
    FirstName VARCHAR(45),
    LastName VARCHAR(45),
    DateOfBirth DATE,
    Gender VARCHAR(45),
    PhoneNumber VARCHAR(45),
    EmailID VARCHAR(45),
    Height VARCHAR(45),
    Weight VARCHAR(45),
    BloodGroup VARCHAR(45),
    CreatedOn DATETIME,
    ModifiedOn DATETIME
);

-- 7. PatientRegister
CREATE TABLE PatientRegister (
    PatientRegisterID INT PRIMARY KEY,
    PatientID INT,
    AdmittedOn VARCHAR(45),
    DischargeOn VARCHAR(45),
    PatientInsuranceID INT,
    RoomNumber VARCHAR(45),
    CoPayType VARCHAR(45),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

-- 8. PatientInsurance
CREATE TABLE PatientInsurance (
    PatientInsuranceID INT PRIMARY KEY,
    PatientID INT,
    ProviderName VARCHAR(45),
    GroupNumber VARCHAR(45),
    InsuranceNumber VARCHAR(45),
    InNetworkCoPay INT,
    OutNetworkCoPay INT,
    StartDate DATETIME,
    EndDate DATETIME,
    IsCurrent BIT,
    CreatedOn DATETIME,
    ModifiedOn DATETIME,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID)
);

-- 9. PatientBilling
CREATE TABLE PatientBilling (
    PatientBillingID INT PRIMARY KEY,
    PatientRegisterID INT,
    TransactionDesc VARCHAR(45),
    Amount DECIMAL(10,2),
    GeneratedDate DATETIME,
    Type VARCHAR(45),
    PatientAddressID INT,
    PaymentType VARCHAR(45),
    FOREIGN KEY (PatientRegisterID) REFERENCES PatientRegister(PatientRegisterID)
);

-- 10. LabTest
CREATE TABLE LabTest (
    LabTestID INT PRIMARY KEY,
    TestName VARCHAR(45),
    IsActive BIT,
    ReferenceMinValue VARCHAR(10),
    ReferenceMaxValue VARCHAR(10),
    CalcUnit VARCHAR(30)
);

-- 11. PatientLabReport
CREATE TABLE PatientLabReport (
    PatientLabReportID INT PRIMARY KEY,
    PatientRegisterID INT,
    LabTestID INT,
    TestValue VARCHAR(45),
    Comment VARCHAR(100),
    FOREIGN KEY (PatientRegisterID) REFERENCES PatientRegister(PatientRegisterID),
    FOREIGN KEY (LabTestID) REFERENCES LabTest(LabTestID)
);

-- 12. Disease
CREATE TABLE Disease (
    DiseaseID INT PRIMARY KEY,
    Name VARCHAR(45)
);

-- 13. PatientDisease (MANY TO MANY)
CREATE TABLE PatientDisease (
    PatientRegisterID INT,
    DiseaseID INT,
    PRIMARY KEY (PatientRegisterID, DiseaseID),
    FOREIGN KEY (PatientRegisterID) REFERENCES PatientRegister(PatientRegisterID),
    FOREIGN KEY (DiseaseID) REFERENCES Disease(DiseaseID)
);

-- 14. PatientAppointment
CREATE TABLE PatientAppointment (
    PatientID INT,
    EmployeeID INT,
    AppointmentDate DATETIME,
    IsComplete BIT,
    IsCancelled BIT,
    IsNoShow BIT,
    CreatedBy INT,
    CreatedOn DATETIME,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- 15. Feedback
CREATE TABLE Feedback (
    FeedbackID INT PRIMARY KEY,
    FromPatientID INT,
    ToEmployeeID INT,
    Comment VARCHAR(45),
    Rating VARCHAR(45),
    CreatedOn DATETIME,
    FOREIGN KEY (FromPatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (ToEmployeeID) REFERENCES Employee(EmployeeID)
);

-- 16. PatientAttendant
CREATE TABLE PatientAttendant (
    PatientRegisterID INT,
    EmployeeID INT,
    PRIMARY KEY (PatientRegisterID, EmployeeID),
    FOREIGN KEY (PatientRegisterID) REFERENCES PatientRegister(PatientRegisterID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

-- 17. Address
CREATE TABLE Address (
    AddressID INT PRIMARY KEY,
    Address1 VARCHAR(45),
    Address2 VARCHAR(45),
    City VARCHAR(45),
    State VARCHAR(45),
    Zipcode VARCHAR(45),
    CreatedOn DATETIME,
    ModifiedOn DATETIME
);

-- 18. AddressType
CREATE TABLE AddressType (
    AddressTypeID INT PRIMARY KEY,
    Type VARCHAR(45)
);

-- 19. EmployeeAddressMapping
CREATE TABLE EmployeeAddressMapping (
    EmployeeAddressMappingID INT PRIMARY KEY,
    EmployeeDetailsID INT,
    AddressTypeID INT,
    AddressID INT,
    IsActive BIT,
    `Index` INT,
    CreatedOn DATETIME,
    ModifiedOn DATETIME,
    FOREIGN KEY (EmployeeDetailsID) REFERENCES EmployeeDetails(EmployeeDetailsID),
    FOREIGN KEY (AddressID) REFERENCES Address(AddressID),
    FOREIGN KEY (AddressTypeID) REFERENCES AddressType(AddressTypeID)
);

-- 20. PatientAddressMapping
CREATE TABLE PatientAddressMapping (
    PatientAddressMappingID INT PRIMARY KEY,
    PatientID INT,
    AddressTypeID INT,
    AddressID INT,
    IsActive BIT,
    `Index` INT,
    CreatedOn DATETIME,
    ModifiedOn DATETIME,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (AddressID) REFERENCES Address(AddressID),
    FOREIGN KEY (AddressTypeID) REFERENCES AddressType(AddressTypeID)
);

-- =======================================
-- VALUES
-- =======================================

-- Department
INSERT INTO Department VALUES
(1,'Cardiology'),
(2,'Neurology'),
(3,'Orthopedics'),
(4,'Pediatrics'),
(5,'Radiology');

-- Role
INSERT INTO Role VALUES
(1,'Doctor'),
(2,'Nurse'),
(3,'Admin'),
(4,'Technician'),
(5,'Receptionist');

-- Employee
INSERT INTO Employee VALUES
(1,'EMP001','doc1@mail.com','pass',1,NOW()),
(2,'EMP002','nurse1@mail.com','pass',1,NOW()),
(3,'EMP003','admin@mail.com','pass',1,NOW()),
(4,'EMP004','tech@mail.com','pass',1,NOW()),
(5,'EMP005','rec@mail.com','pass',1,NOW());

-- EmployeeDetails
INSERT INTO EmployeeDetails VALUES
(1,'Ali','Khan','1990-01-01','Male','0300',1,NOW(),NOW(),1),
(2,'Sara','Ahmed','1992-02-02','Female','0301',2,NOW(),NOW(),2),
(3,'John','Doe','1988-03-03','Male','0302',3,NOW(),NOW(),3),
(4,'Ayesha','Malik','1995-04-04','Female','0303',4,NOW(),NOW(),4),
(5,'Bilal','Raza','1993-05-05','Male','0304',5,NOW(),NOW(),5);

-- EmployeeDepartment
INSERT INTO EmployeeDepartment VALUES
(1,1,1),
(2,4,1),
(3,3,1),
(4,5,1),
(5,2,1);

-- Patient
INSERT INTO Patient VALUES
(1,'P001','Ahmed','Ali','2000-01-01','Male','0311','p1@mail.com','170','70','A+',NOW(),NOW()),
(2,'P002','Fatima','Noor','1998-02-02','Female','0312','p2@mail.com','160','60','B+',NOW(),NOW()),
(3,'P003','Usman','Khan','1995-03-03','Male','0313','p3@mail.com','175','75','O+',NOW(),NOW()),
(4,'P004','Zara','Sheikh','2001-04-04','Female','0314','p4@mail.com','165','55','AB+',NOW(),NOW()),
(5,'P005','Hassan','Raza','1997-05-05','Male','0315','p5@mail.com','180','80','A-',NOW(),NOW());

-- PatientInsurance
INSERT INTO PatientInsurance VALUES
(1,1,'ABC Insurance','G1','INS001',500,1000,NOW(),NOW(),1,NOW(),NOW()),
(2,2,'XYZ Insurance','G2','INS002',400,900,NOW(),NOW(),1,NOW(),NOW()),
(3,3,'ABC Insurance','G3','INS003',300,800,NOW(),NOW(),1,NOW(),NOW()),
(4,4,'XYZ Insurance','G4','INS004',200,700,NOW(),NOW(),1,NOW(),NOW()),
(5,5,'ABC Insurance','G5','INS005',600,1100,NOW(),NOW(),1,NOW(),NOW());

-- PatientRegister
INSERT INTO PatientRegister VALUES
(1,1,'2024-01-01','2024-01-05',1,'101','Cash'),
(2,2,'2024-02-01','2024-02-05',2,'102','Card'),
(3,3,'2024-03-01','2024-03-05',3,'103','Cash'),
(4,4,'2024-04-01','2024-04-05',4,'104','Card'),
(5,5,'2024-05-01','2024-05-05',5,'105','Cash');

-- PatientBilling
INSERT INTO PatientBilling VALUES
(1,1,'Consultation',2000,NOW(),'Credit',1,'Cash'),
(2,2,'Surgery',5000,NOW(),'Debit',2,'Card'),
(3,3,'X-Ray',1500,NOW(),'Credit',3,'Cash'),
(4,4,'MRI',7000,NOW(),'Debit',4,'Card'),
(5,5,'Medicine',1000,NOW(),'Credit',5,'Cash');

-- LabTest
INSERT INTO LabTest VALUES
(1,'Blood Test',1,'4','10','mg'),
(2,'Sugar Test',1,'70','120','mg'),
(3,'Cholesterol',1,'100','200','mg'),
(4,'Hemoglobin',1,'12','16','g/dL'),
(5,'Calcium',1,'8','10','mg');

-- PatientLabReport
INSERT INTO PatientLabReport VALUES
(1,1,1,'7','Normal'),
(2,2,2,'110','Normal'),
(3,3,3,'180','High'),
(4,4,4,'13','Normal'),
(5,5,5,'9','Normal');

-- Disease
INSERT INTO Disease VALUES
(1,'Diabetes'),
(2,'Hypertension'),
(3,'Flu'),
(4,'COVID-19'),
(5,'Asthma');

-- PatientDisease
INSERT INTO PatientDisease VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5);

-- PatientAppointment
INSERT INTO PatientAppointment VALUES
(1,1,NOW(),1,0,0,1,NOW()),
(2,2,NOW(),1,0,0,1,NOW()),
(3,3,NOW(),0,1,0,1,NOW()),
(4,4,NOW(),1,0,0,1,NOW()),
(5,5,NOW(),0,0,1,1,NOW());

-- Feedback
INSERT INTO Feedback VALUES
(1,1,1,'Good','5',NOW()),
(2,2,2,'Average','3',NOW()),
(3,3,3,'Excellent','5',NOW()),
(4,4,4,'Poor','2',NOW()),
(5,5,5,'Good','4',NOW());

-- PatientAttendant
INSERT INTO PatientAttendant VALUES
(1,2),
(2,2),
(3,4),
(4,2),
(5,4);

-- Address
INSERT INTO Address VALUES
(1,'Street 1','Area A','Karachi','Sindh','75000',NOW(),NOW()),
(2,'Street 2','Area B','Lahore','Punjab','54000',NOW(),NOW()),
(3,'Street 3','Area C','Islamabad','ICT','44000',NOW(),NOW()),
(4,'Street 4','Area D','Peshawar','KPK','25000',NOW(),NOW()),
(5,'Street 5','Area E','Quetta','Balochistan','87000',NOW(),NOW());

-- AddressType
INSERT INTO AddressType VALUES
(1,'Home'),
(2,'Office'),
(3,'Billing'),
(4,'Temporary'),
(5,'Permanent');

-- EmployeeAddressMapping
INSERT INTO EmployeeAddressMapping VALUES
(1,1,1,1,1,1,NOW(),NOW()),
(2,2,2,2,1,1,NOW(),NOW()),
(3,3,3,3,1,1,NOW(),NOW()),
(4,4,1,4,1,1,NOW(),NOW()),
(5,5,2,5,1,1,NOW(),NOW());

-- PatientAddressMapping
INSERT INTO PatientAddressMapping VALUES
(1,1,1,1,1,1,NOW(),NOW()),
(2,2,2,2,1,1,NOW(),NOW()),
(3,3,3,3,1,1,NOW(),NOW()),
(4,4,1,4,1,1,NOW(),NOW()),
(5,5,2,5,1,1,NOW(),NOW());

-- =====================================================
-- QUERIES
-- =====================================================

-- View all patients
-- Purpose: Check master patient list
SELECT * FROM Patient;

-- View all employees
-- Purpose: Hospital staff directory
SELECT * FROM Employee;

-- View all departments
-- Purpose: Hospital structure
SELECT * FROM Department;

-- View all roles
-- Purpose: Employee job classification
SELECT * FROM Role;

-- Get employee full details with role
-- Purpose: Understand employee designation
SELECT e.EmployeeID, ed.FirstName, ed.LastName, r.RoleDesc
FROM Employee e
JOIN EmployeeDetails ed ON e.EmployeeID = ed.EmployeeID
JOIN Role r ON ed.RoleID = r.RoleID;

-- Get employees with department mapping
-- Purpose: Which employee works in which department
SELECT e.EmployeeID, d.DepartmentName
FROM Employee e
JOIN EmployeeDepartment edp ON e.EmployeeID = edp.EmployeeID
JOIN Department d ON edp.DepartmentID = d.DepartmentID;

-- Get patient admission details
-- Purpose: Patient hospitalization tracking
SELECT p.PatientID, p.FirstName, pr.RoomNumber, pr.AdmittedOn
FROM Patient p
JOIN PatientRegister pr ON p.PatientID = pr.PatientID;

-- Count total patients
-- Purpose: Hospital patient load
SELECT COUNT(*) AS TotalPatients FROM Patient;

-- Patients by blood group
-- Purpose: Blood group distribution
SELECT BloodGroup, COUNT(*) AS Total
FROM Patient
GROUP BY BloodGroup;

-- Female vs Male patients
-- Purpose: Gender analytics
SELECT Gender, COUNT(*) AS Total
FROM Patient
GROUP BY Gender;

-- All appointments with doctor (employee)
-- Purpose: Doctor schedule tracking
SELECT pa.PatientID, pa.EmployeeID, pa.AppointmentDate
FROM PatientAppointment pa;

-- Completed appointments
-- Purpose: Performance tracking
SELECT COUNT(*) AS CompletedAppointments
FROM PatientAppointment
WHERE IsComplete = 1;

-- Cancelled appointments
-- Purpose: Service quality issue tracking
SELECT COUNT(*) AS CancelledAppointments
FROM PatientAppointment
WHERE IsCancelled = 1;

-- No-show patients
-- Purpose: Patient behavior tracking
SELECT COUNT(*) AS NoShowPatients
FROM PatientAppointment
WHERE IsNoShow = 1;

-- Total revenue
-- Purpose: Hospital income
SELECT SUM(Amount) AS TotalRevenue
FROM PatientBilling;

-- Revenue by payment type
-- Purpose: Cash vs Card analysis
SELECT PaymentType, SUM(Amount) AS Total
FROM PatientBilling
GROUP BY PaymentType;

-- Highest billing transactions
-- Purpose: Identify expensive cases
SELECT *
FROM PatientBilling
ORDER BY Amount DESC
LIMIT 5;

-- All lab tests
-- Purpose: Available tests
SELECT * FROM LabTest;

-- Patient lab results
-- Purpose: Medical report tracking
SELECT plr.PatientRegisterID, lt.TestName, plr.TestValue
FROM PatientLabReport plr
JOIN LabTest lt ON plr.LabTestID = lt.LabTestID;

-- Abnormal lab results (simple filter example)
-- Purpose: Identify risky patients
SELECT *
FROM PatientLabReport
WHERE Comment != 'Normal';

-- All diseases
SELECT * FROM Disease;

-- Patients with diseases
-- Purpose: Medical condition mapping
SELECT pr.PatientRegisterID, d.Name
FROM PatientDisease pd
JOIN Disease d ON pd.DiseaseID = d.DiseaseID
JOIN PatientRegister pr ON pd.PatientRegisterID = pr.PatientRegisterID;

-- Most common disease (interview KPI)
-- Purpose: Disease frequency
SELECT d.Name, COUNT(*) AS TotalCases
FROM PatientDisease pd
JOIN Disease d ON pd.DiseaseID = d.DiseaseID
GROUP BY d.Name
ORDER BY TotalCases DESC;

-- Doctor appointment load
-- Purpose: Workload analysis
SELECT EmployeeID, COUNT(*) AS TotalAppointments
FROM PatientAppointment
GROUP BY EmployeeID
ORDER BY TotalAppointments DESC;

-- Employee feedback rating
-- Purpose: Service quality
SELECT ToEmployeeID, AVG(Rating) AS AvgRating
FROM Feedback
GROUP BY ToEmployeeID;

-- Active insurance patients
-- Purpose: Insurance coverage check
SELECT PatientID, ProviderName
FROM PatientInsurance
WHERE IsCurrent = 1;

-- Insurance usage summary
-- Purpose: Insurance provider analysis
SELECT ProviderName, COUNT(*) AS TotalPatients
FROM PatientInsurance
GROUP BY ProviderName;

-- Employee addresses
SELECT e.EmployeeID, a.City, at.Type
FROM EmployeeAddressMapping eam
JOIN Address a ON eam.AddressID = a.AddressID
JOIN AddressType at ON eam.AddressTypeID = at.AddressTypeID
JOIN EmployeeDetails e ON eam.EmployeeDetailsID = e.EmployeeDetailsID;

-- Patient addresses
SELECT p.PatientID, a.City, at.Type
FROM PatientAddressMapping pam
JOIN Address a ON pam.AddressID = a.AddressID
JOIN AddressType at ON pam.AddressTypeID = at.AddressTypeID
JOIN Patient p ON pam.PatientID = p.PatientID;

-- Hospital total revenue KPI
SELECT SUM(Amount) AS Revenue FROM PatientBilling;

-- Total patients KPI
SELECT COUNT(*) AS Patients FROM Patient;

-- Total active doctors KPI
SELECT COUNT(DISTINCT EmployeeID) AS Doctors
FROM EmployeeDetails
WHERE RoleID = 1;

-- Average appointment per doctor KPI
SELECT AVG(AppCount) AS AvgAppointments
FROM (
    SELECT EmployeeID, COUNT(*) AS AppCount
    FROM PatientAppointment
    GROUP BY EmployeeID
) AS Temp;

-- Q1: Which patient has highest billing?
SELECT PatientRegisterID, SUM(Amount) AS TotalSpent
FROM PatientBilling
GROUP BY PatientRegisterID
ORDER BY TotalSpent DESC
LIMIT 1;

-- Q2: Which department has most employees?
SELECT d.DepartmentName, COUNT(*) AS TotalEmployees
FROM EmployeeDepartment ed
JOIN Department d ON ed.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName
ORDER BY TotalEmployees DESC;

-- Q3: Which doctor is most active?
SELECT EmployeeID, COUNT(*) AS Appointments
FROM PatientAppointment
GROUP BY EmployeeID
ORDER BY Appointments DESC
LIMIT 1;

-- Q4: Patients with no insurance
SELECT p.PatientID
FROM Patient p
LEFT JOIN PatientInsurance pi ON p.PatientID = pi.PatientID
WHERE pi.PatientID IS NULL;

-- Q5: Monthly revenue (basic example)
SELECT DATE(GeneratedDate) AS Date, SUM(Amount)
FROM PatientBilling
GROUP BY DATE(GeneratedDate);

