using System;

/*
% java --version
% java -cp "$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/H2-Maven-Jar/h2-1.4.193.jar" org.h2.tools.Console -baseDir $HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/H2-Base -properties $HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/H2-Base


# DLLList.txt
H2-Sign-with-Strong-Name/h2-1.4.193.dll
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


# Terminal New Window
% cd $HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS

% sudo gacutil -il DLLList.txt

% csc Sample.cs /reference:"$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/H2-Sign-with-Strong-Name/h2-1.4.193.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Beans.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Misc.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Util.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.XPath.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Charsets.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Naming.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.API.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Corba.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Remoting.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.Bind.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Core.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Security.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.Crypto.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.Runtime.JNI.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.AWT.WinForms.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Jdbc.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.SwingAWT.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.Parse.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Management.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Text.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.Transform.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Media.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Tools.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.WebServices.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.Reflection.dll;$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.Runtime.dll;"

% mono Sample.exe

% sudo gacutil -ul DLLListUninstall.txt
*/

// using System.Data.SqlClient;
// using MySql.Data.MySqlClient;
using java.sql;

class Sample
{
    static void Main()
    {
        Console.WriteLine($"Environment.Version: {Environment.Version}");
        Console.WriteLine($"System.Runtime.InteropServices.RuntimeInformation.FrameworkDescription: {System.Runtime.InteropServices.RuntimeInformation.FrameworkDescription}\n");

        // org.h2.Driver.load();        
        // Registering the H2 driver
        org.h2.Driver h2Driver = new org.h2.Driver();
        DriverManager.registerDriver(h2Driver);

        // Connection conn = DriverManager.getConnection("jdbc:h2:~test", "sa", "sa");
        // Connection conn = DriverManager.getConnection("jdbc:h2:~test", "sa", "");
        Connection conn = DriverManager.getConnection("jdbc:h2:tcp://localhost/sampledb", "sa", "");
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
$ ./ikvmc -target:winexe h2-1.4.193.jar # $HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/h2-1.4.193.exe 
$ ./h2-1.4.193
# [Windows Security Alert]
http://192.168.56.1:8082/login.jsp?jsessionid=a5fa2a1e0b7205dca92d1fd0483541c6

## H2 dll
$ ./ikvmc -target:library -version:1.4.193 h2-1.4.193.jar # $HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/h2-1.4.193.dll

## H2 Sign with Strong Name
$ cd "E:\Working\SQL\H2\CS\H2-Sign-with-Strong-Name"
$ cp "$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/h2-1.4.193.dll" "E:\Working\SQL\H2\CS\H2-Sign-with-Strong-Name"
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
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Beans.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Misc.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Util.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.XPath.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Charsets.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Naming.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.API.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Corba.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Remoting.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.Bind.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Core.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Security.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.Crypto.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.Runtime.JNI.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.AWT.WinForms.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Jdbc.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.SwingAWT.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.Parse.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Management.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Text.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.Transform.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Media.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Tools.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.WebServices.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.Reflection.dll
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.Runtime.dll

## GAC
C:\Windows\Microsoft.NET\assembly\GAC_MSIL

## csc Sample.cs
$ csc Sample.cs /reference:"E:\Working\SQL\H2\CS\H2-Sign-with-Strong-Name\h2-1.4.193.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Beans.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Misc.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Util.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.XPath.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Charsets.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Naming.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.API.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Corba.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Remoting.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.Bind.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Core.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Security.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.Crypto.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.Runtime.JNI.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.AWT.WinForms.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Jdbc.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.SwingAWT.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.Parse.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Management.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Text.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.Transform.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Media.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.Tools.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.OpenJDK.XML.WebServices.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.Reflection.dll;
$HOME/Desktop/GitHub/SQL-1/H2/macOSarm64/CS/IKVM.NET/ikvm-7.2.4630.5/bin/IKVM.Runtime.dll;"

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