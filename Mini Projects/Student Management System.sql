CREATE DATABASE StudentDB;
USE StudentDB;

CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    gender VARCHAR(10),
    dob DATE,
    department VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15)
);

CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);

CREATE TABLE Enrollments (
    enroll_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enroll_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Students (name, gender, dob, department, email, phone) VALUES
('Ali Khan','Male','2002-05-10','CS','ali@gmail.com','03001234567'),
('Sara Ahmed','Female','2001-08-15','IT','sara@gmail.com','03011234567'),
('Usman Ali','Male','2003-01-20','SE','usman@gmail.com','03021234567'),
('Ayesha Noor','Female','2002-11-30','CS','ayesha@gmail.com','03031234567'),
('Bilal Ahmed','Male','2001-07-25','IT','bilal@gmail.com','03041234567');

INSERT INTO Courses (course_name, credits) VALUES
('Database Systems',3),
('Programming',4),
('Data Structures',3),
('Operating Systems',4),
('Networks',3);

INSERT INTO Enrollments (student_id, course_id, enroll_date) VALUES
(1,1,'2024-01-01'),
(2,2,'2024-01-02'),
(3,3,'2024-01-03'),
(4,4,'2024-01-04'),
(5,5,'2024-01-05');

-- Get all students
SELECT * FROM Students;

-- Get students from CS department
SELECT * FROM Students
WHERE department = 'CS';

-- Count total students
SELECT COUNT(*) AS total_students FROM Students;

-- Join: Student + Course
SELECT s.name, c.course_name
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id;

-- Count students per department
SELECT department, COUNT(*) AS total
FROM Students
GROUP BY department;