-- bmdb crud stuff
-- Insert a Movie
USE BMDB;

INSERT INTO Movie (Title, Year, Rating, Director)
VALUES
('The Dark Knight', 2008, 'PG-13', 'Christopher Nolan'),
('Joker', 2019, 'R', 'Todd Phillips'),
('The Notebook', 2004, 'PG-13', 'Nick Cassavetes'),
('Good Will Hunting', 1997, 'R', 'Gus Van Sant'),
('Unbroken', 2014, 'PG-13', 'Angelina Jolie');

INSERT INTO Actor (FirstName, LastName, Gender, Birthdate) 
VALUES
('Christian', 'Bale', 'Male', '1974-01-30'),
('Heath', 'Ledger', 'Male', '1979-01-22'),
('Joaquin', 'Phoenix', 'Male', '1974-10-28'),
('Robert', 'De Niro', 'Male', '1943-08-17'),
('Ryan', 'Gosling', 'Male', '1980-11-12'),
('Rachel', 'McAdams', 'Female', '1978-11-17'),
('Matt', 'Damon', 'Male', '1970-10-08'),
('Ben', 'Affleck', 'Male', '1972-08-15'),
('Robin', 'Williams', 'Male', '1957-07-21'),
('Jack', 'O''Connell', 'Male', '1990-08-01');

INSERT INTO Credit (MovieId, ActorId, Role) 
VALUES
(1, 1, 'Bruce Wayne, Batman'),
(1, 2, 'Joker'),
(2, 3, 'Arthur Fleck'),
(2, 4, 'Murray Franklin'),
(3, 5, 'Noah'),
(3, 6, 'Allie'),
(4, 7, 'Will'),
(4, 8, 'Chuckie'),
(4, 9, 'Sean'),
(5, 10, 'Louis Zamperini');



/*
SELECT *
	FROM Movie;

SELECT *
	FROM Actor;

SELECT *
	FROM Credit;
*/






/*
INSERT INTO Movie (Title, Year, Rating, Director)
VALUES
()
();

SELECT *
	FROM Movie;

--UPDATE Statement
SELECT *
	FROM Movie
	WHERE Id = 2;

UPDATE Movie
	SET Title = 'Super Dumb Movie';

DELETE *
	FROM Movie
	WHERE Id = 2;


INSERT INTO Actor (FirstName, LastName, Gender, Birthdate)
VALUES
('Mark', 'Hamill', 'M', '1951-09-25');

--ADD CREDIT
INSERT INTO Credit (MovieId, ActorId, Role)
VALUES
(4, 1, 'Luke Skywalker');

-- JOIN 3tables to show the movie - actor - and role info
SELECT *
	FROM Credit c
	JOIN Movie m
		ON c.MovieId = m.Id
	JOIN Actor a
		ON a.Id = c.ActorId;
*/