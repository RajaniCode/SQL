--spGetHighest
USE [master];
GO

IF EXISTS(SELECT name FROM sys.databases WHERE NAME = N'Employeedb')
DROP DATABASE Employeedb;
GO

CREATE DATABASE Employeedb;
GO

USE [Employeedb];
GO

IF EXISTS(SELECT name FROM sys.tables WHERE NAME = N'Employee')
DROP TABLE dbo.Employee;
GO

CREATE TABLE dbo.Employee
(ID INT IDENTITY(1,1) CONSTRAINT pkID PRIMARY KEY, Name NVARCHAR(MAX), Salary Money);
GO

INSERT INTO dbo.Employee
VALUES
('A', 10000), --4th
('B', 8000),  --5th
('C', 8000),  
('D', 6000),  --6th
('E', 6000),  
('F', 6000),
('G', 5000),  --7th  
('H', 5000),
('I', 5000),
('J', 5000),
('K', 4000),  --8th
('L', 4000),
('M', 3000),  --9th
('N', 3000),
('O', 1000),  --10th
('P', 14000), --2nd
('Q', 14000),
('R', 12000), --3rd
('S', 12000),
('T', 16000), --1st
('U', 16000), 
('V', 16000), 
('W', 14000),
('X', 12000),
('Y', 12000),
('Z', 10000);
GO

SELECT * FROM Employee;
GO

-- 16000 --1st
-- 14000 --2nd
-- 12000 --3rd
-- 10000 --4th
--  8000 --5th
--  6000 --6th
--  5000 --7th  
--  4000 --8th
--  3000 --9th
--  1000 --10th

IF EXISTS(SELECT name FROM sys.procedures WHERE name = N'spGetHighest')
DROP PROCEDURE spGetHighest;
GO

-- OR

IF OBJECT_ID ( N'spGetHighest', N'P' ) IS NOT NULL 
DROP PROCEDURE spGetHighest;
GO

CREATE PROCEDURE spGetHighest
(
	@N int,
	@NthHighest Money = NULL OUTPUT 
)
AS
BEGIN
SET NOCOUNT ON;
WITH CTE AS 
(
	SELECT Salary, Rnk = DENSE_RANK() OVER (ORDER BY Salary DESC) FROM Employee
)
SELECT @NthHighest = (SELECT TOP 1 Salary FROM CTE WHERE Rnk = @N);
WITH CTE AS 
(
	SELECT Salary, Rnk = DENSE_RANK() OVER (ORDER BY Salary DESC) FROM Employee
)
SELECT Salary FROM CTE WHERE Rnk = @N
END
GO

EXECUTE spGetHighest @N = 5;
GO

DECLARE @Result Money
EXECUTE spGetHighest 5, @RESULT OUTPUT;
SELECT @Result AS '@NthHighest'
GO

DECLARE @Result Money
EXECUTE spGetHighest @N = 5, @NthHighest = @RESULT OUTPUT;
SELECT @Result AS '@NthHighest'
GO

/*
USE AdventureWorks2008R2;
GO
IF OBJECT_ID ( 'dbo.uspCurrencyCursor', 'P' ) IS NOT NULL
    DROP PROCEDURE dbo.uspCurrencyCursor;
GO
CREATE PROCEDURE dbo.uspCurrencyCursor 
    @CurrencyCursor CURSOR VARYING OUTPUT
AS
    SET NOCOUNT ON;
    SET @CurrencyCursor = CURSOR
    FORWARD_ONLY STATIC FOR
      SELECT CurrencyCode, Name
      FROM Sales.Currency;
    OPEN @CurrencyCursor;
GO


--Next, execute a batch that declares a local cursor variable, 
--executes the procedure to assign the cursor to the local variable, 
--and then fetches the rows from the cursor.


USE AdventureWorks2008R2;
GO
DECLARE @MyCursor CURSOR;
EXEC dbo.uspCurrencyCursor @CurrencyCursor = @MyCursor OUTPUT;
WHILE (@@FETCH_STATUS = 0)
BEGIN;
     FETCH NEXT FROM @MyCursor;
END;
CLOSE @MyCursor;
DEALLOCATE @MyCursor;
GO

*/

