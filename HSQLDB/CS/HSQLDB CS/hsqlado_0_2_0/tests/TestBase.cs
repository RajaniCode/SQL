using System.Data;
using sf.net.hsqlado;

namespace tests
{
	public class TestBase
	{
		protected HsqlConnection connection = null;

		protected void Open()
		{
			connection = new HsqlConnection("user=SA;password=;database=testdb");
			connection.Open();
		}

		protected void Close()
		{
			connection.Close();
		}

		protected void CreateTempTable()
		{
			ExecuteSQL("DROP TABLE TEMP_TABLE IF EXISTS");
			ExecuteSQL("CREATE TABLE TEMP_TABLE ( ID int PRIMARY KEY, I int, F float, S varchar, B boolean, L bigint, DT date, T time)");
			ExecuteSQL("INSERT INTO TEMP_TABLE(ID,I,F,S,B,L,DT,T) VALUES(1, 11, 2.3, 'string1', true, 123456, '1999-08-22', '23:53:00')");
			ExecuteSQL("INSERT INTO TEMP_TABLE(ID,I,F,S,B,L,DT,T) VALUES(2, 22, 4.5, 'string2', true, 12233456, '2007-01-01', '02:34:00')");
			ExecuteSQL("INSERT INTO TEMP_TABLE(ID,I,F,S,B,L,DT,T) VALUES(3, 33, 6, 'string3', false, 12345446, '1970-01-01', '13:30:00')");
			ExecuteSQL("INSERT INTO TEMP_TABLE(ID,I,F,S,B,L,DT,T) VALUES(4, 44, 1, 'string4', true, 1234556, '1993-04-12', '21:01:06')");
		}

		protected void DropTempTable()
		{
			ExecuteSQL("DROP TABLE TEMP_TABLE IF EXISTS");
		}

		protected void ExecuteSQL(string sql)
		{
			IDbCommand command = connection.CreateCommand();
			command.CommandText = sql;
			command.ExecuteNonQuery();
		}
	}
}