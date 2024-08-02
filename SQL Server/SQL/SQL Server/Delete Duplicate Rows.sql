--Delete Duplicate Rows
USE [master];
GO

IF EXISTS(SELECT name FROM sys.databases WHERE NAME = N'temporarydb')
DROP DATABASE temporarydb;
GO

CREATE DATABASE temporarydb;
GO

USE [temporarydb];
GO

IF EXISTS(SELECT name FROM sys.tables WHERE NAME = N'DuplicateRecordTable')
DROP TABLE DuplicateRecordTable;
GO

/* Create Table with 7 entries - 3 are duplicate entries */
CREATE TABLE DuplicateRecordTable (Col1 INT, Col2 INT)
INSERT INTO DuplicateRecordTable
SELECT 1, 1
UNION ALL
SELECT 1, 1 --duplicate
UNION ALL
SELECT 1, 1 --duplicate
UNION ALL
SELECT 1, 2
UNION ALL
SELECT 1, 2 --duplicate
UNION ALL
SELECT 1, 3
UNION ALL
SELECT 1, 4
GO 

/* It should give you 7 rows */
SELECT * FROM DuplicateRecordTable;
GO


/* Delete Duplicate records */
;WITH CTE (COl1, Col2, DuplicateCount) AS
(
	SELECT COl1, Col2, ROW_NUMBER() OVER(PARTITION BY COl1, Col2 ORDER BY Col1) AS DuplicateCount
	FROM DuplicateRecordTable
)
DELETE FROM CTE WHERE DuplicateCount > 1
GO

/* It should give you Distinct 4 records */
SELECT * FROM DuplicateRecordTable;
GO

/* Delete Duplicate records */
WITH CTE AS
(
	SELECT COl1, Col2, DuplicateCount = ROW_NUMBER() OVER(PARTITION BY COl1,Col2 ORDER BY Col1)
	FROM DuplicateRecordTable
)
DELETE CTE WHERE DuplicateCount > 1
GO 

/* It should give you Distinct 4 records */
SELECT * FROM DuplicateRecordTable;
GO