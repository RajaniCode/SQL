--SQL Server


USE master;
GO

IF EXISTS(SELECT name FROM sys.databases WHERE name = N'employeedb')
DROP DATABASE employeedb;
GO

CREATE DATABASE employeedb;
GO

USE employeedb;
GO

IF OBJECT_ID('Employee', 'U') IS NOT NULL
DROP TABLE Employee;
GO


CREATE TABLE Employee
(
    EmployeeID INT PRIMARY KEY,
    Name NVARCHAR(50),
    ManagerID INT
);
GO


INSERT INTO Employee
SELECT 1, 'Alpha', 3
UNION ALL
SELECT 2, 'Beta', 3
UNION ALL
SELECT 3, 'Gamma', NULL
UNION ALL
SELECT 4, 'Delta',2
UNION ALL
SELECT 5, 'Epsilon',2
UNION ALL
SELECT 7, 'Eta',2;
GO


SELECT * FROM Employee;
GO


/* (INNER) JOIN as Self JOIN */
SELECT e1.Name EmployeeName, e2.name AS ManagerName
FROM Employee e1
INNER JOIN Employee e2
ON e1.ManagerID = e2.EmployeeID;
GO


/* LEFT (OUTER) JOIN as Self JOIN */
SELECT e1.Name EmployeeName, ISNULL(e2.name, 'Top Manager') AS ManagerName
FROM Employee e1
LEFT JOIN Employee e2
ON e1.ManagerID = e2.EmployeeID;
GO
