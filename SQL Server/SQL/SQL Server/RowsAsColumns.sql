--Rows As Columns
/*
http://www.sqlteam.com/forums/topic.asp?TOPIC_ID=97074
*/
USE [master];

IF EXISTS (SELECT * FROM sys.databases WHERE name = N'Testdb') 
DROP DATABASE [Testdb];

IF DB_ID (N'Testdb') IS NOT NULL
DROP DATABASE [Testdb];

CREATE DATABASE [Testdb];

USE [Testdb];

IF EXISTS(SELECT name FROM sys.objects WHERE name = N'Test')
DROP TABLE [Test];

--IF EXISTS(SELECT name FROM sys.tables WHERE name = N'Test')
--DROP TABLE [Test];

--IF OBJECT_ID (N'Test', N'U') IS NOT NULL
--DROP TABLE [Test];

CREATE TABLE dbo.Test
(
C1 	int,
C2 	int,
C3	int
)

SELECT * FROM Test

INSERT INTO Test
SELECT	 1,  2,  3 	UNION ALL
SELECT	 4,  5,  6	UNION ALL
SELECT	 7,  8,  9

SELECT * FROM Test

SELECT	C1 = [1], C2 = [2], C3 = [3]
FROM
(
	SELECT	col = 1, C = C1,
		row_no	= row_number() OVER(ORDER BY C1)
	FROM	Test
	UNION ALL
	SELECT	col = 2, C = C2,
		row_no	= row_number() OVER(ORDER BY C2)
	FROM	Test
	UNION ALL
	SELECT	col = 3, C = C3,
		row_no	= row_number() OVER(ORDER BY C3)
	FROM	Test
) d1
pivot
(
	MAX(C)
	FOR	row_no IN ([1], [2], [3])
) p1


