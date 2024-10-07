USE BMDB;
GO
--Join 3-table

SELECT Title AS MovieTitle, Year AS ReleaseYear, Rating, Director, FirstName + LastName AS Actor, Gender, Role, Birthdate
	FROM Credit c
	JOIN Movie m
		ON c.MovieId = m.Id
	JOIN Actor a
		ON c.ActorId = a.Id
	ORDER BY m.Id;


SELECT Title, Year, Rating, CONCAT(FirstName, LastName) AS Actor, Role
	From Credit c
	JOIN Movie m 
		ON m.Id = c.MovieId
	JOIN Actor a
		ON a.Id = c. ActorId
	ORDER BY Title, LastName;