-- Crud
-- Create
INSERT INTO Movie (Title, Year, Rating, Director)
VALUES ('Test Movie')

-- Update
UPDATE Movie
	SET Title = 'great movie'
	WHERE Id = 5;

-- Delete
DELETE 
	FROM Movie
	WHERE Id = 5;

SELECT *
	FROM Actor
	WHERE Gender = 'F'
	ORDER BY Birthdate DESC;