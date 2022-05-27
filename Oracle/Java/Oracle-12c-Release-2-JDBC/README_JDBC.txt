Oracle JDBC Drivers release 12.2.0.1.0 production Readme.txt
============================================================

What Is New In This Release ?
-----------------------------

- Support for database sharding. Starting from Oracle Database 12c
Release 2 (12.2.0.1), Oracle JDBC supports database sharding. The JDBC
driver recognizes the specified sharding key and super sharding key
and connects to the relevant shard that contains the data. Once the
connection is established to a shard, then any database operations,
such as DMLs, SQL queries and so on, are supported and executed in the
usual way. The Universal Connection Pool also supports Sharding and
can be used to efficiently manage connections to the Sharded
Databases.

- Support for JDK 8 and JDBC 4.2 was added in this release of the JDBC
drivers.  ojdbc8.jar from 12.2 supports JDK8. 

- JDBC Driver Support for Fast Application Notification (FAN).
Starting from Oracle Database 12c Release 2 (12.2.0.1), Oracle JDBC
driver supports Oracle RAC Fast Application Notification (FAN) events,
for planned and unplanned outages. This facilitates third-party
connection pools to leverage Oracle RAC features for high
availability. Java applications not using Oracle Universal Connection
Pool (UCP) or WebLogic Server can now leverage on this support. For
example, scenarios like rolling upgrades at the Oracle RAC server-side
do not cause JDBC errors within applications.

- Application Continuity Support for XA Data Source. Oracle Database
12c Release 2 (12.2.0.1) introduces a new feature that enhances
Application Continuity with support for Oracle XA data source
(javax.sql.XADataSource), which is similar to non-XA data source
(javax.sql.DataSource).

- Support for network compression. Starting from Oracle Database 12c
Release 2 (12.2.0.1), the JDBC Thin driver supports network data
compression. Network data compression reduces the size of the session
data unit (SDU) transmitted over a data connection and reduces the
time required to transmit a SQL query and the result across the
network. The benefits are more significant in case of Wireless Area
Network (WAN). 

For the complete list of new features please refer to the "JDBC
Developer's Guide and Reference".


Intentional changes that may cause backward compatibility issues
----------------------------------------------------------------

- Oracle update batching was deprecated in Oracle Database 12c Release
1 (12.1). Starting in Oracle Database 12c Release 2 (12.2), Oracle
update batching is a no operation code (no-op). This means that if you
implement Oracle update batching in your application, using the Oracle
Database 12c Release 2 (12.2) JDBC driver, then the specified batch
size is not set and results in a batch size of 1. With this batch
setting, your application processes one row at a time. Oracle strongly
recommends that you use the standard JDBC batching if you are using
the Oracle Database 12c Release 2 (12.2) JDBC driver.

- Desupport of JPublisher. All Oracle JPublisher features are
desupported and unavailable in Oracle Database 12c Release 2
(12.2.0.1).

- JDK6 and JDK7 are no longer supported. You must use JDK8 in order to
use the 12R2 JDBC Driver.
  
Driver Versions
---------------

These are the driver versions in the 12R2 release:

  - JDBC Thin Driver 12R2
    100% Java client-side JDBC driver for use in client applications,
    middle-tier servers and applets.

  - JDBC OCI Driver 12R2
    Client-side JDBC driver for use on a machine where OCI 12R1
    is installed.

  - JDBC Thin Server-side Driver 12R2
    JDBC driver for use in Java program in the database to access
    remote Oracle databases.

  - JDBC Server-side Internal Driver 12R2
    Server-side JDBC driver for use by Java Stored procedures.  This
    driver used to be called the "JDBC Kprb Driver".

For complete documentation, please refer to "JDBC Developer's Guide
and Reference".


Contents Of This Release
------------------------

For all platforms:

  [ORACLE_HOME]/jdbc/lib contains:

  - ojdbc8.jar
    Classes for use with JDK 8. It contains the JDBC driver classes
    except classes for NLS support in Oracle Object and Collection
    types. 

  - ojdbc8_g.jar
    Same as ojdbc8.jar except compiled with "javac -g" and contains
    tracing code.

  - ojdbc8dms.jar
    Same as ojdbc8.jar, except that it contains instrumentation to
    support DMS and limited java.util.logging calls.

  - ojdbc8dms_g.jar
    Same as ojdbc8_g.jar except that it contains instrumentation to
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

The basic jar files (ojdbc8.jar) contain all the
necessary classes to provide complete NLS support for:

  - Oracle Character sets for CHAR/VARCHAR/LONGVARCHAR/CLOB type data
    that is not retrieved or inserted as a data member of an Oracle
    Object or Collection type.

  - NLS support for CHAR/VARCHAR data members of Objects and
    Collections for a few commonly used character sets.  These
    character sets are:  US7ASCII, WE8DEC, WE8ISO8859P1, WE8MSWIN1252,
    AL32UTF8 and UTF8.

Users must include the NLS extension jar file
([ORACLE_HOME]/jlib/orai18n.jar) in their CLASSPATH if utilization of
other character sets in CHAR/VARCHAR data members of
Objects/Collections is desired.  

The file orai18n.jar contains many important character-related files.
Most of these files are essential to globalization support.  Instead
of extracting only the character-set files your application uses, it
is safest to follow this three-step process: 1.  Unpack orai18n.jar
into a temporary directory.  2.  Delete the character-set files that
your application does not use.  Do not delete any territory, collation
sequence, or mapping files.  3.  Create a new orai18n.jar file from
the temporary directory and add the altered file to your CLASSPATH.
See the JDBC Developers Guide for more information.


Installation
------------

Please do not try to put multiple versions of the Oracle JDBC drivers
in your CLASSPATH.  The Oracle installer installs the JDBC Drivers in
the [ORACLE_HOME]/jdbc directory.


Setting Up Your Environment
---------------------------

In order to use the JDBC Thin Driver 12R2, please add ojdbc8.jar to
your CLASSPATH.

You may also add the following jars:
- orai18n.jar in order to get full NLS support;
- ucp.jar, ons.jar and simplefan.jar in case you use RAC
- oraclepki.jar and osdt_cert.jar if you use Wallets
- xdb.jar if your use XMLType or SQLXML


Known Problems/Limitations Fixed in This Release
------------------------------------------------

19030178 - ADD TLSV1.1 AND TLSV1.2 IN JDBC THIN

19632480 - ORACLEDATABASEMETADATA.GETTABLES CURSOR CONNECTION LEAK

19795066 - ORA-904 CALLLING ORACLEDATABASEMETADATA.GETCOLUMNS AGAINST
OLD DB

19154304 - JDBC: RETRY_COUNT DOES NOT RETRY WHEN SERVICE DOWN AS
REQUIRED

19002423 - JAVA.LANG.ARRAYINDEXOUTOFBOUNDSEXCEPTION: -1 LOADING DATA
USING EXECUTEBATCH

18905788 - UPDATE SUBSCRIBER CREATION TO BE SPECIFIC TO EACH ONS
OBJECT 

18029737 - NULLPOINTEREXCEPTION ON ADDRESS RESOLUTION USING SCAN
LISTENER 

16618074 - NO DELAY PARAMETER FOR RETRYING INCOMING CONNECTIONS 


Known Problems/Limitations In This Release
------------------------------------------

The following is a list of important known problems/limitations:

 *  The JDBC Thin driver needs to generate random strings during
authentication and if the system isn't able to generate enough entropy
the driver will look like it's hanging during connection creation. A
simple workaround is to switch to the pseudo random generator
(urandom) using -Djava.security.egd=file:///dev/urandom.

 *  25501502 - JDBC-OCI 12C THROWS ORA-29275 WHEN FETCHING DATA WHICH
HAS MULTI-BYTE CHARACTERS 
 
 *  25336054 - WRONG RESULTS RETURNED BY 12C SERVER SIDE INTERNAL
DRIVER 
