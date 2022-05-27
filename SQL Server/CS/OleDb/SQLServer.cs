// using static System.Console;
using System;
using System.Configuration;
using System.Data.OleDb;
// using System.Data.SqlClient;
using System.Data;
using System.Text;

class DataAccessObject
{
    private string ConnectionString
    {
        get
        {  
            // return "Persist Security Info=False;Data Source=(local);User ID=sa;Password=$ql@Server#2016;Initial Catalog=sampledb;Provider=SQLOLEDB;";
	    ConnectionStringSettingsCollection connectionStringSettings = ConfigurationManager.ConnectionStrings;
            // connectionStringSettings["ConnectionStringName"].ProviderName;
	    return connectionStringSettings["ConnectionStringName"].ConnectionString; 
        }
    }

    public void TestConnection()
    {
	using (OleDbConnection connectionOleDb = new OleDbConnection(ConnectionString))
	{
	   connectionOleDb.Open();
	   Console.WriteLine("Connected to SQL Server successfully.");              
	}
    }

    public DataTable GetData(OleDbCommand commandOleDb)
    {
        DataTable datTable = null;
        try
        {
            using (OleDbConnection connectionOleDb = new OleDbConnection(ConnectionString))
            {
                using (OleDbCommand command = commandOleDb)
                {
                    command.Connection = connectionOleDb;
                    command.Connection.Open();
                    Console.WriteLine("Connected to SQL Server successfully.");
                    datTable = new DataTable();
                    datTable.Load(command.ExecuteReader());
                    int rowCount = datTable.Rows.Count;
                    //Console.WriteLine("Number of Row(s) = " + rowCount);
                    return datTable;
                }                
            }
        }
        finally 
        {
            datTable = null;
        }
    }
}

class Program
{
    static void Main()
    { 
        DataAccessObject dao = new DataAccessObject();  
	// dao.TestConnection();

        StringBuilder selectQuery = new StringBuilder();
        // selectQuery.Append("Select * FROM users;");
        selectQuery.Append("SELECT id, username, login_date, login_time, created_at, updated_at FROM users;");
        OleDbCommand commandOleDb = new OleDbCommand(selectQuery.ToString());
        DataTable datTable = dao.GetData(commandOleDb);
        
        int rowCount = datTable.Rows.Count;
        // DataRow[] datRows = datTable.Select();
        Console.WriteLine("Number of Row(s) = " + rowCount);
        if (rowCount > 0)
	{           
            foreach(DataRow datRow in datTable.Rows) 
            {
	        foreach(DataColumn datColumn in datTable.Columns) 
		{
                    Console.WriteLine(datColumn.ColumnName + ": " + datRow[datColumn]);
		}
                Console.WriteLine();
            }
	}
    }    
}


/*
$ SQLCMD -S "(local)" -U sa
Password: $ql@Server#2016

> SQLCMD -S (local) -U sa -P $ql@Server#2016

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

IF EXISTS(SELECT name FROM sys.tables WHERE name = N'users')
DROP TABLE [users];
GO

-- OR

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

INSERT INTO users(username, login_date, login_time, created_at, updated_at)
VALUES('Foo', '2016-11-06', '10:49:35', '2016-11-06 10:49:35.0', '2016-11-06 10:49:35.0');
GO

SELECT * FROM users;
GO
*/