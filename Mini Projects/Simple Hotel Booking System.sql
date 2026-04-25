CREATE DATABASE HotelDB;
USE HotelDB;

CREATE TABLE Rooms (
    room_id INT AUTO_INCREMENT PRIMARY KEY,
    room_type VARCHAR(50),
    price_per_night DECIMAL(10,2),
    availability_status VARCHAR(20)
);

CREATE TABLE Guests (
    guest_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE Bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    guest_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (guest_id) REFERENCES Guests(guest_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

INSERT INTO Rooms (room_type, price_per_night, availability_status) VALUES
('Single',3000,'Available'),
('Double',5000,'Booked'),
('Suite',10000,'Available'),
('Single',3200,'Available'),
('Double',5500,'Booked');

INSERT INTO Guests (name, phone, email) VALUES
('Ali','03001111111','ali@gmail.com'),
('Sara','03002222222','sara@gmail.com'),
('Usman','03003333333','usman@gmail.com'),
('Ayesha','03004444444','ayesha@gmail.com'),
('Bilal','03005555555','bilal@gmail.com');

INSERT INTO Bookings (guest_id, room_id, check_in, check_out, total_amount) VALUES
(1,1,'2024-10-01','2024-10-03',6000),
(2,2,'2024-10-02','2024-10-04',10000),
(3,3,'2024-10-03','2024-10-05',20000),
(4,4,'2024-10-04','2024-10-06',6400),
(5,5,'2024-10-05','2024-10-07',11000);

-- View all bookings
SELECT * FROM Bookings;

-- Total revenue
SELECT SUM(total_amount) AS total_revenue FROM Bookings;

-- Join: Guest + Room
SELECT g.name, r.room_type, b.check_in, b.check_out
FROM Bookings b
JOIN Guests g ON b.guest_id = g.guest_id
JOIN Rooms r ON b.room_id = r.room_id;

-- Available rooms
SELECT * FROM Rooms
WHERE availability_status = 'Available';