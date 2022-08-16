// using static System.Console;
using System;
using System.Configuration;
// nuget install MySql.Data
// csc MySQLSpIn.cs /reference:"E:\Working\SQL\MySQL\CS\MySql.Data.6.9.9\lib\net45\MySql.Data.dll"
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
	    // return "Persist Security Info=False;Data Source=localhost;Port=3306;User ID=root;Password=My$ql@Server#5.7;Initial Catalog=classicmodels;";
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
                    using (MySqlDataReader reader = command.ExecuteReader())
                    {   
                        DataTable schemaTable = reader.GetSchemaTable();
                        int rowCountSchema = schemaTable.Rows.Count;
                        Console.WriteLine("Number of row(s) in Schema Table = " + rowCountSchema);
                        foreach (DataRowView datRowView in schemaTable.DefaultView)
                        {
                            var columnName = datRowView["ColumnName"] as string;
                            var dataType = datRowView["DataType"] as System.Type;
                            Console.WriteLine("ColumnName: {0}, DataType: {1}", columnName, dataType);
                            schemaTable.Columns.Add(columnName, dataType);                          
                        }
                       
                        datTable = schemaTable.Clone();
                        int rowCountData = datTable.Rows.Count;
                        Console.WriteLine("Number of row(s) in Data Table = " + rowCountData); 
            
                        int rowCountReader = 0;
                        Console.WriteLine("reader.FieldCount = " + reader.FieldCount);
                        // Console.WriteLine("reader.Depth = " + reader.Depth); // Not Implemented in MySqlDataReader as yet
                        Console.WriteLine("reader.RecordsAffected = " + reader.RecordsAffected);

                        while (reader.HasRows)
			{   
                            DataRow datRow;
                            if (reader.RecordsAffected >= 0)
                            {
                                var result = reader.Read();
                                Console.WriteLine("Result = " + result);
                                datRow = datTable.NewRow(); 
                                for(int j = 0; j < reader.FieldCount; j++)
                                {
                                    //Console.WriteLine(j);
                                    //Console.WriteLine(reader[j]);
                                    //Console.WriteLine(reader.GetName(j));
                                    //Console.WriteLine(reader[j].GetType());
                                    datRow[reader.GetName(j)] = reader[j];                                                                      
                                }
                                datTable.Rows.Add(datRow);
                                rowCountReader++;
                                reader.NextResult();
                            }
                            else if (reader.RecordsAffected == -1)
                            {
                                while (reader.Read())
                                {
                                    datRow = datTable.NewRow(); 
                                    for(int j = 0; j < reader.FieldCount; j++)
                                    {
                                        //Console.WriteLine(j);
                                        //Console.WriteLine(reader[j]);
                                        //Console.WriteLine(reader.GetName(j));
                                        //Console.WriteLine(reader[j].GetType());
                                        datRow[reader.GetName(j)] = reader[j];                                                                            
                                    }
                                    datTable.Rows.Add(datRow);
                                    rowCountReader++;                                    
                                }
                                reader.NextResult();
                            }                                      
                        }

                        Console.WriteLine("Number of row(s) in reader = " + rowCountReader);
                        rowCountData = datTable.Rows.Count;
                        Console.WriteLine("Number of row(s) in Data Table = " + rowCountData); 
                        return datTable;
                    }                
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
	//dao.TestConnection();

        MySqlCommand commandMySql = new MySqlCommand();
        
        commandMySql.CommandText = "spin";
        commandMySql.CommandType = CommandType.StoredProcedure;
 
        MySqlParameter parameterMySql = new MySqlParameter();
                    
        parameterMySql.ParameterName = "@n";
        parameterMySql.MySqlDbType = MySqlDbType.Int32;
        parameterMySql.Direction = ParameterDirection.Input;
        parameterMySql.Value = 2;
        commandMySql.Parameters.Add(parameterMySql);

        DataTable datTable = dao.GetData(commandMySql);
        
        int rowCount = datTable.Rows.Count;
        //DataRow[] datRows = datTable.Select();
        Console.WriteLine("Number of Row(s) = " + rowCount);
        if (rowCount > 0)
	{           
            foreach(DataRow datRow in datTable.Rows) 
            {
	        foreach(DataColumn datColumn in datTable.Columns) 
		{  
                    if(datRow[datColumn] != null && datRow[datColumn].ToString().Trim() != String.Empty) 
                    {
                        Console.WriteLine(datColumn.ColumnName + ": " + datRow[datColumn]);
                    }
		}
                Console.WriteLine();
            }
	}

    } 
}


/*
USE classicmodels;
DROP PROCEDURE IF EXISTS sp;
DELIMITER $$
CREATE PROCEDURE sp
(
 IN cust_no INT,
 OUT shipped INT,
 OUT canceled INT,
 OUT resolved INT,
 OUT disputed INT
)
BEGIN
 -- shipped
 SELECT
  count(*) INTO shipped
 FROM
  orders
 WHERE
  customerNumber = cust_no
 AND 
  status = 'Shipped';
 
 -- canceled
 SELECT
  count(*) INTO canceled
 FROM
  orders
 WHERE
  customerNumber = cust_no
 AND 
  status = 'Canceled';
 
 -- resolved
 SELECT
  count(*) INTO resolved
 FROM
  orders
 WHERE
  customerNumber = cust_no
 AND 
  status = 'Resolved';
 
 -- disputed
 SELECT
  count(*) INTO disputed
 FROM
  orders
 WHERE
  customerNumber = cust_no
 AND 
  status = 'Disputed';
END;$$
DELIMITER ; 

USE classicmodels;
CALL sp(141, @shipped, @canceled, @resolved, @disputed);
SELECT @shipped, @canceled, @resolved, @disputed;


USE classicmodels;
DROP PROCEDURE IF EXISTS spin;
DELIMITER $$
CREATE PROCEDURE spin
(
 IN n INT
) 
BEGIN
 # SELECT * FROM customers LIMIT n;
 SELECT customerNumber, customerName, contactLastName, contactFirstName, phone, addressLine1, addressLine2, city, state, postalCode, country, salesRepEmployeeNumber, creditLimit FROM customers LIMIT n;
END;$$
DELIMITER ;

USE classicmodels;
CALL spin(2);


USE classicmodels;
DROP PROCEDURE IF EXISTS spinout;
DELIMITER $$
CREATE PROCEDURE spinout 
(
 IN in_customerNumber INT, OUT out_count INT
) 
BEGIN
 SELECT COUNT(*) INTO out_count  FROM customers WHERE customerNumber > in_customerNumber;
END; $$
DELIMITER ;

USE classicmodels;
CALL spinout(200, @out_count);
SELECT @out_count;


USE classicmodels;
DROP PROCEDURE IF EXISTS spinputoutput;
DELIMITER $$
CREATE PROCEDURE spinputoutput
(
 in  p_customerNumber int(11), 
 inout p_customerLevel  varchar(10) # Note # out p_customerLevel  varchar(10)
)
BEGIN
 DECLARE creditlim double; 
 SELECT 
  creditlimit INTO creditlim
 FROM 
  customers
 WHERE 
  customerNumber = p_customerNumber; 
 IF creditlim > 50000 THEN
  SET p_customerLevel = 'PLATINUM';
 ELSEIF (creditlim <= 50000 AND creditlim >= 10000) THEN
  SET p_customerLevel = 'GOLD';
 ELSEIF creditlim < 10000 THEN
  SET p_customerLevel = 'SILVER';
 END IF; 
END; $$
DELIMITER ;

USE classicmodels;
CALL spinputoutput(103, @level);
SELECT @level AS level;
*/