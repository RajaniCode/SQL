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
using sf.net.hsqlado.utils;

namespace sf.net.hsqlado.driver
{
	abstract class PacketReader
	{
		protected byte[] buffer;
		protected int pos;
		protected int count;

		public abstract string ReadString();
		public abstract DateTime ReadDateTime();


		protected PacketReader()
		{
		}

		protected PacketReader(byte[] buffer)
		{
			this.buffer = buffer;
		}

		public void Reset(int newSize)
		{
			count = 0;

			if (newSize > buffer.Length)
			{
				buffer = new byte[newSize];
			}

			count = newSize;
			pos = 4;
			buffer[0] = (byte) (((uint) newSize >> 24) & 0xFF);
			buffer[1] = (byte) (((uint) newSize >> 16) & 0xFF);
			buffer[2] = (byte) (((uint) newSize >> 8) & 0xFF);
			buffer[3] = (byte) (((uint) newSize >> 0) & 0xFF);
		}

		public int Read()
		{
			return (pos < count) ? (buffer[pos++] & 0xff) : -1;
		}

		public bool ReadBoolean()
		{
			int ch = Read();

			if (ch < 0)
			{
				throw new Exception(); //EOFException
			}

			return (ch != 0);
		}

		public byte ReadByte()
		{
			int ch = Read();

			if (ch < 0)
			{
				throw new Exception(); //EOFException
			}

			return (byte) ch;
		}

		public short ReadShort()
		{
			if (count - pos < 2)
			{
				pos = count;

				throw new Exception(); //EOFException
			}

			int ch1 = buffer[pos++] & 0xff;
			int ch2 = buffer[pos++] & 0xff;

			return (short) ((ch1 << 8) + (ch2));
		}

		public int ReadUnsignedShort()
		{
			int ch1 = Read();
			int ch2 = Read();

			if ((ch1 | ch2) < 0)
			{
				throw new Exception(); //EOFException
			}

			return (ch1 << 8) + (ch2);
		}

		public int ReadInt()
		{
			if (count - pos < 4)
			{
				pos = count;

				throw new Exception();
			}

			int ch1 = buffer[pos++] & 0xff;
			int ch2 = buffer[pos++] & 0xff;
			int ch3 = buffer[pos++] & 0xff;
			int ch4 = buffer[pos++] & 0xff;

			return ((ch1 << 24) + (ch2 << 16) + (ch3 << 8) + (ch4));
		}

		public long ReadLong()
		{
			return (((long) ReadInt()) << 32)
			       + ((ReadInt()) & 0xffffffffL);
		}

		public float ReadFloat()
		{
			return Convert.ToSingle(ReadReal());
		}

		public double ReadReal()
		{
			return BitConverter.Int64BitsToDouble(ReadLong());
		}

		public String ReadUTF()
		{
			int bytecount = ReadUnsignedShort();

			if (pos + bytecount >= count)
			{
				throw new Exception(); //EOFException
			}

			String result = ReadUTF(buffer, pos, bytecount);

			pos += bytecount;

			return result;
		}

		protected bool CheckNull()
		{
			int b = ReadByte();
			return b == 0 ? true : false;
		}

		public Object[] ReadRowData(int[] colTypes)
		{
			int l = colTypes.Length;
			Object[] data = new Object[l];
			Object o;
			int type;

			for (int i = 0; i < l; i++)
			{
				if (CheckNull())
				{
					continue;
				}

				o = null;
				type = colTypes[i];

				switch (type)
				{
					case HsqlTypes.NULL:
					case HsqlTypes.CHAR:
					case HsqlTypes.VARCHAR:
					case HsqlTypes.LONGVARCHAR:
					case HsqlTypes.VARCHAR_IGNORECASE:
						o = ReadString();
						break;

					case HsqlTypes.TINYINT:
					case HsqlTypes.SMALLINT:
						o = ReadShort();
						break;

					case HsqlTypes.INTEGER:
						o = ReadInt();
						break;

					case HsqlTypes.FLOAT:
						o = ReadFloat();
						break;

					case HsqlTypes.REAL:
					case HsqlTypes.DOUBLE:
						o = ReadReal();
						break;

					case HsqlTypes.BIGINT:
						o = ReadLong();
						break;

					case HsqlTypes.BOOLEAN:
						o = ReadBoolean();
						break;

//					case HsqlTypes.NUMERIC :
//					case HsqlTypes.DECIMAL :
//						o = readDecimal();
//						break;
//
					case HsqlTypes.DATE:
					case HsqlTypes.TIME:
						o = ReadDateTime();
						break;

//					case HsqlTypes.TIMESTAMP :
//						o = readTimestamp();
//						break;
//					
//					case HsqlTypes.BINARY :
//					case HsqlTypes.VARBINARY :
//					case HsqlTypes.LONGVARBINARY :
//						o = readBinary(type);
//						break;

					default:
						throw new NotImplementedException("Field type '" + type + "' is not supported.");
				}

				data[i] = o;
			}

			return data;
		}

		protected String ReadUTF(byte[] bytearr, int offset, int length)
		{
			char[] buf = new char[length * 2];
			return ReadUTF(bytearr, offset, length, buf);
		}

		protected string ReadUTF(byte[] byteArr, int offset, int length, char[] buf)
		{
			int bcount = 0;
			int c, char2, char3;
			int count = 0;

			while (count < length)
			{
				c = (int) byteArr[offset + count];

				if (bcount > buf.Length - 4)
				{
					buf = (char[]) ArrayUtil.ResizeArray(buf, buf.Length + length);
				}

				if (c > 0)
				{
					/* 0xxxxxxx*/
					count++;

					buf[bcount++] = (char) c;

					continue;
				}

				c &= 0xff;

				switch (c >> 4)
				{
					case 12:
					case 13:

						/* 110x xxxx   10xx xxxx*/
						count += 2;

						if (count > length)
						{
							throw new Exception(); //UTFDataFormatException
						}

						char2 = (int) byteArr[offset + count - 1];

						if ((char2 & 0xC0) != 0x80)
						{
							throw new Exception(); //UTFDataFormatException
						}

						buf[bcount++] = (char) (((c & 0x1F) << 6)
						                        | (char2 & 0x3F));
						break;

					case 14:

						/* 1110 xxxx  10xx xxxx  10xx xxxx */
						count += 3;

						if (count > length)
						{
							throw new Exception(); //UTFDataFormatException
						}

						char2 = (int) byteArr[offset + count - 2];
						char3 = (int) byteArr[offset + count - 1];

						if (((char2 & 0xC0) != 0x80)
						    || ((char3 & 0xC0) != 0x80))
						{
							throw new Exception(); //UTFDataFormatException
						}

						buf[bcount++] = (char) (((c & 0x0F) << 12)
						                        | ((char2 & 0x3F) << 6)
						                        | ((char3 & 0x3F) << 0));
						break;

					default:

						/* 10xx xxxx,  1111 xxxx */
						throw new Exception(); //UTFDataFormatException
				}
			}

			// The number of chars produced may be less than length
			return new String(buf, 0, bcount);
		}
	}
}