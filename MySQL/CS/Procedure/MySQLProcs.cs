// using static System.Console;
using System;
using System.Configuration;
// nuget install MySql.Data
// csc MySQLProcs.cs /reference:"E:\Working\SQL\MySQL\CS\MySql.Data.6.9.9\lib\net45\MySql.Data.dll"
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
	    // return "Persist Security Info=False;Data Source=localhost;Port=3306;User ID=root;Password=My$ql@Server#5.7;Initial Catalog=procdb;";
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
    private MySqlCommand GetMultiplyCommand()
    {
        MySqlCommand commandMySql = null; 
        try
        {   
            commandMySql = new MySqlCommand();
            
            commandMySql.CommandText = "multiply";
            commandMySql.CommandType = CommandType.StoredProcedure;
 
            MySqlParameter parameterMySql = new MySqlParameter();
                            
            parameterMySql.ParameterName = "@pFac1";
            parameterMySql.MySqlDbType = MySqlDbType.Int32;
            parameterMySql.Direction = ParameterDirection.Input;
            parameterMySql.Value = 5;
            commandMySql.Parameters.Add(parameterMySql);
         
            parameterMySql = new MySqlParameter();                            
            parameterMySql.ParameterName = "@pFac2";
            parameterMySql.MySqlDbType = MySqlDbType.Int32;
            parameterMySql.Direction = ParameterDirection.Input;
            parameterMySql.Value = 5;
            commandMySql.Parameters.Add(parameterMySql);

            parameterMySql = new MySqlParameter();
            parameterMySql.ParameterName = "@pProd";
            parameterMySql.MySqlDbType = MySqlDbType.Int32;
            parameterMySql.Direction = ParameterDirection.Output;
            parameterMySql.Value = "@pProd";
            commandMySql.Parameters.Add(parameterMySql);        
        }
        catch (MySqlException ex)
        {
            Console.WriteLine(ex.ToString());
        }
        return commandMySql;       
    }

    private MySqlCommand GetConcatCommand()
    {
        MySqlCommand commandMySql = null;
        try
        {   
            commandMySql= new MySqlCommand();
            
            commandMySql.CommandText = "concat";
            commandMySql.CommandType = CommandType.StoredProcedure;
 
            MySqlParameter parameterMySql = new MySqlParameter();
                            
            parameterMySql.ParameterName = "@pStr1";
            parameterMySql.MySqlDbType = MySqlDbType.VarChar;
            parameterMySql.Direction = ParameterDirection.Input;
            parameterMySql.Value = "My";
            commandMySql.Parameters.Add(parameterMySql);
         
            parameterMySql = new MySqlParameter();                            
            parameterMySql.ParameterName = "@pStr2";
            parameterMySql.MySqlDbType = MySqlDbType.VarChar;
            parameterMySql.Direction = ParameterDirection.Input;
            parameterMySql.Value = "SQL";
            commandMySql.Parameters.Add(parameterMySql);

            parameterMySql = new MySqlParameter();
            parameterMySql.ParameterName = "@pConCat";
            parameterMySql.MySqlDbType = MySqlDbType.VarChar;
            parameterMySql.Direction = ParameterDirection.Output;
            parameterMySql.Value = "@pConCat";
            commandMySql.Parameters.Add(parameterMySql);   
        }
        catch (MySqlException ex)
        {
            Console.WriteLine(ex.ToString());
        }
        return commandMySql;
    } 

    static void Main()
    { 
        DataAccessObject dao = new DataAccessObject();  
	//dao.TestConnection();
         
        Program pgrm = new Program();
        MySqlCommand commandMySql = pgrm.GetMultiplyCommand();       
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

        commandMySql = pgrm.GetConcatCommand(); 
        datTable = dao.GetData(commandMySql);
        
        rowCount = datTable.Rows.Count;
        //datRows = datTable.Select();
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
DROP DATABASE IF EXISTS procdb;
DELIMITER $$
CREATE DATABASE procdb;$$
DELIMITER ;


USE procdb;
DROP PROCEDURE IF EXISTS multiply;
DELIMITER $$
CREATE PROCEDURE multiply
(
 IN pFac1 INT, 
 IN pFac2 INT, 
 OUT pProd INT
)
BEGIN
  SET pProd := pFac1 * pFac2;
END;$$
DELIMITER ;

USE procdb;
CALL multiply(5, 5, @Result);
SELECT @Result;


USE procdb;
DROP PROCEDURE IF EXISTS concat;
DELIMITER $$
CREATE PROCEDURE concat
(
 IN pStr1 VARCHAR(20), 
 IN pStr2 VARCHAR(20),
 OUT pConCat VARCHAR(100)
)
BEGIN
  SET pConCat := CONCAT(pStr1, pStr2);
END;$$
DELIMITER ;

USE procdb;
CALL concat('My', 'SQL', @Result);
SELECT @Result;


USE procdb;
DROP PROCEDURE IF EXISTS prepend;
DELIMITER $$
CREATE PROCEDURE prepend
(
 IN inParam VARCHAR(255), 
 INOUT inOutParam INT
)
BEGIN
 DECLARE z INT;
 SET z = inOutParam + 1;
 SET inOutParam = z;
 SELECT inParam;
 SELECT CONCAT('zyxw', inParam);
END;$$
DELIMITER ;

USE procdb;
CALL prepend('abcdefg', @inOutParam);
*/