-- Create Database
CREATE DATABASE LibraryDB;
USE LibraryDB;

-- Table Creation
-- 1. Members Table
CREATE TABLE Members (
    member_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address TEXT,
    membership_date DATE
);

-- 2. Books Table
CREATE TABLE Books (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(200),
    author VARCHAR(100),
    genre VARCHAR(50),
    publisher VARCHAR(100),
    published_year INT,
    total_copies INT,
    available_copies INT
);

-- 3. Staff Table
CREATE TABLE Staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    role VARCHAR(50),
    hire_date DATE,
    salary DECIMAL(10,2)
);

-- 4. Issued Books Table
CREATE TABLE Issued_Books (
    issue_id INT PRIMARY KEY AUTO_INCREMENT,
    member_id INT,
    book_id INT,
    issue_date DATE,
    due_date DATE,
    return_date DATE,
    status VARCHAR(20), -- Issued / Returned / Overdue
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- 5. Fines Table
CREATE TABLE Fines (
    fine_id INT PRIMARY KEY AUTO_INCREMENT,
    issue_id INT,
    amount DECIMAL(10,2),
    paid_status VARCHAR(20), -- Paid / Unpaid
    FOREIGN KEY (issue_id) REFERENCES Issued_Books(issue_id)
);

-- Sample Data
-- Members
INSERT INTO Members (full_name, email, phone, address)
VALUES
('Ali Khan', 'ali@gmail.com', '03001234567', 'Karachi'),
('Sara Ahmed', 'sara@gmail.com', '03111234567', 'Lahore'),
('John Smith', 'john@gmail.com', '03221234567', 'Dubai');

-- Books
INSERT INTO Books (title, author, genre, publisher, published_year, total_copies, available_copies)
VALUES
('Database Systems', 'Abraham Silberschatz', 'Education', 'McGraw Hill', 2019, 10, 7),
('SQL Basics', 'John Smith', 'Technology', 'Tech Press', 2021, 15, 10),
('Data Analytics', 'Alex Brown', 'Data Science', 'OReilly', 2022, 12, 8);

-- Staff
INSERT INTO Staff (full_name, role, hire_date, salary)
VALUES
('Ahmed Raza', 'Librarian', '2020-01-10', 50000),
('Ayesha Malik', 'Assistant', '2021-06-15', 30000);

-- Issued Books
INSERT INTO Issued_Books (member_id, book_id, issue_date, due_date, return_date, status)
VALUES
(1, 1, '2025-01-01', '2025-01-10', '2025-01-09', 'Returned'),
(2, 2, '2025-01-05', '2025-01-15', NULL, 'Issued'),
(3, 3, '2025-01-07', '2025-01-17', NULL, 'Issued');

-- Fines
INSERT INTO Fines (issue_id, amount, paid_status)
VALUES
(2, 50.00, 'Unpaid'),
(3, 0.00, 'Paid');

-- 1. Total Books in Library
SELECT SUM(total_copies) AS total_books
FROM Books;

-- 2. Available vs Issued Books
SELECT 
    SUM(available_copies) AS available_books,
    SUM(total_copies - available_copies) AS issued_books
FROM Books;

-- 3. Most Borrowed Books
SELECT b.title, COUNT(i.book_id) AS times_issued
FROM Issued_Books i
JOIN Books b ON i.book_id = b.book_id
GROUP BY b.title
ORDER BY times_issued DESC;
-- 4. Active Members (Currently Holding Books)
SELECT DISTINCT m.full_name
FROM Members m
JOIN Issued_Books i ON m.member_id = i.member_id
WHERE i.status = 'Issued';

-- 5. Overdue Books Report
SELECT m.full_name, b.title, i.due_date
FROM Issued_Books i
JOIN Members m ON i.member_id = m.member_id
JOIN Books b ON i.book_id = b.book_id
WHERE i.due_date < CURDATE()
AND i.status != 'Returned';

-- 6. Total Fine Collected
SELECT SUM(amount) AS total_fine_collected
FROM Fines
WHERE paid_status = 'Paid';

-- 7. Genre-wise Book Distribution
SELECT genre, COUNT(*) AS total_books
FROM Books
GROUP BY genre;

-- 8. Monthly Book Issue Trend
SELECT 
    DATE_FORMAT(issue_date, '%Y-%m') AS month,
    COUNT(*) AS books_issued
FROM Issued_Books
GROUP BY month
ORDER BY month;

-- 9. Staff Salary Report
SELECT full_name, role, salary
FROM Staff
ORDER BY salary DESC;

-- 10. Book Availability Alert (Low Stock)
SELECT title, available_copies
FROM Books
WHERE available_copies < 3;

-- 11. Book Performance Score (Popularity Ranking)
SELECT 
    b.title,
    COUNT(i.issue_id) AS total_issues,
    b.available_copies,
    RANK() OVER (ORDER BY COUNT(i.issue_id) DESC) AS popularity_rank
FROM Books b
JOIN Issued_Books i ON b.book_id = i.book_id
GROUP BY b.book_id, b.title, b.available_copies;