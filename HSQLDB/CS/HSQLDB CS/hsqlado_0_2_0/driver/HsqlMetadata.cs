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
	class HsqlMetadata
	{
		// always resolved
		private String[] columnLabels;
		private String[] tableNames;
		private String[] columnNames;
		private bool[] isLabelQuoted;
		private int[] columnTypes;
		private int[] columnSizes;
		private int[] columnScales;

		// extra attrs, sometimes resolved
		private String[] catalogNames;
		private String[] schemaNames;
		private int[] columnNullable;
		private bool[] isIdentity;
		private bool[] isWritable;
		private int[] parametersMode;
		private String[] classNames;

		private int columnCount;

		private bool isParameterDescription;

		public HsqlMetadata(BinaryPacketReader packetReader,
		                    int mode)
		{
			int l = packetReader.ReadInteger();

			PrepareData(l);

			if (mode == HsqlResultConstants.HSQL_PARAM_META_DATA)
			{
				isParameterDescription = true;
				parametersMode = new int[l];
			}

			for (int i = 0; i < l; i++)
			{
				columnTypes[i] = packetReader.ReadType();

				columnSizes[i] = packetReader.ReadInteger();
				columnScales[i] = packetReader.ReadInteger();
				columnLabels[i] = packetReader.ReadString();
				tableNames[i] = packetReader.ReadString();
				columnNames[i] = packetReader.ReadString();
				classNames[i] = packetReader.ReadString();

				if (IsTableColumn(i))
				{
					ReadTableColumnAttrs(packetReader, i);
				}

				if (mode == HsqlResultConstants.HSQL_PARAM_META_DATA)
				{
					parametersMode[i] = packetReader.ReadInteger();
				}
			}
		}

		private void PrepareData(int columns)
		{
			columnLabels = new String[columns];
			tableNames = new String[columns];
			columnNames = new String[columns];
			isLabelQuoted = new bool[columns];
			columnTypes = new int[columns];
			columnSizes = new int[columns];
			columnScales = new int[columns];
			catalogNames = new String[columns];
			schemaNames = new String[columns];
			columnNullable = new int[columns];
			isIdentity = new bool[columns];
			isWritable = new bool[columns];
			classNames = new String[columns];

			columnCount = columns;
		}

		private int EncodeTableColumnAttrs(int i)
		{
			int colAttrs = columnNullable[i]; // always between 0x00 and 0x02

			if (isIdentity[i])
			{
				colAttrs |= 0x00000010;
			}

			if (isWritable[i])
			{
				colAttrs |= 0x00000020;
			}

			return colAttrs;
		}

		private void DecodeTableColumnAttrs(int colAttrs, int i)
		{
			columnNullable[i] = colAttrs & 0x0000000f;
			isIdentity[i] = (colAttrs & 0x00000010) != 0;
			isWritable[i] = (colAttrs & 0x00000020) != 0;
		}

		private void WriteTableColumnAttrs(BinaryPacketWriter packetWriter, int i)
		{
			packetWriter.WriteInteger(EncodeTableColumnAttrs(i));

			packetWriter.WriteString(catalogNames[i] == null
			                         	? ""
			                         	: catalogNames[i]);

			packetWriter.WriteString(schemaNames[i] == null
			                         	? ""
			                         	: schemaNames[i]);
		}

		private void ReadTableColumnAttrs(BinaryPacketReader packetReader, int i)
		{
			DecodeTableColumnAttrs(packetReader.ReadInteger(), i);

			catalogNames[i] = packetReader.ReadString();
			schemaNames[i] = packetReader.ReadString();
		}

		private bool IsTableColumn(int i)
		{
			return tableNames[i] != null && tableNames[i].Length > 0
			       && columnNames[i] != null && columnNames[i].Length > 0;
		}

		public void Write(BinaryPacketWriter packetWriter,
		                  int colCount)
		{
			packetWriter.WriteInteger(colCount);

			for (int i = 0; i < colCount; i++)
			{
				packetWriter.WriteType(columnTypes[i]);

				packetWriter.WriteInteger(columnSizes[i]);
				packetWriter.WriteInteger(columnScales[i]);
				packetWriter.WriteString(columnLabels[i] == null ? "" : columnLabels[i]);
				packetWriter.WriteString(tableNames[i] == null ? "" : tableNames[i]);
				packetWriter.WriteString(columnNames[i] == null ? "" : columnNames[i]);
				packetWriter.WriteString(classNames[i] == null ? "" : classNames[i]);

				if (IsTableColumn(i))
				{
					WriteTableColumnAttrs(packetWriter, i);
				}

				if (isParameterDescription)
				{
					packetWriter.WriteInteger(parametersMode[i]);
				}
			}
		}


		public string[] ColumnLabels
		{
			get { return columnLabels; }
			set { columnLabels = value; }
		}

		public string[] TableNames
		{
			get { return tableNames; }
			set { tableNames = value; }
		}

		public string[] ColumnNames
		{
			get { return columnNames; }
			set { columnNames = value; }
		}

		public bool[] IsLabelQuoted
		{
			get { return isLabelQuoted; }
			set { isLabelQuoted = value; }
		}

		public int[] ColumnTypes
		{
			get { return columnTypes; }
			set { columnTypes = value; }
		}

		public int[] ColumnSizes
		{
			get { return columnSizes; }
			set { columnSizes = value; }
		}

		public int[] ColumnScales
		{
			get { return columnScales; }
			set { columnScales = value; }
		}

		public string[] CatalogNames
		{
			get { return catalogNames; }
			set { catalogNames = value; }
		}

		public string[] SchemaNames
		{
			get { return schemaNames; }
			set { schemaNames = value; }
		}

		public int[] ColumnNullable
		{
			get { return columnNullable; }
			set { columnNullable = value; }
		}

		public bool[] IsIdentity
		{
			get { return isIdentity; }
			set { isIdentity = value; }
		}

		public bool[] IsWritable
		{
			get { return isWritable; }
			set { isWritable = value; }
		}

		public int[] ParametersMode
		{
			get { return parametersMode; }
			set { parametersMode = value; }
		}

		public string[] ClassNames
		{
			get { return classNames; }
			set { classNames = value; }
		}

		public int ColumnCount
		{
			get { return columnCount; }
			set { columnCount = value; }
		}

		public bool IsParameterDescription
		{
			get { return isParameterDescription; }
			set { isParameterDescription = value; }
		}
	}
}