--COALESCE
USE [master];
GO

IF EXISTS(SELECT NAME FROM SYS.DATABASES WHERE NAME = 'temporarydb')
DROP DATABASE temporarydb;
GO

CREATE DATABASE temporarydb;
GO

USE [temporarydb];
GO

 CREATE TABLE Alpha(Col1 INT, Col2 INT, Col3 INT)
 INSERT INTO Alpha
 SELECT 1, 11, 111
 UNION ALL
 SELECT 2, NULL, 222
 UNION ALL
 SELECT 3, 33, NULL
 UNION ALL
 SELECT NULL, 44, 444
 UNION ALL
 SELECT 5, 55, 555
 GO 
 
 SELECT * FROM Alpha
 GO
 
 SELECT *, COALESCE(Col1, Col2, Col3) AS 'Col4' FROM Alpha
 GO


/*
COALESCE (Transact-SQL)

Returns the first nonnull expression among its arguments.

If all arguments are NULL, COALESCE returns NULL.
 
COALESCE(expression1,...n) is equivalent to this CASE function:
 CASE
   WHEN (expression1 IS NOT NULL) THEN expression1
   ...
   WHEN (expressionN IS NOT NULL) THEN expressionN
   ELSE NULL

*/

SELECT 
Col1, Col2, Col3,
CASE
   WHEN (Col1 IS NOT NULL) THEN Col1
   WHEN (Col2 IS NOT NULL) THEN Col2
   ELSE NULL
END AS Col4
FROM Alpha
GO