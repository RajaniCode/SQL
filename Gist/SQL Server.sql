
/******************************************************************************/

-- SQL Server 2019

/******************************************************************************/

-- apply

/******************************************************************************/

USE [master];
GO

-- IF EXISTS(SELECT name FROM sys.databases WHERE name = N'sampledb')
IF DB_ID (N'sampledb') IS NOT NULL
DROP DATABASE [sampledb];
GO

CREATE DATABASE sampledb;
GO

USE [sampledb];
GO

IF OBJECT_ID('Table1', 'U') IS NOT NULL
DROP TABLE Table1;
GO

CREATE TABLE Table1
(
 ID int, 
 Value nvarchar(max)
);
GO

INSERT INTO Table1
SELECT 1, 'First' UNION ALL
SELECT 2, 'Second' UNION ALL
SELECT 3, 'Third' UNION ALL
SELECT 4, 'Fourth' UNION ALL
SELECT 5, 'Fifth';
GO

SELECT * FROM Table1;
GO

IF OBJECT_ID('Table2', 'U') IS NOT NULL
DROP TABLE Table2;
GO

CREATE TABLE Table2
(
 ID int, 
 Value nvarchar(max)
);
GO

INSERT INTO Table2
SELECT 1, 'I' UNION ALL
SELECT 2, 'II' UNION ALL
SELECT 3, 'III' UNION ALL
SELECT 6, 'VI' UNION ALL
SELECT 7, 'VII' UNION ALL
SELECT 8, 'VIII';
GO

SELECT * FROM Table2;
GO

-- (INNER) JOIN
SELECT t1.*, t2.* 
FROM Table1 t1
JOIN Table2 t2 
ON t1.ID = t2.ID;
GO

-- CROSS APPLY
SELECT t1.*, t3.* 
FROM Table1 t1
CROSS APPLY
(SELECT * FROM Table2 t2 
WHERE t1.ID = t2.ID) t3;
GO

-- LEFT (OUTER) JOIN
SELECT t1.*, t2.* 
FROM Table1 t1
LEFT JOIN Table2 t2 
ON t1.ID = t2.ID;
GO

-- OUTER APPLY
SELECT t1.*, t3.* 
FROM Table1 t1
OUTER APPLY
(SELECT * FROM Table2 t2 
WHERE t1.ID = t2.ID) t3;
GO

-- IF EXISTS(SELECT name FROM sys.objects WHERE name = N'F1' AND type =N'FN')
IF OBJECT_ID(N'F1', N'FN') IS NOT NULL
DROP FUNCTION F1
GO

CREATE FUNCTION F1
(
 @In int
)
RETURNS nvarchar(max)
AS
BEGIN
 -- DECLARE @Return nvarchar(max)
 -- SET @Return = (SELECT TOP 1 ID FROM Table2 WHERE ID = @In);
 -- RETURN @Return
 RETURN (SELECT TOP 1 ID FROM Table2 WHERE ID = @In);
END
GO

-- CROSS APPLY with User-Defined Function
SELECT t1.*, t3.* 
FROM Table1 t1
CROSS APPLY
(SELECT [dbo].[F1](t1.ID)) t3(ID);
GO

-- IF EXISTS(SELECT name FROM sys.objects WHERE name = N'F2' AND type =N'TF')
IF OBJECT_ID(N'F2', N'TF') IS NOT NULL
DROP FUNCTION F2;
GO

CREATE FUNCTION F2
(
 @In int
)
RETURNS @R2 TABLE
(
  ID int,
  Value nvarchar(max)
)
AS
BEGIN
 INSERT INTO @R2 
 SELECT ID, Value FROM Table2 WHERE (ID > @In);
 RETURN;
END
GO

SELECT * FROM Table1;
GO

DECLARE @ID int;
DECLARE CursorID CURSOR 
  LOCAL STATIC READ_ONLY FORWARD_ONLY
FOR 
SELECT DISTINCT ID FROM Table1
OPEN CursorID
FETCH NEXT FROM CursorID INTO @ID
WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT * FROM F2(@ID);
    FETCH NEXT FROM CursorID INTO @ID;
END
CLOSE CursorID
DEALLOCATE CursorID

/*
1 + 1 + 1 + 1 + 1 + 1 = 5
2 + 2 + 2 + 2 = 8
3 + 3 + 3 = 9
4 + 4 + 4 = 12
5 + 5 + 5 = 15
SELECT t1.ID, t2.ID
FROM Table1 t1
OUTER APPLY
F2(t1.ID) t2;
GO
*/
-- OUTER APPLY with User-Defined Function
SELECT t1.ID, SUM(t1.ID) AS Total
FROM Table1 t1
OUTER APPLY
F2(t1.ID) t2
GROUP BY t1.ID;
GO

-- CROSS APPLY with TOP
SELECT t1.*, t3.* FROM Table1 t1
CROSS APPLY(SELECT TOP 4(ID), Value FROM Table2 t2 WHERE t1.ID = t2.ID) t3;
GO

-- OUTER APPLY with TOP
SELECT t1.*, t3.* FROM Table1 t1
OUTER APPLY(SELECT TOP 4(ID), Value FROM Table2 t2 WHERE t1.ID = t2.ID) t3;
GO

/******************************************************************************/

-- columns

/******************************************************************************/

USE [master];
GO

-- IF EXISTS(SELECT name FROM sys.databases WHERE name = N'sampledb')
IF DB_ID (N'sampledb') IS NOT NULL
DROP DATABASE [sampledb];
GO

CREATE DATABASE sampledb;
GO

USE [sampledb];
GO

-- IF EXISTS(SELECT name FROM sys.tables WHERE name = N'users')
IF OBJECT_ID (N'users', N'U') IS NOT NULL
DROP TABLE [users];
GO

CREATE TABLE users
(
    id INT IDENTITY(1,1) NOT NULL,
    username VARCHAR(50) NOT NULL, 
    login_date DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    login_time TIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at DATETIME2 DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,    
    CONSTRAINT pk_id PRIMARY KEY(id),
    CONSTRAINT idx_username UNIQUE(username)    
);
GO

SELECT * FROM users;
GO

sp_help users;
GO

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'users';
GO

sp_columns users
GO

-- sys.columns returns a row for each column of an object that has columns, such as views or tables.
-- The following is a list of object types that have columns:
-- • Table-valued assembly functions (FT)
-- • Inline table-valued SQL functions (IF)
-- • Internal tables (IT)
-- • System tables (S)
-- • Table-valued SQL functions (TF)
-- • User tables (U)
-- • Views (V)
-- sys.all_columns shows the union of all columns belonging to user-defined objects and system objects.

SELECT * FROM sys.columns WHERE object_id = OBJECT_ID(N'users');
GO

SELECT   o.name, c.name
FROM     sys.columns c 
         JOIN sys.objects o ON o.object_id = c.object_id 
WHERE    o.type = 'U' -- AND o.name = 'users'
ORDER BY o.name, c.name;
GO

/******************************************************************************/

-- cursor

/******************************************************************************/

USE [master];
GO

-- IF EXISTS(SELECT name FROM sys.databases WHERE name = N'sampledb')
IF DB_ID (N'sampledb') IS NOT NULL
DROP DATABASE [sampledb];
GO

CREATE DATABASE sampledb;
GO

USE [sampledb];
GO

IF OBJECT_ID('Table1', 'U') IS NOT NULL
DROP TABLE Table1;
GO

CREATE TABLE Table1
(
 ID int, 
 Value nvarchar(max)
);
GO

INSERT INTO Table1
SELECT 1, 'First' UNION ALL
SELECT 2, 'Second' UNION ALL
SELECT 3, 'Third' UNION ALL
SELECT 4, 'Fourth' UNION ALL
SELECT 5, 'Fifth';
GO

SELECT * FROM Table1;
GO

IF OBJECT_ID('Table2', 'U') IS NOT NULL
DROP TABLE Table2;
GO

CREATE TABLE Table2
(
 ID int, 
 Value nvarchar(max)
);
GO

INSERT INTO Table2
SELECT 1, 'I' UNION ALL
SELECT 2, 'II' UNION ALL
SELECT 3, 'III' UNION ALL
SELECT 6, 'VI' UNION ALL
SELECT 7, 'VII' UNION ALL
SELECT 8, 'VIII';
GO

SELECT * FROM Table2;
GO

-- IF EXISTS(SELECT name FROM sys.objects WHERE name = N'F1' AND type =N'TF')
IF OBJECT_ID(N'F1', N'TF') IS NOT NULL
DROP FUNCTION F1;
GO

CREATE FUNCTION F1
(
 @In int
)
RETURNS @R1 TABLE
(
  ID int,
  Value nvarchar(max)
)
AS
BEGIN
 INSERT INTO @R1 
 SELECT ID, Value FROM Table2 WHERE (ID > @In);
 RETURN;
END
GO

SELECT * FROM Table1;
GO

DECLARE @ID int;
DECLARE CursorID CURSOR 
  LOCAL STATIC READ_ONLY FORWARD_ONLY
FOR 
SELECT DISTINCT ID FROM Table1
OPEN CursorID
FETCH NEXT FROM CursorID INTO @ID
WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT * FROM F1(@ID);
    FETCH NEXT FROM CursorID INTO @ID;
END
CLOSE CursorID
DEALLOCATE CursorID
GO

/******************************************************************************/

-- databases and tables

/******************************************************************************/

USE [master];
GO

IF EXISTS(SELECT name FROM sys.databases WHERE name = N'sampledb')
DROP DATABASE [sampledb];
GO

-- OR

IF DB_ID (N'sampledb') IS NOT NULL
DROP DATABASE [sampledb];
GO

CREATE DATABASE sampledb;
GO

USE [sampledb];
GO

IF EXISTS(SELECT name FROM sys.tables WHERE name = N'sample')
DROP TABLE [sample];
GO

-- OR

IF OBJECT_ID (N'sample', N'U') IS NOT NULL
DROP TABLE [sample];
GO

CREATE TABLE sample
(
 id int IDENTITY(1, 1),
 name nvarchar(max),
 date datetime2
);
GO

SELECT * FROM sample;
GO

INSERT INTO sample VALUES('ABC', GETDATE());
GO

INSERT INTO sample (date) VALUES(GETDATE());
GO

INSERT INTO sample
SELECT 'Alpha', GETDATE() UNION ALL
SELECT 'Beta', GETDATE() UNION ALL
SELECT 'Gamma', GETDATE();
GO

SELECT * FROM sample;
GO

SELECT name, database_id, create_date  
FROM sys.databases;  
GO  

SELECT * 
FROM sys.databases;
GO

SELECT * 
FROM sys.databases ORDER BY name;
GO

SELECT * 
FROM sys.databases ORDER BY database_id;
GO

SELECT * 
FROM sys.databases 
WHERE name NOT IN ('master', 'model', 'msdb',  'tempdb') 
ORDER BY name;
GO

SELECT * 
FROM sys.databases 
WHERE name NOT IN ('master', 'model', 'msdb', 'tempdb') 
ORDER BY name;
GO

SELECT * 
FROM sys.databases 
WHERE database_id > 6 ORDER BY name;
GO

SELECT * 
FROM sys.databases 
WHERE name NOT IN ('master', 'model', 'msdb', 'tempdb') 
ORDER BY name;
GO

SELECT *
FROM sys.sysdatabases -- SQL Server 2000
WHERE HAS_DBACCESS(name) = 1
GO

SELECT * 
FROM sys.databases
WHERE HAS_DBACCESS(name) = 1
GO

declare @sql nvarchar(max);

select @sql = 
    (select ' UNION ALL
        SELECT ' +  + quotename(name,'''') + ' as database_name,
               s.name COLLATE DATABASE_DEFAULT
                    AS schema_name,
               t.name COLLATE DATABASE_DEFAULT as table_name 
               FROM '+ quotename(name) + '.sys.tables t
               JOIN '+ quotename(name) + '.sys.schemas s
                    on s.schema_id = t.schema_id'
    from sys.databases 
    where state = 0
    order by [name] for xml path(''), type).value('.', 'nvarchar(max)');

set @sql = stuff(@sql, 1, 12, '') + ' order by database_name, 
                                               schema_name,
                                               table_name';

execute (@sql);
GO

declare @sql nvarchar(max);

select @sql = 
    (select ' UNION ALL
        SELECT ' +  + quotename(name,'''') + ' as database_name,
               s.name COLLATE DATABASE_DEFAULT
                    AS schema_name,
               t.name COLLATE DATABASE_DEFAULT as table_name 
               FROM '+ quotename(name) + '.sys.tables t
			   
               JOIN '+ quotename(name) + '.sys.schemas s
                    on s.schema_id = t.schema_id'
    from sys.databases 
    WHERE name NOT IN 
	('master', 'model', 'msdb', 'tempdb')
    AND state = 0
    order by [name] for xml path(''), type).value('.', 'nvarchar(max)');

set @sql = stuff(@sql, 1, 12, '') + ' order by database_name, 
                                               schema_name,
                                               table_name';

execute (@sql);
GO

declare @sql nvarchar(max);

select @sql = 
    (select ' UNION ALL
        SELECT ' +  + quotename(name,'''') + ' as database_name,
               s.name COLLATE DATABASE_DEFAULT
                    AS schema_name,
               t.name COLLATE DATABASE_DEFAULT as table_name 
               FROM '+ quotename(name) + '.sys.tables t
			   
               JOIN '+ quotename(name) + '.sys.schemas s
                    on s.schema_id = t.schema_id'
    from sys.databases 
    WHERE HAS_DBACCESS(name) = 1
    AND state = 0
    order by [name] for xml path(''), type).value('.', 'nvarchar(max)');

set @sql = stuff(@sql, 1, 12, '') + ' order by database_name, 
                                               schema_name,
                                               table_name';

execute (@sql);
GO

-- IF EXISTS(SELECT name FROM tempdb.sys.tables WHERE name LIKE '#T1%')
IF OBJECT_ID(N'tempdb.dbo.#T1', N'U') IS NOT NULL
DROP TABLE #T1;
GO

CREATE TABLE #T1
(
  database_name nvarchar(max),
  schema_name nvarchar(max),
  table_name nvarchar(max)
);
GO

declare @sql nvarchar(max);

select @sql = 
    (select ' UNION ALL
        SELECT ' +  + quotename(name,'''') + ' as database_name,
               s.name COLLATE DATABASE_DEFAULT
                    AS schema_name,
               t.name COLLATE DATABASE_DEFAULT as table_name 
               FROM '+ quotename(name) + '.sys.tables t
			   
               JOIN '+ quotename(name) + '.sys.schemas s
                    on s.schema_id = t.schema_id'
    from sys.databases 
    WHERE HAS_DBACCESS(name) = 1
    AND state = 0
    order by [name] for xml path(''), type).value('.', 'nvarchar(max)');

set @sql = stuff(@sql, 1, 12, '') + ' order by database_name, 
                                               schema_name,
                                               table_name';

INSERT #T1 execute (@sql);
GO

SELECT * FROM #T1 WHERE table_name = 'sample';
GO

SELECT * FROM #T1 WHERE database_name = 'sampledb';
GO

SELECT
    P.[entity_name],
    P.subentity_name,
    P.[permission_name]
FROM sys.fn_my_permissions
    (
        N'sample', 
        N'OBJECT'
    ) AS P
ORDER BY
    P.subentity_name,
    P.[permission_name];
GO

IF EXISTS(SELECT name FROM tempdb.sys.tables WHERE name LIKE '#T2%')
-- IF OBJECT_ID(N'tempdb.dbo.#T2', N'U') IS NOT NULL
DROP TABLE #T2;
GO

CREATE TABLE #T2
(
  id int IDENTITY(1,1),
  [name] nvarchar(max),
  [date] datetime2
);
GO

SELECT * FROM #T2;
GO

INSERT INTO #T2 VALUES('Alpha', GETDATE());
INSERT INTO #T2 VALUES('Beta', GETDATE());
INSERT INTO #T2 VALUES('Gamma', GETDATE());
GO

SELECT * FROM #T2;
GO

IF EXISTS(SELECT * FROM tempdb.sys.tables WHERE name = '##T3')
-- IF OBJECT_ID(N'tempdb.dbo.##T3', N'U') IS NOT NULL
DROP TABLE ##T3;
GO

CREATE TABLE ##T3
(
  id int IDENTITY(1,1),
  [name] nvarchar(max),
  [date] datetime2
);
GO

SELECT * FROM ##T3;
GO

INSERT INTO ##T3 VALUES('A', GETDATE());
INSERT INTO ##T3 VALUES('B', GETDATE());
INSERT INTO ##T3 VALUES('C', GETDATE());
GO

SELECT * FROM ##T3;
GO

/******************************************************************************/

-- functions

/******************************************************************************/

USE [master];
GO

-- IF EXISTS(SELECT name FROM sys.databases WHERE name = N'sampledb')
IF DB_ID (N'sampledb') IS NOT NULL
DROP DATABASE [sampledb];
GO

CREATE DATABASE sampledb;
GO

USE [sampledb];
GO

-- IF EXISTS(SELECT name FROM sys.tables WHERE name = N'greek')
IF OBJECT_ID (N'greek', N'U') IS NOT NULL
DROP TABLE [greek];
GO

CREATE TABLE greek
(
  id int IDENTITY(1,1),
  name nvarchar(max),
  rgb nvarchar(max),
  score int
);
GO

SELECT * FROM greek;
GO

INSERT INTO greek 
SELECT 'Alpha', 'Green', 85 UNION ALL
SELECT 'Beta', 'Green', 85 UNION ALL
SELECT 'Gamma', 'Green', 80 UNION ALL
SELECT 'Delta', 'Blue', 70 UNION ALL
SELECT 'Epsilon', 'Blue', 71 UNION ALL
SELECT 'Zeta', 'Blue', 72 UNION ALL
SELECT 'Eta', 'Blue', 73 UNION ALL
SELECT 'Theta', 'Blue', 74 UNION ALL
SELECT 'Iota', 'Red', 60 UNION ALL
SELECT 'Kappa', 'Red', 60 UNION ALL
SELECT 'Lambda', 'Red', 60 UNION ALL
SELECT 'Mu', 'Red', 65 UNION ALL
SELECT 'Nu', 'Green', 89 UNION ALL
SELECT 'Xi', 'Green', 87 UNION ALL
SELECT 'Omicron', 'Green', 89;
GO

SELECT * FROM greek;
GO

-- IF EXISTS(SELECT name FROM sys.tables WHERE name = N'alphabet')
IF OBJECT_ID (N'alphabet', N'U') IS NOT NULL
DROP TABLE [alphabet];
GO

CREATE TABLE alphabet
(
  id int,
  name nvarchar(max),
  date datetime2
);
GO

SELECT * FROM alphabet;
GO

INSERT INTO alphabet
SELECT 1, 'A', GETDATE() UNION ALL
SELECT 2, 'B', GETDATE() UNION ALL
SELECT 3, 'C', GETDATE() UNION ALL
SELECT 4, 'D', GETDATE() UNION ALL
SELECT 5, 'E', GETDATE() UNION ALL
SELECT 6, 'F', GETDATE() UNION ALL
SELECT 7, 'G', GETDATE() UNION ALL
SELECT 8, 'H', GETDATE() UNION ALL
SELECT 9, 'I', GETDATE() UNION ALL
SELECT 10, 'J', GETDATE() UNION ALL
SELECT 11, 'K', GETDATE() UNION ALL
SELECT 12, 'L', GETDATE() UNION ALL
SELECT 13, 'M', GETDATE() UNION ALL
SELECT 14, 'N', GETDATE() UNION ALL
SELECT 15, 'O', GETDATE();
GO

SELECT * FROM alphabet;
GO

-- sys.objects contains a row for each user-defined, schema-scoped object that is created within a database, including natively compiled scalar user-defined function.
-- sys.all_objects shows the UNION of all schema-scoped user-defined objects and system objects.

-- FN = SQL scalar function
-- IF = SQL inline table-valued function
-- TF = SQL table-valued-function
-- FS = Assembly (CLR) scalar-function
-- FT = Assembly (CLR) table-valued function
-- AF = Aggregate function (CLR)

-- IF EXISTS(SELECT name FROM sys.objects WHERE name = N'F1' AND type =N'FN')
IF OBJECT_ID(N'F1', N'FN') IS NOT NULL
DROP FUNCTION F1
GO

CREATE FUNCTION F1
(
 @in nvarchar(max)
)
RETURNS int
AS
BEGIN
 -- DECLARE @counter int
 -- SET @counter = (SELECT COUNT(rgb) FROM greek WHERE rgb = @in);
 -- RETURN @counter
 RETURN (SELECT COUNT(rgb) FROM greek WHERE rgb = @in);
END
GO

-- DECLARE @ret int;
-- EXECUTE @ret = F1 'Green';
-- SELECT @ret;
-- GO

SELECT [dbo].F1('Green');
GO

-- IF EXISTS(SELECT name FROM sys.objects WHERE name = N'F2' AND type = N'IF')
IF OBJECT_ID(N'F2', N'IF') IS NOT NULL
DROP FUNCTION F2;
GO

CREATE FUNCTION F2
(
 @rgb nvarchar(max)
)
RETURNS TABLE
AS
RETURN (SELECT id, name, rgb, score FROM greek WHERE rgb = @rgb);
GO

SELECT * FROM F2('Green');
GO

-- IF EXISTS(SELECT name FROM sys.objects WHERE name = N'F3' AND type =N'TF')
IF OBJECT_ID(N'F3', N'TF') IS NOT NULL
DROP FUNCTION F3;
GO

CREATE FUNCTION F3
(
 @in int
)
RETURNS @T1 TABLE
(
  id int IDENTITY(1,1),
  name nvarchar(max),
  [table] nvarchar(max)
)
AS
BEGIN
 INSERT INTO @T1 
 SELECT name, 'greek' FROM greek WHERE (id % 2 = @in);
 INSERT INTO @T1 
 SELECT name, 'alphabet' FROM alphabet WHERE (id % 2 = @in);
 RETURN;
END
GO

SELECT * FROM F3(0);
GO


-- Returning all the user-defined functions in a database
SELECT name AS function_name   
  ,SCHEMA_NAME(schema_id) AS schema_name  
  ,type_desc  
  ,create_date  
  ,modify_date  
FROM sys.objects  
WHERE type_desc LIKE '%FUNCTION%';  
GO  

SELECT name, definition, type_desc 
  FROM sys.sql_modules m 
INNER JOIN sys.objects o 
        ON m.object_id=o.object_id
WHERE type_desc like '%FUNCTION%';
GO

SELECT * 
FROM sys.objects
-- WHERE object_id = OBJECT_ID(N'[dbo].[F1]')
WHERE -- AND
type IN ( N'FN', N'IF', N'TF', N'FS', N'FT', N'AF');
GO

/******************************************************************************/

-- identity

/******************************************************************************/

IF OBJECT_ID(N'tempdb.dbo.#Source', N'U') IS NOT NULL
DROP TABLE #Source; 
GO

CREATE TABLE #Source
(
 source_name nvarchar(max)
);
GO

INSERT INTO #Source VALUES('Alpha');
INSERT INTO #Source VALUES('Beta');
INSERT INTO #Source VALUES('Gamma');
GO

SELECT * FROM #Source;
GO

IF OBJECT_ID(N'tempdb.dbo.#Target', N'U') IS NOT NULL
DROP TABLE #Target; 
GO

-- IDENTITY function is used only in a SELECT statement with an INTO table clause to insert an identity column into a new table
-- IDENTITY function is not the IDENTITY property that is used with CREATE TABLE and ALTER TABLE
-- SELECT IDENTITY(int, 1, 1) AS target_id, 'name' as target_name INTO #Target;
SELECT IDENTITY(int, 1, 1) AS target_id, source_name as target_name INTO #Target FROM #Source;
GO

SELECT * FROM #Target;
GO


IF OBJECT_ID(N'tempdb.dbo.#T1', N'U') IS NOT NULL
DROP TABLE #T1; 
GO

CREATE TABLE #T1
(
 id int IDENTITY(1, 1),
 name nvarchar(max)
);
GO

INSERT INTO #T1 VALUES('Alpha');
INSERT INTO #T1 VALUES('Beta');
INSERT INTO #T1 VALUES('Gamma');
GO

SELECT * FROM #T1;
GO

INSERT INTO #T1 VALUES('Gamma');
-- SCOPE_IDENTITY returns the last identity values that are generated in any table in the current session
-- SCOPE_IDENTITY returns values inserted only within the current scope
SELECT SCOPE_IDENTITY() as 'Scope_Identity';
-- @@IDENTITY return the last identity values that are generated in any table in the current session
-- @@IDENTITY is not limited to a specific scope
SELECT @@IDENTITY as 'Identity';
-- IDENT_CURRENT is not limited by scope and session; it is limited to a specified table or view
-- IDENT_CURRENT returns the value generated for a specific table or view in any session and any scope
SELECT IDENT_CURRENT('#T1') as 'Ident_Current';
GO

/******************************************************************************/

-- merge

/******************************************************************************/

IF EXISTS(SELECT name FROM tempdb.sys.tables WHERE name LIKE '#Target%')
-- IF OBJECT_ID(N'tempdb.dbo.#Target', N'U') IS NOT NULL
DROP TABLE #Target;
GO

CREATE TABLE #Target
(
  id int,
  name nvarchar(max),
  date datetime2
);
GO

SELECT * FROM #Target;
GO

INSERT INTO #Target VALUES(1, 'Alpha', GETDATE());
INSERT INTO #Target VALUES(2, 'Beta', GETDATE());
INSERT INTO #Target VALUES(3, 'Gamma', GETDATE());
INSERT INTO #Target VALUES(4, 'Delta', GETDATE());
GO

SELECT * FROM #Target;
GO

IF EXISTS(SELECT name FROM tempdb.sys.tables WHERE name LIKE '#Source%')
-- IF OBJECT_ID(N'tempdb.dbo.#Source', N'U') IS NOT NULL
DROP TABLE #Source;
GO

CREATE TABLE #Source
(
  id int,
  name nvarchar(max),
  date datetime2
);
GO

SELECT * FROM #Source;
GO

INSERT INTO #Source VALUES(1, 'A', GETDATE());
INSERT INTO #Source VALUES(3, 'C', GETDATE());
INSERT INTO #Source VALUES(4, 'D', GETDATE());
INSERT INTO #Source VALUES(5, 'E', GETDATE());
INSERT INTO #Source VALUES(6, 'F', GETDATE());
GO

SELECT * FROM #Source;
GO

IF EXISTS(SELECT name FROM tempdb.sys.tables WHERE name LIKE '#Result%')
-- IF OBJECT_ID(N'tempdb.dbo.#Result', N'U') IS NOT NULL
DROP TABLE #Result;
GO

CREATE TABLE #Result
(
 existing_id int,
 existing_name nvarchar(max),
 existing_date datetime2,
 action_taken nvarchar(max),
 new_id int,
 new_name nvarchar(max),
 new_date datetime2
);
GO

SELECT * FROM #Result;
GO

MERGE #Target t USING #Source s
ON t.id = s.id
WHEN MATCHED THEN
UPDATE SET 
t.name = s.name,
t.date = s.date
WHEN NOT MATCHED BY TARGET THEN
INSERT(id, name, date) VALUES (s.id, s.name, s.date)
WHEN NOT MATCHED BY SOURCE THEN
DELETE
OUTPUT deleted.*, $action, inserted.* INTO #Result;
GO

SELECT * FROM #Target;
GO

SELECT * FROM #Source;
GO

SELECT * FROM #Result;
GO

/******************************************************************************/

-- parameters

/******************************************************************************/

-- sys.parameters contains a row for each parameter of an object that accepts parameters. If the object is a scalar function, there is also a single row describing the return value. That row will have a parameter_id value of 0.
-- sys.all_parameters shows the union of all parameters that belong to user-defined or system objects.

SELECT * 
FROM sys.parameters;
GO

SELECT *
FROM sys.all_parameters;
GO

USE [master];
GO

-- IF EXISTS(SELECT name FROM sys.databases WHERE name = N'sampledb')
IF DB_ID (N'sampledb') IS NOT NULL
DROP DATABASE [sampledb];
GO

CREATE DATABASE sampledb;
GO

USE [sampledb];
GO

-- IF EXISTS(SELECT name FROM sys.tables WHERE name = N'greek')
IF OBJECT_ID (N'greek', N'U') IS NOT NULL
DROP TABLE [greek];
GO

CREATE TABLE greek
(
  id int IDENTITY(1,1),
  name nvarchar(max),
  rgb nvarchar(max),
  score int
);
GO

SELECT * FROM greek;
GO

INSERT INTO greek 
SELECT 'Alpha', 'Green', 85 UNION ALL
SELECT 'Beta', 'Green', 85 UNION ALL
SELECT 'Gamma', 'Green', 80 UNION ALL
SELECT 'Delta', 'Blue', 70 UNION ALL
SELECT 'Epsilon', 'Blue', 71 UNION ALL
SELECT 'Zeta', 'Blue', 72 UNION ALL
SELECT 'Eta', 'Blue', 73 UNION ALL
SELECT 'Theta', 'Blue', 74 UNION ALL
SELECT 'Iota', 'Red', 60 UNION ALL
SELECT 'Kappa', 'Red', 60 UNION ALL
SELECT 'Lambda', 'Red', 60 UNION ALL
SELECT 'Mu', 'Red', 65 UNION ALL
SELECT 'Nu', 'Green', 89 UNION ALL
SELECT 'Xi', 'Green', 87 UNION ALL
SELECT 'Omicron', 'Green', 89;
GO

SELECT * FROM greek;
GO

-- IF EXISTS(SELECT name FROM sys.tables WHERE name = N'alphabet')
IF OBJECT_ID (N'alphabet', N'U') IS NOT NULL
DROP TABLE [alphabet];
GO

CREATE TABLE alphabet
(
  id int,
  name nvarchar(max),
  date datetime2
);
GO

SELECT * FROM alphabet;
GO

INSERT INTO alphabet
SELECT 1, 'A', GETDATE() UNION ALL
SELECT 2, 'B', GETDATE() UNION ALL
SELECT 3, 'C', GETDATE() UNION ALL
SELECT 4, 'D', GETDATE() UNION ALL
SELECT 5, 'E', GETDATE() UNION ALL
SELECT 6, 'F', GETDATE() UNION ALL
SELECT 7, 'G', GETDATE() UNION ALL
SELECT 8, 'H', GETDATE() UNION ALL
SELECT 9, 'I', GETDATE() UNION ALL
SELECT 10, 'J', GETDATE() UNION ALL
SELECT 11, 'K', GETDATE() UNION ALL
SELECT 12, 'L', GETDATE() UNION ALL
SELECT 13, 'M', GETDATE() UNION ALL
SELECT 14, 'N', GETDATE() UNION ALL
SELECT 15, 'O', GETDATE();
GO

SELECT * FROM alphabet;
GO

-- sys.objects contains a row for each user-defined, schema-scoped object that is created within a database, including natively compiled scalar user-defined function.
-- sys.all_objects shows the UNION of all schema-scoped user-defined objects and system objects.

-- FN = SQL scalar function
-- IF = SQL inline table-valued function
-- TF = SQL table-valued-function
-- FS = Assembly (CLR) scalar-function
-- FT = Assembly (CLR) table-valued function
-- AF = Aggregate function (CLR)

-- IF EXISTS(SELECT name FROM sys.objects WHERE name = N'F1' AND type =N'FN')
IF OBJECT_ID(N'F1', N'FN') IS NOT NULL
DROP FUNCTION F1
GO

CREATE FUNCTION F1
(
 @in nvarchar(max)
)
RETURNS int
AS
BEGIN
 -- DECLARE @counter int
 -- SET @counter = (SELECT COUNT(rgb) FROM greek WHERE rgb = @in);
 -- RETURN @counter
 RETURN (SELECT COUNT(rgb) FROM greek WHERE rgb = @in);
END
GO

-- DECLARE @ret int;
-- EXECUTE @ret = F1 'Green';
-- SELECT @ret;
-- GO

SELECT [dbo].F1('Green');
GO

-- IF EXISTS(SELECT name FROM sys.objects WHERE name = N'F2' AND type = N'IF')
IF OBJECT_ID(N'F2', N'IF') IS NOT NULL
DROP FUNCTION F2;
GO

CREATE FUNCTION F2
(
 @rgb nvarchar(max)
)
RETURNS TABLE
AS
RETURN (SELECT id, name, rgb, score FROM greek WHERE rgb = @rgb);
GO

SELECT * FROM F2('Green');
GO

-- IF EXISTS(SELECT name FROM sys.objects WHERE name = N'F3' AND type =N'TF')
IF OBJECT_ID(N'F3', N'TF') IS NOT NULL
DROP FUNCTION F3;
GO

CREATE FUNCTION F3
(
 @in int
)
RETURNS @T1 TABLE
(
  id int IDENTITY(1,1),
  name nvarchar(max),
  [table] nvarchar(max)
)
AS
BEGIN
 INSERT INTO @T1 
 SELECT name, 'greek' FROM greek WHERE (id % 2 = @in);
 INSERT INTO @T1 
 SELECT name, 'alphabet' FROM alphabet WHERE (id % 2 = @in);
 RETURN;
END
GO

SELECT * FROM F3(0);
GO

-- If the object is a scalar function, parameter_id = 0 represents the return value
SELECT * 
FROM sys.parameters sp
INNER JOIN sys.objects so
ON sp.object_id = so.object_id
WHERE so.type IN ('FN', 'IF', 'TF');
GO

-- sys.objects contains a row for each user-defined, schema-scoped object that is created within a database, including natively compiled scalar user-defined function.
-- sys.all_objects shows the UNION of all schema-scoped user-defined objects and system objects.
-- sys.procedures contains a row for each object that is a procedure of some kind, with sys.objects.type = P, X, RF, and PC.

-- P = SQL Stored Procedure
-- X = Extended Stored Procedure
-- RF = Replication-filter-procedure
-- PC = CLR Stored Procedure

SELECT * FROM sys.all_objects
WHERE ([type] = N'P' OR [type] = N'X' OR [type] = N'RF' OR [type] = N'PC')
ORDER BY [name];
GO

SELECT * FROM sys.all_objects
WHERE ([type] = N'P' OR [type] = N'X' OR [type] = N'RF' OR [type] = N'PC')
AND [is_ms_shipped] = 0
ORDER BY [name];
GO

SELECT QUOTENAME(SCHEMA_NAME(schema_id)) + '.' + QUOTENAME(name)
FROM   sys.all_objects
WHERE  (type = N'P' OR type = N'X' OR type = N'RF' OR type = N'PC')
--  Only User Defined Procedures
AND is_ms_shipped = 0
--  Only System Stored Procedures
-- AND is_ms_shipped = 1
ORDER BY name
GO

SELECT QUOTENAME(SCHEMA_NAME(schema_id)) + '.' + QUOTENAME(name)
FROM   sys.all_objects
WHERE type IN (N'P', N'X', N'PC')
--  Only User Defined Procedures
AND is_ms_shipped = 0
--  Only System Stored Procedures
-- AND is_ms_shipped = 1
ORDER BY name
GO

-- Extended stored procedures reside inside the master database
-- Extended stored procedures will be removed in a future version - Use CLR Integration instead
-- sp_addextendedproc can only be executed in the master database
-- Only members of the sysadmin fixed server role can execute sp_addextendedproc
-- Existing DLLs that were not registered with a complete path will not work after upgrading to SQL Server 2019 (15.x) - To correct the problem, use sp_dropextendedproc to unregister the DLL, and then reregister it with sp_addextendedproc, specifying the complete path

USE [master];
GO

-- IF EXISTS(SELECT name FROM sys.procedures WHERE name = N'xp_hello')
IF OBJECT_ID(N'xp_hello', N'X') IS NOT NULL
-- DROP PROCEDURE xp_hello;
EXECUTE sp_dropextendedproc 'xp_hello';
GO

sp_addextendedproc 'xp_hello', 'c:\xp_hello.dll';  
GO

GRANT EXECUTE
ON [xp_hello]
TO PUBLIC
GO

DECLARE @txt varchar(33);  
-- EXEC xp_hello @txt OUTPUT;
GO

sp_helpextendedproc;
GO

SELECT * FROM sys.extended_properties;
GO

SELECT *
FROM 
    sys.objects             O LEFT OUTER JOIN
    sys.extended_properties E ON O.object_id = E.major_id
WHERE
    O.name IS NOT NULL
    AND ISNULL(O.is_ms_shipped, 0) = 0
    AND ISNULL(E.name, '') <> 'microsoft_database_tools_support'
    AND O.type_desc = 'SQL_STORED_PROCEDURE'
ORDER BY O.name;
GO

-- IF EXISTS(SELECT name FROM sys.databases WHERE name = N'sampledb')
IF DB_ID (N'sampledb') IS NOT NULL
DROP DATABASE [sampledb];
GO

CREATE DATABASE sampledb;
GO

USE [sampledb];
GO

-- IF EXISTS(SELECT name FROM sys.tables WHERE name = N'greek')
IF OBJECT_ID (N'greek', N'U') IS NOT NULL
DROP TABLE [greek];
GO

CREATE TABLE greek
(
  id int IDENTITY(1,1),
  name nvarchar(max),
  rgb nvarchar(max),
  score int
);
GO

SELECT * FROM greek;
GO

INSERT INTO greek 
SELECT 'Alpha', 'Green', 85 UNION ALL
SELECT 'Beta', 'Green', 85 UNION ALL
SELECT 'Gamma', 'Green', 80 UNION ALL
SELECT 'Delta', 'Blue', 70 UNION ALL
SELECT 'Epsilon', 'Blue', 71 UNION ALL
SELECT 'Zeta', 'Blue', 72 UNION ALL
SELECT 'Eta', 'Blue', 73 UNION ALL
SELECT 'Theta', 'Blue', 74 UNION ALL
SELECT 'Iota', 'Red', 60 UNION ALL
SELECT 'Kappa', 'Red', 60 UNION ALL
SELECT 'Lambda', 'Red', 60 UNION ALL
SELECT 'Mu', 'Red', 65 UNION ALL
SELECT 'Nu', 'Green', 89 UNION ALL
SELECT 'Xi', 'Green', 87 UNION ALL
SELECT 'Omicron', 'Green', 89;
GO

SELECT * FROM greek;
GO

IF EXISTS(SELECT name FROM sys.procedures WHERE name = N'P1')
-- IF OBJECT_ID(N'P1', N'P') IS NOT NULL
DROP PROCEDURE P1;
GO

CREATE PROCEDURE P1
AS
SELECT * FROM greek ORDER BY id OFFSET 5 ROW FETCH NEXT 5 ROWS ONLY;
GO

EXECUTE P1;
GO

IF EXISTS(SELECT name FROM sys.procedures WHERE name = N'Recursion')
-- IF OBJECT_ID(N'Recursion', N'P') IS NOT NULL
DROP PROCEDURE Recursion;
GO

CREATE PROCEDURE Recursion
(
  @Number int,
  @Result nvarchar(max) OUTPUT
)
AS
DECLARE @In int;
DECLARE @Out int;
IF @Number > 1
 BEGIN
  SELECT @In = @Number - 1;
  EXECUTE Recursion @In, @Out OUTPUT;
  SELECT @Result = @Number * @Out;
 END
ELSE IF @Number = 1 OR @Number = 0
 BEGIN
  SELECT @Result = 1;
 END
ELSE
 BEGIN
  SELECT @Result = 'Invalid input';
 END
RETURN
GO

DECLARE @In int;
DECLARE @Out nvarchar(max);
SET @In = -1;
EXECUTE Recursion @In, @Out OUTPUT;
SELECT @Out;
GO

IF EXISTS(SELECT name FROM sys.procedures WHERE name = N'Recursion')
-- IF OBJECT_ID(N'Recursion', N'P') IS NOT NULL
DROP PROCEDURE Recursion;
GO

CREATE PROCEDURE Recursion
(
  @Number int,
  @Result int OUTPUT
)
AS
DECLARE @In int;
DECLARE @Out int;
IF @Number = 1 OR @Number = 0
 BEGIN
  SELECT @Result = 1;
 END
ELSE
 BEGIN
  BEGIN TRY
   SELECT @In = @Number - 1;
   EXECUTE Recursion @In, @Out OUTPUT;
   SELECT @Result = @Number * @Out;
  END TRY
  BEGIN CATCH
   /* 
    SELECT 
	 ERROR_NUMBER() AS ErrorNumber  
     ,ERROR_SEVERITY() AS ErrorSeverity  
     ,ERROR_STATE() AS ErrorState  
     ,ERROR_PROCEDURE() AS ErrorProcedure  
     ,ERROR_LINE() AS ErrorLine  
     ,ERROR_MESSAGE() AS ErrorMessage;
   */
   THROW 51000, 'Invalid input.', 1; 
  END CATCH;
 END
RETURN
GO

DECLARE @In int;
DECLARE @Out int;
SET @In = 6;
EXECUTE Recursion @In, @Out OUTPUT;
SELECT @Out;
GO

IF EXISTS(SELECT name FROM sys.procedures WHERE name = N'Recursion')
-- IF OBJECT_ID(N'Recursion', N'P') IS NOT NULL
DROP PROCEDURE Recursion;
GO

CREATE PROCEDURE Recursion
(
  @Number sql_variant,
  @Result sql_variant OUTPUT
)
AS
DECLARE @In sql_variant;
DECLARE @Out sql_variant;
IF SQL_VARIANT_PROPERTY(@Number,'BaseType') = 'int'
 BEGIN
  IF @Number = 1 OR @Number = 0
  BEGIN
   SELECT @Result = 1;
  END
 ELSE
  BEGIN
   BEGIN TRY
    SELECT @In = CONVERT(int, @Number) - 1;
    EXECUTE Recursion @In, @Out OUTPUT;
    SELECT @Result = CONVERT(int, @Number) * CONVERT(int, @Out);
   END TRY
  BEGIN CATCH
   THROW 51000, 'Invalid input.', 1; 
  END CATCH;
  END
 END
ELSE
 BEGIN
  SELECT @Result = CONVERT(nvarchar, 'Positive interger required');
 END
RETURN
GO

DECLARE @In sql_variant;
DECLARE @Out sql_variant;
SET @In = 5
EXECUTE Recursion @In, @Out OUTPUT;
SELECT @Out;
GO

SELECT * 
FROM sys.parameters sp
INNER JOIN sys.objects so
ON sp.object_id = so.object_id
WHERE so.type IN ('P', 'X', 'RX', 'PC');
GO

/******************************************************************************/

-- pivot and unpivot

/******************************************************************************/

IF EXISTS(SELECT name FROM tempdb.sys.tables WHERE name LIKE '#T1%')
-- IF OBJECT_ID(N'tempdb.dbo.#T1', N'U') IS NOT NULL
DROP TABLE #T1;
GO

CREATE TABLE #T1
(
  Id int IDENTITY(1,1),
  Name nvarchar(max),
  Rgb nvarchar(max),
  Score int
);
GO

INSERT INTO #T1
SELECT 'Alpha', 'Green', 90 UNION ALL 
SELECT 'Beta', 'Green', 91 UNION ALL
SELECT 'Gamma', 'Green', 93 UNION ALL
SELECT 'Gamma', 'Green', 94 UNION ALL
SELECT 'Alpha', 'Blue', 85 UNION ALL
SELECT 'Beta', 'Blue', 81 UNION ALL
SELECT 'Beta', 'Blue', 83 UNION ALL
SELECT 'Gamma', 'Blue', 81 UNION ALL
SELECT 'Gamma', 'Blue', 83 UNION ALL
SELECT 'Alpha', 'Blue', 80 UNION ALL
SELECT 'Alpha', 'Red', 70 UNION ALL
SELECT 'Alpha', 'Red', 70 UNION ALL
SELECT 'Gamma', 'Red', 70 UNION ALL
SELECT 'Gamma', 'Red', 70 UNION ALL
SELECT 'Beta', 'Red', 71 UNION ALL
SELECT 'Beta', 'Red', 72 UNION ALL
SELECT 'Alpha', 'Green', 95 UNION ALL
SELECT 'Beta', 'Green', 93;
GO

SELECT * FROM #T1 ORDER BY name, score;
GO

-- Pivot
SELECT Rgb, Alpha, Beta, Gamma FROM
(SELECT Name, Rgb, Score From #T1) AS Table1
PIVOT (SUM(Score) For Name IN (Alpha, Beta, Gamma)) AS Table2
ORDER BY Table2.Rgb;
GO

-- Pivot
SELECT Name, Blue, Green, Red FROM
(SELECT Name, Rgb, Score From #T1) AS Table1
PIVOT (SUM(Score) For Rgb IN (Blue, Green, Red)) AS Table2
ORDER BY Table2.Name;
GO

-- Pivot
DECLARE @Pivot nvarchar(max);
DECLARE @DynamicQuery nvarchar(max);
SELECT @Pivot = COALESCE(@Pivot + ', ',  '') + QUOTENAME(Rgb) FROM
(SELECT DISTINCT (Rgb) FROM #T1) AS Table1;

-- PRINT @Pivot;

SELECT @DynamicQuery = 'SELECT Name, ' + @Pivot + ' FROM 
(SELECT Name, Rgb, Score FROM #T1) AS Table2
PIVOT (SUM(Score) FOR RGB IN ('+ @Pivot + ')) AS Table3
ORDER BY Table3.Name';

-- PRINT @DynamicQuery;

EXECUTE sp_executesql @DynamicQuery;


-- Unpivot
DECLARE @T1 table
(
 Rgb nvarchar(max),
 Alpha nvarchar(max),
 Beta nvarchar(max),
 Gamma nvarchar(max)
 );
 
INSERT INTO @T1
SELECT Rgb, Alpha, Beta, Gamma FROM
(SELECT Name, Rgb, Score From #T1) AS Table1
PIVOT (SUM(Score) FOR Name IN (Alpha, Beta, Gamma)) AS Table2
ORDER BY Table2.Rgb;

SELECT * FROM @T1;

SELECT Name, Rgb, Score FROM @T1 AS T1
UNPIVOT (Score FOR Name IN (Alpha, Beta, Gamma)) AS T2;
GO

-- Unpivot
DECLARE @T2 table
(
 Name nvarchar(max),
 Blue nvarchar(max),
 Green nvarchar(max),
 Red nvarchar(max)
);

INSERT @T2
SELECT Name, Blue, Green, Red FROM
(SELECT Name, Rgb, Score FROM #T1) AS T1
PIVOT (SUM(Score) FOR Rgb IN (Blue, Green, Red)) AS T2
ORDER BY T2.Name;

SELECT * FROM @T2;

SELECT Name, Rgb, Score FROM @T2 AS Table1
UNPIVOT (Score FOR Rgb IN (Blue, Green, Red)) AS Table2;
GO

/******************************************************************************/

-- procedures

/******************************************************************************/

-- sys.objects contains a row for each user-defined, schema-scoped object that is created within a database, including natively compiled scalar user-defined function.
-- sys.all_objects shows the UNION of all schema-scoped user-defined objects and system objects.
-- sys.procedures contains a row for each object that is a procedure of some kind, with sys.objects.type = P, X, RF, and PC.

-- P = SQL Stored Procedure
-- X = Extended Stored Procedure
-- RF = Replication-filter-procedure
-- PC = CLR Stored Procedure

SELECT * FROM sys.all_objects
WHERE ([type] = N'P' OR [type] = N'X' OR [type] = N'RF' OR [type] = N'PC')
ORDER BY [name];
GO

SELECT * FROM sys.all_objects
WHERE ([type] = N'P' OR [type] = N'X' OR [type] = N'RF' OR [type] = N'PC')
AND [is_ms_shipped] = 0
ORDER BY [name];
GO

SELECT QUOTENAME(SCHEMA_NAME(schema_id)) + '.' + QUOTENAME(name)
FROM   sys.all_objects
WHERE  (type = N'P' OR type = N'X' OR type = N'RF' OR type = N'PC')
--  Only User Defined Procedures
AND is_ms_shipped = 0
--  Only System Stored Procedures
-- AND is_ms_shipped = 1
ORDER BY name
GO

SELECT QUOTENAME(SCHEMA_NAME(schema_id)) + '.' + QUOTENAME(name)
FROM   sys.all_objects
WHERE type IN (N'P', N'X', N'PC')
--  Only User Defined Procedures
AND is_ms_shipped = 0
--  Only System Stored Procedures
-- AND is_ms_shipped = 1
ORDER BY name
GO

-- Extended stored procedures reside inside the master database
-- Extended stored procedures will be removed in a future version - Use CLR Integration instead
-- sp_addextendedproc can only be executed in the master database
-- Only members of the sysadmin fixed server role can execute sp_addextendedproc
-- Existing DLLs that were not registered with a complete path will not work after upgrading to SQL Server 2019 (15.x) - To correct the problem, use sp_dropextendedproc to unregister the DLL, and then reregister it with sp_addextendedproc, specifying the complete path

USE [master];
GO

-- IF EXISTS(SELECT name FROM sys.procedures WHERE name = N'xp_hello')
IF OBJECT_ID(N'xp_hello', N'X') IS NOT NULL
-- DROP PROCEDURE xp_hello;
EXECUTE sp_dropextendedproc 'xp_hello';
GO

sp_addextendedproc 'xp_hello', 'c:\xp_hello.dll';  
GO

GRANT EXECUTE
ON [xp_hello]
TO PUBLIC
GO

DECLARE @txt varchar(33);  
-- EXEC xp_hello @txt OUTPUT;
GO

sp_helpextendedproc;
GO

SELECT * FROM sys.extended_properties;
GO

SELECT *
FROM 
    sys.objects             O LEFT OUTER JOIN
    sys.extended_properties E ON O.object_id = E.major_id
WHERE
    O.name IS NOT NULL
    AND ISNULL(O.is_ms_shipped, 0) = 0
    AND ISNULL(E.name, '') <> 'microsoft_database_tools_support'
    AND O.type_desc = 'SQL_STORED_PROCEDURE'
ORDER BY O.name;
GO

-- IF EXISTS(SELECT name FROM sys.databases WHERE name = N'sampledb')
IF DB_ID (N'sampledb') IS NOT NULL
DROP DATABASE [sampledb];
GO

CREATE DATABASE sampledb;
GO

USE [sampledb];
GO

-- IF EXISTS(SELECT name FROM sys.tables WHERE name = N'greek')
IF OBJECT_ID (N'greek', N'U') IS NOT NULL
DROP TABLE [greek];
GO

CREATE TABLE greek
(
  id int IDENTITY(1,1),
  name nvarchar(max),
  rgb nvarchar(max),
  score int
);
GO

SELECT * FROM greek;
GO

INSERT INTO greek 
SELECT 'Alpha', 'Green', 85 UNION ALL
SELECT 'Beta', 'Green', 85 UNION ALL
SELECT 'Gamma', 'Green', 80 UNION ALL
SELECT 'Delta', 'Blue', 70 UNION ALL
SELECT 'Epsilon', 'Blue', 71 UNION ALL
SELECT 'Zeta', 'Blue', 72 UNION ALL
SELECT 'Eta', 'Blue', 73 UNION ALL
SELECT 'Theta', 'Blue', 74 UNION ALL
SELECT 'Iota', 'Red', 60 UNION ALL
SELECT 'Kappa', 'Red', 60 UNION ALL
SELECT 'Lambda', 'Red', 60 UNION ALL
SELECT 'Mu', 'Red', 65 UNION ALL
SELECT 'Nu', 'Green', 89 UNION ALL
SELECT 'Xi', 'Green', 87 UNION ALL
SELECT 'Omicron', 'Green', 89;
GO

SELECT * FROM greek;
GO

IF EXISTS(SELECT name FROM sys.procedures WHERE name = N'P1')
-- IF OBJECT_ID(N'P1', N'P') IS NOT NULL
DROP PROCEDURE P1;
GO

CREATE PROCEDURE P1
AS
SELECT * FROM greek ORDER BY id OFFSET 5 ROW FETCH NEXT 5 ROWS ONLY;
GO

EXECUTE P1;
GO

SELECT object_id FROM sys.procedures WHERE name = N'P1';
GO

SELECT * FROM sys.sql_modules WHERE object_id = (SELECT object_id FROM sys.procedures WHERE name = N'P1');
GO

SELECT * FROM sys.all_sql_modules WHERE object_id = (SELECT object_id FROM sys.procedures WHERE name = N'P1');
GO

SELECT sp.name, sp.object_id, sm.definition
FROM sys.procedures sp
JOIN sys.sql_modules sm
ON sp.object_id = sm.object_id;
GO

SELECT sp.name, sp.object_id, sa.definition
FROM sys.procedures sp
JOIN sys.all_sql_modules sa
ON sp.object_id = sa.object_id;
GO

IF EXISTS(SELECT name FROM sys.procedures WHERE name = N'Recursion')
-- IF OBJECT_ID(N'Recursion', N'P') IS NOT NULL
DROP PROCEDURE Recursion;
GO

CREATE PROCEDURE Recursion
(
  @Number int,
  @Result nvarchar(max) OUTPUT
)
AS
DECLARE @In int;
DECLARE @Out int;
IF @Number > 1
 BEGIN
  SELECT @In = @Number - 1;
  EXECUTE Recursion @In, @Out OUTPUT;
  SELECT @Result = @Number * @Out;
 END
ELSE IF @Number = 1 OR @Number = 0
 BEGIN
  SELECT @Result = 1;
 END
ELSE
 BEGIN
  SELECT @Result = 'Invalid input';
 END
RETURN
GO

DECLARE @In int;
DECLARE @Out nvarchar(max);
SET @In = -1;
EXECUTE Recursion @In, @Out OUTPUT;
SELECT @Out;
GO

IF EXISTS(SELECT name FROM sys.procedures WHERE name = N'Recursion')
-- IF OBJECT_ID(N'Recursion', N'P') IS NOT NULL
DROP PROCEDURE Recursion;
GO

CREATE PROCEDURE Recursion
(
  @Number int,
  @Result int OUTPUT
)
AS
DECLARE @In int;
DECLARE @Out int;
IF @Number = 1 OR @Number = 0
 BEGIN
  SELECT @Result = 1;
 END
ELSE
 BEGIN
  BEGIN TRY
   SELECT @In = @Number - 1;
   EXECUTE Recursion @In, @Out OUTPUT;
   SELECT @Result = @Number * @Out;
  END TRY
  BEGIN CATCH
   /* 
    SELECT 
	 ERROR_NUMBER() AS ErrorNumber  
     ,ERROR_SEVERITY() AS ErrorSeverity  
     ,ERROR_STATE() AS ErrorState  
     ,ERROR_PROCEDURE() AS ErrorProcedure  
     ,ERROR_LINE() AS ErrorLine  
     ,ERROR_MESSAGE() AS ErrorMessage;
   */
   THROW 51000, 'Invalid input.', 1; 
  END CATCH;
 END
RETURN
GO

DECLARE @In int;
DECLARE @Out int;
SET @In = 6;
EXECUTE Recursion @In, @Out OUTPUT;
SELECT @Out;
GO

IF EXISTS(SELECT name FROM sys.procedures WHERE name = N'Recursion')
-- IF OBJECT_ID(N'Recursion', N'P') IS NOT NULL
DROP PROCEDURE Recursion;
GO

CREATE PROCEDURE Recursion
(
  @Number sql_variant,
  @Result sql_variant OUTPUT
)
AS
DECLARE @In sql_variant;
DECLARE @Out sql_variant;
IF SQL_VARIANT_PROPERTY(@Number,'BaseType') = 'int'
 BEGIN
  IF @Number = 1 OR @Number = 0
  BEGIN
   SELECT @Result = 1;
  END
 ELSE
  BEGIN
   BEGIN TRY
    SELECT @In = CONVERT(int, @Number) - 1;
    EXECUTE Recursion @In, @Out OUTPUT;
    SELECT @Result = CONVERT(int, @Number) * CONVERT(int, @Out);
   END TRY
  BEGIN CATCH
   THROW 51000, 'Invalid input.', 1; 
  END CATCH;
  END
 END
ELSE
 BEGIN
  SELECT @Result = CONVERT(nvarchar, 'Positive interger required');
 END
RETURN
GO

DECLARE @In sql_variant;
DECLARE @Out sql_variant;
SET @In = 5
EXECUTE Recursion @In, @Out OUTPUT;
SELECT @Out;
GO

SELECT * 
FROM sys.parameters sp
INNER JOIN sys.objects so
ON sp.object_id = so.object_id
WHERE so.type IN ('P', 'X', 'RX', 'PC');
GO

/******************************************************************************/

-- rank

/******************************************************************************/

;WITH CTE(SetID, ID)
      AS (SELECT 1,1 UNION ALL
          SELECT 1,1 UNION ALL
          SELECT 1,1 UNION ALL
          SELECT 1,2)
SELECT *,
	   -- Numbers the output of a result set
	   -- Returns the sequential number of a row within a partition of a result set, starting at 1 for the first row in each partition
	   -- ROW_NUMBER numbers all rows sequentially (for example 1, 2, 3, 4, 5)
       ROW_NUMBER() OVER(PARTITION BY SetID ORDER BY ID) AS 'ROW_NUMBER',
       -- Returns the rank of each row within the partition of a result set
	   -- The rank of a row is one plus the number of ranks that come before the row in question
	   -- RANK provides the same numeric value for ties (for example 1, 2, 2, 4, 5)
       RANK() OVER(PARTITION BY SetID ORDER BY ID)       AS 'RANK',
	   -- This function returns the rank of each row within a result set partition, with no gaps in the ranking values
	   -- The rank of a specific row is one plus the number of distinct rank values that come before that specific row
       DENSE_RANK() OVER(PARTITION BY SetID ORDER BY ID) AS 'DENSE_RANK',
	   -- Distributes the rows in an ordered partition into a specified number of groups
	   -- The groups are numbered, starting at one
	   -- For each row, NTILE returns the number of the group to which the row belongs
	   NTILE(3) OVER(PARTITION BY SetID ORDER BY ID) AS 'NTILE'
FROM  CTE;


;WITH CTE(SetID, ID)
      AS (SELECT 1,1 UNION ALL
          SELECT 1,1 UNION ALL
          SELECT 1,1 UNION ALL
          SELECT 1,2)
SELECT *,
	   -- Numbers the output of a result set
	   -- Returns the sequential number of a row within a partition of a result set, starting at 1 for the first row in each partition
	   -- ROW_NUMBER numbers all rows sequentially (for example 1, 2, 3, 4, 5)
       ROW_NUMBER() OVER(PARTITION BY SetID ORDER BY ID DESC) AS 'ROW_NUMBER',
       -- Returns the rank of each row within the partition of a result set
	   -- The rank of a row is one plus the number of ranks that come before the row in question
	   -- RANK provides the same numeric value for ties (for example 1, 2, 2, 4, 5)
       RANK() OVER(PARTITION BY SetID ORDER BY ID DESC)       AS 'RANK',
	   -- This function returns the rank of each row within a result set partition, with no gaps in the ranking values
	   -- The rank of a specific row is one plus the number of distinct rank values that come before that specific row
       DENSE_RANK() OVER(PARTITION BY SetID ORDER BY ID DESC) AS 'DENSE_RANK',
	   -- Distributes the rows in an ordered partition into a specified number of groups
	   -- The groups are numbered, starting at one
	   -- For each row, NTILE returns the number of the group to which the row belongs
	   NTILE(3) OVER(PARTITION BY SetID ORDER BY ID DESC) AS 'NTILE'
FROM  CTE;


IF EXISTS(SELECT name FROM tempdb.sys.tables WHERE name LIKE '#T1%')
-- IF OBJECT_ID(N'tempdb.dbo.#T1', N'U') IS NOT NULL
DROP TABLE #T1;
GO

CREATE TABLE #T1
(
  id int IDENTITY(1,1),
  name nvarchar(max),
  rgb nvarchar(max),
  score int,
);
GO

SELECT * FROM #T1;
GO

INSERT INTO #T1 VALUES('Alpha', 'Green', 85);
INSERT INTO #T1 VALUES('Beta', 'Green', 85);
INSERT INTO #T1 VALUES('Gamma', 'Green', 80);
INSERT INTO #T1 VALUES('Delta', 'Blue', 70);
INSERT INTO #T1 VALUES('Epsilon', 'Blue', 71);
INSERT INTO #T1 VALUES('Zeta', 'Blue', 72);
INSERT INTO #T1 VALUES('Eta', 'Blue', 73);
INSERT INTO #T1 VALUES('Theta', 'Blue', 74);
INSERT INTO #T1 VALUES('Iota', 'Red', 60);
INSERT INTO #T1 VALUES('Kappa', 'Red', 60);
INSERT INTO #T1 VALUES('Lambda', 'Red', 60);
INSERT INTO #T1 VALUES('Mu', 'Red', 65);
INSERT INTO #T1 VALUES('Nu', 'Green', 89);
INSERT INTO #T1 VALUES('Xi', 'Green', 87);
INSERT INTO #T1 VALUES('Omicron', 'Green', 89);
GO

SELECT * FROM #T1;
GO


SELECT * FROM #T1 GROUP BY rgb, score, name, id;


SELECT id, name, rgb, score, AVG(score) OVER(PARTITION BY rgb) as 'average' FROM #T1;
SELECT id, name, rgb, score, COUNT(id) OVER(PARTITION BY rgb) as 'count' FROM #T1;

SELECT id, name, rgb, score, ROW_NUMBER() OVER(ORDER BY score) as 'row_no' FROM #T1;
SELECT id, name, rgb, score, ROW_NUMBER() OVER(PARTITION BY rgb ORDER BY score) as 'row_no' FROM #T1;

SELECT id, name, rgb, score, RANK() OVER(ORDER BY score) as 'rank' FROM #T1;
SELECT id, name, rgb, score, RANK() OVER(PARTITION BY rgb ORDER BY score) as 'rank' FROM #T1;

SELECT id, name, rgb, score, DENSE_RANK() OVER(ORDER BY score) as 'dense_rank' FROM #T1;
SELECT id, name, rgb, score, DENSE_RANK() OVER(PARTITION BY rgb ORDER BY score) as 'dense_rank' FROM #T1;

SELECT id, name, rgb, score, NTILE(4) OVER(ORDER BY score) as 'ntile' FROM #T1;
SELECT id, name, rgb, score, NTILE(4) OVER(PARTITION BY rgb ORDER BY score) as 'ntile' FROM #T1;

/******************************************************************************/

-- sql_variant

/******************************************************************************/
DECLARE @variant sql_variant;
SELECT @variant = GETDATE();
SELECT SQL_VARIANT_PROPERTY(@variant,'BaseType');

/******************************************************************************/

-- temp variables

/******************************************************************************/

USE [master];
GO

-- IF EXISTS(SELECT name FROM sys.databases WHERE name = N'sampledb')
IF DB_ID (N'sampledb') IS NOT NULL
DROP DATABASE [sampledb];
GO

CREATE DATABASE sampledb;
GO

USE [sampledb];
GO

-- IF EXISTS(SELECT name FROM sys.tables WHERE name = N'greek')
IF OBJECT_ID (N'greek', N'U') IS NOT NULL
DROP TABLE [greek];
GO

CREATE TABLE greek
(
  id int IDENTITY(1,1),
  name nvarchar(max),
  rgb nvarchar(max),
  score int
);
GO

SELECT * FROM greek;
GO

INSERT INTO greek 
SELECT 'Alpha', 'Green', 85 UNION ALL
SELECT 'Beta', 'Green', 85 UNION ALL
SELECT 'Gamma', 'Green', 80 UNION ALL
SELECT 'Delta', 'Blue', 70 UNION ALL
SELECT 'Epsilon', 'Blue', 71 UNION ALL
SELECT 'Zeta', 'Blue', 72 UNION ALL
SELECT 'Eta', 'Blue', 73 UNION ALL
SELECT 'Theta', 'Blue', 74 UNION ALL
SELECT 'Iota', 'Red', 60 UNION ALL
SELECT 'Kappa', 'Red', 60 UNION ALL
SELECT 'Lambda', 'Red', 60 UNION ALL
SELECT 'Mu', 'Red', 65 UNION ALL
SELECT 'Nu', 'Green', 89 UNION ALL
SELECT 'Xi', 'Green', 87 UNION ALL
SELECT 'Omicron', 'Green', 89;
GO

SELECT * FROM greek;
GO

DECLARE @test1 nvarchar(max);

SELECT @test1 = 'SELECT * FROM greek';

EXECUTE (@test1);
GO

DECLARE @test2 int;

SELECT @test2 = (SELECT COUNT(*) FROM greek);

SELECT (@test2);
GO

/******************************************************************************/

-- triggers

/******************************************************************************/

USE [master];
GO

-- IF EXISTS(SELECT name FROM sys.databases WHERE name = N'sampledb')
IF DB_ID (N'sampledb') IS NOT NULL
DROP DATABASE [sampledb];
GO

CREATE DATABASE sampledb;
GO

USE [sampledb];
GO

-- IF EXISTS(SELECT name FROM sys.tables WHERE name = N'greek')
IF OBJECT_ID (N'greek', N'U') IS NOT NULL
DROP TABLE [greek];
GO

CREATE TABLE greek
(
  id int IDENTITY(1,1),
  name nvarchar(max),
  rgb nvarchar(max),
  score int
);
GO

SELECT * FROM greek;
GO

INSERT INTO greek 
SELECT 'Alpha', 'Green', 85 UNION ALL
SELECT 'Beta', 'Green', 85 UNION ALL
SELECT 'Gamma', 'Green', 80 UNION ALL
SELECT 'Delta', 'Blue', 70 UNION ALL
SELECT 'Epsilon', 'Blue', 71 UNION ALL
SELECT 'Zeta', 'Blue', 72 UNION ALL
SELECT 'Eta', 'Blue', 73 UNION ALL
SELECT 'Theta', 'Blue', 74 UNION ALL
SELECT 'Iota', 'Red', 60 UNION ALL
SELECT 'Kappa', 'Red', 60 UNION ALL
SELECT 'Lambda', 'Red', 60 UNION ALL
SELECT 'Mu', 'Red', 65 UNION ALL
SELECT 'Nu', 'Green', 89 UNION ALL
SELECT 'Xi', 'Green', 87 UNION ALL
SELECT 'Omicron', 'Green', 89;
GO

SELECT * FROM greek;
GO

-- IF EXISTS(SELECT name FROM sys.tables WHERE name = N'result')
IF OBJECT_ID (N'result', N'U') IS NOT NULL
DROP TABLE [result];
GO

CREATE TABLE result
(
  id int IDENTITY(1,1),
  color nvarchar(max)
);
GO

SELECT * FROM result;
GO

-- sys.triggers contains a row for each object that is a trigger, with a type of TR or TA
-- DML trigger names are schema-scoped and, therefore, are visible in sys.objects
-- DDL trigger names are scoped by the parent entity and are only visible in this view
-- TR = SQL trigger
-- TA = Assembly (CLR-integration) trigger

IF EXISTS (SELECT * FROM sys.triggers WHERE name = 'TG1')
-- IF OBJECT_ID(N'TG1', N'TR') IS NOT NULL
DROP TRIGGER TG1;
GO

CREATE TRIGGER TG1
ON greek
--  FOR INSERT, UPDATE, DELETE
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    INSERT INTO result 
    SELECT DISTINCT (rgb) FROM greek;    
END
GO

INSERT INTO greek VALUES
('pi', 'White', 100);
GO

SELECT * FROM greek;
GO

SELECT * FROM result;
GO

/******************************************************************************/

-- Users and Roles

/******************************************************************************/

USE [master];
GO

CREATE LOGIN [samplelogin] WITH PASSWORD = '*************';
GO

-- DROP LOGIN [samplelogin];
-- GO


USE [master];
GO

IF EXISTS(SELECT name FROM sys.databases WHERE name = N'sampledb')
-- IF DB_ID (N'sampledb') IS NOT NULL
DROP DATABASE [sampledb];
GO

CREATE DATABASE sampledb;
GO

USE [sampledb];
GO


-- CREATE USER [sampleuser] WITHOUT LOGIN; 
-- GO
-- EXEC sp_addrolemember N'db_owner', N'sampleuser';
-- GO
-- DROP USER [sampleuser];
-- GO


-- CREATE USER [sampleuser] FOR LOGIN [samplelogin];  
-- GO 


IF NOT EXISTS (SELECT * FROM sys.database_principals WHERE name = N'sampleuser')
BEGIN
    CREATE USER [sampleuser] FOR LOGIN [samplelogin];
    EXEC sp_addrolemember N'db_owner', N'sampleuser';
END;
GO


SELECT DP1.name AS DatabaseRoleName,   
   isnull (DP2.name, 'No members') AS DatabaseUserName   
 FROM sys.database_role_members AS DRM  
 RIGHT OUTER JOIN sys.database_principals AS DP1  
   ON DRM.role_principal_id = DP1.principal_id  
 LEFT OUTER JOIN sys.database_principals AS DP2  
   ON DRM.member_principal_id = DP2.principal_id  
WHERE DP1.type = 'R'
ORDER BY DP1.name; 
GO


-- EXEC sp_addrolemember  @rolename='db_owner', @membername = 'sampleuser';  
-- EXEC sp_addrolemember 'db_owner', 'sampleuser';

SELECT DP1.name AS DatabaseRoleName,   
   isnull (DP2.name, 'No members') AS DatabaseUserName   
 FROM sys.database_role_members AS DRM  
 RIGHT OUTER JOIN sys.database_principals AS DP1  
   ON DRM.role_principal_id = DP1.principal_id  
 LEFT OUTER JOIN sys.database_principals AS DP2  
   ON DRM.member_principal_id = DP2.principal_id  
WHERE DP1.type = 'R'
ORDER BY DP1.name; 
GO


-- EXEC sp_droprolemember @rolename='db_owner', @membername = 'sampleuser';
EXEC sp_droprolemember 'db_owner', 'sampleuser';

SELECT DP1.name AS DatabaseRoleName,   
   isnull (DP2.name, 'No members') AS DatabaseUserName   
 FROM sys.database_role_members AS DRM  
 RIGHT OUTER JOIN sys.database_principals AS DP1  
   ON DRM.role_principal_id = DP1.principal_id  
 LEFT OUTER JOIN sys.database_principals AS DP2  
   ON DRM.member_principal_id = DP2.principal_id  
WHERE DP1.type = 'R'
ORDER BY DP1.name; 
GO


DROP USER [sampleuser];
GO


GRANT CONNECT TO guest;
GO

REVOKE CONNECT FROM guest;
GO


USE [master];
GO

DROP LOGIN [samplelogin];
GO

DROP DATABASE [sampledb];
GO

/******************************************************************************/

-- views

/******************************************************************************/

USE [master];
GO

-- IF EXISTS(SELECT name FROM sys.databases WHERE name = N'sampledb')
IF DB_ID (N'sampledb') IS NOT NULL
DROP DATABASE [sampledb];
GO

CREATE DATABASE sampledb;
GO

USE [sampledb];
GO

-- IF EXISTS(SELECT name FROM sys.tables WHERE name = N'greek')
IF OBJECT_ID (N'greek', N'U') IS NOT NULL
DROP TABLE [greek];
GO

CREATE TABLE greek
(
  id int IDENTITY(1,1),
  name nvarchar(max),
  rgb nvarchar(max),
  score int
);
GO

SELECT * FROM greek;
GO

INSERT INTO greek 
SELECT 'Alpha', 'Green', 85 UNION ALL
SELECT 'Beta', 'Green', 85 UNION ALL
SELECT 'Gamma', 'Green', 80 UNION ALL
SELECT 'Delta', 'Blue', 70 UNION ALL
SELECT 'Epsilon', 'Blue', 71 UNION ALL
SELECT 'Zeta', 'Blue', 72 UNION ALL
SELECT 'Eta', 'Blue', 73 UNION ALL
SELECT 'Theta', 'Blue', 74 UNION ALL
SELECT 'Iota', 'Red', 60 UNION ALL
SELECT 'Kappa', 'Red', 60 UNION ALL
SELECT 'Lambda', 'Red', 60 UNION ALL
SELECT 'Mu', 'Red', 65 UNION ALL
SELECT 'Nu', 'Green', 89 UNION ALL
SELECT 'Xi', 'Green', 87 UNION ALL
SELECT 'Omicron', 'Green', 89;
GO

SELECT * FROM greek;
GO

-- sys.views contains a row for each view object, with sys.objects.type = V
-- sys.all_views shows the UNION of all user-defined and system views

IF EXISTS(SELECT name FROM sys.views WHERE name = N'V1' and type = N'V')
-- IF OBJECT_ID(N'V1', N'V') IS NOT NULL
DROP VIEW V1;
GO

CREATE VIEW V1
AS
-- Cannot update the view "V1" because it or a view it references was created with WITH CHECK OPTION and its definition contains a TOP or OFFSET clause.
-- SELECT * FROM greek ORDER BY id OFFSET 5 ROW FETCH NEXT 5 ROWS ONLY
SELECT * FROM greek WHERE (score % 2 = 0)
WITH CHECK OPTION;
GO

SELECT * FROM V1;
GO

SELECT * FROM greek;
GO

DELETE FROM V1;
GO

SELECT * FROM V1;
GO

SELECT * FROM greek;
GO

INSERT INTO V1 
-- The attempted insert or update failed because the target view either specifies WITH CHECK OPTION or spans a view that specifies WITH CHECK OPTION and one or more rows resulting from the operation did not qualify under the CHECK OPTION constraint.
-- SELECT 'Pi', 'Red', 65 UNION ALL
-- SELECT 'Rho', 'Blue', 75 UNION ALL
-- SELECT 'Sigma', 'Green', 85 UNION ALL
SELECT 'Tau', 'Red', 60 UNION ALL
SELECT 'Upsilon', 'Blue', 70 UNION ALL
SELECT 'Phi', 'Green', 80;
GO

SELECT * FROM V1;
GO

SELECT * FROM greek;
GO

UPDATE V1
-- The attempted insert or update failed because the target view either specifies WITH CHECK OPTION or spans a view that specifies WITH CHECK OPTION and one or more rows resulting from the operation did not qualify under the CHECK OPTION constraint.
-- SET score = 85
SET score = 82
WHERE name = 'Phi' AND rgb = 'Green';
GO

SELECT * FROM V1;
GO

SELECT * FROM greek;
GO

-- Note
/*
IMPORTANT!
-- You cannot insert a row if the view references more than one base table.
-- You cannot delete a row if the view references more than one base table.
-- You can only update columns that belong to a single base table.
Updatable Views
-- You can modify the data of an underlying base table through a view, as long as the following conditions are true:
-- Any modifications, including UPDATE, INSERT, and DELETE statements, must reference columns from only one base table.
-- The columns being modified in the view must directly reference the underlying data in the table columns. The columns cannot be derived in any other way, such as through the following:
-- An aggregate function: AVG, COUNT, SUM, MIN, MAX, GROUPING, STDEV, STDEVP, VAR, and VARP.
-- A computation. The column cannot be computed from an expression that uses other columns. Columns that are formed by using the set operators UNION, UNION ALL, CROSSJOIN, EXCEPT, and INTERSECT amount to a computation and are also not updatable.
-- The columns being modified are not affected by GROUP BY, HAVING, or DISTINCT clauses.
-- TOP is not used anywhere in the select_statement of the view together with the WITH CHECK OPTION clause.
-- The previous restrictions apply to any subqueries in the FROM clause of the view, just as they apply to the view itself. Generally, the Database Engine must be able to unambiguously trace modifications from the view definition to one base table.
Permissions
-- Requires UPDATE, INSERT, or DELETE permissions on the target table, depending on the action being performed.
*/

USE [master];
GO

-- IF EXISTS(SELECT name FROM sys.databases WHERE name = N'sampledb')
IF DB_ID (N'sampledb') IS NOT NULL
DROP DATABASE [sampledb];
GO

CREATE DATABASE sampledb;
GO

USE [sampledb];
GO

-- IF EXISTS(SELECT name FROM sys.tables WHERE name = N'greek1')
IF OBJECT_ID (N'greek1', N'U') IS NOT NULL
DROP TABLE [greek1];
GO

CREATE TABLE greek1
(
  id int IDENTITY(1,1),
  name nvarchar(max),
  rgb nvarchar(max),
  score int
);
GO

-- IF EXISTS(SELECT name FROM sys.tables WHERE name = N'greek2')
IF OBJECT_ID (N'greek2', N'U') IS NOT NULL
DROP TABLE [greek2];
GO
CREATE TABLE greek2
(
  id int IDENTITY(1,1),
  name nvarchar(max),
  rgb nvarchar(max),
  score int
);
GO

SELECT * FROM greek1;
GO

INSERT INTO greek1 
SELECT 'Alpha', 'Green', 85 UNION ALL
SELECT 'Beta', 'Green', 85 UNION ALL
SELECT 'Gamma', 'Green', 80;
GO

SELECT * FROM greek1;
GO

INSERT INTO greek2 
SELECT 'Delta', 'Blue', 70 UNION ALL
SELECT 'Epsilon', 'Blue', 71 UNION ALL
SELECT 'Zeta', 'Blue', 72;
GO

SELECT * FROM greek2;
GO

-- sys.views contains a row for each view object, with sys.objects.type = V
-- sys.all_views shows the UNION of all user-defined and system views

IF EXISTS(SELECT name FROM sys.views WHERE name = N'V1' and type = N'V')
-- IF OBJECT_ID(N'V1', N'V') IS NOT NULL
DROP VIEW V1;
GO

CREATE VIEW V1
AS
-- Column names in each view or function must be unique.
SELECT 
g1.id id1, g1.name name1, g1.rgb rgb1, g1.score score1, 
g2.id id2, g2.name name2, g2.rgb rgb2, g2.score score2
FROM greek1 g1
LEFT JOIN greek2 g2 ON g1.id = g2.id;
GO

SELECT * FROM V1;
GO

SELECT * FROM greek1;
GO

SELECT * FROM greek2;
GO

-- View or function 'V1' is not updatable because the modification affects multiple base tables.
-- DELETE FROM V1;
-- DELETE FROM V1 WHERE name1 = 'Alpha'
-- GO

INSERT INTO V1 (name1, score1) VALUES ('psi', 0);
GO

SELECT * FROM V1;
GO

SELECT * FROM greek1;
GO

SELECT * FROM greek2;
GO

INSERT INTO V1 (rgb2) VALUES ('#000000');
GO

SELECT * FROM V1;
GO

SELECT * FROM greek1;
GO

SELECT * FROM greek2;
GO

UPDATE V1
-- View or function 'V1' is not updatable because the modification affects multiple base tables.
-- SET name1 = 'Omega', rgb1 = '#00FF00', score1 = 100, name2 = 'Chi', rgb2 = '#0000FF', score2 = 1
SET name1 = 'Omega', rgb1 = '#00FF00', score1 = 100
WHERE id1 = 1;
GO

SELECT * FROM V1;
GO

SELECT * FROM greek1;
GO

SELECT * FROM greek2;
GO

UPDATE V1
-- View or function 'V1' is not updatable because the modification affects multiple base tables.
-- SET name1 = 'Omega', rgb1 = '#00FF00', score1 = 100, name2 = 'Chi', rgb2 = '#0000FF', score2 = 1
SET name2 = 'Chi', rgb2 = '#0000FF', score2 = 1
WHERE id1 = 1;
GO

SELECT * FROM V1;
GO

SELECT * FROM greek1;
GO

SELECT * FROM greek2;
GO

/******************************************************************************/


-- Credit:
/*
https://microsoft.com/
*/