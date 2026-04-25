CREATE DATABASE MovieDB;
USE MovieDB;

CREATE TABLE Movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150),
    genre VARCHAR(50),
    release_year INT
);

CREATE TABLE Actors (
    actor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE Movie_Cast (
    cast_id INT AUTO_INCREMENT PRIMARY KEY,
    movie_id INT,
    actor_id INT,
    role_name VARCHAR(100),
    FOREIGN KEY (movie_id) REFERENCES Movies(movie_id),
    FOREIGN KEY (actor_id) REFERENCES Actors(actor_id)
);

INSERT INTO Movies (title, genre, release_year) VALUES
('Inception','Sci-Fi',2010),
('Titanic','Romance',1997),
('Avengers','Action',2012),
('Joker','Drama',2019),
('Frozen','Animation',2013);

INSERT INTO Actors (name) VALUES
('Leonardo DiCaprio'),
('Kate Winslet'),
('Robert Downey Jr.'),
('Joaquin Phoenix'),
('Idina Menzel');

INSERT INTO Movie_Cast (movie_id, actor_id, role_name) VALUES
(1,1,'Cobb'),
(2,2,'Rose'),
(3,3,'Iron Man'),
(4,4,'Joker'),
(5,5,'Elsa');

-- View all movies
SELECT * FROM Movies;

-- Movies by genre
SELECT * FROM Movies
WHERE genre = 'Action';

-- Join: Movie + Actor
SELECT m.title, a.name
FROM Movie_Cast mc
JOIN Movies m ON mc.movie_id = m.movie_id
JOIN Actors a ON mc.actor_id = a.actor_id;

-- Count movies per genre
SELECT genre, COUNT(*) AS total
FROM Movies
GROUP BY genre;