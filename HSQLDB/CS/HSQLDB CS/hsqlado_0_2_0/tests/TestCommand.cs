using System;
using System.Data;
using NUnit.Framework;
using sf.net.hsqlado;

namespace tests
{
	[TestFixture]
	public class TestCommand : TestBase
	{
		[TestFixtureSetUp]
		public void TestFixtureSetUp()
		{
			Open();
		}

		[TestFixtureTearDown]
		public void TestFixtureTearDown()
		{
			Close();
		}

		[Test]
		public void TestReadScalar()
		{
			CreateTempTable();

			object o;
			IDbCommand command = connection.CreateCommand();

			command.CommandText = "SELECT I FROM TEMP_TABLE WHERE ID=1";
			o = command.ExecuteScalar();
			Assert.IsTrue(Convert.ToInt32(o) == 11, o.ToString());

			command.CommandText = "SELECT S FROM TEMP_TABLE WHERE Id=2";
			o = command.ExecuteScalar();
			Assert.IsTrue(o.Equals("string2"), o.ToString());

			command.CommandText = "SELECT F FROM TEMP_TABLE WHERE Id=1";
			o = command.ExecuteScalar();
			Assert.IsTrue(Convert.ToDouble(o) == 2.3f, o.ToString());

			command.CommandText = "SELECT B FROM TEMP_TABLE WHERE Id=1";
			o = command.ExecuteScalar();
			Assert.IsTrue(Convert.ToBoolean(o) == true, o.ToString());

			command.CommandText = "SELECT L FROM TEMP_TABLE WHERE Id=1";
			o = command.ExecuteScalar();
			Assert.IsTrue(Convert.ToInt64(o) == 123456, o.ToString());

			command.CommandText = "SELECT DT FROM TEMP_TABLE WHERE Id=1";
			o = command.ExecuteScalar();
			Assert.IsTrue(Convert.ToDateTime(o) == new DateTime(1999,8,22), o.ToString());

			DropTempTable();
		}

		[Test]
		public void TestExecuteReader()
		{
			CreateTempTable();

			IDbCommand command = connection.CreateCommand();
			command.CommandText = "SELECT id FROM TEMP_TABLE";

			IDataReader reader = command.ExecuteReader();

			if (reader.Read())
			{
				Assert.IsTrue(reader.GetName(0).ToLower().Equals("id"));
				Assert.IsTrue(reader.GetOrdinal("id") == 0);
				Assert.IsTrue(reader.Depth > 1);
				Assert.IsTrue(reader.FieldCount == 1);
			}

			DropTempTable();
		}

		[Test]
		public void TestExecuteReaderSingleRow()
		{
			CreateTempTable();

			IDbCommand command = connection.CreateCommand();
			command.CommandText = "SELECT id FROM TEMP_TABLE";

			IDataReader reader = command.ExecuteReader(CommandBehavior.SingleRow);

			Assert.IsTrue(reader.Depth == 1);

			if (reader.Read())
			{
				Assert.IsTrue(reader.GetName(0).ToLower().Equals("id"));
				Assert.IsTrue(reader.GetOrdinal("id") == 0);
				Assert.IsTrue(reader.FieldCount == 1);
			}

			DropTempTable();
		}

		[Test]
		public void TestExecuteNoQuery()
		{
			CreateTempTable();

			IDbCommand command = connection.CreateCommand();
			command.CommandText = "DELETE FROM TEMP_TABLE";

			int i = command.ExecuteNonQuery();

			command.CommandText = "SELECT id FROM TEMP_TABLE";
			IDataReader reader = command.ExecuteReader();

			Assert.IsFalse(reader.Read());
			Assert.IsTrue(reader.RecordsAffected == 0);
			Assert.IsTrue(reader.Depth == 0);

			command.CommandText = "INSERT INTO TEMP_TABLE(ID,I,F,S,B,L) VALUES(1, 11, 2.3, 'string1', true, 123456)";

			i = command.ExecuteNonQuery();

			Assert.IsTrue(i == 1);

			command.CommandText = "SELECT id,S FROM TEMP_TABLE";
			reader = command.ExecuteReader();

			if (reader.Read())
			{
				Assert.IsTrue(reader.GetName(0).ToLower().Equals("id"));
				Assert.IsTrue(reader.GetOrdinal("id") == 0);
				Assert.IsTrue(reader["id"].ToString().Equals("1"));
				Assert.IsTrue(reader["S"].ToString().Equals("string1"));
			}

			DropTempTable();
		}

		[Test]
		public void TestPrepareAndExecute()
		{
			CreateTempTable();

			IDataReader reader;
			HsqlCommand command = (HsqlCommand) connection.CreateCommand();
			command.CommandText = "SELECT * FROM TEMP_TABLE WHERE id=@id";
			command.Parameters.Add(new HsqlParameter("id", 1));
			command.Prepare();
			reader = command.ExecuteReader();

			if (reader.Read())
			{
				Assert.IsTrue(reader.GetName(0).ToLower().Equals("id"));
				Assert.IsTrue(reader.GetOrdinal("id") == 0);
				Assert.IsTrue(reader["id"].ToString().Equals("1"));
				Assert.IsTrue(reader["S"].ToString().Equals("string1"));
			}

			command.Parameters[0].Value = 2;
			reader = command.ExecuteReader();

			if (reader.Read())
			{
				Assert.IsTrue(reader.GetName(0).ToLower().Equals("id"));
				Assert.IsTrue(reader.GetOrdinal("id") == 0);
				Assert.IsTrue(reader["id"].ToString().Equals("2"));
				Assert.IsTrue(reader["S"].ToString().Equals("string2"));
			}

			command.Parameters[0].Value = 3;
			reader = command.ExecuteReader();

			if (reader.Read())
			{
				Assert.IsTrue(reader.GetName(0).ToLower().Equals("id"));
				Assert.IsTrue(reader.GetOrdinal("id") == 0);
				Assert.IsTrue(reader["id"].ToString().Equals("3"));
				Assert.IsTrue(reader["S"].ToString().Equals("string3"));
			}

			command = (HsqlCommand) connection.CreateCommand();
			command.CommandText = "SELECT * FROM TEMP_TABLE WHERE id=@id AND s=@s";
			command.Parameters.Add(new HsqlParameter("id", 4));
			command.Parameters.Add(new HsqlParameter("s", "string4"));
			command.Prepare();

			reader = command.ExecuteReader();

			if (reader.Read())
			{
				Assert.IsTrue(reader.GetName(0).ToLower().Equals("id"));
				Assert.IsTrue(reader.GetOrdinal("id") == 0);
				Assert.IsTrue(reader["id"].ToString().Equals("4"));
				Assert.IsTrue(reader["S"].ToString().Equals("string4"));
			}

			command.Parameters[0].Value = 3;
			reader = command.ExecuteReader();

			Assert.IsTrue(reader.Read() == false);

			DropTempTable();
		}

		[Test]
		public void TestParameterCollectionImplementation()
		{
			DateTime now = DateTime.Now;
			HsqlParameterCollection c = new HsqlParameterCollection();

			c.Add(new HsqlParameter("string", "string"));
			c.Add(new HsqlParameter("int", Int32.MinValue));
			c.Add(new HsqlParameter("long", Int64.MinValue));
			c.Add(new HsqlParameter("date", now));

			Assert.IsTrue(c.Count == 4);
			Assert.IsTrue(c.Contains("string"));
			Assert.IsTrue(c.Contains("int"));
			Assert.IsTrue(c.Contains("long"));
			Assert.IsTrue(c.Contains("date"));

			Assert.IsTrue(c["string"].Value.ToString().Equals("string"));
			Assert.IsTrue(c["int"].Value.ToString().Equals(Int32.MinValue.ToString()));
			Assert.IsTrue(c["long"].Value.ToString().Equals(Int64.MinValue.ToString()));
			Assert.IsTrue(c["date"].Value.ToString().Equals(now.ToString()));

			c.RemoveAt("long");
			Assert.IsFalse(c.Contains("long"));

			c.RemoveAt("string");
			Assert.IsFalse(c.Contains("string"));

			c.RemoveAt("int");
			Assert.IsFalse(c.Contains("int"));

			c.RemoveAt("date");
			Assert.IsFalse(c.Contains("date"));

			Assert.IsTrue(c.Count == 0);
		}
	}
}