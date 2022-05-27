USE [master];
GO

IF EXISTS(SELECT NAME FROM SYS.DATABASES WHERE NAME = 'EmployeeDatabase')
DROP DATABASE EmployeeDatabase;
GO

CREATE DATABASE EmployeeDatabase;
GO

USE [EmployeeDatabase];
GO

IF EXISTS(SELECT NAME FROM SYS.TABLES WHERE NAME = 'EmployeeTable')
DROP TABLE dbo.EmployeeTable;
GO

CREATE TABLE dbo.EmployeeTable
(
ID int,
Name NVARCHAR(50),
Salary Money
);
GO

INSERT INTO dbo.EmployeeTable
VALUES
(
1,
'A',
10000
);
GO

INSERT INTO dbo.EmployeeTable
VALUES
(
2,
'B',
9000
);
GO

INSERT INTO dbo.EmployeeTable
VALUES
(
3,
'C',
8000
);
GO

INSERT INTO dbo.EmployeeTable
VALUES
(
4,
'D',
7000
);
GO

INSERT INTO dbo.EmployeeTable
VALUES
(
5,
'E',
6000
);
GO

INSERT INTO dbo.EmployeeTable
VALUES
(
6,
'F',
5000
);
GO

INSERT INTO dbo.EmployeeTable
VALUES
(
7,
'G',
4000
);
GO

INSERT INTO dbo.EmployeeTable
VALUES
(
8,
'H',
3000
);
GO

INSERT INTO dbo.EmployeeTable
VALUES
(
9,
'I',
2000
);
GO

INSERT INTO dbo.EmployeeTable
VALUES
(
10,
'J',
1000
);
GO

SELECT * FROM dbo.EmployeeTable;
GO

USE [EmployeeDatabase];
GO

--Sixth Highest
SELECT TOP 1 Salary FROM
(
SELECT DISTINCT TOP 6 Salary FROM EmployeeTable 
ORDER BY Salary DESC
)
A ORDER BY Salary

--Second Highest
SELECT MAX(Salary) FROM EmployeeTable WHERE Salary NOT IN (SELECT MAX(Salary) FROM EmployeeTable)