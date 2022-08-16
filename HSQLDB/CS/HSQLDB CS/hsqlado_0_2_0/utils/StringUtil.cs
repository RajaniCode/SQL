using System;
using System.Collections;

namespace sf.net.hsqlado.utils
{
	public class StringUtil
	{
		private StringUtil()
		{
		}

		public static IDictionary ParseKeyValuePairs(string src)
		{
			String[] keyvalues = src.Split(';');
			String[] newkeyvalues = new String[keyvalues.Length];
			int x = 0;

			// first run through the array and check for any keys that
			// have ; in their value
			foreach (String keyvalue in keyvalues)
			{
				// check for trailing ; at the end of the connection string
				if (keyvalue.Length == 0) continue;

				// this value has an '=' sign so we are ok
				if (keyvalue.IndexOf('=') >= 0)
				{
					newkeyvalues[x++] = keyvalue;
				}
				else
				{
					newkeyvalues[x - 1] += ";";
					newkeyvalues[x - 1] += keyvalue;
				}
			}

			Hashtable hash = new Hashtable();

			// now we run through our normalized key-values, splitting on equals
			for (int y = 0; y < x; y++)
			{
				String[] parts = newkeyvalues[y].Split('=');

				// first trim off any space and lowercase the key
				parts[0] = parts[0].Trim().ToLower();
				parts[1] = parts[1].Trim();

				// we also want to clear off any quotes
				if (parts[1].Length >= 2)
				{
					if ((parts[1][0] == '"' && parts[1][parts[1].Length - 1] == '"') ||
					    (parts[1][0] == '\'' && parts[1][parts[1].Length - 1] == '\''))
					{
						parts[1] = parts[1].Substring(1, parts[1].Length - 2);
					}
				}
				else
				{
					parts[1] = parts[1];
				}
				parts[0] = parts[0].Trim('\'', '"');

				hash[parts[0]] = parts[1];
			}
			return hash;
		}

		public static IList ParseNamedParameters(string src, char paramMarker)
		{
			IList parameters = new ArrayList();
			char[] chars = src.ToCharArray();
			int len = chars.Length;
			int markerPos = 0;
			int i;

			for (i = 0; i < len; i++)
			{
				char ch = chars[i];

				if (ch.Equals(paramMarker))
				{
					if ((i > 0) &&
					    (chars[i - 1] == ' ') ||
					    (chars[i - 1] == '=') ||
					    (chars[i - 1] == '(') ||
					    (chars[i - 1] == ','))
					{
						markerPos = i;
					}
				}
				else
				{
					if (markerPos > 0)
					{
						if (ch == ',' || ch == ' ' || ch == ')')
						{
							parameters.Add(src.Substring(markerPos, (i - markerPos)));
							markerPos = 0;
						}
					}
				}
			}

			if (markerPos > 0)
			{
				parameters.Add(src.Substring(markerPos, (i - markerPos)));
			}

			return parameters;
		}
	}
}