// using static System.Console;
using System;
using System.Configuration;
// using System.Data.OleDb;
// using System.Data.SqlClient;
// nuget install System.Data.SQLite
// gacutil -i "E:\Working\SQL\SQLite\CS\System.Data.SQLite.Core.1.0.104.0\lib\net46\System.Data.SQLite.dll"
// cp -r "E:\Working\SQL\SQLite\CS\System.Data.SQLite.Core.1.0.104.0\build\net46\x64" "E:\Working\SQL\SQLite\CS"
// cp -r "E:\Working\SQL\SQLite\CS\System.Data.SQLite.Core.1.0.104.0\build\net46\x86" "E:\Working\SQL\SQLite\CS"
// Note
// C:\Windows\Microsoft.NET\assembly\GAC_MSIL\System.Data.SQLite\v4.0_1.0.104.0__db937bc2d44ff139\System.Data.SQLite.dll
// csc SQLiteConnection.cs /reference:"E:\Working\SQL\SQLite\CS\System.Data.SQLite.Core.1.0.104.0\lib\net46\System.Data.SQLite.dll;"
using System.Data.SQLite;
using System.Data;
using System.Text;

class DataAccessObject
{
    private string ConnectionString
    {
        get
        {  
            // return "Persist Security Info=False;Data Source=sampledb.sqlite3;";
	    ConnectionStringSettingsCollection connectionStringSettings = ConfigurationManager.ConnectionStrings;
            // connectionStringSettings["ConnectionStringName"].ProviderName;
	    return connectionStringSettings["ConnectionStringName"].ConnectionString; 
        }
    }

    public void TestConnection()
    {
	using (SQLiteConnection connectionSQLite = new SQLiteConnection(ConnectionString))
	{
	   connectionSQLite.Open();
	   Console.WriteLine("Connected to SQLite successfully.");              
	}
    }

}

class Program
{
    static void Main()
    { 
        DataAccessObject dao = new DataAccessObject();  
	dao.TestConnection();
    }    
}


/*
$ winpty sqlite3 sampledb.sqlite3
sqlite> .tables
sqlite> .exit

DROP TABLE IF EXISTS users;
CREATE TABLE users
(
    --id INTEGER NOT NULL,
    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    username VARCHAR(50) NOT NULL, 
    login_date DATE DEFAULT CURRENT_DATE,
    login_time TIME DEFAULT CURRENT_TIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT LOCALTIMESTAMP,    
    --CONSTRAINT pk_id PRIMARY KEY(id),
    CONSTRAINT idx_username UNIQUE(username)    
);

SELECT * FROM users;

INSERT INTO users(username, login_date, login_time, created_at, updated_at)
VALUES('Foo', '2016-11-06', '10:49:35', '2016-11-06 10:49:35.0', '2016-11-06 10:49:35.0');

SELECT * FROM users;

--INSERT INTO users
--VALUES(0, 'Bar', '2016-11-06', '10:49:35', '2016-11-06 10:49:35.0', '2016-11-06 10:49:35.0');

--SELECT * FROM users;

--SELECT ROWID,* FROM users WHERE ROWID > 0;
*/