-- SQL Server JOIN

USE master;
GO

IF EXISTS(SELECT name FROM sys.databases WHERE name = N'JoinExample')
DROP DATABASE JoinExample;
GO

CREATE DATABASE JoinExample;
GO

USE JoinExample;
GO

IF OBJECT_ID('Table1', 'U') IS NOT NULL
DROP TABLE Table1;
GO

CREATE TABLE Table1
(ID INT, Value VARCHAR(10));
GO

INSERT INTO Table1 (ID, Value)
SELECT 1, 'First'
UNION ALL
SELECT 2, 'Second'
UNION ALL
SELECT 3, 'Third'
UNION ALL
SELECT 4, 'Fourth'
UNION ALL
SELECT 5, 'Fifth';
GO

IF OBJECT_ID('Table2', 'U') IS NOT NULL
DROP TABLE Table2;
GO

CREATE TABLE Table2
(ID INT, Value VARCHAR(10));
GO

INSERT INTO Table2 (ID, Value)
SELECT 1, 'I'
UNION ALL
SELECT 2, 'II'
UNION ALL
SELECT 3, 'III'
UNION ALL
SELECT 6, 'VI'
UNION ALL
SELECT 7, 'VII'
UNION ALL
SELECT 8, 'VIII';
GO

SELECT * FROM Table1;
SELECT * FROM Table2;
GO


/* (INNER) JOIN */
SELECT t1.*, t2.* FROM Table1 t1
JOIN Table2 t2 ON t1.ID = t2.ID;
GO


/* LEFT (OUTER) JOIN */
SELECT t1.*, t2.* FROM Table1 t1
LEFT JOIN Table2 t2 ON t1.ID = t2.ID;
GO


/* RIGHT (OUTER) JOIN */
SELECT t1.*, t2.* FROM Table1 t1
RIGHT JOIN Table2 t2 ON t1.ID = t2.ID;
GO


/* FULL (OUTER) JOIN -- NOTE: NULLS LAST */
SELECT t1.*, t2.* FROM Table1 t1
FULL JOIN Table2 t2 ON t1.ID = t2.ID;
GO


/* Emulate FULL (OUTER) JOIN -- NOTE: NULLS FIRST */
SELECT * FROM Table1 t1
LEFT JOIN Table2 t2 ON t1.id = t2.id
UNION
SELECT * FROM Table1 t1
RIGHT JOIN Table2 t2 ON t1.id = t2.id;
GO


/* CROSS JOIN -- NOTE: Pivot t1.ID */
SELECT t1.*, t2.* FROM Table1 t1
CROSS JOIN Table2 t2;
GO