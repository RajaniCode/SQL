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
	abstract class PacketWriter
	{
		protected byte[] buffer = new byte[128];
		protected int count;

		public abstract void WriteNull(int type);
		public abstract void WriteFieldType(int type);
		public abstract void WriteString(String s);
		public abstract void WriteInteger(Int32 i);
		public abstract void WriteBigint(Int64 l);
		public abstract void WriteDateTime(DateTime dt);

		public int Size
		{
			get { return count; }
		}

		public void WriteShort(int v)
		{
			EnsureRoom(2);

			buffer[count++] = (byte) ((uint) v >> 8);
			buffer[count++] = (byte) v;
		}

		protected void WriteInt(int v)
		{
			if (count + 4 > buffer.Length)
			{
				EnsureRoom(4);
			}

			buffer[count++] = (byte) ((uint) v >> 24);
			buffer[count++] = (byte) ((uint) v >> 16);
			buffer[count++] = (byte) ((uint) v >> 8);
			buffer[count++] = (byte) v;
		}

		public void WriteLong(long v)
		{
			WriteInt((int) (v >> 32));
			WriteInt((int) v);
		}

		public void WriteBoolean(bool v)
		{
			EnsureRoom(1);
			buffer[count++] = (byte) (v ? 1 : 0);
		}

		public void WriteByte(int v)
		{
			EnsureRoom(1);
			buffer[count++] = (byte) (v);
		}

		public void WriteChar(int v)
		{
			EnsureRoom(2);

			buffer[count++] = (byte) ((uint) v >> 8);
			buffer[count++] = (byte) v;
		}

		public void WriteChars(String s)
		{
			int len = s.Length;

			EnsureRoom(len * 2);

			for (int i = 0; i < len; i++)
			{
				int v = s[i];

				buffer[count++] = (byte) ((uint) v >> 8);
				buffer[count++] = (byte) v;
			}
		}

		public void WriteReal(double d)
		{
			WriteLong(BitConverter.DoubleToInt64Bits(d));
		}

		public void Write(int b)
		{
			EnsureRoom(1);
			buffer[count] = (byte) b;
			count++;
		}

		protected void EnsureRoom(int extra)
		{
			int newcount = count + extra;

			if (newcount > buffer.Length)
			{
				byte[] newbuf =
					new byte[(newcount + newcount / 2 + 256) & 0xffffff00];

				Array.Copy(buffer, 0, newbuf, 0, count);

				buffer = newbuf;
			}
		}

		protected void Reset(int newSize)
		{
			count = 0;

			if (newSize > buffer.Length)
			{
				buffer = new byte[newSize];
			}
		}

		public byte[] ToByteArray()
		{
			byte[] newbuf = new byte[count];

			Array.Copy(buffer, 0, newbuf, 0, count);

			return newbuf;
		}

		public void WriteData(int l, int[] types, Object[] data)
		{
			for (int i = 0; i < l; i++)
			{
				object o = data[i];
				int t = types[i];

				if (o == null)
				{
					WriteNull(t);

					continue;
				}

				WriteFieldType(t);

				switch (t)
				{
					case HsqlTypes.NULL:
					case HsqlTypes.CHAR:
					case HsqlTypes.VARCHAR:
					case HsqlTypes.LONGVARCHAR:
					case HsqlTypes.VARCHAR_IGNORECASE:
						WriteString((String) o);
						break;

					case HsqlTypes.INTEGER:
						WriteInteger(Convert.ToInt32(o));
						break;

					case HsqlTypes.TINYINT:
					case HsqlTypes.SMALLINT:
						WriteShort(Convert.ToInt16(o));
						break;

					case HsqlTypes.REAL:
					case HsqlTypes.FLOAT:
					case HsqlTypes.DOUBLE:
						WriteReal(Convert.ToDouble(o));
						break;

					case HsqlTypes.BIGINT:
						WriteBigint(Convert.ToInt64(o));
						break;

					case HsqlTypes.BOOLEAN:
						WriteBoolean(Convert.ToBoolean(o));
						break;

//					case HsqlTypes.NUMERIC :
//					case HsqlTypes.DECIMAL :
//						writeDecimal((BigDecimal) o);
//						break;
//
					case HsqlTypes.DATE:
					case HsqlTypes.TIME:
						WriteDateTime((DateTime) o);
						break;

//					case HsqlTypes.TIMESTAMP :
//						writeTimestamp((Timestamp) o);
//						break;
//
//					case HsqlTypes.BINARY :
//					case HsqlTypes.VARBINARY :
//					case HsqlTypes.LONGVARBINARY :
//						writeBinary((Binary) o, t);
//						break;

					default:
						throw new NotImplementedException("Field type '" + t + "' is not supported.");
				}
			}
		}

		protected int WriteUTF(String str, PacketWriter packetWriter)
		{
			int strlen = str.Length;
			int c, count = 0;

			for (int i = 0; i < strlen; i++)
			{
				c = str[i];

				if (c >= 0x0001 && c <= 0x007F)
				{
					packetWriter.Write(c);

					count++;
				}
				else if (c > 0x07FF)
				{
					packetWriter.Write(0xE0 | ((c >> 12) & 0x0F));
					packetWriter.Write(0x80 | ((c >> 6) & 0x3F));
					packetWriter.Write(0x80 | ((c >> 0) & 0x3F));

					count += 3;
				}
				else
				{
					packetWriter.Write(0xC0 | ((c >> 6) & 0x1F));
					packetWriter.Write(0x80 | ((c >> 0) & 0x3F));

					count += 2;
				}
			}

			return count;
		}
	}
}