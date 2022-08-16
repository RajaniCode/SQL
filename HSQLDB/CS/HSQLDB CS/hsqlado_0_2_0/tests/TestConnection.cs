using System.Data;
using NUnit.Framework;
using sf.net.hsqlado;
using sf.net.hsqlado.exceptions;

namespace tests
{
	[TestFixture]
	public class TestConnection : TestBase
	{
		[Test]
		public void TestOpenDifferenConnectionStrings()
		{
			connection = new HsqlConnection();
			connection.ConnectionString = "user=SA;password=;database=testdb";
			connection.Open();
			Assert.IsTrue(connection.State == ConnectionState.Open);
			connection.Close();

			connection.ConnectionString = "user id=SA;pwd=;initial catalog=testdb";
			connection.Open();
			Assert.IsTrue(connection.State == ConnectionState.Open);
			connection.Close();

			connection.ConnectionString = "user=SA;database=testdb";
			connection.Open();
			Assert.IsTrue(connection.State == ConnectionState.Open);
			connection.Close();

			connection.ConnectionString = "user=SA;password=;database=testdb;data source=localhost";
			connection.Open();
			Assert.IsTrue(connection.State == ConnectionState.Open);
			connection.Close();
		}

		[Test]
		[ExpectedException(typeof(HsqlServerException), ExpectedMessage="User not found: WRONGUSER")]
		public void TestOpenBadUser()
		{
			connection = new HsqlConnection();
			connection.ConnectionString = "user=wronguser;password=;database=testdb";
			connection.Open();

			Assert.IsTrue(connection.State == ConnectionState.Open);

			connection.Close();
		}

		[Test]
		[ExpectedException(typeof(HsqlServerException), "Access is denied")]
		public void TestOpenBadPassword()
		{
			connection = new HsqlConnection();
			connection.ConnectionString = "user=SA;password=wrongpassword;database=testdb";
			connection.Open();

			Assert.IsTrue(connection.State == ConnectionState.Open);

			connection.Close();
		}
	}
}