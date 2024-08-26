USE MASTER;
GO

DROP DATABASE IF EXISTS capstone_prs;
GO

CREATE DATABASE capstone_prs;
GO

USE capstone_prs;
GO

CREATE TABLE [User] (
	id				int				PRIMARY KEY IDENTITY(1,1),
	username		varchar(20)		NOT NULL,
	password		varchar(10)		NOT NULL,
	firstName		varchar(20)		NOT NULL,
	lastName		varchar(20)		NOT NULL,
	phoneNumber		varchar(12)		NOT NULL,
	email			varchar(75)		NOT NULL,
	reviewer		bit				NOT NULL DEFAULT 0,
	admin			bit				NOT NULL DEFAULT 0,
	CONSTRAINT UQ_User_username UNIQUE(username),
	CONSTRAINT UQ_User_fn_ln_phone UNIQUE(firstName, lastName, phoneNumber),
	CONSTRAINT UQ_User_email UNIQUE(email)
);


CREATE TABLE Vendor (
	id				int				PRIMARY KEY IDENTITY(1,1),
	code			varchar(10)		NOT NULL,
	name			varchar(255)	NOT NULL,
	address			varchar(255)	NOT NULL,
	city			varchar(255)	NOT NULL,
	state			varchar(2)		NOT NULL,
	zip				varchar(10)		NOT NULL,
	phoneNumber		varchar(12)		NOT NULL,
	email			varchar(100)	NOT NULL,
	CONSTRAINT UQ_Vendor_code UNIQUE(code)	
);


CREATE TABLE Product (
	id				int				PRIMARY KEY IDENTITY(1,1),
	vendorId		int				NOT NULL,
	partNumber		varchar(50)		NOT NULL,
	name			varchar(150)	NOT NULL,
	price			float			NOT NULL,
	unit			varchar(255)	NULL,
	photoPath		varchar(255)	NULL,
	FOREIGN KEY (vendorId) REFERENCES Vendor(id),
	CONSTRAINT UQ_Product_vendor_part UNIQUE(vendorId, partNumber)
);


CREATE TABLE Request (
	id					int				PRIMARY KEY IDENTITY(1,1),
	userId				int				NOT NULL,
	description			varchar(100)	NOT NULL,
	justification		varchar(225)	NOT NULL,
	dateNeeded			date			NULL,
	deliveryMode		varchar(25)		NOT NULL,
	status				varchar(20)		NOT NULL DEFAULT 'New',
	total				float			NOT NULL,
	submittedDate		datetime		NOT NULL DEFAULT current_timestamp,
	reasonForRejection	varchar(100)	NULL,
	FOREIGN KEY (userId) REFERENCES [User](id)	
);


CREATE TABLE LineItem(
	id			int		PRIMARY KEY IDENTITY(1,1),
	requestId	int		NOT NULL,
	productId	int		NOT NULL,
	quantity	int		NOT NULL,
	FOREIGN KEY (requestId) REFERENCES Request(id),
	FOREIGN KEY (productId) REFERENCES Product(id),
	CONSTRAINT UQ_LineItem_reqId_prodId UNIQUE(requestId, productId)
);

