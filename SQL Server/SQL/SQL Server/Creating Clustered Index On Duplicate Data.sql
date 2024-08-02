--Creating Clustered Index On Duplicate Data
USE [master];
GO

IF EXISTS(SELECT NAME FROM SYS.DATABASES WHERE NAME = 'temporarydb')
DROP DATABASE temporarydb;
GO

CREATE DATABASE temporarydb;
GO

USE [temporarydb];
GO

CREATE TABLE dbo.Test
(
	FName VARCHAR(20) NOT NULL,
	LName VARCHAR(20)
)

--Inserting duplicate records in the table 
INSERT INTO Test VALUES 
('Dan', 'Allard'),
('Dan', 'Allard'),
('Dan', 'Allard'),
('Sam', 'Philips'),
('Sam', 'Philips'),
('Sam', 'Philips');
GO
 
--Selecting the values from the table 
SELECT * FROM Test;
GO

--Creating Clustered Index on Fname column of Test Table that is having duplicate records 
CREATE CLUSTERED INDEX Clustered_Index_FName ON Test(FName);
GO
 
--Also, can do this 
----Creating NonClustered Index on Fname column of Test Table that is having duplicate records 
--CREATE NONCLUSTERED INDEX NonClustered_Index_FName ON Test(FName);
--GO

--Cannot do this 
--ALTER TABLE Test
--ADD CONSTRAINT pkFName PRIMARY KEY CLUSTERED(FName);
--GO

--Cannot do this 
--ALTER TABLE Test
--ADD CONSTRAINT ukFName UNIQUE CLUSTERED(FName);
--GO

--Selecting the values from the table 
SELECT * FROM Test;
GO
 