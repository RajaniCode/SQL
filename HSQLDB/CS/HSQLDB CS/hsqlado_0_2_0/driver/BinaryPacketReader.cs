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
	class BinaryPacketReader : PacketReader
	{
		public BinaryPacketReader()
		{
		}

		public BinaryPacketReader(byte[] buffer) : base(buffer)
		{
		}

		public int ReadInteger()
		{
			return ReadInt();
		}

		public long ReadBigint()
		{
			return ReadLong();
		}

		public int ReadType()
		{
			return ReadShort();
		}

		public override String ReadString()
		{
			int length = ReadInt();

			String s = ReadUTF(buffer, pos, length);

			pos += length;

			return s;
		}

		public override DateTime ReadDateTime()
		{
			long t1 = new DateTime(1970, 1, 1).Ticks;
			long t2 = 0;
			long j = ReadLong();

			t2 = (10000 * (j - 14400000)) + t1;

			return new DateTime(t2);
		}
	}
}