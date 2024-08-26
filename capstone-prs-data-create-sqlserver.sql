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
	username		varchar(25)	NOT NULL,
	password		varchar(25)	NOT NULL,
	firstName		varchar(25)	NOT NULL,
	lastName		varchar(25)	NOT NULL,
	phoneNumber		varchar(20)	NOT NULL,
	email			varchar(50)	NOT NULL,
	reviewer		BIT				DEFAULT 0,
	admin			BIT				DEFAULT 0,
	CONSTRAINT UQ_User_user_info UNIQUE(username, password, firstName, lastName, phoneNumber, email)
);

CREATE TABLE Request (
	id					int				PRIMARY KEY IDENTITY(1,1),
	userId				int				NOT NULL,
	description			varchar(225)	NOT NULL,
	justification		varchar(225)	NOT NULL,
	dateNeeded			DATE			NOT NULL,
	deliveryMode		varchar(225)	NOT NULL,
	status				varchar(225)	NOT NULL,
	total				decimal(18,2)	NOT NULL,
	submittedDate		datetime2		NOT NULL,
	reasonForRejection	varchar(225)	NOT NULL,
	FOREIGN KEY (userId) REFERENCES [User](id),
	CONSTRAINT UQ_Request_userId UNIQUE(userId)
);

CREATE TABLE Vendor (
	id				int				PRIMARY KEY IDENTITY(1,1),
	code			varchar(225)	NOT NULL,
	name			varchar(25)	NOT NULL,
	address			varchar(100)	NOT NULL,
	city			varchar(20)	NOT NULL,
	state			varchar(15)	NOT NULL,
	zip				varchar(10)	NOT NULL,
	phoneNumber		varchar(20)	NOT NULL,
	email			varchar(50)	NOT NULL,
	CONSTRAINT UQ_Vendor_code_name UNIQUE(code, name)
);

CREATE TABLE Product (
	id				int				PRIMARY KEY IDENTITY(1,1),
	vendorId		int				NOT NULL,
	partNumber		varchar(50)	NOT NULL,
	name			varchar(25)	NOT NULL,
	price			decimal(18,2)	NOT NULL,
	unit			varchar(25)	NOT NULL,
	FOREIGN KEY (vendorId) REFERENCES Vendor(id),
	CONSTRAINT UQ_Product_vendorId UNIQUE(vendorId)
);

CREATE TABLE LineItem(
	id			int		PRIMARY KEY IDENTITY(1,1),
	requestId	int		NOT NULL,
	productId	int		NOT NULL,
	quantity	int		NOT NULL,
	FOREIGN KEY (requestId) REFERENCES Request(id),
	FOREIGN KEY (productId) REFERENCES Product(id),
	CONSTRAINT UQ_LineItem_request_product_Id UNIQUE(requestId, productId)
);


