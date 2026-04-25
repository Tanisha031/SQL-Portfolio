CREATE DATABASE ContactDB;
USE ContactDB;

CREATE TABLE Contacts (
    contact_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(200),
    category VARCHAR(50) -- family / friend / work
);

INSERT INTO Contacts (name, phone, email, address, category) VALUES
('Ali','03001111111','ali@gmail.com','Karachi','Friend'),
('Sara','03002222222','sara@gmail.com','Lahore','Work'),
('Usman','03003333333','usman@gmail.com','Islamabad','Family'),
('Ayesha','03004444444','ayesha@gmail.com','Karachi','Friend'),
('Bilal','03005555555','bilal@gmail.com','Peshawar','Work');

-- View all contacts
SELECT * FROM Contacts;

-- Filter by category
SELECT * FROM Contacts
WHERE category = 'Friend';

-- Count contacts by category
SELECT category, COUNT(*) AS total
FROM Contacts
GROUP BY category;

-- Search by name
SELECT * FROM Contacts
WHERE name LIKE '%Ali%';