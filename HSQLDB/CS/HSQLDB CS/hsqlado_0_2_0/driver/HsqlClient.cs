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
using System.Collections;
using System.Net.Sockets;

namespace sf.net.hsqlado.driver
{
	class HsqlClient
	{
		private int databaseId;
		private int sessionId;

		private byte[] writeBuff;
		private byte[] readBuff = new byte[1024];

		private TcpClient socket = null;

		private IList preparedStatements = new ArrayList();

		public void Connect(string server, int port,
		                    string user, string password,
		                    string database)
		{
			try
			{
				socket = new TcpClient(server, port);

				HsqlResult result = new HsqlResult();
				result.Mode = HsqlResultConstants.SQL_SQLCONNECT;
				result.MainString = user;
				result.SubString = password;
				result.SubSubString = database;

				Send(result);
			}
			catch (Exception e)
			{
				if (socket != null)
				{
					socket.Close();
				}

				throw e;
			}
		}

		public void Close()
		{
			if (preparedStatements.Count > 0)
			{
				int pLen = preparedStatements.Count;

				//Free all prepared statements
				for (int i = 0; i < pLen; i++)
				{
					HsqlStatement pStatement = (HsqlStatement) preparedStatements[i];

					HsqlResult r = new HsqlResult();
					r.Mode = HsqlResultConstants.SQL_SQLFREESTMT;
					r.SessionId = sessionId;
					r.DatabaseId = databaseId;
					r.StatementId = pStatement.StatementId;

					Send(r);
				}

				preparedStatements.Clear();
			}

			HsqlResult result = new HsqlResult();
			result.Mode = HsqlResultConstants.SQL_SQLDISCONNECT;
			result.DatabaseId = databaseId;
			result.SessionId = sessionId;

			Send(result);

			socket.Close();
		}

		public HsqlResult ExecuteStatement(HsqlStatement statement)
		{
			/*
			 The result must contain the following:
			  - update count
			  - statement id
			  - Metadata that includes the type of the parameters
			  - Root.Data must have the value of all the paramaterers
				
			 The server response is an update count result
			 
			 A free sql statement should be executed when the prepared 
				statement is not needed any more
			*/

			HsqlResult result = new HsqlResult();
			result.Mode = HsqlResultConstants.SQL_SQLEXECDIRECT;
			result.DatabaseId = databaseId;
			result.SessionId = sessionId;
			result.MainString = statement.ToString();
			result.UpdateCount = statement.MaxRows;

			if (statement.IsPrepared)
			{
				result.Mode = HsqlResultConstants.SQL_SQLEXECUTE;
				result.Metadata = statement.ParametersMetadata;
				result.StatementId = statement.StatementId;

				int pLen = statement.Parameters.Count;
				object[] obj = new object[pLen];

				for (int i = 0; i < pLen; i++)
				{
					HsqlParameter p = statement.Parameters[i];
					obj[i] = p.Value;
				}

				result.Add(obj);
			}

			result = Send(result);

			return result;
		}

		public void PrepareStatement(HsqlStatement statement)
		{
			/*
			  - Server responds with a multiple result packet.
			  - 1st result: Prepare statement acknowledge where the statementId can be fetched
			  - 2nd result:
					SELECT: Data result containing only the metadata of the selected columns
					UPDATE, DELETE, INSERT: Update count
			  - 3rd result: Metadata result containing the metadata of the parameters
			*/
			HsqlResult result = new HsqlResult();
			result.Mode = HsqlResultConstants.SQL_SQLPREPARE;
			result.DatabaseId = databaseId;
			result.SessionId = sessionId;
			result.MainString = statement.ToString();

			result = Send(result);

			if (result.Root != null ||
			    result.Root.Data != null ||
			    result.Root.Next != null ||
			    result.Root.Next.Next != null ||
			    result.Root.Next.Next.Data != null)
			{
				statement.StatementId = ((HsqlResult) result.Root.Data[0]).StatementId;
				statement.ParametersMetadata = ((HsqlResult) result.Root.Next.Next.Data[0]).Metadata;

				preparedStatements.Add(statement);
			}
			else
			{
				//What to do here?
			}
		}

		private HsqlResult Send(HsqlResult outResult)
		{
			HsqlResult inResult;

			writeBuff = outResult.ToByteArray();

			//try
			//{
				socket.GetStream().Write(writeBuff, 0, writeBuff.Length);
				socket.GetStream().Read(readBuff, 0, readBuff.Length);

				inResult = new HsqlResult(readBuff);

				sessionId = inResult.SessionId;
				databaseId = inResult.DatabaseId;
			//}
			//catch (Exception e)
			//{
			//	throw new Exception("Unable to communicate with HSQL database server.", e);
			//}

			return inResult;
		}
	}
}