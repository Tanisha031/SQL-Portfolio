-- Create Database
CREATE DATABASE BankDB;
USE BankDB;

-- 1. Customers Table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    dob DATE,
    gender VARCHAR(10),
    phone VARCHAR(20),
    email VARCHAR(100),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Accounts Table
CREATE TABLE Accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    account_type VARCHAR(20), -- Savings / Checking / Loan
    balance DECIMAL(12,2) DEFAULT 0,
    status VARCHAR(20) DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- 3. Employees Table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(100),
    role VARCHAR(50),
    branch VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);

-- 4. Transactions Table
CREATE TABLE Transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT,
    transaction_type VARCHAR(20), -- Deposit / Withdraw / Transfer
    amount DECIMAL(12,2),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20),
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

-- 5. Loans Table
CREATE TABLE Loans (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    loan_amount DECIMAL(12,2),
    interest_rate DECIMAL(5,2),
    start_date DATE,
    end_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

-- Customers
INSERT INTO Customers (full_name, dob, gender, phone, email, address)
VALUES
('Ali Ahmed', '1995-05-12', 'Male', '03001234567', 'ali@gmail.com', 'Karachi'),
('Sara Khan', '1998-09-21', 'Female', '03111234567', 'sara@gmail.com', 'Lahore'),
('John Smith', '1990-01-10', 'Male', '03221234567', 'john@gmail.com', 'Dubai');

-- Accounts
INSERT INTO Accounts (customer_id, account_type, balance)
VALUES
(1, 'Savings', 50000),
(2, 'Savings', 75000),
(3, 'Checking', 120000);

-- Employees
INSERT INTO Employees (full_name, role, branch, salary, hire_date)
VALUES
('Ahmed Raza', 'Manager', 'Karachi', 120000, '2020-01-15'),
('Ayesha Malik', 'Cashier', 'Lahore', 60000, '2021-06-10');

-- Transactions
INSERT INTO Transactions (account_id, transaction_type, amount, status)
VALUES
(1, 'Deposit', 10000, 'Success'),
(2, 'Withdraw', 5000, 'Success'),
(3, 'Deposit', 20000, 'Success');

-- Loans
INSERT INTO Loans (customer_id, loan_amount, interest_rate, start_date, end_date, status)
VALUES
(1, 200000, 12.5, '2024-01-01', '2026-01-01', 'Active'),
(2, 150000, 10.0, '2023-06-01', '2025-06-01', 'Active');

-- 1. Total Balance in Bank
SELECT SUM(balance) AS total_bank_balance
FROM Accounts;

-- 2. Top Customers by Balance
SELECT c.full_name, a.balance
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
ORDER BY a.balance DESC;

-- 3. Monthly Transaction Summary
SELECT 
    DATE_FORMAT(transaction_date, '%Y-%m') AS month,
    COUNT(*) AS total_transactions,
    SUM(amount) AS total_amount
FROM Transactions
GROUP BY month
ORDER BY month;

-- 4. Account Type Distribution
SELECT account_type, COUNT(*) AS total_accounts
FROM Accounts
GROUP BY account_type;

-- 5. High Value Transactions (>10,000)
SELECT *
FROM Transactions
WHERE amount > 10000;

-- 6. Customer with Loan + Account
SELECT c.full_name, l.loan_amount, a.balance
FROM Customers c
JOIN Loans l ON c.customer_id = l.customer_id
JOIN Accounts a ON c.customer_id = a.customer_id;

-- 7. Active vs Inactive Accounts
SELECT status, COUNT(*) AS total
FROM Accounts
GROUP BY status;

-- 8. Branch-wise Employee Count
SELECT branch, COUNT(*) AS total_employees
FROM Employees
GROUP BY branch;

-- 9 Customer Net Worth (Balance + Loans)
SELECT 
    c.full_name,
    a.balance,
    COALESCE(l.loan_amount, 0) AS loan_amount,
    (a.balance - COALESCE(l.loan_amount, 0)) AS net_worth
FROM Customers c
JOIN Accounts a ON c.customer_id = a.customer_id
LEFT JOIN Loans l ON c.customer_id = l.customer_id;