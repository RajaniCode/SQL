--Check If Database, Table, Procedure Exists
USE [master];
Go

IF EXISTS(SELECT name FROM sys.databases WHERE name = N'Testdb')
DROP DATABASE [Testdb];
GO

-- OR

IF DB_ID (N'Testdb') IS NOT NULL
DROP DATABASE [Testdb];
GO

CREATE DATABASE [Testdb];
GO

USE [Testdb];
GO

IF EXISTS(SELECT name FROM sys.tables WHERE name = N'Test')
DROP TABLE [Test];
GO

-- OR

IF OBJECT_ID (N'Test', N'U') IS NOT NULL
DROP TABLE [Test];
GO

CREATE TABLE dbo.Test
(
	ID INT IDENTITY(1,1) CONSTRAINT pkID PRIMARY KEY,
	Name NVARCHAR(MAX)
)

INSERT INTO
dbo.Test
VALUES
('Bill'),
('Larry'),
('Anders'),
('Jack'),
('Mark');
GO

SELECT * FROM Test

IF EXISTS(SELECT name FROM sys.procedures WHERE name = N'spTest')
DROP PROCEDURE spTest;
GO

-- OR

IF OBJECT_ID ( N'spTest', N'P' ) IS NOT NULL 
DROP PROCEDURE spTest;
GO

CREATE PROCEDURE spTest
(
	@CustomerID INT,
	@CustomerName  NVARCHAR(MAX) = NULL OUTPUT 
)
AS
BEGIN
   SET NOCOUNT ON;
   SELECT Name 
   FROM Test
   WHERE @CustomerID = ID
END
GO

EXECUTE spTest @CustomerID = 1;
GO

EXEC spTest 2;
GO