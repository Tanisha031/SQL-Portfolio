-- Create database
CREATE DATABASE IF NOT EXISTS PracticeDB;
USE PracticeDB;

-- Create old table
CREATE TABLE Students (
    ID INT,
    Name VARCHAR(50),
    Marks INT
);

-- Rename table
RENAME TABLE Students TO Student_Info;

-- Check tables
SHOW TABLES;