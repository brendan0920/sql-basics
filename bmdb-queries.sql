USE BMDB;

--Join 3-table

SELECT Title AS MovieTitle, Year AS ReleaseYear, Rating, Director, FirstName + LastName AS Actor, Gender, Role, Birthdate
	FROM Credit c
	JOIN Movie m
		ON c.MovieId = m.Id
	JOIN Actor a
		ON c.ActorId = a.Id
	ORDER BY m.Id;