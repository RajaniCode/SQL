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
	class BinaryPacketWriter : PacketWriter
	{
		public void WriteInteger(Int32 i, int position)
		{
			int temp = count;

			count = position;

			WriteInt(i);

			if (count < temp)
			{
				count = temp;
			}
		}

		public void WriteSize(int size)
		{
			WriteInt(size);
		}

		public void WriteType(int type)
		{
			WriteShort(type);
		}

		public override void WriteNull(int type)
		{
			Write(0);
		}

		protected void WriteChar(String s, int t)
		{
			WriteString(s);
		}

		public override void WriteInteger(Int32 i)
		{
			WriteInt(i);
		}

		public override void WriteBigint(Int64 l)
		{
			WriteLong(l);
		}

		public override void WriteFieldType(int type)
		{
			Write(type);
		}

		public override void WriteString(String s)
		{
			int temp = count;

			WriteInt(0);
			WriteUTF(s, this);
			WriteInteger(count - temp - 4, temp);
		}

		public override void WriteDateTime(DateTime dt)
		{
			long t1 = new DateTime(1970, 1, 1).Ticks;
			long t2 = dt.Ticks;

			long ticks = ((t2 - t1) / 10000) + 14400000;

			WriteLong(ticks);
		}
	}
}