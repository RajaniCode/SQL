--SQL Server

$ SQLCMD -S "(local)" -U sa
Password: $ql@Server#2016

> SQLCMD -S (local) -U sa -P $ql@Server#2016

USE [master];
GO

SELECT name, database_id, create_date FROM sys.databases; 
GO

SELECT * FROM INFORMATION_SCHEMA.TABLES;
GO

SELECT DB_NAME();
GO

SELECT @@VERSION;
GO

exit


USE [master];

IF EXISTS(SELECT name FROM sys.databases WHERE name = N'customerdb')
DROP DATABASE [customerdb];
GO

-- OR

IF DB_ID (N'customerdb') IS NOT NULL
DROP DATABASE [customerdb];
GO

CREATE DATABASE [customerdb];
GO

USE [customerdb];
GO

IF EXISTS(SELECT name FROM sys.tables WHERE name = N'Customer')
DROP TABLE [Customer];
GO

-- OR

IF OBJECT_ID (N'Customer', N'U') IS NOT NULL
DROP TABLE [Customer];
GO

IF OBJECT_ID ('Customer', N'U') IS NOT NULL
DROP TABLE Customer;

CREATE TABLE Customer
(
    CustomerId INT IDENTITY(1,1) NOT NULL,
    FirstName NVARCHAR(max),
    LastName NVARCHAR(max),
    Technology NVARCHAR(max),
    CONSTRAINT PK_custid PRIMARY KEY(CustomerId)
) 
GO

INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Bill', 'Gates', 'Microsoft');
GO

INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Larry', 'Page', 'Google');
GO

INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Steve', 'Jobs', 'Apple');
GO

INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Anders', 'Hejlsberg', 'C#');
GO

INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Bjarne', 'Stroustrup', 'C++');
GO

INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('James', 'Gosling', 'Java');
GO

INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Scott', 'Guthrie', 'ASP.NET');
GO

INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Don', 'Syme', 'F#');
GO

INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Dennis', 'Ritchie', 'C');
GO

INSERT INTO Customer(FirstName, LastName, Technology)
VALUES('Hasso', 'Plattner', 'SAP');
GO

SELECT * FROM Customer;

INSERT INTO Customer(FirstName, LastName, Technology)
SELECT 'Brendan', 'Eich', 'JavaScript'
UNION ALL
SELECT 'Guido', 'van Rossum', 'Python'
UNION ALL
SELECT 'Yukihiro', 'Matsumoto', 'Ruby';
GO

SELECT * FROM Customer;
GO

INSERT INTO Customer (FirstName, LastName, Technology)
VALUES
('Rasmus', 'Lerdorf', 'PHP'),
('Martin', 'Odersky', 'Scala'),
('Donald', 'D. Chamberlin', 'SQL');
GO

SELECT * FROM Customer;
GO