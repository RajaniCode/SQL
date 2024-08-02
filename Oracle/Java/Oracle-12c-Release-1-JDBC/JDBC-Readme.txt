Oracle JDBC Drivers release 12.1.0.2.0 production Readme.txt
==========================================================


What Is New In This Release ?
-----------------------------

Transaction Guard
    Oracle Database 12c Release 1 introduces Transaction Guard, a
    feature that provides a generic infrastructure for at-most-once
    execution during planned and unplanned outages and duplicate
    submissions.

Application Continuity for Java
    The outages of the underlying software, hardware, communications,
    and storage layers can cause application execution to fail, and as
    a result, application outages are exposed to the end users. In the
    worst cases, the middle-tier servers may need to be restarted to
    deal with the logon storms. To overcome such problems, Oracle
    Database 12c Release 1 introduces the Application Continuity
    feature that masks database outages to the application and end
    users are not exposed to such outages.

    Application Continuity provides a general purpose,
    application-independent solution that enables recovery of work
    from an application perspective, after the occurrence of a
    planned or unplanned outage. The outage can be related to system,
    communication, or hardware following a repair, a configuration
    change, or a patch application.

SQL Translation Support
    The SQL preprocess or SQL translation mechanism enables to translate
    the text of SQL statements, submitted from client programs, before it
    is submitted to the Oracle Database SQL processor. SQL Translation
    can be implemented through programs, by look-up, or by a combination
    of the two.

    The SQL translation feature is most suitable to an application written
    using an open API, such as ODBC or JDBC, and all applications using SQL 
    statements that can be translated into semantically equivalent Oracle
    syntax.

Database Resident Connection Pooling
    Database Resident Connection Pool (DRCP) is a connection pool in the server
    that is shared across many clients. You should use DRCP in connection pools
    where the number of active connections is fairly less than the number of
    open connections. As the number of instances of connection pools that can
    share the connections from DRCP pool increases, the benefits derived from
    using DRCP increases. DRCP increases Database server scalability and resolves
    the resource wastage issue that is associated with middle-tier connection
    pooling.

JDBC 4.1 Standard
    Oracle Database 12c Release 1 JDBC drivers provide support for JDBC 4.1 standard
    through JDK 7.

Advanced Security Enhancements
    The Advanced Security Option of the Oracle Database 12c Release 1 includes support
    for SHA2 as a checksumming algorithm.

Reduced Memory Footprint
    In the Oracle Database 12c Release 1, the internal buffer mechanism used by the JDBC
    drivers has been substantially modified. The memory footprint of the 12R1 driver will
    in almost all cases be smaller than 11 or 10 drivers and only in the case of a very
    small footprint will it be any larger.



Intentional changes that may cause backward compatibility issues
----------------------------------------------------------------
- Per the JDBC specification, a call to commit() or rollback() when AutoCommit is turned on
  should throw an exception. Prior to 12R1, the drivers did not throw any exception which
  was a bug (please refer to bug 11891661 for more details). This bug has been fixed in 12R1
  so the driver will throw an exception on commit() or rollback() if the AutoCommit mode
  is turned on. This change is intentional and makes the Oracle JDBC drivers comply to the
  specification.

- Similarly the JDBC specification states that if setAutoCommit is called in the middle of
  a local transaction then the transaction is committed. Starting in 12R1, the JDBC drivers
  will issue an implicit commit when setAutoCommit is called if a local transaction is detected.
  
Driver Versions
---------------

These are the driver versions in the 12R1 release:

  - JDBC Thin Driver 12R1
    100% Java client-side JDBC driver for use in client applications,
    middle-tier servers and applets.

  - JDBC OCI Driver 12R1
    Client-side JDBC driver for use on a machine where OCI 12R1
    is installed.

  - JDBC Thin Server-side Driver 12R1
    JDBC driver for use in Java program in the database to access
    remote Oracle databases.

  - JDBC Server-side Internal Driver 12R1
    Server-side JDBC driver for use by Java Stored procedures.  This
    driver used to be called the "JDBC Kprb Driver".

For complete documentation, please refer to "JDBC Developer's Guide
and Reference".


Contents Of This Release
------------------------

For all platforms:

  [ORACLE_HOME]/jdbc/lib contains:

  - ojdbc7.jar
    Classes for use with JDK 7. It contains the JDBC driver classes
    except classes for NLS support in Oracle Object and Collection
    types. 

  - ojdbc7_g.jar
    Same as ojdbc7.jar except compiled with "javac -g" and contains
    tracing code.

  - ojdbc7dms.jar
    Same as ojdbc7.jar, except that it contains instrumentation to
    support DMS and limited java.util.logging calls.

  - ojdbc7dms_g.jar
    Same as ojdbc7_g.jar except that it contains instrumentation to
    support DMS.

  - ojdbc6.jar
    Classes for use with JDK 1.6. It contains the JDBC driver classes
    except classes for NLS support in Oracle Object and Collection
    types. 

  - ojdbc6_g.jar
    Same as ojdbc6.jar except compiled with "javac -g" and contains
    tracing code.

  - ojdbc6dms.jar
    Same as ojdbc6.jar, except that it contains instrumentation to
    support DMS and limited java.util.logging calls.

  - ojdbc6dms_g.jar
    Same as ojdbc6_g.jar except that it contains instrumentation to
    support DMS.

  Note: The dms versions of the jar files are the same as 
    standard jar files, except that they contain additional code
    to support Oracle Dynamic Monitoring Service. They contain a
    limited amount of tracing code. These can only be used
    when dms.jar is in the classpath. dms.jar is provided as part of
    Oracle Application Server releases. As a result the dms versions
    of the jar files can only be used in an Oracle Application Server
    environment. 

  [ORACLE_HOME]/jdbc/doc/javadoc.tar contains the JDBC Javadoc
  for the public API of the public classes of Oracle JDBC. This
  JavaDoc is the primary reference for Oracle JDBC API extensions. The
  Oracle JDBC Development Guide contains high level discussion of
  Oracle extensions. The details are in this JavaDoc. The JavaDoc is
  every bit as authorative as the Dev Guide.

  [ORACLE_HOME]/jdbc/demo/demo.tar contains sample JDBC programs.

  [ORACLE_HOME]/jlib/orai18n.jar
    NLS classes for use with JDK 1.6, and 7.  It contains
    classes for NLS support in Oracle Object and Collection types.
    This jar file replaces the old nls_charset jar/zip files. In 
    Oracle 10g R1 it was duplicated in [ORACLE_HOME]/jdbc/lib. We
    have removed the duplicate copy and you should now get it from
    its proper location.


For the Windows platform:

  [ORACLE_HOME]\bin directory contains ocijdbc12.dll and
  heteroxa12.dll, which are the libraries used by the JDBC OCI
  driver.

For non-Windows platforms:

  [ORACLE_HOME]/lib directory contains libocijdbc12.so,
  libocijdbc12_g.so, libheteroxa11.so and libheteroxa12_g.so, which
  are the shared libraries used by the JDBC OCI driver.


NLS Extension Jar File (for client-side only)
---------------------------------------------

The JDBC Server-side Internal Driver provides complete NLS support.
It does not require any NLS extension jar file.  Discussions in this
section only apply to the Oracle JDBC Thin and JDBC OCI drivers.

The basic jar files (ojdbc6.jar and ojdbc7.jar) contain all the
necessary classes to provide complete NLS support for:

  - Oracle Character sets for CHAR/VARCHAR/LONGVARCHAR/CLOB type data
    that is not retrieved or inserted as a data member of an Oracle
    Object or Collection type.

  - NLS support for CHAR/VARCHAR data members of Objects and
    Collections for a few commonly used character sets.  These
    character sets are:  US7ASCII, WE8DEC, WE8ISO8859P1, WE8MSWIN1252,
    and UTF8.

Users must include the NLS extension jar file
([ORACLE_HOME]/jlib/orai18n.jar) in their CLASSPATH if utilization of
other character sets in CHAR/VARCHAR data members of
Objects/Collections is desired.  The new orai18n.jar replaces the
nls_charset*.* files in the 9i and older releases.

The file orai18n.jar contains many important character-related files.
Most of these files are essential to globalization support.  Instead
of extracting only the character-set files your application uses, it
is safest to follow this three-step process: 1.  Unpack orai18n.jar
into a temporary directory.  2.  Delete the character-set files that
your application does not use.  Do not delete any territory, collation
sequence, or mapping files.  3.  Create a new orai18n.jar file from
the temporary directory and add the altered file to your CLASSPATH.
See the JDBC Developers Guide for more information.

In addition, users can also include internationalized Jdbc error
message files selectively.  The message files are included in the
oracle/jdbc/driver/Messages_*.properties files in ojdbc6*.jar and
ojdbc7*.jar. 


-----------------------------------------------------------------------


Installation
------------

Please do not try to put multiple versions of the Oracle JDBC drivers
in your CLASSPATH.  The Oracle installer installs the JDBC Drivers in
the [ORACLE_HOME]/jdbc directory.


Setting Up Your Environment
---------------------------

On Windows platforms:
  - Add [ORACLE_HOME]\jdbc\lib\ojdbc6.jar to
    your CLASSPATH if you use JDK 1.6 or
    [ORACLE_HOME]\jdbc\lib\ojdbc7.jar if you use JDK 7.
  - Add [ORACLE_HOME]\jlib\orai18n.jar to your CLASSPATH if needed.
  - Add [ORACLE_HOME]\bin to your PATH if you are using the JDBC OCI
    driver.

On Solaris/Digital Unix:
  - Add [ORACLE_HOME]/jdbc/lib/ojdbc6.jar to your CLASSPATH if you
    use JDK 1.6 or [ORACLE_HOME]/jdbc/lib/ojdbc7.jar if you use JDK 7
  - Add [ORACLE_HOME]/jlib/orai18n.jar to your CLASSPATH if needed.
  - Add [ORACLE_HOME]/jdbc/lib to your LD_LIBRARY_PATH if you use
    the JDBC OCI driver.

On HP/UX:
  - Add [ORACLE_HOME]/jdbc/lib/ojdbc6.jar to your CLASSPATH if you
    use JDK 1.6 or [ORACLE_HOME]/jdbc/lib/ojdbc7.jar if you use JDK 7
  - Add [ORACLE_HOME]/jlib/orai18n.jar to your CLASSPATH if needed.
  - Add [ORACLE_HOME]/jdbc/lib to your SHLIB_PATH and LD_LIBRARY_PATH
    if you use the JDBC OCI driver.

On AIX:
  - Add [ORACLE_HOME]/jdbc/lib/ojdbc6.jar to your CLASSPATH if you
    use JDK 1.6 or [ORACLE_HOME]/jdbc/lib/ojdbc7.jar if you use JDK 7
  - Add [ORACLE_HOME]/jlib/orai18n.jar to your CLASSPATH if needed.
  - Add [ORACLE_HOME]/jdbc/lib to your LIBPATH and LD_LIBRARY_PATH
    if you use the JDBC OCI driver.


Some Useful Hints In Using the JDBC Drivers
-------------------------------------------

Please refer to "JDBC Developer's Guide and Reference" for details
regarding usage of Oracle's JDBC Drivers.  This section only offers
useful hints.  These hints are not meant to be exhaustive.

These are a few simple things that you should do in your JDBC program:

 1. Import the necessary JDBC classes in your programs that use JDBC.
    For example:

      import java.sql.*;
      import java.math.*; // if needed

    To use OracleDataSource, you need to do:
      import oracle.jdbc.pool.OracleDataSource;

 2. Create an OracleDataSource instance. 

      OracleDataSource ods = new OracleDataSource();

 3. set the desired properties if you don't want to use the
    default properties. Different connection URLs should be
    used for different JDBC drivers.

      ods.setUser("my_user");
      ods.setPassword("my_password");

    For the JDBC OCI Driver:
      To make a bequeath connection, set URL as:
      ods.setURL("jdbc:oracle:oci:@");

      To make a remote connection, set URL as:
      ods.setURL("jdbc:oracle:oci:@<database>");

      where <database> is either a TNSEntryName 
      or a SQL*net name-value pair defined in tnsnames.ora.
 
    For the JDBC Thin Driver, or Server-side Thin Driver:
      ods.setURL("jdbc:oracle:thin:@<database>");

      where <database> is either a string of the form
      //<host>:<port>/<service_name>, or a SQL*net name-value pair,
      or a TNSEntryName.

    For the JDBC Server-side Internal Driver:
      ods.setURL("jdbc:oracle:kprb:");

      Note that the trailing ':' is necessary. When you use the 
      Server-side Internal Driver, you always connect to the
      database you are executing in. You can also do this:

      Connection conn =
        new oracle.jdbc.OracleDriver().defaultConnection();

 4. Open a connection to the database with getConnection()
    methods defined in OracleDataSource class.

      Connection conn = ods.getConnection();


-----------------------------------------------------------------------


Java Stored Procedures
----------------------

Examples for callins and instance methods using Oracle Object Types
can be found in:

  [ORACLE_HOME]/javavm/demo/demo.zip

After you unzip the file, you will find the examples under:

  [ORACLE_HOME]/javavm/demo/examples/jsp


Known Problems/Limitations Fixed in This Release
------------------------------------------------


14641400    JDBC THREAD HANG WHEN CANCELING OCCURS
        JDBC thread hang when canceling occurs

14584969    OUTOFMEMORYEXCEPTION WHEN EXECUTING PLSQL STATEMENT WITH 280+ VARCHAR PARAMETERS
        OutOfMemoryException when executing plsql statement with 280+ varchar parameters

14574450    NPE:GETLONG ON THE JDBC RESULTSET WITH INDEX 24 : 2 CUSTOM LONG TEXT FIELD TO FR
        NullPointerException when calling getlong on the jdbc resultset with index 24 : 2 custom long text field to FR

14538214    ADDITIONAL CASES OTHER THAN NAN/INFINITY IN BUG:14222149 ALSO THROW NULLPOINTER
        Catch overflow/underflow of Double to NUMBER at bind time.

14496772    JDBC INTERNAL SQL PARSER INCORRECT FOR SQL CONTAINING XXXRETURNINGYYY TEXT
        Problem parsing 'RETURNING ... INTO'

14465733    JDBC DRIVER CANNOT CONNECT VIA KERBEROS USING WINDOWS NATIVE CACHE
        Windows native cache doesnt work with delegation enabled

14462284    SIMPLEFAN.JAR MAKES WALLET MANDATORY
        simplefan sends an empty string to ONS if the wallet file and/or wallet
        passwords are not specified. ONS raises an error

14407350    ORACLE 11G JDBC KERBEROS CROSS-REALM FAILURE
        Kerberos doesn't work in cross realm scenario

14354533    PERFORMANCE ISSUE ON ALL_TYPE_ATTRS USING JDBC
        performance issue with ADTs.

14282782    RULE HINT IN SOME QUERIES ON ALL_SYNONYMS DEGRADES PERFORMANCE
        Improved performance of metadata queries.

14223360    DATA ENCRYPTED WHEN ORACLE.NET.ENCRYPTION_CLIENT SET TO REJECTED
        Connection properties ignored using pool data souurce.

14222149    NAN USAGE IN JDBC RESULTS IN NULLPOINTEREXCEPTION
        Catch use of NaN sooner to prevent NPE later on.

14107475    ORA-4043 USING JDBC THICK AND ALL WORKS FINE USING THIN DRIVER WHEN WORKING WITH
        ORA-4043 using OCI driver. Works fine using Thin driver when working with CLOB

14021941    JDBC TESTCASE SHOWS HIGH CURSOR VERSION COUNT AND HIGH BIND MISMATCH
        JDBC testcase shows high cursor version count and high bind mismatch

13877559    NLS: TIMEZONE CONVERSION BY ORACLE.SQL.TIMESTAMP IS WRONG
        Occasional wrong results using TIMESTAMP.TimeZoneConvert()

13635601    MISSING TIMEZONES BETWEEN JDBC AND DATABASE
        Missing time zones

13627118    ATLANTIC/JAN-MAYEN MAPPING IN ZONEIDMAP.JAVA DOES NOT MATCH THE DATABASE VALUE
        missing time zone

13618702    RETRY_COUNT DOES NOT WORK IN JDBC FOR REDIRECTED CONNECTIONS
        Retry count ignored for redirected connections.

13582368    XA CONNECTION REQUEST IGNORES ORACLE.NET.CONNECT_TIMEOUT
        XA connection request ignores oracle.net.CONNECT_TIMEOUT

13508485    BUG 13090621 FIX CAUSES A HANG.
        bug 13090621 fix causes a hang.

13105092    TIMESTAMP TS LITERAL USING 11.2 JDBC THIN OR OCI DOESN'T WORK
        In SQL with two or more JDBC escape sequences the second sequence is not
        recognized if the first escape sequence ends with a character literal not
        followed by a space, eg {ts '1980-01-01'}. Notice no space between the
        literal and the closing brace.

13090621    STATEMENT.CANCEL CANCELS ROLLBACK FOLLOWING CANCELLED INSERT WITH ORA-01013
        Driver does not recognize parameters in SQL with double quoted identifiers.

12998506    RETRY_COUNT IS TOTAL NUMBER OF CONNECTION ATTEMPTS IN JDBC THIN
        retry_count on a JDBC THIN connection didn't retry enough times.

12808945    JDBC DEADLOCK IN ORACLETIMEOUTTHREADPERVM AND T4CCONNECTION
        JDBC deadlock in OracleTimeoutThreadPerVM and T4CConnection

12775220    JDBC 11.2.0.2 DB METADATA GETCOLUMNS RETURNS UNEXPECTED VALUES FOR DECIMAL_DIGITS
        Meta data for decimal and integer columns have wrong values.

12770050    MULTITHREADED APP INTERMITTENTLY FAILS WITH PKI-02002: UNABLE TO OPEN THE WALLET
        Connection failure with PKI-02002: Unable to open the wallet

12760352    RETRY_COUNT PARAMETER DOES NOT WORK CORRECTLY WITH JDBC THIN
        JDBC does not correctly apply RETRY_COUNT on a connection.

12760268    JDBC THROWS NULLPOINTEREXCEPTION WITH RETRY_COUNT=0 IN URL
        RETRY_COUNT=0 would cause an NPE in JDBC

12744967    JDBC THIN DRIVER 11.2.0.2: THE DATABASE SESSION TIME ZONE IS NOT SUPPORTED
        Missing timezone support in JDBC client.

12744662    GETTING "UNDEFINED ERROR" IF THE OS USER NAME CONTAINS SPECIFIC CHARACTER
        Possible connection/login failure with certain multi-byte characters.

12596686    JDBC THIN APP SENDS SCALE VALUE OF 0 OR 9 FOR BINDS CAUSING MANY CHILD CURSORS
        JDBC thin app sends scale value of 0 or 9 for binds causing many child cursors

12582023    JDBC THIN DOES NOT CONNECT WHEN SECURITY BANNER IS SET IN DATBASE
        Security banner could cause THIN conenctions to fail.

12359128    NULLPOINTEREXCEPTION OCCURS AT ORACLEDRIVER.CONNECT().
        NullPointerException occurs at oracledriver.connect().

12358506    GET WRONG TIMESTAMP FOR THAI LOCALE USING OJDBC5.JAR
        Wrong Timestamp when using Thai locale.

11892137    ERROR ORA-22925 WHEN RETRIEVING A CLOB LARGER THAN 2GB
        Error fetching CLOB > 2GB

11879436    GETDATE AND GETTIMESTAMP RETURN INCORRECT YEAR WHEN RETRIEVING DATE FROM BC ERA
        Conversion from Java dtae/time to Oracle datatype and then back could
        lose a year with BC dates.

11833476    ORACLEBLOBINPUTSTREAM.AVAILABLE() METHOD ALWAYS RETURNS 0
        available() (on clob/blob column got from rs.getBinaryStream())  returned
        remaining size available as 0 for clob and blob when the buffer of 0 bytes
        was given to read().

11672297    ORA-01092 MAPPED TO XAER_RMERR INSTEAD OF XAER_RMFAIL
        ORA-01092 mapped to XAER_RMERR instead of XAER_RMFAIL.

11670695    RESULTSET.GETTIMESTAMP() RETURNS WRONG TIMESTAMP TIMESTAMP WITH LOCAL TIME ZONE
        Possible wrong timestamp with TIMESTAMPLTZ if db and
        session timezone are equal.

10385510    JDBC TCPS CONNECTIONS DO NOT FAILOVER USING SCAN LISTENERS
        JDBC TCPS connections do not failover using scan listeners

10364671    ZERO LENGTH AND NULL ARRAYS NOT WORKING IN JDBC 11.2.0.2
        zero length and null arrays not working in jdbc 11.2.0.2

10337920    JDBC GOT ORA-17090 WHEN USING TYPE_SCROLL_SENSITIVE
        Get ORA-17090 with TYPE_SCROLL_SENSITIVE result set when SQL includes
        ROW_NUMBER() OVER (... ORDER BY ...).

10315994    RESULTSET.GETROW() DOES NOT CONFORM TO STANDARDS OF JDBC
        After the resultset cursor has crossed over the last row (next() returns false)
         ResultSet.getRow() should return 0 as the cursor is not on an active row.
         It was returning the row count

10314983    CURSOR IS CLOSED IS THROWN FROM JDBC WHEN REF_CURSOR IS NOT AVAILABLE
        If a PL/SQL procedure returns a REF_CURSOR which is opened conditionally
        in the procedure then in the case where the cursor is not opened in the
        procedure the Thin driver throws a cursor is closed exception. The bug
        is a request to change the behaviour to return a null instead of the exception.

10258812    JDBC APP RETURNS INCORRECT COLUMN SIZE USING GETCOLUMNDISPLAYSIZE BETWEEN THIN A
        Wrong result from getColumnDisplaySize() for NUMBER.

10232230    GETOBJECT ON RAW COLUMN NOT INSTANCE OF BYTE[] WHEN FETCHSIZE CHANGES BETWEEN EX
        getObject() on a RAW column doesn't instance of byte[] when fetchsize changes
        between executions.

10185052    PREPARESTATEMENT(SQL,GENERATEDCOLS) HANGS IF SUM(LENGTH(COLUMN_NAMES) >= 800
        Possible hang when performing prepareStatement() with an OCI connection.

10177225    JDBC THIN GOT "IO ERROR: PROTOCOL VIOLATION" WHEN AFTER FETCHING LONG COLUMN
        Protocol violation exception is thrown when execte() is called as instead of
        executeUpdate() and the connection is closed right after.

9979618    DATABASEMETADATA GETCOLUMNS AND GETSCHEMAS MISSES COLUMNS
    Columns for DatabaaeMetaData getSchema and getColumns added in JDBC 4.0
    are added.

9869716    PRINTING STRING VALUE OF TIMESTAMPTZ IS SENSITIVE TO DEFAULT TIMEZONE
    Conversion of TIMESTAMPTZ to a string can produce wrong results.

9787201    WEBLOGIC XA DATASOURCE CONNECTION SSL ERROR
    Weblogic XA datasource connection SSL error

9786503    CANNOT USE OS AUTHENTICATION WHEN CUSTOMER USES ORACLEXADATASOURCE
    Cannot use OracleXADataSource to connect with OS authentication.

9785135    DST CONVERSION NOT CORRECT USING JDBC 11G TIMESTAMPTZ
    Wrong TIMESTAMPTZ value could be constructed.

9660015    SUDDENLY JDBC THIN HANGS BY WAITING GETNEXTPACKET WHEN CALLING STORED PROCEDURE
    Hang in JDBC Thin.

9496068    RETRIEVAL OF NVARCHAR COLUMNS FAILS WITH BIGGER TYPE LENGTH THAN MAXIMUM
    Retrieval of nvarchar columns fails with bigger type length than maximum.

9491385    MEMORY NOT BEING RELEASED WHEN USING REGISTERINDEXTABLEOUTPARAMETER
    Memory not being released when using registerindextableoutparameter.

9468517    SLAMD BENCHMARKING TOOL OR 10G JDBC OCI CLIENT, TAF WORKING ERRATICALLY
    JDBC OCI and OCI do not behave the same on TAF failover returned.

9445675    NO MORE DATA TO READ FROM SOCKET WHEN USING END-TO-END METRICS
    No more data to read from socket when using end-to-end metrics.

9394224    INSERTING A XMLTYPE FIELD PREVENT BATCHING AND FORCES SOFT PARSE
    Corrects problem with batch or repeat execution of PreparedStatements with
    XMLType of other OPAQUE types where a sever side parse is forced for every
    execution.

9387945    UNREGISTERDATABASECHANGENOTIFICATION OFTEN FAILS WHEN CONNECTED TO RAC DATABASE
    Unregister DCN was often failing when done against a RAC connection from
    a connection pool.

9341742    SETBINARYSTREAM CRASHES SERVER IF AN UNREAD STREAM IS BOUND TO A DML
    DB server crash when unread lob stream is bound as a bind.

9341542    GETMETADATA().GETINDEXINFO FAILS WITH QUOTED TABLENAME
    ORA-942 on quoted tablenames with GETMETADATA().GETINDEXINFO().

9259830    UNABLE TO DEREGISTER DCN WHEN JVM PROCESS WHICH REGISERTED IT DIES
    The API that lets you clean up a registration in the database in the
    case of a JVM crash doesn't work as expected.

9240210    SILENT (NO ERROR) TRUNCATION READING 4GB BLOB WITH JDBC 11.2.0.1. JDBC 11.1 OK.
    LOBs over 4gb could fail to read over THIN.

9224501    NEED OPTION TO RELEASE PREPAREDSTATEMENT BIND BUFFERS BETWEEN BATCHES
    Large amount of memory is retained by statements in allocated buffers
    when the statements are in implicit cache or after clearBatch() call

9197956    DATA CHANGE NOTIFICATION FAILS WITH JAVA.LANG.ILLEGALARGUMENTEXCEPTION AT JAVA.
    DCN notification could fail with a Java exception.

9180882    JDBC STATEMENT.EXECUTE DOES NOT HANDLE COMMENTS AS FIRST ELEMENTS FOR INSERT STA
    JDBC statement.execute does not handle comments as first elements for insert
    statement.

9139227    ERROR CODE CHANGE IN 11G
    Wrong error code on connection failure.

9105438    ORA-22275 DURING PS.EXECUTEBATCH WITH STREAMS AND NON-STREAMS
    ora-22275 during ps.executebatch with streams and non-streams.

9099863    PS.SETBYTES ON BLOB COLUMNS IN BATCH DOES NOT INHERIT VALUE TO FOLLOWING LINES
    ps.setbytes on blob columns in batch does not inherit value to following lines

9045206    11.2 JDBC DRIVER RETURNS ZERO ROWS WITH REF CURSOR OUT PARAMETER
    11.2 jdbc driver returns zero rows with ref cursor out parameter

8922272    JDBC CRASHES WHEN PROTOCOL IN NETWORK PACKET MODIFIED AND SERVER RUNS ON LINUX
    Corrupt network packets during logon can cause the Thin driver to
    throw a NullPointerException.

8874882    ORA-22922: NONEXISTENT LOB VALUE WHEN RE-USING LARGE STRING BIND VALUE
    ORA-22922: nonexistent lob value when re-using large string bind value

8473620    KPRB DRIVER FAILS IN UPDATEABLE RESULTSET.UPDATEROW () ON AL32UTF8
    In server side internal driver when using a  multi-byte database
    character set, a ResultSet.updateRow fails when the result set
    is for a PreparedStatement with a varchar column in a where clause.

8411111 JDBC THIN SUPPORTS ONLY TWO O5LOGON VERIFIER TYPES WHILST OCI SUPPORTS MANY MORE
    This bug has 2 symptoms:
    1) Slow connection establishment. Establishing a JDBC Thin connection to the
       database takes more time that when using the driver from 10.2.
    2) No EUS support. Trying to connect to the database as an Entreprise user
       doesn't work.

8889839    XA_RMERR BEING THROWN ON THE RECOVER(TMNOFLAGS) CALL
    xa_rmerr being thrown on the recover(tmnoflags) call


Known Problems/Limitations In This Release
------------------------------------------

The following is a list of known problems/limitations:

 *  Calling getSTRUCT() on ADT data in a ScrollableResultSet may
    result in a NullpointerException.

 *  Programs can fail to open 16 or more connections using our
    client-side drivers at any one time.  This is not a limitation 
    caused by the JDBC drivers.  It is most likely that the limit of
    per-process file descriptors is exceeded.  The solution is to 
    increase the limit. 

 *  The Server-side Internal Driver has the following limitation:
    - LONG and LONG RAW types are limited 32512 bytes for parameters
      of PL/SQL procedures. BUG-5965340
    - In a chain of SQLExceptions, only the first one in the chain
      will have a getSQLState value.
    - Batch updates with Oracle 8 Object, REF and Collection data
      types are not supported.

 *  The JDBC OCI driver on an SSL connection hangs when the Java
    Virtual Machine is running in green threads mode.  A work-around
    is to run the Java Virtual Machine in native threads mode.

 *  Date-time format, currency symbol and decimal symbols are always
    presented in American convention.

 *  The utility dbms_java.set_output or dbms_java.set_stream that is
    used for redirecting the System.out.println() in JSPs to stdout
    SHOULD NOT be used when JDBC tracing is turned on.  This is
    because the current implementation of dbms_java.set_output and
    set_stream uses JDBC to write the output to stdout.  The result
    would be an infinite loop.

 *  The JDBC OCI and Thin drivers do not read CHAR data via binary
    streams correctly.  In other word, using getBinaryStream() to
    retrieve CHAR data may yield incorrect results.  A work-around is
    to use either getCHAR() or getAsciiStream() instead.  The other
    alternative is to use getUnicodeStream() although the method is
    deprecated.

 *   There is a limitation for Triggers implemented in Java and Object
     Types. Triggers implemented as Java methods cannot have OUT
     arguments of Oracle 8 Object or Collection type.  This means the
     Java methods used to implement triggers cannot have arguments
     of the following types:

    - java.sql.Struct
    - java.sql.Array
    - oracle.sql.STRUCT
    - oracle.sql.ARRAY
    - oracle.jdbc2.Struct
    - oracle.jdbc2.Array
    - any class implementing oracle.jdbc2.SQLData or
      oracle.sql.CustomDatum

 *  The scrollable result set implementation has the following
    limitation:

    - setFetchDirection() on ScrollableResultSet does not do anything.
    - refreshRow() on ScrollableResultSet does not support all
      combinations of sensitivity and concurrency.  The following
      table depicts the supported combinations.

        Support     Type                       Concurrency
        -------------------------------------------------------
        no          TYPE_FORWARD_ONLY          CONCUR_READ_ONLY
        no          TYPE_FORWARD_ONLY          CONCUR_UPDATABLE
        no          TYPE_SCROLL_INSENSITIVE    CONCUR_READ_ONLY
        yes         TYPE_SCROLL_INSENSITIVE    CONCUR_UPDATABLE
        yes         TYPE_SCROLL_SENSITIVE      CONCUR_READ_ONLY
        yes         TYPE_SCROLL_SENSITIVE      CONCUR_UPDATABLE

 *  Limitation on using PreparedStatements to create triggers. Since
    :foo is recognized by the drivers as a SQL parameter, it is not
    possible to use :in and :out in SQL that defines a trigger when
    using a PreparedStatement. The workaround is to use a Statement
    instead. 


15870552    REGISTEROUTPARAMETER WITH TYPENAME DOES NOT WORK IN SPECIFIC DATA TYPES
        If sqlType defined in registerOutParameter is CHAR or VARCHAR,
        values are not returned with using getString().

14849379    ORACLE JDBC SSL NOT COMPATIBLE WITH NSS (NETSCAPE SECURITY SERVICES)
        JDBC SSL connections do not currently work when the JDK's standard JSSE SSL
        provider has been replaced with  NSS (Netscape Security Services)

14828039    CONNECTION.SETPLSQLWARNINGS HAS NO EFFECT
        Calling OracleConnection.setPlsqlWarnings has no effect on
        Connection.getWarnings(). After creating a faulty plsql package
          getWarnings() returns null.

14806443    NUMBER CORRUPTION FROM JDBC DRIVERS
        GoldenGate replication process fails with ORA-1722. Further analysis shows
          that the actual number values for two rows are corrupted. The number columns
          is updated through JDBC setBigDecimal.

14793214    ORACLEDATASOURCEFACTORY CLASS DOESN'T PARSE IMPLICITCACHINGENABLED PROPERTY
        When creating an oracle.jdbc.pool.OracleDataSource instance in Tomcat
          application server using JDBC 11.2.0.3, the OracleDataSourceFactory
          class parses such properties as connectionCachingEnabled,
          connectionCacheName etc. However, implicitCachingEnabled isn't parsed.

14789006    CHAR ATTRIBUTE OF OBJECT NOT BLANK PADDED TO LENGTH WHEN CREATED FROM JDBC
        There are two defined type in Oracle DB. One has a CHAR type column (say
          TypeA) and another type is defined as a table for TypeA(say TypeB). A
          function is defined to accept a TypeB parameter and query data in it using
          table() function. If the string length in input parameter is shorter than
          the length defined in TypeA, the return value should be fixed with padding
          blank characters. However if JDBC client calls this function with an Array
          type, the return value is trimmed.

14774730    DATABASEMETADATA.GETTABLES RETURNS SYNONYMS TO FUNCTIONS, STORED PROCEDURES
        Oracle JDBC driver should not return synonyms to functions and synonyms to
        stored procedures when calling DatabaseMetadata.getTables(...).

14651229    JDBC OCI APPLICATION CRASHES JVM RANDOMLY
        A java application using JDBC OCI crashes randomly.  Most of the crashes are
        in the library libclntsh.so and some of them are in the IBM JDK libraries.

14066597    JDBC 11.2.0.3 INSERTS \X0 CHAR AT <DEFAULTLOBPREFETCHSIZE> IN A XMLTYPE RESULT
        select XMLType.getclobval(col) from tab contains additional \x0 char at the
        byte position of the last byte of the prefetched data. With the default LOB
        prefetch size of 4000 bytes this is byte offset 4000. This behavior is 100%
        reproducible.

13817407    REMAINING AS ACTIVE CONNECTION EVEN IF IT IS CLOSED BY TIMETOLIVETIMEOUT
        When a connection is closed by TimeToLiveTimeout with ORA-1013, the
        connection remains active status.

13768437    ORA-01460 CALLING STORED PROCEDURE WITH BLOB
        This seems to occur:
          - When calling a Stored Procedure with IN parameter as BLOB
          - When reusing the Callable or PreparedStatement
          - When the first invocation of the Statement contains a bind with a size 0
        Bytes and the second invocation of the Statement contains a bind size >4000
        but <32768 Bytes.

13725094    SERVER-SIDE INTERNAL DRIVER CAN NOT HANDLE NULL INSERT AND RAISE ORA-01459
        Server-Side Internal Driver can not handle NULL insert and raise ORA-01459

13536790    ADDSTATEMENTEVENTLISTENER AND REMOVESTATEMENTEVENTLISTENER SEEM TO DO NOTHING
        Following methods seem to do nothing.
         PooledConnection.addStatementEventListener()
         PooledConnection.removeStatementEventListener()
        These are new methods in JDBC 4.0.

13070258    JDBC GETS ORA-17090 UNDER THE SPECIFIC CONDITION
        JDBC gets ORA-17090 occur under the specific condition.

12851493    SQLEXCEPTION: INTERNAL - UNEXPECTED VALUE WHEN CONNECTING FROM Z/OS S390 CLIENT
        Trying to connect using JDBC/thin from an IBM s390 with z/OS using a trivial
        standalone program. works fine using JDBC/thin 10.2.0.4. Fails with JDBC/thin
        11.1.0.7  and JDBC/thin 11.2.0.2

10625488    ORA-06512 OR ORA-01461 WHEN CALLING STORED PROCEDURE WITH OUT CHAR ARGUMENT
        Simple JDBC standalone testcase gets ORA-06512 (blank_trimming=false)  or
        ORA-01461 (blank_trimming=true). The error is triggered by a CallableStatement
        execute on a PL/SQL stored procedure that has an argument of CHAR(10) which
        is defined through a %TYPE which is based on a database table column.

10048812    GETUPDATECOUNTS() RETURNS WRONG VALUE ON JDBC OCI.
        Execute PreparedStatement.executeBatch() with error, then
        BatchUpdateException will occur. In exception handler by BatchUpdateException,
        BatchUpdateException.getUpdateCounts() returns NOT expected results with JDBC OCI.

9755639    ADDED ATTRIBUTE TO A UDT REFERENCED VIA VARRAY TYPE CAUSES ARRAYINDEXOUTOFBOUNDS
    Adding an attribute to a UDT referenced via VARRAY causes the following
    exception when fetching from ResultSet using getARRAY(x).

9655468    JDBC/THIN CANNOT USE TNSNAMES IFILE CLAUSE VIA ORACLE.NET.TNS_ADMIN
    if oracle.net.tns_admin  points to a tnsnames.ora that contains the actual
    tns entry then it works. if oracle.net.tns_admin  points to a tnsnames.ora
    that contains the IFILE that references another tnsnames.ora then it doesn't
    work in JDBC/thin
