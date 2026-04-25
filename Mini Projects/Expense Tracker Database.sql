CREATE DATABASE ExpenseDB;
USE ExpenseDB;

CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE Expenses (
    expense_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    category VARCHAR(50),
    amount DECIMAL(10,2),
    expense_date DATE,
    note VARCHAR(200),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

INSERT INTO Users (name, email) VALUES
('Ali','ali@gmail.com'),
('Sara','sara@gmail.com'),
('Usman','usman@gmail.com'),
('Ayesha','ayesha@gmail.com'),
('Bilal','bilal@gmail.com');

INSERT INTO Expenses (user_id, category, amount, expense_date, note) VALUES
(1,'Food',500,'2024-08-01','Lunch'),
(2,'Transport',300,'2024-08-02','Bus fare'),
(3,'Shopping',2000,'2024-08-03','Clothes'),
(4,'Bills',1500,'2024-08-04','Electricity'),
(5,'Food',700,'2024-08-05','Dinner');

-- View all expenses
SELECT * FROM Expenses;

-- Total expenses per user
SELECT u.name, SUM(e.amount) AS total_spent
FROM Expenses e
JOIN Users u ON e.user_id = u.user_id
GROUP BY u.name;

-- Expenses by category
SELECT category, SUM(amount) AS total
FROM Expenses
GROUP BY category;

-- Highest expense
SELECT MAX(amount) AS max_expense FROM Expenses;