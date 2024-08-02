// using static System.Console;
using System;

/*
$ cd "E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin"
$ ./h2-1.4.193

$ gacutil -il DLLList.txt

$ csc Sample.cs /reference:"E:\Working\SQL\H2\CS\H2-Sign-with-Strong-Name\h2-1.4.193.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Beans.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Misc.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Util.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.XPath.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Charsets.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Naming.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.API.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Corba.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Remoting.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.Bind.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Core.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Security.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.Crypto.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.Runtime.JNI.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.AWT.WinForms.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Jdbc.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.SwingAWT.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.Parse.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Management.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Text.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.Transform.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Media.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Tools.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.WebServices.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.Reflection.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.Runtime.dll;"

$ ./Sample.exe

$ gacutil -ul DLLListUninstall.txt
*/

// using System.Data.SqlClient;
// using MySql.Data.MySqlClient;
using java.sql;

class Sample
{
    static void Main()
    {
        // org.h2.Driver.load();        
        // Registering the H2 driver
        org.h2.Driver h2Driver = new org.h2.Driver();
        DriverManager.registerDriver(h2Driver);

        // Connection conn = DriverManager.getConnection("jdbc:h2:~test", "sa", "sa");
        // Connection conn = DriverManager.getConnection("jdbc:h2:~test", "sa", "");
        Connection conn = DriverManager.getConnection("jdbc:h2:tcp://192.168.56.1:9092/sampledb", "sa", "");
        Statement stat = conn.createStatement();
        ResultSet rs = stat.executeQuery("SELECT 'Hello World'");
        while (rs.next())
        {
            Console.WriteLine(rs.getString(1));
        }
    }
}

/*

## H2 ## Start Server
$ java -version
$ cd "E:\Working\SQL\H2\CS\IKVM.NET"
$ unzip ikvmbin-7.2.4630.5.zip
$ cd "E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin"
$ ./ikvm
$ cp "E:\Working\SQL\H2\H2\H2-Maven-Jar\h2-1.4.193.jar" "E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin"
$ ./ikvm -jar h2-1.4.193.jar
# [Windows Security Alert]
http://192.168.56.1:8082/login.jsp?jsessionid=93658a894b880f1b857a0e19cb1e745d

## H2 exe ## Start Server
$ ./ikvmc -target:winexe h2-1.4.193.jar # E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\h2-1.4.193.exe 
$ ./h2-1.4.193
# [Windows Security Alert]
http://192.168.56.1:8082/login.jsp?jsessionid=a5fa2a1e0b7205dca92d1fd0483541c6

## H2 dll
$ ./ikvmc -target:library -version:1.4.193 h2-1.4.193.jar # E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\h2-1.4.193.dll

## H2 Sign with Strong Name
$ cd "E:\Working\SQL\H2\CS\H2-Sign-with-Strong-Name"
$ cp "E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\h2-1.4.193.dll" "E:\Working\SQL\H2\CS\H2-Sign-with-Strong-Name"
$ sn -k keyPair.snk 
$ ildasm h2-1.4.193.dll /out:h2-1.4.193.il 
$ cmd
E:\Working\SQL\H2\CS\H2-Sign-with-Strong-Name>"C:\Windows\Microsoft.NET\Framework64\v4.0.30319\ilasm.exe" h2-1.4.193.il /dll /key=keyPair.snk
E:\Working\SQL\H2\CS\H2-Sign-with-Strong-Name>exit
$ sn -v h2-1.4.193.dll
# $ gacutil -i h2-1.4.193.dll 

## gacutil -il H2 and IKVM DLLs
$ cd "E:\Working\SQL\H2\CS"
$ gacutil -il DLLList.txt

# Note DLLList.txt file contains the following list of (1 H2 and 26 IKVM) assemblies
E:\Working\SQL\H2\CS\H2-Sign-with-Strong-Name\h2-1.4.193.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Beans.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Misc.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Util.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.XPath.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Charsets.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Naming.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.API.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Corba.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Remoting.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.Bind.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Core.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Security.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.Crypto.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.Runtime.JNI.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.AWT.WinForms.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Jdbc.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.SwingAWT.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.Parse.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Management.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Text.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.Transform.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Media.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Tools.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.WebServices.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.Reflection.dll
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.Runtime.dll

## GAC
C:\Windows\Microsoft.NET\assembly\GAC_MSIL

## csc Sample.cs
$ csc Sample.cs /reference:"E:\Working\SQL\H2\CS\H2-Sign-with-Strong-Name\h2-1.4.193.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Beans.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Misc.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Util.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.XPath.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Charsets.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Naming.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.API.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Corba.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Remoting.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.Bind.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Core.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Security.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.Crypto.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.Runtime.JNI.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.AWT.WinForms.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Jdbc.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.SwingAWT.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.Parse.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Management.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Text.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.Transform.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Media.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.Tools.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.OpenJDK.XML.WebServices.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.Reflection.dll;
E:\Working\SQL\H2\CS\IKVM.NET\ikvm-7.2.4630.5\bin\IKVM.Runtime.dll;"

$ ./Sample.exe

## gacutil -ul H2 and IKVM DLLs
$ gacutil -ul DLLListUninstall.txt

# Note 
# DLLListUninstall.txt file contains the following list of 1 h2 assembly name (h2-1.4.193) and 26 IKVM assembly names  to be uninstalled from GAC
h2-1.4.193
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