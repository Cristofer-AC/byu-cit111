CREATE DATABASE mdb;

USE mdb;

CREATE TABLE actors
	(actor_id INT NOT NULL AUTO_INCREMENT,
    last_name VARCHAR(30) NOT NULL,
    first_name VARCHAR(25) NOT NULL,
    PRIMARY KEY(actor_id));
    
SELECT * FROM actors;

INSERT INTO actors VALUES
	(NULL, 'Hanks', 'Tom'),
    (NULL, 'Allen', 'Tim');

INSERT INTO actors VALUES
	(DEFAULT, 'Potts', 'Annie');
    
INSERT INTO actors (last_name, first_name) VALUES
	('Fisher', 'Carrie');
    
CREATE TABLE movies (movie_id INT NOT NULL AUTO_INCREMENT,
	title VARCHAR(45) NOT NULL,
    rating ENUM('G', 'PG', 'PG-13'),
    r_year YEAR NOT NULL,
    studio VARCHAR;
    