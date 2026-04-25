CREATE DATABASE SchoolDB;
USE SchoolDB;

CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    class VARCHAR(20),
    roll_no INT
);

CREATE TABLE Subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(100)
);

CREATE TABLE Results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    marks INT,
    exam_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

INSERT INTO Students (name, class, roll_no) VALUES
('Ali','10th',1),
('Sara','10th',2),
('Usman','10th',3),
('Ayesha','10th',4),
('Bilal','10th',5);

INSERT INTO Subjects (subject_name) VALUES
('Math'),
('English'),
('Science'),
('Computer'),
('Urdu');

INSERT INTO Results (student_id, subject_id, marks, exam_date) VALUES
(1,1,85,'2024-06-01'),
(2,2,78,'2024-06-01'),
(3,3,88,'2024-06-01'),
(4,4,92,'2024-06-01'),
(5,5,80,'2024-06-01');

-- View all results
SELECT * FROM Results;

-- Average marks per student
SELECT s.name, AVG(r.marks) AS avg_marks
FROM Results r
JOIN Students s ON r.student_id = s.student_id
GROUP BY s.name;

-- Highest marks
SELECT MAX(marks) AS highest_marks FROM Results;

-- Join: Student + Subject + Marks
SELECT s.name, sub.subject_name, r.marks
FROM Results r
JOIN Students s ON r.student_id = s.student_id
JOIN Subjects sub ON r.subject_id = sub.subject_id;