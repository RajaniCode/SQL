using System;
using System.Data;
using NUnit.Framework;
using sf.net.hsqlado;

namespace tests
{
	[TestFixture]
	public class TestDataAdapter : TestBase
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
		public void TestFill()
		{
			CreateTempTable();

			ExecuteSQL("DELETE FROM TEMP_TABLE");
			ExecuteSQL("INSERT INTO TEMP_TABLE(ID,I,F,S,B,L,DT,T) VALUES(1, 11, 2.3, 'string1', true, 123456, '1999-08-22', '23:53:00')");
			ExecuteSQL("INSERT INTO TEMP_TABLE(ID,I,F,S,B,L,DT,T) VALUES(2, 22, 4.5, 'string2', true, 12233456, '2007-01-01', '02:34:00')");
			ExecuteSQL("INSERT INTO TEMP_TABLE(ID,I,F,S,B,L,DT,T) VALUES(3, 33, 6, NULL, false, 12345446, '1970-01-01', '13:30:00')");

			HsqlDataAdapter da = new HsqlDataAdapter("SELECT * FROM TEMP_TABLE", connection);
			da.SelectCommand.Prepare();
			DataSet ds = new DataSet();
			da.Fill(ds, "Test");

			Assert.AreEqual(1, ds.Tables.Count);
			Assert.AreEqual(3, ds.Tables[0].Rows.Count);

			Assert.AreEqual(1, ds.Tables[0].Rows[0]["ID"]);
			Assert.AreEqual(3, ds.Tables[0].Rows[2]["ID"]);
			Assert.AreEqual(2, ds.Tables[0].Rows[1]["ID"]);

			Assert.AreEqual(11, ds.Tables[0].Rows[0]["I"]);
			Assert.AreEqual(22, ds.Tables[0].Rows[1]["I"]);
			Assert.AreEqual(33, ds.Tables[0].Rows[2]["I"]);

			Assert.AreEqual(2.3f, ds.Tables[0].Rows[0]["F"]);
			Assert.AreEqual(4.5f, ds.Tables[0].Rows[1]["F"]);
			Assert.AreEqual(6f, ds.Tables[0].Rows[2]["F"]);

			Assert.AreEqual("string1", ds.Tables[0].Rows[0]["S"]);
			Assert.AreEqual("string2", ds.Tables[0].Rows[1]["S"]);
			Assert.AreEqual(DBNull.Value, ds.Tables[0].Rows[2]["S"]);

			Assert.AreEqual(true, ds.Tables[0].Rows[0]["B"]);
			Assert.AreEqual(true, ds.Tables[0].Rows[1]["B"]);
			Assert.AreEqual(false, ds.Tables[0].Rows[2]["B"]);

			Assert.AreEqual(123456L, ds.Tables[0].Rows[0]["L"]);
			Assert.AreEqual(12233456L, ds.Tables[0].Rows[1]["L"]);
			Assert.AreEqual(12345446L, ds.Tables[0].Rows[2]["L"]);

			Assert.AreEqual(new DateTime(1999,08,22), ds.Tables[0].Rows[0]["DT"]);
			Assert.AreEqual(new DateTime(2007,01,01), ds.Tables[0].Rows[1]["DT"]);
			Assert.AreEqual(new DateTime(1970,01,01), ds.Tables[0].Rows[2]["DT"]);

			Assert.AreEqual(new DateTime(1970,01,01,23,53,0), ds.Tables[0].Rows[0]["T"]);
			Assert.AreEqual(new DateTime(1970,01,01,2,34,0), ds.Tables[0].Rows[1]["T"]);
			Assert.AreEqual(new DateTime(1970,01,01,13,30,0), ds.Tables[0].Rows[2]["T"]);

			DropTempTable();
		}
	}
}