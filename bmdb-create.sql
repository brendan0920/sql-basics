USE MASTER;
GO

DROP DATABASE IF EXISTS BMDB;
GO


CREATE DATABASE BMDB;
GO

USE BMDB;
GO

CREATE TABLE Movie(
	Id			int				PRIMARY KEY IDENTITY(1,1),	
	Title		varchar(255)	NOT NULL,
	Year		int				NOT NULL, --or it could be samllint
	Rating		varchar(5)		NOT NULL,
	Director	varchar(255)	NOT NULL,	
	CONSTRAINT UQ_Movie_Title_Year UNIQUE(Title, Year)
);

CREATE TABLE Actor(
	Id			int				PRIMARY KEY IDENTITY(1,1),
	FirstName	varchar(255)	NOT NULL,
	LastName	varchar(255)	NOT NULL,
	Gender		varchar(10)		NOT NULL,
	Birthdate	date			NOT NULL,
	CONSTRAINT UQ_Actor_fn_ln_bd UNIQUE (FirstName, LastName, Birthdate)	
);

CREATE TABLE Credit(
	Id			int					PRIMARY KEY IDENTITY(1,1),
	MovieId		int					NOT NULL,
	ActorId		int					NOT NULL,
	Role		varchar(255)		NOT NULL,	
	FOREIGN KEY (MovieId) REFERENCES Movie(Id),
	FOREIGN KEY (ActorId) REFERENCES Actor(Id),
	CONSTRAINT UQ_Credit_Movie_Actor UNIQUE (MovieId,ActorId)
);


--ALTER TABLE Actor
--ALTER COLUMN Gender varchar(10);