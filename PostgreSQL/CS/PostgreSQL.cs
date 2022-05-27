// using static System.Console;
using System;
using System.Configuration;
// nuget install dotConnect.Express.for.PostgreSQL
// gacutil -i "E:\Working\SQL\PostgreSQL\CS\dotConnect.Express.for.PostgreSQL.7.6.763\lib\Devart.Data.dll"
// gacutil -i "E:\Working\SQL\PostgreSQL\CS\dotConnect.Express.for.PostgreSQL.7.6.763\lib\Devart.Data.PostgreSql.dll"
// Note
// C:\Windows\assembly\GAC_MSIL\Devart.Data\5.0.1555.0__09af7300eec23701
// C:\Windows\assembly\GAC_MSIL\Devart.Data.PostgreSql\7.6.763.0__09af7300eec23701
// csc PostgreSQL.cs /reference:"E:\Working\SQL\PostgreSQL\CS\dotConnect.Express.for.PostgreSQL.7.6.763\lib\Devart.Data.dll;E:\Working\SQL\PostgreSQL\CS\dotConnect.Express.for.PostgreSQL.7.6.763\lib\Devart.Data.PostgreSql.dll"
// using System.Data.SqlClient;
// using MySql.Data.MySqlClient;
using Devart.Data.PostgreSql;
using System.Data;
using System.Text;

class DataAccessObject
{
    private string ConnectionString
    {
        get
        {
	    // Optional Port=3306; 
	    // Unknown connection string parameter 'Initial Catalog'.
	    // Initial Catalog=sampledb; 
	    // Database=sampledb;
	    // return "Persist Security Info=False;Data Source=localhost;Port=5432;User ID=postgres;Password=P0stgre$ql@Server#9.5;Database=sampledb;";
            ConnectionStringSettingsCollection connectionStringSettings = ConfigurationManager.ConnectionStrings;
            // connectionStringSettings["ConnectionStringName"].ProviderName;
            return connectionStringSettings["ConnectionStringName"].ConnectionString;            
        }
    }

    public void TestConnection()
    {
	using (PgSqlConnection connectionPgSql = new PgSqlConnection(ConnectionString))
	{
	   connectionPgSql.Open();
	   Console.WriteLine("Connected to PostgreSQL Server successfully.");              
	}
    }

    public DataTable GetData(PgSqlCommand commandPgSql)
    {
        DataTable datTable = null;
        try
        {
            using (PgSqlConnection connectionPgSql = new PgSqlConnection(ConnectionString))
            {
                using (PgSqlCommand command = commandPgSql)
                {
                    command.Connection = connectionPgSql;
                    command.Connection.Open();
                    Console.WriteLine("Connected to PostgreSQL Server successfully.");
                    datTable = new DataTable();
                    datTable.Load(command.ExecuteReader());
                    int rowCount = datTable.Rows.Count;
                    // Console.WriteLine("Number of Row(s) = " + rowCount);
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
        PgSqlCommand commandPgSql = new PgSqlCommand(selectQuery.ToString());
        DataTable datTable = dao.GetData(commandPgSql);
        
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
DROP DATABASE IF EXISTS sampledb;

CREATE DATABASE sampledb;

-- \connect sampledb;

DROP TABLE IF EXISTS users;
CREATE TABLE users
(
    id SERIAL NOT NULL,
    username VARCHAR(50) NOT NULL, 
    login_date DATE NOT NULL DEFAULT CURRENT_DATE,
    login_time TIME NOT NULL DEFAULT CURRENT_TIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    
    CONSTRAINT pk_id PRIMARY KEY(id),
    CONSTRAINT idx_username UNIQUE(username)    
);

SELECT * FROM users;

INSERT INTO users(username, login_date, login_time, created_at, updated_at)
VALUES('Foo', '2016-11-06', '10:49:35', '2016-11-06 10:49:35.0', '2016-11-06 10:49:35.0');

SELECT * FROM users;
*/