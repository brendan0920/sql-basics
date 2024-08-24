USE MASTER;
GO

DROP DATABASE IF EXISTS SALESDB;
GO


CREATE DATABASE SALESDB;
GO

USE SALESDB;
GO

CREATE TABLE Sales_Denormalized (
	Id int PRIMARY KEY IDENTITY(1,1),
	SalesPersonId int NOT NULL,
	SalesPersonFirstName varchar(25) NOT NULL,
	SalesPersonLastName varchar(25) NOT NULL,
	Region varchar(20) NOT NULL,
	SalesDate date NOT NULL,
	SalesAmount decimal(10,2),
	Customer varchar(50)
);

-- name should be unique
CREATE TABLE Region (
	Id int PRIMARY KEY IDENTITY(1,1),
	Name varchar(15) NOT NULL
);

-- name should be unique
CREATE TABLE Customer (
	Id int PRIMARY KEY IDENTITY(1,1),
	Name varchar(50) NOT NULL
);


CREATE TABLE SalesPerson (
	Id int PRIMARY KEY IDENTITY(1,1),
	FirstName varchar(50) NOT NULL,
	LastName varchar(50) NOT NULL,
	RegionId int NOT NULL
);

CREATE TABLE Sales (
	Id int PRIMARY KEY IDENTITY(1,1),
	SalesPersonId int NOT NULL,
	SalesDate	date NOT NULL,
	SalesAmount decimal(10,2) NOT NULL,
	CustomerId int NOT NULL
);

