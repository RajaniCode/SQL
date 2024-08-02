// java -cp "E:\Working\SQL\SQL-Server\Java\SQL-Server-JDBC\sqljdbc_6.0.7728.100_enu\sqljdbc_6.0\enu\sqljdbc42.jar;.;" SQLServerConnection
// OR
// export CLASSPATH="E:\Working\SQL\SQL-Server\Java\SQL-Server-JDBC\sqljdbc_6.0.7728.100_enu\sqljdbc_6.0\enu\sqljdbc42.jar;.;"
// echo $CLASSPATH
// OR
// set CLASSPATH=E:\Working\SQL\SQL-Server\Java\SQL-Server-JDBC\sqljdbc_6.0.7728.100_enu\sqljdbc_6.0\enu\sqljdbc42.jar;.;
// echo %CLASSPATH%

// import static java.lang.System.out;

import java.io.InputStream;
import java.io.IOException;
import java.io.FileInputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
// import java.sql.Statement;
// import java.sql.ResultSet;
//import java.sql.ResultSetMetaData;
import java.util.Properties;
// import java.util.List;
// import java.util.ArrayList;
// import java.util.Map;
// import java.util.HashMap;
// import java.util.Map.Entry;
// import java.lang.StringBuilder;

class DataAccessObject {
    //private final String url = "jdbc:sqlserver://localhost:1433;databaseName=sampledb;user=sa;password=$ql@Server#2016";
    //private final String url = "jdbc:sqlserver://localhost:1433;databaseName=sampledb";
    //private final String user = "sa";
    //private final String password = "$ql@Server#2016"; 
    
    private Connection getConnection() throws SQLException {
        Connection conn = null;
        try  {
             InputStream input = new FileInputStream("config.properties");
             Properties connectionProps = new Properties();
             connectionProps.load(input);
             String url = connectionProps.getProperty("url"); //        
             String user = connectionProps.getProperty("user"); //
             String password = connectionProps.getProperty("password"); //
             // conn = DriverManager.getConnection(url); //
             conn = DriverManager.getConnection(url, user, password); //              
        } catch (IOException e) {
             e.printStackTrace();
        }
        return conn;
    }

    public void testConnection() {
        try (Connection conn = getConnection();) {
            System.out.println("Connected to SQL Server successfully.");   
        } catch (SQLException e) {
            e.printStackTrace();
        }
    } 
}

class SQLServerConnection { 
    public static void main(String args[]) {                
        DataAccessObject dao = new DataAccessObject();             
        dao.testConnection();        
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


// SQL Server Configuration

Open SQL Server Configuration Manager, and then expand SQL Server 2012 Network Configuration.

Click Protocols for InstanceName, and then make sure TCP/IP is enabled in the right panel and double-click TCP/IP.

On the Protocol tab, notice the value of the Listen All item.

Click the IP Addresses tab: If the value of Listen All is yes, the TCP/IP port number for this instance of SQL Server is the value of the TCP Dynamic Ports item under IPAll. 
If the value of Listen All is no, the TCP/IP port number for this instance of SQL Server is the value of the TCP Dynamic Ports item for a specific IP address.
Make sure the TCP Port is 1433.

Click OK.

SQL Server Configuration Manager -> "SQL Server Services" right-click on "SQL Server" and choose "Restart".
*/