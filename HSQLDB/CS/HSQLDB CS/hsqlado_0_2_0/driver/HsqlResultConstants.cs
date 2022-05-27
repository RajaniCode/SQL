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

namespace sf.net.hsqlado.driver
{
	public class HsqlResultConstants
	{
		private HsqlResultConstants()
		{
		}

		private const int HSQL_API_BASE = 0;

		/**
		* Indicates that the Result object encapsulates multiple Result objects.
		*/
		public const int HSQL_MULTI = HSQL_API_BASE + 0;

		/**
		* Indicates that the Result object encapsulates an update
		* count response.
		*/
		public const int HSQL_UPDATECOUNT = HSQL_API_BASE + 1;

		/**
		* Indicates that the Result object encapsualtes an
		* error response.
		*/
		public const int HSQL_ERROR = HSQL_API_BASE + 2;

		/**
		* Indicates that the Result object encapsulates a result
		* set response containing data.
		*/
		public const int HSQL_DATA = HSQL_API_BASE + 3;

		/**
		* Indicates that the Result object encapsulates a response
		* that communicates the acknowlegement of newly allocated
		* CompiledStatement object in the form of its statementID.
		*/
		public const int HSQL_PREPARE_ACK = HSQL_API_BASE + 4;

		/**
		* Indicates that the Result object encapsulates a result
		* set response containing parameter metadata.
		*/
		public const int HSQL_PARAM_META_DATA = HSQL_API_BASE + 5;

		/**
		* Indicates that the Result object encapsulates a batch of statements
		*/
		public const int HSQL_BATCHEXECDIRECT = HSQL_API_BASE + 8;

		/**
		* Indicates that the Result object encapsulates a batch of prepared
		* statement parameter values
		*/
		public const int HSQL_BATCHEXECUTE = HSQL_API_BASE + 9;


		private const int SQL_API_BASE = 0x00010000;

		/**
		* Indicates that Result encapsulates a request to establish a connection.
		*/
		public const int SQL_SQLCONNECT = SQL_API_BASE + 7;

		/**
		* Indicates that Result encapsulates a request to terminate an
		* established connection.
		*/
		public const int SQL_SQLDISCONNECT = SQL_API_BASE + 9;

		/**
		* Indicates that Result encapsulates a request to execute a statement
		* directly.
		*/
		public const int SQL_SQLEXECDIRECT = SQL_API_BASE + 11;

		/**
		* Indicates that Result encapsulates a request to execute a prepared
		* statement.
		*/
		public const int SQL_SQLEXECUTE = SQL_API_BASE + 12;

		/**
		* Indicates that Result encapsulates a request to deallocate an
		* SQL-statement.
		*/
		public const int SQL_SQLFREESTMT = SQL_API_BASE + 16;

		/**
		* Indicates that Result encapsulates a request to prepare a statement.
		*/
		public const int SQL_SQLPREPARE = SQL_API_BASE + 19;

		/**
		* Indicates that Result encapsulates a request to explicitly start an
		* SQL-transaction and set its characteristics.
		*/
		public const int SQL_SQLSTARTTRAN = SQL_API_BASE + 74;


		public const int HSQL_COMMIT = 0;
		public const int HSQL_ROLLBACK = 0;

		public const int MAX_ROWS_NO_LIMIT = 0;
	}
}