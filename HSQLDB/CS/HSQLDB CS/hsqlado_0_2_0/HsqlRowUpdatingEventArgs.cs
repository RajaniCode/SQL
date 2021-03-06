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

using System.Data;
using System.Data.Common;

namespace sf.net.hsqlado
{
	public class HsqlRowUpdatingEventArgs : RowUpdatingEventArgs
	{
		public HsqlRowUpdatingEventArgs(DataRow dataRow, IDbCommand command, StatementType statementType,
		                                DataTableMapping tableMapping) : base(dataRow, command, statementType, tableMapping)
		{
		}

		public new HsqlCommand Command
		{
			get { return (HsqlCommand) base.Command; }
			set { base.Command = value; }
		}
	}
}