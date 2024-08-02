using System;
using System.Collections.Generic;
using System.Text;
using System.Configuration;

/*
% cd $HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/hsqldb
% java --version
% java -cp $HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/HSQLDB-JDBC/hsqldb.jar org.hsqldb.Server -database.0 file:xdb -dbname.0 sampledb


# DLLList.txt
HSQLDB-Sign-with-Strong-Name/hsqldb.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Beans.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Misc.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Util.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.XPath.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Charsets.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Naming.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.API.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Corba.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Remoting.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.Bind.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Core.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Security.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.Crypto.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.Runtime.JNI.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.AWT.WinForms.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Jdbc.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.SwingAWT.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.Parse.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Management.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Text.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.Transform.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Media.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Tools.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.WebServices.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.Reflection.dll
IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.Runtime.dll


# DLLListUninstall.txt
hsqldb
IKVM.OpenJDK.Beans
IKVM.OpenJDK.Misc
IKVM.OpenJDK.Util
IKVM.OpenJDK.XML.XPath
IKVM.OpenJDK.Charsets
IKVM.OpenJDK.Naming
IKVM.OpenJDK.XML.API
IKVM.OpenJDK.Corba
IKVM.OpenJDK.Remoting
IKVM.OpenJDK.XML.Bind
IKVM.OpenJDK.Core
IKVM.OpenJDK.Security
IKVM.OpenJDK.XML.Crypto
IKVM.Runtime.JNI
IKVM.AWT.WinForms
IKVM.OpenJDK.Jdbc
IKVM.OpenJDK.SwingAWT
IKVM.OpenJDK.XML.Parse
IKVM.OpenJDK.Management
IKVM.OpenJDK.Text
IKVM.OpenJDK.XML.Transform
IKVM.OpenJDK.Media
IKVM.OpenJDK.Tools
IKVM.OpenJDK.XML.WebServices
IKVM.Reflection
IKVM.Runtime


# HSQLDBConnection.exe.config
<?xml version="1.0" encoding="utf-8" ?>
<configuration>
  <appSettings>
    <add key="url" value="jdbc:hsqldb:hsql://localhost/sampledb"/>
    <add key="user" value="SA"/>
    <add key="password" value=""/>
  </appSettings>
</configuration>


# Terminal New Window
% cd $HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS

% sudo gacutil -il DLLList.txt

% ls /Library/Frameworks/Mono.framework/Versions/6.12.0/lib/mono/gac

% csc HyperSQLonnection.cs /reference:"$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/HSQLDB-Sign-with-Strong-Name/hsqldb.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Beans.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Misc.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Util.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.XPath.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Charsets.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Naming.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.API.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Corba.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Remoting.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.Bind.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Core.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Security.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.Crypto.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.Runtime.JNI.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.AWT.WinForms.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Jdbc.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.SwingAWT.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.Parse.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Management.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Text.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.Transform.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Media.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Tools.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.WebServices.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.Reflection.dll;$HOME/Desktop/GitHub/SQL-1/HSQLDB/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.Runtime.dll;"

% mono HyperSQLonnection.exe

% sudo gacutil -ul DLLListUninstall.txt
*/


// using System.Data.SqlClient;
// using MySql.Data.MySqlClient;
using java.sql;
// using org.hsqldb;

class DataAccessObject
{
    // private const string url = "jdbc:hsqldb:hsql://localhost/sampledb";
    // private const string user = "SA";
    // private const string password = ""; 

    private Connection GetConnection() 
    {
        Connection conn = null;
        try 
        {
            string url = ConfigurationManager.AppSettings["url"];        
            string user = ConfigurationManager.AppSettings["user"]; 
            string password = ConfigurationManager.AppSettings["password"];
            // Registering the HSQLDB JDBC driver
            org.hsqldb.jdbc.JDBCDriver hsqldbJDBCDriver = new org.hsqldb.jdbc.JDBCDriver();
            DriverManager.registerDriver(hsqldbJDBCDriver);
            conn = DriverManager.getConnection(url, user, password); //
        } catch (ConfigurationErrorsException e) {
             Console.WriteLine(e.Message);
        }
        return conn;
    }

    public void TestConnection()
    {
        try 
        {            
            Connection conn = GetConnection();
            Console.WriteLine("Connected to HSQLDB successfully."); 
        }
        catch (SQLException e) 
        {
            e.printStackTrace();
        }    
    }
}

class HyperSQLonnection
{
    static void Main()
    {
        Console.WriteLine($"Environment.Version: {Environment.Version}");
        Console.WriteLine($"System.Runtime.InteropServices.RuntimeInformation.FrameworkDescription: {System.Runtime.InteropServices.RuntimeInformation.FrameworkDescription}\n");

        DataAccessObject dao = new DataAccessObject();
        dao.TestConnection();       
    }
}


/*

## HSQLDB # Start Server # Create Database # Create Table 
$ java -version
$ cd "E:\Working\SQL\HSQLDB\CS"
$ mkdir -p HSQLDB-JDBC
$ cp "E:\Working\SQL\HSQLDB\hsqldb-2.3.4\hsqldb\lib\hsqldb.jar" "E:\Working\SQL\HSQLDB\CS\HSQLDB-JDBC"
$ cp "E:\Working\SQL\HSQLDB\hsqldb-2.3.4\hsqldb\lib\sqltool.jar" "E:\Working\SQL\HSQLDB\CS\HSQLDB-JDBC"

$ cd "E:\Working\SQL\HSQLDB\CS"

1. HSQLDB-JDBC/sqltool.jar

2. HSQLDB-JDBC/hsqldb.jar

3. server.properties
server.database.0 = file:hsqldb/sampledb
server.dbname.0 = sampledb

4. hsqldb/sqltool.rc
$ mkdir -p hsqldb
$ cp sqltool.rc hsqldb/sqltool.rc
# hsqldb/sqltool.rc
...
# A personal, local, persistent database.
urlid personal
# url jdbc:hsqldb:file:${user.home}/db/personal;shutdown=true
url jdbc:hsqldb:hsql://localhost/sampledb;shutdown=true

5. Start Server
$ java -classpath HSQLDB-JDBC/hsqldb.jar org.hsqldb.server.Server
[Ctrl]+[C]

6. Create Database # Start Server after Database creation
$ java -classpath HSQLDB-JDBC/hsqldb.jar org.hsqldb.server.Server --database.0 file:hsqldb/sampledb --dbname.0 sampledb

# New Git Bash # cd
7. Create Table 
$ java -jar HSQLDB-JDBC/sqltool.jar --driver=org.hsqldb.jdbcDriver --rcFile hsqldb/sqltool.rc personal

/i hsqldb_table_users.sql

# OR

DROP TABLE IF EXISTS users;
CREATE TABLE users
(
    -- id INT IDENTITY NOT NULL,
    id INT  GENERATED BY DEFAULT AS IDENTITY (START WITH 101, INCREMENT BY 1),
    username VARCHAR(50) NOT NULL, 
    login_date DATE DEFAULT CURRENT_DATE,
    login_time TIME DEFAULT CURRENT_TIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT LOCALTIMESTAMP,    
    CONSTRAINT pk_id PRIMARY KEY(id),
    CONSTRAINT idx_username UNIQUE(username)    
);
COMMIT;

SELECT * FROM users;

INSERT INTO users(username, login_date, login_time, created_at, updated_at)
VALUES('Foo', '2016-11-06', '10:49:35', '2016-11-06 10:49:35.0', '2016-11-06 10:49:35.0');
COMMIT;

SELECT * FROM users;

\q

## HSQLDB ## HSQL Database Manager
$ cd "E:\Working\SQL\HSQLDB\CS\IKVM.NET"
$ unzip ikvmbin-7.2.4630.5.zip
$ cd "E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin"
$ ./ikvm
$ cp "E:\Working\SQL\HSQLDB\CS\HSQLDB-JDBC\hsqldb.jar" "E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin"
$ ./ikvm -jar hsqldb.jar
# HSQL Database Manager

## HSQLDB exe ## HSQL Database Manager
$ ./ikvmc -target:winexe hsqldb.jar # E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\hsqldb.exe 
$ ./hsqldb
# HSQL Database Manager

## HSQLDB dll
$ ./ikvmc -target:library -version:2.3.4 hsqldb.jar # E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\hsqldb.dll

## HSQLDB Sign with Strong Name
$ cd "E:\Working\SQL\HSQLDB\CS\HSQLDB-Sign-with-Strong-Name"
$ cp "E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\hsqldb.dll" "E:\Working\SQL\HSQLDB\CS\HSQLDB-Sign-with-Strong-Name"
$ sn -k keyPair.snk 
$ ildasm hsqldb.dll /out:hsqldb.il 
$ cmd
E:\Working\SQL\HSQLDB\CS\HSQLDB-Sign-with-Strong-Name>"C:\Windows\Microsoft.NET\Framework64\v4.0.30319\ilasm.exe" hsqldb.il /dll /key=keyPair.snk
E:\Working\SQL\HSQLDB\CS\HSQLDB-Sign-with-Strong-Name>exit
$ sn -v hsqldb.dll
# $ gacutil -i hsqldb.dll 

## gacutil -il HSQLDB and IKVM DLLs
$ cd "E:\Working\SQL\HSQLDB\CS"
$ gacutil -il DLLList.txt

# Note DLLList.txt file contains the following list of (1 HSQLDB and 26 IKVM) assemblies
E:\Working\SQL\HSQLDB\CS\HSQLDB-Sign-with-Strong-Name\hsqldb.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Beans.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Misc.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Util.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.XPath.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Charsets.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Naming.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.API.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Corba.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Remoting.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.Bind.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Core.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Security.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.Crypto.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.Runtime.JNI.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.AWT.WinForms.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Jdbc.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.SwingAWT.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.Parse.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Management.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Text.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.Transform.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Media.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Tools.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.WebServices.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.Reflection.dll
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.Runtime.dll

## GAC
C:\Windows\Microsoft.NET\assembly\GAC_MSIL

## csc HSQLDBConnection.cs
$ csc HSQLDB.cs /reference:"E:\Working\SQL\HSQLDB\CS\HSQLDB-Sign-with-Strong-Name\hsqldb.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Beans.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Misc.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Util.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.XPath.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Charsets.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Naming.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.API.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Corba.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Remoting.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.Bind.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Core.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Security.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.Crypto.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.Runtime.JNI.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.AWT.WinForms.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Jdbc.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.SwingAWT.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.Parse.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Management.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Text.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.Transform.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Media.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Tools.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.WebServices.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.Reflection.dll;
E:\Working\SQL\HSQLDB\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.Runtime.dll;"

$ ./HSQLDBConnection.exe

## gacutil -ul H2 and IKVM DLLs
$ gacutil -ul DLLListUninstall.txt

# Note 
# DLLListUninstall.txt file contains the following list of 1 h2 assembly name (hsqldb) and 26 IKVM assembly names  to be uninstalled from GAC
hsqldb
IKVM.OpenJDK.Beans
IKVM.OpenJDK.Misc
IKVM.OpenJDK.Util
IKVM.OpenJDK.XML.XPath
IKVM.OpenJDK.Charsets
IKVM.OpenJDK.Naming
IKVM.OpenJDK.XML.API
IKVM.OpenJDK.Corba
IKVM.OpenJDK.Remoting
IKVM.OpenJDK.XML.Bind
IKVM.OpenJDK.Core
IKVM.OpenJDK.Security
IKVM.OpenJDK.XML.Crypto
IKVM.Runtime.JNI
IKVM.AWT.WinForms
IKVM.OpenJDK.Jdbc
IKVM.OpenJDK.SwingAWT
IKVM.OpenJDK.XML.Parse
IKVM.OpenJDK.Management
IKVM.OpenJDK.Text
IKVM.OpenJDK.XML.Transform
IKVM.OpenJDK.Media
IKVM.OpenJDK.Tools
IKVM.OpenJDK.XML.WebServices
IKVM.Reflection
IKVM.Runtime
*/