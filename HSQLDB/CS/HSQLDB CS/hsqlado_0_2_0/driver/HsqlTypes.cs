// HSQL ADO.Net Data Provider
// Copyright (c) 2007 Jesse Martinez
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

using System;

namespace sf.net.hsqlado.driver
{
	class HsqlTypes
	{
		public const int TINYINT = -6;
		public const int BIGINT = -5;
		public const int BOOLEAN = 16;
		public const int CHAR = 1;
		public const int NUMERIC = 2;
		public const int DECIMAL = 3;
		public const int INTEGER = 4;
		public const int SMALLINT = 5;
		public const int FLOAT = 6;
		public const int REAL = 7;
		public const int DOUBLE = 8;
		public const int NULL = 0;
		public const int VARCHAR = 12;
		public const int VARCHAR_IGNORECASE = 100;
		public const int LONGVARCHAR = -1;
		public const int DATE = 91;
		public const int TIME = 92;

		private HsqlTypes()
		{
		}

		public static string GetDataTypeName(int dataType)
		{
			string typeName = "not supported";

			switch (dataType)
			{
				case BIGINT:
					typeName = "Int64";
					break;

				case BOOLEAN:
					typeName = "Boolean";
					break;

				case CHAR:
					typeName = "char";
					break;

				case INTEGER:
					typeName = "Int32";
					break;

				case DATE:
				case TIME:
					typeName = "DateTime";
					break;

				case VARCHAR:
				case VARCHAR_IGNORECASE:
				case LONGVARCHAR:
					typeName = "String";
					break;

				case TINYINT:
				case SMALLINT:
					typeName = "Int16";
					break;

				case REAL:
				case FLOAT:
				case DOUBLE:
					typeName = "Double";
					break;

				default:
					break;
			}

			return typeName;
		}

		public static Type GetDataTypeType(int dataType)
		{
			Type typeType = null;

			switch (dataType)
			{
				case BIGINT:
					typeType = typeof (Int64);
					break;

				case BOOLEAN:
					typeType = typeof (bool);
					break;

				case CHAR:
					typeType = typeof (char);
					break;

				case INTEGER:
					typeType = typeof (Int32);
					break;

				case DATE:
				case TIME:
					typeType = typeof (DateTime);
					break;

				case VARCHAR:
				case VARCHAR_IGNORECASE:
				case LONGVARCHAR:
					typeType = typeof (string);
					break;

				case TINYINT:
				case SMALLINT:
					typeType = typeof (Int16);
					break;

				case FLOAT:
					typeType = typeof (Single);
					break;

				case REAL:
				case DOUBLE:
					typeType = typeof (Double);
					break;
				default:
					break;
			}

			return typeType;
		}
	}
}