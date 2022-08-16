USE [master];
GO

IF EXISTS(SELECT name FROM sys.databases WHERE NAME = N'G7')
DROP DATABASE G7;
GO

CREATE DATABASE G7;
GO

USE [G7];
GO

IF EXISTS(SELECT name FROM sys.tables WHERE NAME = N'Leaders')
DROP TABLE dbo.Leaders;
GO

CREATE TABLE Leaders
(
    LeaderID INT IDENTITY(1,1) NOT NULL,
    FirstName NVARCHAR(20),
    LastName NVARCHAR(20),
    Country NVARCHAR(10),
    CONSTRAINT PK_LeaderID PRIMARY KEY(LeaderID)
)
GO

INSERT INTO Leaders(FirstName, LastName, Country)
VALUES('Barrack', 'Obama', 'USA');
GO

INSERT INTO Leaders(FirstName, LastName, Country)
VALUES('Stephen', 'Harper', 'Canada');
GO

INSERT INTO Leaders(FirstName, LastName, Country)
VALUES('David', 'Cameron', 'UK');
GO

INSERT INTO Leaders(FirstName, LastName, Country)
VALUES('Angela', 'Merkel', 'Germany');
GO

INSERT INTO Leaders(FirstName, LastName, Country)
VALUES('Francois', 'Hollande', 'France');
GO

INSERT INTO Leaders(FirstName, LastName, Country)
VALUES('Mario', 'Monti', 'Italy');
GO

INSERT INTO Leaders(FirstName, LastName, Country)
VALUES('Yoshihiko', 'Noda', 'Japan');
GO

SELECT * FROM Leaders