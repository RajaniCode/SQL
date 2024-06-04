using System;
using System.Data;
using NUnit.Framework;

namespace tests
{
	[TestFixture]
	public class TestDataReader : TestBase
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
		public void TestGetTableSchema()
		{
		}

		[Test]
		public void TestGetDataTypes()
		{
			CreateTempTable();

			IDbCommand command = connection.CreateCommand();
			command.CommandText = "SELECT * FROM TEMP_TABLE";

			IDataReader reader = command.ExecuteReader();

			if (reader.Read())
			{
				Assert.IsTrue(reader.GetFieldType(0) == typeof (int));
				Assert.IsTrue(reader.GetInt32(0) == 1);
				Assert.IsTrue(reader.GetFieldType(1) == typeof (int));
				Assert.IsTrue(reader.GetInt32(1) == 11);
				Assert.IsTrue(reader.GetFieldType(2) == typeof (float));
				Assert.IsTrue(reader.GetFloat(2) == 2.3f);
				Assert.IsTrue(reader.GetFieldType(3) == typeof (string));
				Assert.IsTrue(reader.GetString(3).Equals("string1"));
				Assert.IsTrue(reader.GetFieldType(4) == typeof (bool));
				Assert.IsTrue(reader.GetBoolean(4));
				Assert.IsTrue(reader.GetFieldType(5) == typeof (long));
				Assert.IsTrue(reader.GetInt64(5) == 123456);
				Assert.IsTrue(reader.GetFieldType(6) == typeof (DateTime));
				Assert.IsTrue(reader.GetDateTime(6) == new DateTime(1999, 8, 22));
				Assert.IsTrue(reader.GetFieldType(7) == typeof (DateTime));
				Assert.IsTrue(reader.GetDateTime(7) == new DateTime(1970, 1, 1, 23, 53, 0), reader.GetDateTime(7).ToString());

				Assert.IsTrue(reader.GetDataTypeName(0).Equals("Int32"));
				Assert.IsTrue(reader.GetDataTypeName(1).Equals("Int32"));
				Assert.IsTrue(reader.GetDataTypeName(2).Equals("Double"));
				Assert.IsTrue(reader.GetDataTypeName(3).Equals("String"));
				Assert.IsTrue(reader.GetDataTypeName(4).Equals("Boolean"));
				Assert.IsTrue(reader.GetDataTypeName(5).Equals("Int64"));
				Assert.IsTrue(reader.GetDataTypeName(6).Equals("DateTime"));
				Assert.IsTrue(reader.GetDataTypeName(7).Equals("DateTime"));
			}

			DropTempTable();
		}

		[Test]
		public void TestCloseConnectionBehavior()
		{
			CreateTempTable();

			IDbCommand command = connection.CreateCommand();
			command.CommandText = "SELECT * FROM TEMP_TABLE";

			IDataReader reader = command.ExecuteReader(CommandBehavior.CloseConnection);

			DropTempTable();

			reader.Close();

			Assert.IsTrue(connection.State == ConnectionState.Closed);
		}
	}
}