-- Use a new database
CREATE DATABASE IF NOT EXISTS sql_datatypes;
USE sql_datatypes;

-- 1) Numeric Data Types – Exact Numeric
CREATE TABLE IF NOT EXISTS Product_Sales (
    ProductID INT PRIMARY KEY,
    Quantity SMALLINT,
    UnitPrice DECIMAL(10,2),
    TotalAmount DECIMAL(10,2)
);

-- 1) Numeric Data Types – Approximate Numeric
CREATE TABLE IF NOT EXISTS Measurements (
    SensorID INT,
    Temperature FLOAT,
    Humidity REAL
);

-- 2) Character and String Data Types – Non-Unicode
CREATE TABLE IF NOT EXISTS Employee_Info (
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName CHAR(30),
    Bio TEXT
);

-- 2) Character and String Data Types – Unicode
CREATE TABLE IF NOT EXISTS International_Users (
    UserID INT PRIMARY KEY,
    FullName NVARCHAR(100),
    Country NCHAR(50)
);

-- 3) Date and Time Data Types
CREATE TABLE IF NOT EXISTS Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    OrderTime TIME,
    ShippedAt DATETIME
);

-- 4) Binary Data Types
CREATE TABLE IF NOT EXISTS Product_Images (
    ImageID INT PRIMARY KEY,
    ImageName VARCHAR(100)
);

-- 5) Boolean Data Types
CREATE TABLE IF NOT EXISTS User_Status (
    UserID INT PRIMARY KEY,
    IsActive INTEGER,
    IsVerified INTEGER
);

-- 6) Special Data Types – XML
CREATE TABLE IF NOT EXISTS XML_Records (
    RecordID INT PRIMARY KEY
);

-- 6) Special Data Types – Spatial (Geometry)
CREATE TABLE IF NOT EXISTS Locations (
    LocationID INT PRIMARY KEY,
    Area GEOMETRY
);