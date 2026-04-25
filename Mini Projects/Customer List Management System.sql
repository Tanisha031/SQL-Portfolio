CREATE DATABASE CustomerDB;
USE CustomerDB;

CREATE TABLE Customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE Interactions (
    interaction_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    interaction_type VARCHAR(50),
    interaction_date DATE,
    notes VARCHAR(200),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

INSERT INTO Customers (name, phone, email, city) VALUES
('Ali','03001111111','ali@gmail.com','Karachi'),
('Sara','03002222222','sara@gmail.com','Lahore'),
('Usman','03003333333','usman@gmail.com','Islamabad'),
('Ayesha','03004444444','ayesha@gmail.com','Karachi'),
('Bilal','03005555555','bilal@gmail.com','Peshawar');

INSERT INTO Interactions (customer_id, interaction_type, interaction_date, notes) VALUES
(1,'Call','2024-09-01','Follow-up'),
(2,'Email','2024-09-02','Inquiry'),
(3,'Meeting','2024-09-03','Discussion'),
(4,'Call','2024-09-04','Feedback'),
(5,'Email','2024-09-05','Support');

-- View customers
SELECT * FROM Customers;

-- Interactions per customer
SELECT c.name, COUNT(i.interaction_id) AS total_interactions
FROM Interactions i
JOIN Customers c ON i.customer_id = c.customer_id
GROUP BY c.name;

-- Latest interactions
SELECT * FROM Interactions
ORDER BY interaction_date DESC;

-- Customers from Karachi
SELECT * FROM Customers
WHERE city = 'Karachi';