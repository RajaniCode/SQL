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
using sf.net.hsqlado.exceptions;

namespace sf.net.hsqlado.driver
{
	class HsqlResult
	{
		private HsqlRecord root;
		private HsqlRecord tail;
		private HsqlMetadata metadata;

		private int size;
		private int significantColumns;

		private int mode;
		private int databaseId;
		private int sessionId;
		private int statementId;
		private int updateCount;
		private string mainString;
		private string subString;
		private string subSubString;

		public HsqlResult()
		{
		}

		public HsqlResult(byte[] buffer)
		{
			BinaryPacketReader packetReader = new BinaryPacketReader(buffer);
			packetReader.Reset(buffer.Length);
			Read(packetReader);
		}

		private void Read(BinaryPacketReader packetReader)
		{
			try
			{
				mode = packetReader.ReadInteger();

				if (mode == HsqlResultConstants.HSQL_MULTI)
				{
					ReadMultipleResult(packetReader);

					return;
				}

				databaseId = packetReader.ReadInteger();
				sessionId = packetReader.ReadInteger();

				switch (mode)
				{
					case HsqlResultConstants.SQL_SQLPREPARE:
						updateCount = packetReader.ReadInteger();
						mainString = packetReader.ReadString();
						break;

					case HsqlResultConstants.HSQL_PREPARE_ACK:
						statementId = packetReader.ReadInteger();
						break;

					case HsqlResultConstants.SQL_SQLEXECDIRECT:
						updateCount = packetReader.ReadInteger();
						statementId = packetReader.ReadInteger();
						mainString = packetReader.ReadString();
						break;

					case HsqlResultConstants.SQL_SQLCONNECT:
					case HsqlResultConstants.HSQL_ERROR:
						mainString = packetReader.ReadString();
						subString = packetReader.ReadString();
						subSubString = packetReader.ReadString();
						statementId = packetReader.ReadInteger();

						break;

					case HsqlResultConstants.HSQL_UPDATECOUNT:
						updateCount = packetReader.ReadInteger();
						break;

					case HsqlResultConstants.HSQL_DATA:
					case HsqlResultConstants.HSQL_PARAM_META_DATA:
						{
							metadata = new HsqlMetadata(packetReader, mode);
							significantColumns = metadata.ColumnLabels.Length;

							int count = packetReader.ReadInteger();

							while (count-- > 0)
							{
								Add(packetReader.ReadRowData(metadata.ColumnTypes));
							}

							break;
						}
					default:
						throw new HsqlException("HSQL result type is not supported");
				}
			}
			catch (Exception e)
			{
				throw e;
			}

			if (mode == HsqlResultConstants.HSQL_ERROR)
			{
				throw new HsqlServerException(mainString);
			}
		}

		public HsqlRecord Root
		{
			get { return root; }
		}

		public string SubSubString
		{
			get { return subSubString; }
			set { subSubString = value; }
		}

		public string MainString
		{
			get { return mainString; }
			set { mainString = value; }
		}

		public string SubString
		{
			get { return subString; }
			set { subString = value; }
		}

		public int Size
		{
			get { return size; }
		}

		public int Mode
		{
			get { return mode; }
			set { mode = value; }
		}

		public int DatabaseId
		{
			get { return databaseId; }
			set { databaseId = value; }
		}

		public int SessionId
		{
			get { return sessionId; }
			set { sessionId = value; }
		}

		public int StatementId
		{
			get { return statementId; }
			set { statementId = value; }
		}

		public int UpdateCount
		{
			get { return updateCount; }
			set { updateCount = value; }
		}

		public HsqlMetadata Metadata
		{
			set { metadata = value; }
			get { return metadata; }
		}

		public void Add(object[] d)
		{
			HsqlRecord r = new HsqlRecord();

			r.Data = d;

			if (root == null)
			{
				root = r;
			}
			else
			{
				tail.Next = r;
			}

			tail = r;

			size++;
		}

		private void Write(BinaryPacketWriter packetWriter)
		{
			if (mode == HsqlResultConstants.HSQL_MULTI)
			{
				WriteMultipleResult(packetWriter);
				return;
			}

			int startPos = packetWriter.Size;

			packetWriter.WriteSize(0);
			packetWriter.WriteInteger(mode);
			packetWriter.WriteInteger(databaseId);
			packetWriter.WriteInteger(sessionId);

			switch (mode)
			{
				case HsqlResultConstants.SQL_SQLDISCONNECT:
					break;

				case HsqlResultConstants.SQL_SQLPREPARE:
					packetWriter.WriteInteger(updateCount);
					packetWriter.WriteString(mainString);
					break;

				case HsqlResultConstants.SQL_SQLFREESTMT:
					packetWriter.WriteInteger(statementId);
					break;

				case HsqlResultConstants.SQL_SQLEXECDIRECT:
					packetWriter.WriteInteger(updateCount);
					packetWriter.WriteInteger(statementId); // currently unused
					packetWriter.WriteString(mainString);
					break;

				case HsqlResultConstants.SQL_SQLCONNECT:
					packetWriter.WriteString(mainString);
					packetWriter.WriteString(subString);
					packetWriter.WriteString(subSubString);
					packetWriter.WriteInteger(statementId);
					break;

				case HsqlResultConstants.HSQL_UPDATECOUNT:
					packetWriter.WriteInteger(updateCount);
					break;

				case HsqlResultConstants.SQL_SQLEXECUTE:
					{
						packetWriter.WriteInteger(updateCount);
						packetWriter.WriteInteger(statementId);

						int l = metadata.ColumnCount;

						packetWriter.WriteInteger(l);

						for (int i = 0; i < l; i++)
						{
							packetWriter.WriteType(metadata.ColumnTypes[i]);
						}

						packetWriter.WriteInteger(size);

						HsqlRecord n = root;

						while (n != null)
						{
							packetWriter.WriteData(l, metadata.ColumnTypes, n.Data);

							n = n.Next;
						}

						break;
					}
				case HsqlResultConstants.HSQL_DATA:
				case HsqlResultConstants.HSQL_PARAM_META_DATA:
					{
						metadata.Write(packetWriter, significantColumns);
						packetWriter.WriteInteger(size);

						HsqlRecord n = root;

						while (n != null)
						{
							packetWriter.WriteData(
								significantColumns,
								metadata.ColumnTypes,
								n.Data);

							n = n.Next;
						}

						break;
					}
				default:
					throw new HsqlException("HSQL result mode is not supported.");
			}

			packetWriter.WriteInteger(packetWriter.Size, startPos);
		}

		private void ReadMultipleResult(BinaryPacketReader packetReader)
		{
			mode = HsqlResultConstants.HSQL_MULTI;
			databaseId = packetReader.ReadInteger();
			sessionId = packetReader.ReadInteger();

			int count = packetReader.ReadInteger();

			for (int i = 0; i < count; i++)
			{
				packetReader.ReadInteger();

				HsqlResult result = new HsqlResult();
				result.Read(packetReader);

				Add(new Object[] {result});
			}
		}

		private void WriteMultipleResult(BinaryPacketWriter packetWriter)
		{
			int startPos = packetWriter.Size;

			packetWriter.WriteSize(0);
			packetWriter.WriteInteger(mode);
			packetWriter.WriteInteger(databaseId);
			packetWriter.WriteInteger(sessionId);
			packetWriter.WriteInteger(size);

			HsqlRecord n = root;

			while (n != null)
			{
				((HsqlResult) n.Data[0]).Write(packetWriter);

				n = n.Next;
			}

			packetWriter.WriteInteger(packetWriter.Size, startPos);
		}

		public byte[] ToByteArray()
		{
			BinaryPacketWriter packetWriter = new BinaryPacketWriter();

			Write(packetWriter);

			return packetWriter.ToByteArray();
		}
	}
}