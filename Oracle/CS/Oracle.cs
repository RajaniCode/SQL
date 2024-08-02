// using static System.Console;
using System;
using System.Configuration;
// nuget install Oracle.ManagedDataAccess
// gacutil -i "E:\Working\SQL\Oracle\CS\Oracle.ManagedDataAccess.12.1.24160719\lib\net40\Oracle.ManagedDataAccess.dll"
// Note
// C:\Windows\Microsoft.NET\assembly\GAC_MSIL\Oracle.ManagedDataAccess\v4.0_4.121.2.0__89b483f429c47342\Oracle.ManagedDataAccess.dll
// csc Oracle.cs /reference:"E:\Working\SQL\Oracle\CS\Oracle.ManagedDataAccess.12.1.24160719\lib\net40\Oracle.ManagedDataAccess.dll"
// using System.Data.SqlClient;
// using MySql.Data.MySqlClient;
// using Devart.Data.PostgreSql;
using Oracle.ManagedDataAccess.Client;
// using Oracle.ManagedDataAccess.Types;
using System.Data;
using System.Text;

class DataAccessObject
{
    private string ConnectionString
    {
        get
        {
            // Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=localhost)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=orcl)))
            // Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=127.0.0.1)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=orcl)))
            // Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=localhost)(PORT=1521))(CONNECT_DATA=(SERVER = DEDICATED)(SERVICE_NAME=orcl)))
            // Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=127.0.0.1)(PORT=1521))(CONNECT_DATA=(SERVER = DEDICATED)(SERVICE_NAME=orcl)))
	    // return "Persist Security Info=False;Data Source=(DESCRIPTION=(ADDRESS=(PROTOCOL=tcp)(HOST=localhost)(PORT=1521))(CONNECT_DATA=(SERVICE_NAME=orcl)));User ID=SYSTEM;Password=Oracle12cSE2;";
            ConnectionStringSettingsCollection connectionStringSettings = ConfigurationManager.ConnectionStrings;
            // connectionStringSettings["ConnectionStringName"].ProviderName;
            return connectionStringSettings["ConnectionStringName"].ConnectionString;            
        }
    }

    public void TestConnection()
    {
	using (OracleConnection connectionOracle = new OracleConnection(ConnectionString))
	{
	   connectionOracle.Open();
	   Console.WriteLine("Connected to Oracle Server successfully.");              
	}
    }

    public DataTable GetData(OracleCommand commandOracle)
    {
        DataTable datTable = null;
        try
        {
            using (OracleConnection connectionOracle = new OracleConnection(ConnectionString))
            {
                using (OracleCommand command = commandOracle)
                {
                    command.Connection = connectionOracle;
                    command.Connection.Open();
                    Console.WriteLine("Connected to Oracle Server successfully.");
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
        // selectQuery.Append("Select * FROM users"); // Note // No semicolon in query
        selectQuery.Append("SELECT id, username, login_date, login_time, created_at, updated_at FROM users"); // Note // No semicolon in query
        OracleCommand commandOracle = new OracleCommand(selectQuery.ToString());
        DataTable datTable = dao.GetData(commandOracle);
        
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
$ sqlplus SYSTEM/Oracle12cSE2
$ sqlplus SYSTEM/Oracle12cSE2@orcl
$ sqlplus SYSTEM/Oracle12cSE2@localhost:1521/orcl

DROP SEQUENCE seq_id;

CREATE SEQUENCE seq_id
MINVALUE 1
START WITH 1
INCREMENT BY 1
CACHE 10;

DROP TABLE users;

CREATE TABLE users
(
    id INT NOT NULL,
    username VARCHAR(50) NOT NULL, 
    login_date DATE NOT NULL,
    login_time VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    
    CONSTRAINT pk_id PRIMARY KEY(id),
    CONSTRAINT idx_username UNIQUE(username)    
);

COMMIT;

INSERT INTO users(id, username, login_date, login_time, created_at, updated_at)
VALUES
(
seq_id.nextval,
'Foo', 
TO_DATE('2016-11-06', 'YYYY-MM-DD'), 
TO_CHAR(TO_DATE('2016-11-06 10:49:35', 'YYYY-MM-DD HH:MI:SS'),'HH24:MI:SS'), 
TO_TIMESTAMP('2016-11-06 10:49:35.0', 'YYYY-MM-DD HH:MI:SS.FF'), 
TO_TIMESTAMP('2016-11-06 10:49:35.0', 'YYYY-MM-DD HH:MI:SS.FF')
);

COMMIT;

SELECT * FROM users;
*/