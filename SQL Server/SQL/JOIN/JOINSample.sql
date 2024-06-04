USE Master;
GO

-- ===================================================
-- Database:	 People
-- Author:	 FunctionX
-- Date Created: Tuesday, July 28, 2009
-- ===================================================

IF EXISTS(SELECT name FROM sys.databases WHERE name = N'People')
DROP DATABASE People;
GO

CREATE DATABASE People;
GO

USE People;
GO

IF OBJECT_ID('Genders', 'U') IS NOT NULL
DROP TABLE Genders
GO

-- ===================================================
-- Database:	 People
-- Table:	 Genders
-- Author:	 FunctionX
-- Date Created: Tuesday, July 28, 2009
-- Description:	 This table holds the list of genders
-- ===================================================
CREATE TABLE Genders
(
    GenderID int identity(1, 1) not null,
    Gender nchar(15),
    CONSTRAINT PK_Genders PRIMARY KEY(GenderID)
);
GO

INSERT INTO 
Genders
(Gender)
VALUES
(N'Male'),
(N'Female'),
(N'Unknown');
GO

IF OBJECT_ID('Persons', 'U') IS NOT NULL
DROP TABLE Persons;
GO

-- ===================================================
-- Database:	 People
-- Table:	 Persons
-- Author:	 FunctionX
-- Date Created: Tuesday, July 28, 2009
-- Description:	 This table holds a list of people and their genders
-- ===================================================
CREATE TABLE Persons
(
    PersonID int identity(1, 1) not null,
    FirstName nvarchar(20),
    LastName nvarchar(20),
    GenderID int,
    CONSTRAINT PK_Persons PRIMARY KEY(PersonID)
);
GO

INSERT INTO Persons(FirstName, LastName, GenderID)
VALUES
(N'John', N'Franks', 1), 
(N'Peter', N'Sonnens', 1),
(N'Mary', N'Shamberg', 2), 
(N'Hellah', N'Zanogh', 3), 
(N'Arnie', N'Ephron', 3),
(N'Roberta', N'Jerseys', 2);
GO

INSERT INTO Persons(LastName, GenderID)
VALUES
(N'Millam', 1), 
(N'Hessia', 2);
GO

INSERT INTO Persons(LastName) 
VALUES
(N'Millers');
GO

INSERT INTO Persons(FirstName, GenderID) VALUES(N'Robert', 1);
GO

SELECT * FROM Genders
GO

SELECT * FROM Persons
GO