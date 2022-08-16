--Inner Join Two Tables One Column
USE [master];
GO

IF EXISTS(SELECT NAME FROM SYS.DATABASES WHERE NAME = 'temporarydb')
DROP DATABASE temporarydb;
GO

CREATE DATABASE temporarydb;
GO

USE [temporarydb];
GO

 CREATE TABLE Alpha(Col INT)
 INSERT INTO Alpha
 SELECT 1
 UNION ALL
 SELECT 2
 UNION ALL
 SELECT 2 -- 1st duplicate
 UNION ALL
 SELECT 2 -- 2nd duplicate
 UNION ALL
 SELECT 3
 UNION ALL
 SELECT 4
 UNION ALL
 SELECT 5
 UNION ALL
 SELECT 6
 GO 
 
 SELECT * FROM Alpha
 GO
 
 CREATE TABLE Beta(Col INT)
 INSERT INTO Beta
 SELECT 1
 UNION ALL
 SELECT 2
 UNION ALL
 SELECT 3
 UNION ALL
 SELECT 4
 UNION ALL
 SELECT 4 -- 1st duplicate
 UNION ALL
 SELECT 4 -- 2nd duplicate
 UNION ALL
 SELECT 5
 GO 
 
 SELECT * FROM Beta
 GO
 
 SELECT A.Col, B.Col FROM Alpha A
 INNER JOIN Beta B
 ON A.Col = B.Col