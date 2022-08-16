using System.Collections;
using NUnit.Framework;
using sf.net.hsqlado.utils;

namespace tests
{
	[TestFixture]
	public class TestUtils
	{
		[Test]
		public void TestParseNameParameters()
		{
			IList parameters;
			string s;

			s = "SELECT * FROM table1 WHERE id=@id";
			parameters = StringUtil.ParseNamedParameters(s, '@');

			Assert.IsTrue(parameters.Count == 1);
			Assert.IsTrue(parameters[0].ToString().Equals("@id"));

			s = "SELECT * FROM table1 WHERE id=@id AND description=@desc";
			parameters = StringUtil.ParseNamedParameters(s, '@');

			Assert.IsTrue(parameters.Count == 2);
			Assert.IsTrue(parameters[0].ToString().Equals("@id"));
			Assert.IsTrue(parameters[1].ToString().Equals("@desc"));

			s = "INSERT INTO table1(1,2,3,4) VALUES(@1,@2, @3, @4)";
			parameters = StringUtil.ParseNamedParameters(s, '@');

			Assert.IsTrue(parameters.Count == 4);
			Assert.IsTrue(parameters[0].ToString().Equals("@1"));
			Assert.IsTrue(parameters[1].ToString().Equals("@2"));
			Assert.IsTrue(parameters[2].ToString().Equals("@3"));
			Assert.IsTrue(parameters[3].ToString().Equals("@4"));

			s = "SELECT * FROM table1 WHERE 1=1 OR 2=@2 AND 3='@3' AND 4=\\@4 AND 5=\"@5\"";
			parameters = StringUtil.ParseNamedParameters(s, '@');

			Assert.IsTrue(parameters.Count == 1);
			Assert.IsTrue(parameters[0].ToString().Equals("@2"));
		}
	}
}