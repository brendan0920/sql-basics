--p349 Chap 11 Exercises
--1.

USE MASTER;
GO

DROP DATABASE IF EXISTS MEMBERSHIP;
GO


CREATE DATABASE MEMBERSHIP;
GO

USE MEMBERSHIP;
GO

--2.
CREATE TABLE Individuals (
	IndividualID int PRIMARY KEY IDENTITY(1,1),
	FirstName varchar(25) NOT NULL,
	LastName varchar(25) NOT NULL,
	Address varchar(100) NOT NULL,
	Phone varchar(15) NOT NULL
);

CREATE TABLE GroupMembership (
	GroupID int PRIMARY KEY IDENTITY(1,1),
	IndividualID int NOT NULL,
	FOREIGN KEY (IndividualID) REFERENCES Individuals(IndividualID) 
);

CREATE TABLE Groups (
	GroupID int PRIMARY KEY IDENTITY(1,1),
	GroupName varchar(25) NOT NULL,
	Dues money NOT NULL DEFAULT 0 CHECK (Dues > 0)
);

--3. create index table p321
CREATE CLUSTERED INDEX IX_GroupMembership_GroupID
	ON GroupMembership (GroupID);

CREATE INDEX IX_GroupMembership_IndividualID
	ON GroupMembership (IndividualID);

--4. alter table to add p331
ALTER TABLE Individuals
ADD DuesPaid bit NOT NULL DEFAULT 0;

--5. alter table to add thow new check constraints
USE AP;

ALTER TABLE Invoices
--ADD PaymentDate date NOT NULL CHECK (PaymentTotal > 0);

--ALTER TABLE AP.dbo.Invoices
--ADD InvoiceTotal money NOT NULL CHECK (PaymentTotal + CreditTotal > InvoiceTotal);
ADD CHECK ((PaymentDate IS NULL AND PaymentTotal = 0) OR (PaymentDate IS NOT NULL AND PaymentTotal >0)),
	CHECK (PaymentTotal + CreditTotal <= InvoiceTotal);

--6. delete table
USE MEMBERSHIP;
DROP TABLE GroupMembership;
CREATE TABLE GroupMembership (

);