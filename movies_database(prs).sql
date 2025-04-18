SET SQL_SAFE_UPDATES = 0;
CREATE DATABASE `movies`;
USE `movies`;
CREATE TABLE `director` (
    director_id INT PRIMARY KEY AUTO_INCREMENT,
    director_name VARCHAR(255) NOT NULL
    );
CREATE TABLE `language` (
    language_id INT PRIMARY KEY AUTO_INCREMENT,
    language_name VARCHAR(255) NOT NULL
    );
CREATE TABLE `country` (
    country_id INT PRIMARY KEY AUTO_INCREMENT,
    country_name VARCHAR(255) NOT NULL
    );
CREATE TABLE `genre` (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    genre_name VARCHAR(255) NOT NULL
    );
CREATE TABLE `movie` (
    movie_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    release_year INT,
    duration INT,
    budget DECIMAL(15,2),
    box_office DECIMAL(15,2),
    director_id INT,
    language_id INT,
    country_id INT,
    FOREIGN KEY (director_id) REFERENCES `director` (director_id),
    FOREIGN KEY (language_id) REFERENCES `language` (language_id),
    FOREIGN KEY (country_id) REFERENCES `country` (country_id)
    );
CREATE TABLE `movie_genre` (
    movie_id INT,
    genre_id INT,
    PRIMARY KEY (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES `movie` (movie_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES `genre` (genre_id) ON DELETE CASCADE
);
INSERT INTO `genre` (genre_name)
VALUES
    ('Fiction'),
    ('Dystopian'),
    ('Adventure'),
    ('Historical'),
    ('Coming-of-Age'),
    ('Romance'),
    ('Epic'),
    ('Philosophical'),
    ('Fantasy'),
    ('Satire');
INSERT INTO `country` (country_name)
VALUES
('USA'),
('Romania'),
('Spain'),
('Germany'),
('England'),
('France'),
('Italy'),
('Denmark'),
('Norway'),
('Sweden');
INSERT INTO `language` (language_name)
VALUES
('English'),
('Spanish'),
('Chinese'),
('Portuguese'),
('Japanese'),
('Romanian'),
('Indian'),
('Russian'),
('Bulgarian'),
('Korean');
INSERT INTO `director` (director_name)
VALUES
('Robert Stephan'),
('Joe Tony'),
('Andrew Osgwald'),
('Cristiano Ronaldo'),
('Lawrence Idwil'),
('Jeffrey Townley'),
('Trevor Mike'),
('Ikar Suts'),
('Robert Downey'),
('Michael Fill');
INSERT INTO `movie` (movie_id, title, release_year, duration, budget, box_office, director_id, language_id, country_id)
VALUES
(1, 'The Silent Horizon', 2018, 125, 50000000.00, 180000000.00, 3, 1, 1),
(2, 'Echoes of Time', 2020, 140, 75000000.00, 250000000.00, 5, 2, 3),
(3, 'Crimson Night', 2017, 68, 30000000.00, 90000000.00, 2, 1, 2),
(4, 'Last Chance', 2019, 95, 15000000.00, 45000000.00, 8, 6, 2),
(5, 'Skyward Bound', 2021, 130, 120000000.00, 600000000.00, 7, 1, 2),
(6, 'Shadows Within', 2016, 55, 20000000.00, 70000000.00, 1, 2, 2),
(7, 'Beyond the Ice', 2015, 118, 40000000.00, 150000000.00, 4, 1, 1),
(8, 'Hidden Truth', 2022, 60, 25000000.00, 85000000.00, 9, 5, 2),
(9, 'Fading Lights', 2018, 112, 18000000.00, 65000000.00, 6, 3, 1),
(10, 'Winds of Destiny', 2023, 145, 95000000.00, 310000000.00, 10, 1, 2);
INSERT INTO movie_genre (movie_id, genre_id)
VALUES 
(1, 3),
(2, 6),
(3, 2),
(4, 2),
(5, 7),
(6, 3),
(7, 3),
(8, 5),
(9, 2),
(10, 1);
UPDATE country
SET country_name = 'United States of America'
WHERE country_id = 1;
DELETE FROM movie
WHERE duration < 70;
SELECT * FROM movie
WHERE duration BETWEEN 120 AND 150 AND budget > 200000;
SELECT LOWER(director_name) AS lowercase_name
FROM director;
-- 1.
SELECT title, budget
FROM movie m1
WHERE budget > (
SELECT AVG(budget)
FROM movie m2
);
-- 2.
SELECT country_name,
    (SELECT COUNT(*)
    FROM movie m
    WHERE m.country_id = c.country_id) AS total_movies
    FROM country c
    ORDER BY total_movies DESC;
-- 3.
SELECT g.genre_name, COUNT(mg.movie_id) AS total_movies
FROM movie_genre mg
JOIN genre g ON mg.genre_id = g.genre_id
GROUP BY mg.genre_id, g.genre_name
HAVING COUNT(mg.movie_id) > 5;
-- 4.
SELECT title, box_office
FROM movie
ORDER BY box_office DESC
LIMIT 10;
-- 5.
SELECT title, duration
FROM movie
ORDER BY duration ASC
LIMIT 5;
-- 6.
SELECT SUM(box_office) AS "Venitul total al tuturor filmelor din baza de date"
FROM movie;
-- 7.
SELECT AVG(duration) AS "Durata medie a tuturor filmelor"
FROM movie;
-- 8.
SELECT MAX(budget) AS "Cel mai scump film dupa buget", MIN(budget) AS "Cel mai ieftin film dupa buget"
FROM movie;
-- 9.
SELECT UPPER(title)
FROM movie
WHERE LENGTH(title) > 15;
-- 10.
SELECT title, SUBSTRING(title, 1, 5) AS "Primele 5 caractere"
FROM movie;
-- 11.
SELECT 
    g.genre_name AS Gen,
    COUNT(mg.movie_id) AS Numar_Filme
FROM 
    genre g
LEFT JOIN 
    movie_genre mg ON g.genre_id = mg.genre_id
GROUP BY 
    g.genre_name
ORDER BY 
    Numar_Filme DESC;
SHOW VARIABLES LIKE 'port';
-- 12.
SELECT 
    g.genre_name,
    SUM(m.box_office) AS Castiguri_totale
FROM 
    movie_genre mg
JOIN 
    genre g ON mg.genre_id = g.genre_id
JOIN 
    movie m ON mg.movie_id = m.movie_id
GROUP BY 
    g.genre_name
ORDER BY 
    Castiguri_totale DESC LIMIT 3;
-- 13.
SELECT 
    title,
    budget,
    box_office
FROM movie
WHERE budget IS NOT NULL AND box_office IS NOT NULL;
-- 14.
SELECT AVG(budget) AS "Bugetul mediu al filmelor", AVG(box_office) AS "Castigul mediu al filmelor"
FROM movie;
-- 15.
SELECT 
    c.country_name,
    AVG(m.box_office) AS Castig_mediu
FROM 
    movie m
JOIN 
    country c ON m.country_id = c.country_id
WHERE 
    m.box_office IS NOT NULL
GROUP BY 
    c.country_name
ORDER BY 
    Castig_mediu DESC
LIMIT 5;
-- 16.
SELECT 
    title,
    box_office
FROM 
    movie
WHERE 
    box_office IS NOT NULL
ORDER BY 
    box_office DESC
LIMIT 10;



