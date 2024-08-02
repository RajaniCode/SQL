// using static System.Console;
using System;
using System.Configuration;
// nuget install MySql.Data
// csc MySQL.cs /reference:"E:\Working\SQL\MySQL\CS\MySql.Data.6.9.9\lib\net45\MySql.Data.dll"
// using System.Data.SqlClient;
using MySql.Data.MySqlClient;
using System.Data;
using System.Text;

class DataAccessObject
{
    private string ConnectionString
    {
        get
        {
            // Optional // Port=3306;
	    // return "Persist Security Info=False;Data Source=localhost;Port=3306;User ID=root;Password=My$ql@Server#5.7;Initial Catalog=sampledb;";
            ConnectionStringSettingsCollection connectionStringSettings = ConfigurationManager.ConnectionStrings;
            // connectionStringSettings["ConnectionStringName"].ProviderName;
            return connectionStringSettings["ConnectionStringName"].ConnectionString;            
        }
    }

    public void TestConnection()
    {
	using (MySqlConnection connectionMySql = new MySqlConnection(ConnectionString))
	{
	   connectionMySql.Open();
	   Console.WriteLine("Connected to MySQL Server successfully.");              
	}
    }

    public DataTable GetData(MySqlCommand commandMySql)
    {
        DataTable datTable = null;
        try
        {
            using (MySqlConnection connectionMySql = new MySqlConnection(ConnectionString))
            {
                using (MySqlCommand command = commandMySql)
                {
                    command.Connection = connectionMySql;
                    command.Connection.Open();
                    Console.WriteLine("Connected to MySQL Server successfully.");
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
        //selectQuery.Append("Select * FROM users;");
        selectQuery.Append("SELECT id, username, login_date, login_time, created_at, updated_at FROM users;");
        MySqlCommand commandMySql = new MySqlCommand(selectQuery.ToString());
        DataTable datTable = dao.GetData(commandMySql);
        
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
DROP DATABASE IF EXISTS `sampledb`;
CREATE DATABASE `sampledb`;

USE `sampledb`;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`
(
    `id` INT NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(50) NOT NULL, 
    `login_date` DATE NOT NULL,
    `login_time` TIME NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,    
    CONSTRAINT `pk_id` PRIMARY KEY(`id`),
    CONSTRAINT `idx_username` UNIQUE(`username`)    
);

SELECT * FROM users;

INSERT INTO users(username, login_date, login_time, created_at, updated_at)
VALUES('Foo', '2016-11-06', '10:49:35', '2016-11-06 10:49:35.0', '2016-11-06 10:49:35.0');

SELECT * FROM users;
*/