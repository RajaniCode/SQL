USE [master];
GO


--Set database to single-user mode that specifies only one user at a time can access the database
ALTER DATABASE [rbi-us-zts-selectvac] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO

--The database is closed, shut down cleanly, and marked offline. The database can't be modified while it's offline.
ALTER DATABASE [rbi-us-zts-selectvac] SET OFFLINE;
GO

--Move MDF and LDF --Also --Rename
EXEC xp_cmdshell 'MOVE "C:\Users\rajanis\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\rbi-us-zts-selectvac_Primary.mdf", "C:\Users\rajanis\rbi-us-zts-selectvac.mdf"';
GO

EXEC xp_cmdshell 'MOVE "C:\Users\rajanis\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\rbi-us-zts-selectvac_Primary.ldf", "C:\Users\rajanis\rbi-us-zts-selectvac_log.ldf"';
GO


--Modify physical_name
ALTER DATABASE [rbi-us-zts-selectvac] MODIFY FILE (NAME = 'rbi-us-zts-selectvac', FILENAME = 'C:\Users\rajanis\rbi-us-zts-selectvac.mdf')
GO

ALTER DATABASE [rbi-us-zts-selectvac] MODIFY FILE (NAME = 'rbi-us-zts-selectvac_log', FILENAME='C:\Users\rajanis\rbi-us-zts-selectvac_log.ldf')
GO

--Rename MDF and LDF --Note --Rename in --Move MDF and LDF
/*
EXEC xp_cmdshell 'RENAME "C:\Users\rajanis\rbi-us-zts-selectvac.mdf", "rbi-us-zts-selectvac.mdf"';
GO

EXEC xp_cmdshell 'RENAME "C:\Users\rajanis\rbi-us-zts-selectvac_log.ldf", "rbi-us-zts-selectvac_log.ldf"';
GO
*/


--The database is open and available for use.
ALTER DATABASE [rbi-us-zts-selectvac] SET ONLINE;
GO

--Set database to multi-user mode
ALTER DATABASE [rbi-us-zts-selectvac] SET MULTI_USER;
GO


--Modify logical_file_name --NEWNAME should be different
/*
ALTER DATABASE [rbi-us-zts-selectvac] MODIFY FILE (NAME = 'rbi-us-zts-selectvac', NEWNAME = 'rbi-us-zts-selectvac');
GO

ALTER DATABASE [rbi-us-zts-selectvac] MODIFY FILE (NAME = 'rbi-us-zts-selectvac_log', NEWNAME = 'rbi-us-zts-selectvac_log');
GO
*/

IF EXISTS(SELECT name FROM sys.databases WHERE name = N'rbi-us-zts-selectvac')
ALTER DATABASE [rbi-us-zts-selectvac] MODIFY NAME = [rbi-us-zts-selectvac];
GO

USE [rbi-us-zts-selectvac];
GO

SELECT file_id, name as [logical_file_name], physical_name FROM sys.database_files;
GO