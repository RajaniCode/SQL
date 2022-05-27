--spCustomerTracker
USE [master];
Go

IF EXISTS(SELECT name FROM sys.databases WHERE name = N'Customerdb')
DROP DATABASE [Customerdb];

CREATE DATABASE [Customerdb];
GO

USE [Customerdb];
GO

IF EXISTS(SELECT name FROM sys.tables WHERE name = N'Customer')
DROP TABLE [Customer];
GO

CREATE TABLE dbo.Customer
(
	ID INT IDENTITY(1,1) CONSTRAINT pkID PRIMARY KEY,
	Name NVARCHAR(MAX)
)

--INSERT INTO
--dbo.Customer
--VALUES
--('Bill'),
--('Larry'),
--('Anders'),
--('Jack'),
--('Mark');

INSERT INTO
dbo.Customer
SELECT 'Bill'
UNION
SELECT 'Larry'
UNION
SELECT 'Anders'
UNION
SELECT 'Jack'
UNION
SELECT 'Mark'
GO

SELECT * FROM dbo.Customer
GO

IF EXISTS(SELECT name FROM sys.procedures WHERE name = N'spCustomerTracker')
DROP PROCEDURE spCustomerTracker;
GO

-- OR

IF OBJECT_ID ( N'spCustomerTracker', N'P' ) IS NOT NULL 
DROP PROCEDURE spCustomerTracker;
GO

CREATE PROCEDURE spCustomerTracker
(
	@CustomerID INT,
	@CustomerName  NVARCHAR(MAX)=NULL OUTPUT 
)
AS
BEGIN
   SET NOCOUNT ON;
   SELECT Name 
   FROM Customer
   WHERE @CustomerID = ID
END
GO

EXECUTE spCustomerTracker @CustomerID = 1;
GO

EXEC spCustomerTracker 1;
GO