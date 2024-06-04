-- SQL Server nth Highest

USE master;
GO

IF EXISTS(SELECT name FROM sys.databases WHERE NAME = N'employeedb')
DROP DATABASE employeedb;
GO

CREATE DATABASE employeedb;
GO

USE employeedb;
GO

IF EXISTS(SELECT name FROM sys.tables WHERE NAME = N'Employee')
DROP TABLE Employee;
GO

CREATE TABLE Employee
(ID INT, Name NVARCHAR(50), Salary Money);
GO

INSERT INTO Employee
VALUES
(1, 'A', 10000), -- 4th
(2, 'B', 8000),  -- 5th
(3, 'C', 8000),  
(4, 'D', 6000),  -- 6th
(5, 'E', 6000),  
(6, 'F', 6000),
(7, 'G', 5000),  -- 7th  
(8, 'H', 5000),
(9, 'I', 5000),
(10, 'J', 5000),
(11, 'K', 4000),  -- 8th
(12, 'L', 4000),
(13, 'M', 3000),  -- 9th
(14, 'N', 3000),
(15, 'O', 1000),  -- 10th
(16, 'P', 14000), -- 2nd
(17, 'Q', 14000),
(18, 'R', 12000), -- 3rd
(19, 'S', 12000),
(20, 'T', 16000), -- 1st
(21, 'U', 16000), 
(22, 'V', 16000), 
(23, 'W', 14000),
(24, 'X', 12000),
(25, 'Y', 12000),
(26, 'Z', 10000);
GO

SELECT * FROM Employee;
GO

-- 16000 -- 1st
-- 14000 -- 2nd
-- 12000 -- 3rd
-- 10000 -- 4th
--  8000 -- 5th
--  6000 -- 6th
--  5000 -- 7th  
--  4000 -- 8th
--  3000 -- 9th
--  1000 -- 10th

-- nth Highest -- 5th Highest -- 8000
SELECT TOP 1 Salary FROM
(
SELECT DISTINCT TOP 5 Salary FROM Employee
ORDER BY Salary DESC
)
A ORDER BY Salary;
GO

-- Better
;WITH CTE(Salary, Rnk) AS 
(
	SELECT Salary, Rnk = DENSE_RANK() OVER (ORDER BY Salary DESC) FROM Employee
) 
SELECT DISTINCT Salary FROM CTE WHERE Rnk = 5;
GO

-- Best
/* TOP 1 just grabs one of them, while DISTINCT does imply a sort and therefore might be more costly without any obvious benefit */
WITH CTE AS 
(
	SELECT Salary, Rnk = DENSE_RANK() OVER (ORDER BY Salary DESC) FROM Employee
) 
SELECT TOP 1 Salary FROM CTE WHERE Rnk = 5;
GO