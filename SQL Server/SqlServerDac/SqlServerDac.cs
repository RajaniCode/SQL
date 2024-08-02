using System;
// C:\Program Files (x86)\Microsoft Visual Studio\2019\Professional\Common7\IDE\Extensions\Microsoft\SQLDB\DAC\150\
// $ csc SqlServerDac.cs -r:Microsoft.SqlServer.Dac.dll
// > csc SqlServerDac.cs /r:Microsoft.SqlServer.Dac.dll
using Microsoft.SqlServer.Dac;

namespace SqlServerDac
{
    class Program
    {
        static void Main()
        {
            try
            {
                DacServices ds = new DacServices(@"Data Source=(localdb)\MSSQLLocalDB;Initial Catalog=northwind;User ID=sa;Password=$qlServer2016;");
                using (DacPackage dp = DacPackage.Load(@"D:\RajaniS Master Folder\SQL\SQL Server\SQL Server Sample Databases\SQL Server\DACPAC\northwind.dacpac"))
                {
                    ds.Deploy(dp, @"northwind", upgradeExisting: false, options: null, cancellationToken: null);
                }
            }
            catch (Exception ex)
            {
                var error = ex.ToString();
                Console.WriteLine(error);
                throw;
            }

            Console.WriteLine("Press any key to close this window . . .");
            Console.Read();
        }
    }
}
