using System;
using static System.Console;
// Need these to get definitions of common interfaces, and various connection objects for our test.
using System.Data;
using System.Data.SqlClient;
// csc Factory.cs /reference:"C:\Windows\Microsoft.NET\assembly\GAC_MSIL\MySql.Data\v4.0_6.9.9.0__c5687fc88969c44d\MySql.Data.dll"
using MySql.Data.MySqlClient;
using System.Data.OleDb;
using System.Data.Odbc;

namespace MyConnectionFactory
{
    // A list of possible providers.
    enum DataProvider { SqlServer, MySql, OleDb, Odbc, None }

    class Program
    {
        static void Main(string[] args)
        {
            WriteLine("**** Very Simple Connection Factory*****\n");
            // Get a specific connection.
            IDbConnection myConnection = GetConnection(DataProvider.MySql);
            WriteLine($"Your connection is a {myConnection.GetType().Name}");
            // Open, use and close connection...
            ReadLine();
        }

        // This method returns a specific connection object based on the value of a DataProvider enum.
        static IDbConnection GetConnection(DataProvider dataProvider)
        {
            IDbConnection connection = null;
            switch (dataProvider)
            {
                case DataProvider.SqlServer:
                    connection = new SqlConnection();
                    break;
                case DataProvider.MySql:
                    connection = new MySqlConnection();
                    break;
                case DataProvider.OleDb:
                    connection = new OleDbConnection();
                    break;
                case DataProvider.Odbc:
                    connection = new OdbcConnection();
                    break;
            }
            return connection;
        }
    }
}


/*

<configuration>
<appSettings>
<!-- This key value maps to one of our enum values. -->
<add key="provider" value="SqlServer"/>
</appSettings>
<startup>
<supportedRuntime version="v4.0"
sku=".NETFramework,Version=v4.6"/>
</startup>
</configuration>

*/

/*

        static void Main(string[] args)
        {
            WriteLine("**** Very Simple Connection Factory *****\n");
            // Read the provider key.
            string dataProviderString = ConfigurationManager.AppSettings["provider"];
            // Transform string to enum.
            DataProvider dataProvider = DataProvider.None;
            if (Enum.IsDefined(typeof (DataProvider), dataProviderString))
            {
                dataProvider = (DataProvider) Enum.Parse(typeof (DataProvider), dataProviderString);
            }
            else
            {
                WriteLine("Sorry, no provider exists!");
                ReadLine();
                return;
            }

            // Get a specific connection.
            IDbConnection myConnection = GetConnection(dataProvider);
            WriteLine($"Your connection is a {myConnection?.GetType().Name ?? "unrecognized type"}");
            // Open, use and close connection...
            ReadLine();
        }

*/