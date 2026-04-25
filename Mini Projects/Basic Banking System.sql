CREATE DATABASE BankingDB;
USE BankingDB;

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(200)
);

CREATE TABLE Accounts (
    account_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    account_type VARCHAR(50),
    balance DECIMAL(12,2) DEFAULT 0,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Transactions (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    transaction_type VARCHAR(20), -- deposit / withdraw
    amount DECIMAL(12,2),
    transaction_date DATE,
    FOREIGN KEY (account_id) REFERENCES Accounts(account_id)
);

INSERT INTO Customers (name, phone, address) VALUES
('Ali','03001111111','Karachi'),
('Sara','03002222222','Lahore'),
('Usman','03003333333','Islamabad'),
('Ayesha','03004444444','Karachi'),
('Bilal','03005555555','Peshawar');

INSERT INTO Accounts (customer_id, account_type, balance) VALUES
(1,'Saving',50000),
(2,'Current',70000),
(3,'Saving',30000),
(4,'Current',90000),
(5,'Saving',45000);

INSERT INTO Transactions (account_id, transaction_type, amount, transaction_date) VALUES
(1,'deposit',10000,'2024-05-01'),
(2,'withdraw',5000,'2024-05-02'),
(3,'deposit',7000,'2024-05-03'),
(4,'withdraw',2000,'2024-05-04'),
(5,'deposit',8000,'2024-05-05');

-- View all accounts
SELECT * FROM Accounts;

-- Total balance in bank
SELECT SUM(balance) AS total_balance FROM Accounts;

-- Transactions of a specific account
SELECT * FROM Transactions
WHERE account_id = 1;

-- Join: Customer + Account
SELECT c.name, a.account_type, a.balance
FROM Accounts a
JOIN Customers c ON a.customer_id = c.customer_id;