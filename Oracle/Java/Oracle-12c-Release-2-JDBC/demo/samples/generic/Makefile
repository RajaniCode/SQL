#
# Makefile for compiling and executing 
# demo/samples/generic/*.java. Please use rundemo.bat for NT, win64
#
# Usage: make <all> | <thin> | <oci> | <ocitns> | <single demo> |
#             <single demo> DEBUG="true"
#
# Before you run any demo programs, you should:
#   1. set up your database and schema. Please refer to Samples-Readme.txt,
#      section "Setting Up Schemas" for details.
#   2. Modify this makefile to use appropriate host/port/service_name
#      search for MODIFY_HERE ... to process your modification
#   3. use GNU make
#
# Features demonstrated:
#   1. basic JDBC 1.22 features, such as Select, Insert, Define Column Type,
#      embeded PL/SQL procedure, Prefetch, Batch execution, and Stream I/O.
#   2. JDBC 2.0 features, such as Connection Cache, Statement Cache, DataSource,
#      JNDI, PooledConnection, ResultSet, RowSet(OracleCachedRowSet), and XA.
#   3. JDBC 3.0 features, such as transaction savepoint, implicit connection
#      cache.
#   4. connection wrapping feature.
#   5. Oracle 9i features are demonstrated at sub directories -- JavaObject1,
#      Inheritance, and NestedConnection.
#   6. This test needs interactive inputs.
#
# Notes on Oracle Connection Wrapper:
#   oracle.jdbc.OracleConnectionWrapper is an implementation of a connection
#   wrapper originally developed for testing. The compiled code is provided in
#   the distributed classesNN.zip/jar files and the source is in WrapperSource/.
#   While some implementations might be able to use the class directly by
#   extending it for their own use. It is anticipated that many will require an
#   implementation in a class in their own hierarchy. Given that Java provides
#   single inheritance of implementation it would be necessary to provide all
#   the forwarding methods. This source is provided to assist in that effort.
#   Please be aware that using the source will produce problems when the Oracle
#   JDBC API is changed in the future whereas extending the Oracle supplied class
#   should not. 

JDBC_URL=jdbc:oracle:oci:@
JDBC_URL_2=jdbc:oracle:oci:@

# MODIFY_HERE
# You could choose an appropriate directory to store file1.bin and file2.bin
# The files and directory should be presented prior to running the demo
TMPDIR=/tmp/tmpdir
ONS_HOME=${ORACLE_HOME}
ORACLELOGFILE=${ORACLE_HOME}/jdbc/demo/OracleLog.properties
DEMO_CLASSPATH=.:${ORACLE_HOME}/jlib/jndi.jar:${ORACLE_HOME}/jlib/jta.jar:${ORACLE_HOME}/jlib/orai18n.jar:${ORACLE_HOME}/jlib/fscontext.jar

# classpath for JDK6 
CLASSPATH6=.:${ORACLE_HOME}/jdbc/lib/ojdbc6.jar:${DEMO_CLASSPATH}:${ORACLE_HOME}/jlib/providerutil.jar:${ORACLE_HOME}/opmn/lib/ons.jar

CLASSPATH6g=.:${ORACLE_HOME}/jdbc/lib/ojdbc6_g.jar:${DEMO_CLASSPATH}:${ORACLE_HOME}/jlib/providerutil.jar:${ORACLE_HOME}/opmn/lib/ons.jar


# MODIFY_HERE: Please use a correct path on your machine
# JDK1.5 install dir used by Svpt1.java
JDK6_HOME=${ORACLE_HOME}/jdk6

# MODIFY_HERE: If the platform is 64 bit & java takes -d64 flag to run in 64 
# bit mode, set the below value to TRUE
USE_64FLAG=FALSE

# MODIFY_HERE: if LIBPATH is used instead of LD_LIBRARY_PATH then replace
# LD_LIBRARY_PATH by LIBPATH below
# For 64 bit platforms with 32 bit libraries modify lib to lib32 to use
# 32 bit library.
JAVA_LIBRARY_PATH=${ORACLE_HOME}/lib:${LD_LIBRARY_PATH}

# choose JDK1.5 and ojdbc5.jar as the default settings and
# if USE_64FLAG is set to TRUE then use -d64
ifeq ("${USE_64FLAG}","TRUE")
  JAVAC=${JDK6_HOME}/bin/javac
  JAVA=${JDK6_HOME}/bin/java -d64 -Djava.library.path=${JAVA_LIBRARY_PATH}
else
  JAVAC=${JDK6_HOME}/bin/javac
  JAVA=${JDK6_HOME}/bin/java -Djava.library.path=${JAVA_LIBRARY_PATH}
endif



all: clobber compile run

# MODIFY_HERE: Please use appropriate <host> <port> and <service_name>
thin:
	make all JDBC_URL=jdbc:oracle:thin:@//localhost:1521/orcl.oracle.com

oci:
	make all JDBC_URL=jdbc:oracle:oci:@


# MODIFY_HERE: Please use appropriate <host> <port> and <service_name>
ocitns:
	make all JDBC_URL="jdbc:oracle:oci:@\(DESCRIPTION=\(ADDRESS=\(PROTOCOL=tcp\)\(HOST=localhost\)\(PORT=1521\)\)\(CONNECT_DATA=\(SERVICE_NAME=orcl.oracle.com\)\)\)"


# The RowSet and WebRowset demos are not compiled by default.
# To compile these, use JDK 5.0
# The WebRowset also needs $ORACLE_HOME/lib/xmlparserv2.jar at the
# classpath.
compile: compile_6

# compile demos that use JDK6 and ojdbc6.jar
compile_6:
	$(JAVAC) -classpath $(CLASSPATH6) -g ArrayExample.java \
	ConnectionWrapperSample.java \
	DataSource.java     DataSourceJNDI.java \
	Employee.java       ORADataExample.java \
	EmployeeObj.java    SQLDataExample.java \
	FileExample.java    PLSQL_FileExample.java \
	InsertExample.java  SelectExample.java DefineColumnType.java \
	JdbcCheckup.java    JdbcMTSample.java \
	LobExample.java     OpenCloseLob.java \
	PLSQL.java          PLSQLExample.java  PLSQL_LobExample.java \
	PersonObject.java   PersonRef.java \
	PooledConnection1.java                 PooledConnection2.java \
	GenREF.java         RefClient.java     RefCursorExample.java \
	ResultSet1.java     ResultSet2.java    ResultSet3.java \
	ResultSet4.java     ResultSet5.java    ResultSet6.java \
	RowPrefetch_connection.java            RowPrefetch_statement.java \
	RowId.java \
	BatchUpdates.java \
	StmtCache1.java     StmtCache2.java \
	StreamExample.java \
	TemporaryLob.java   TruncateLob.java \
	XA1.java XA2.java XA3.java XA4.java XA5.java \
	Svpt1.java \
	ProxySession01.java \
	ListRecoverableSQLExceptions.java \

#       RowSet01.java  RowSet02.java RowSet03.java RowSet04.java \
#       WebRowset01.java \

%.class : %.java
	$(JAVAC) -classpath $(CLASSPATH6) -g $<


run:    SelectExample DefineColumnType InsertExample JdbcCheckup JdbcMTSample \
	PLSQL PLSQLExample RefCursorExample RowPrefetch_connection \
	RowPrefetch_statement \
	StreamExample DataSource DataSourceJNDI \
	PooledConnection1 PooledConnection2 \
	XA1 XA2 XA3 XA4 XA5 \
	StmtCache1 StmtCache2 \
	BatchUpdates \
	ResultSet1 ResultSet2 ResultSet3 ResultSet4 ResultSet5 ResultSet6 \
        RowId \
	ArrayExample ORADataExample LobExample \
	OpenCloseLob PLSQL_LobExample \
	PersonObject PersonRef \
	RefClient TemporaryLob TruncateLob \
	FileExample PLSQL_FileExample \
	ConnectionWrapperSample Svpt1 \
	ProxySession01 ListRecoverableSQLExceptions
	# RowSet01 RowSet02 RowSet03 RowSet04 \
        # WebRowset01 \


SelectExample: SelectExample.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) SelectExample

DefineColumnType: DefineColumnType.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) DefineColumnType

InsertExample: InsertExample.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) InsertExample

JdbcCheckup: JdbcCheckup.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) JdbcCheckup

JdbcMTSample: JdbcMTSample.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) JdbcMTSample

PLSQL: PLSQL.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) PLSQL

PLSQLExample: PLSQLExample.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) PLSQLExample

RefCursorExample: RefCursorExample.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) RefCursorExample

RowPrefetch_connection: RowPrefetch_connection.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) RowPrefetch_connection

RowPrefetch_statement: RowPrefetch_statement.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) RowPrefetch_statement

StreamExample: StreamExample.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) StreamExample

DataSource: DataSource.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) DataSource

# MODIFY_HERE
# The sub-directories JNDI/ and JNDI/jdbc must be present in this directory,
# Or you could replace it with an appropriate path
DataSourceJNDI: DataSourceJNDI.class
	-rm ./JNDI/jdbc/.bindings
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) \
        DataSourceJNDI ./JNDI

PooledConnection1: PooledConnection1.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) PooledConnection1

PooledConnection2: PooledConnection2.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) PooledConnection2

BatchUpdates: BatchUpdates.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) BatchUpdates

XA1: XA1.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) XA1

XA2: XA2.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) XA2

XA3: XA3.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) XA3

XA4: XA4.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) \
        -DJDBC_URL_2=$(JDBC_URL_2) XA4 localhost 1521 orcl.oracle.com

XA5: XA5.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) XA5

ResultSet1: ResultSet1.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) ResultSet1

ResultSet2: ResultSet2.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) ResultSet2

ResultSet3: ResultSet3.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) ResultSet3

ResultSet4: ResultSet4.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) ResultSet4

ResultSet5: ResultSet5.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) ResultSet5

ResultSet6: ResultSet6.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) ResultSet6

StmtCache1: StmtCache1.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) StmtCache1

StmtCache2: StmtCache2.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) StmtCache2


RowId: RowId.class
	sqlplus hr/hr < books.sql
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) RowId

RowSet01: RowSet01.class
	sqlplus hr/hr < rowset.sql
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) RowSet01

RowSet02: RowSet02.class
	sqlplus hr/hr < rowset.sql
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) RowSet02

RowSet03: RowSet03.class
	sqlplus hr/hr < rowset.sql
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) RowSet03

RowSet04: RowSet04.class
	sqlplus hr/hr < rowset.sql
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) RowSet04

WebRowset01: WebRowset01.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) WebRowset01

ArrayExample: ArrayExample.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) ArrayExample

ORADataExample: ORADataExample.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) ORADataExample

# MODIFY_HERE: The binary files file1.bin and file2.bin must be present in 
# $(TMPDIR).  You could choose a different TIMPDIR
FileExample: FileExample.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) FileExample $(TMPDIR) manager

LobExample: LobExample.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) LobExample

OpenCloseLob: OpenCloseLob.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) OpenCloseLob

# MODIFY_HERE: The binary files file1.bin and file2.bin must be present in
# $(TMPDIR) You could choose a different TIMPDIR
PLSQL_FileExample: PLSQL_FileExample.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) PLSQL_FileExample $(TMPDIR) manager

PLSQL_LobExample: PLSQL_LobExample.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) PLSQL_LobExample

PersonObject: PersonObject.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) PersonObject

PersonRef: PersonRef.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) PersonRef

RefClient: RefClient.class
	sqlplus hr/hr < RefClient.sql
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL)  -DJDBC_URL_2=$(JDBC_URL_2) RefClient

SQLDataExample: SQLDataExample.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) SQLDataExample

TemporaryLob: TemporaryLob.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) TemporaryLob

TruncateLob: TruncateLob.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) TruncateLob

ConnectionWrapperSample: ConnectionWrapperSample.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) ConnectionWrapperSample

Svpt1.class: 
	- if [ ! -f "Svpt1.class" ]; then $(JAVAC) \
           -classpath $(CLASSPATH6g) -g Svpt1.java; fi 

Svpt1: Svpt1.class
	if [ $(DEBUG) ]; then $(JAVA) \
          -classpath $(CLASSPATH6g) -DJDBC_URL=$(JDBC_URL) \
          -Doracle.jdbc.Trace=true \
          -Djava.util.logging.config.file=$(ORACLELOGFILE) Svpt1; \
        else \
          $(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) Svpt1; fi
  
ProxySession01.class:
	- if [ ! -f "ProxySession01.class" ]; then $(JAVAC) \
           -classpath $(CLASSPATH6g) -g ProxySession01.java; fi

ProxySession01: ProxySession01.class
	sqlplus hr/hr < ProxySession01.sql
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) ProxySession01

ListRecoverableSQLExceptions: ListRecoverableSQLExceptions.class
	$(JAVA) -classpath $(CLASSPATH6) -DJDBC_URL=$(JDBC_URL) ListRecoverableSQLExceptions

clobber:
	rm -f *.class
	rm -f *.out
