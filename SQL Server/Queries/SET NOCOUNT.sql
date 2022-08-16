--SET NOCOUNT
/*
SET NOCOUNT (Transact-SQL)
Stops the message that shows the count of the number of rows affected by a Transact-SQL statement or stored procedure from being returned as part of the result set.

Syntax 
SET NOCOUNT { ON | OFF }  

Remarks 
When SET NOCOUNT is ON, the count is not returned. When SET NOCOUNT is OFF, the count is returned.
The @@ROWCOUNT function is updated even when SET NOCOUNT is ON.
SET NOCOUNT ON prevents the sending of DONE_IN_PROC messages to the client for each statement in a stored procedure. 
For stored procedures that contain several statements that do not return much actual data, 
or for procedures that contain Transact-SQL loops, setting SET NOCOUNT to ON can provide a significant performance boost, 
because network traffic is greatly reduced.
The setting specified by SET NOCOUNT is in effect at execute or run time and not at parse time.

Permissions 
Requires membership in the public role.
*/

USE AdventureWorks;
GO
SET NOCOUNT OFF;
GO

-- Display the count message.
SELECT TOP(5)LastName
FROM Person.Contact
WHERE LastName LIKE 'A%';
GO

-- SET NOCOUNT to ON to no longer display the count message.
SET NOCOUNT ON;
GO
SELECT TOP(5) LastName
FROM Person.Contact
WHERE LastName LIKE 'A%';
GO

-- Reset SET NOCOUNT to OFF
SET NOCOUNT OFF;
GO
