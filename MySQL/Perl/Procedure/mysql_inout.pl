use feature ':5.22';
use strict;
use warnings;
# Git CMD # > ppm install DBD-mysql
use DBI;
use Data::Dumper qw(Dumper);

# MySQL
my $dsn = "DBI:mysql:procdb";
my $username = "root";
my $password = 'My$ql@Server#5.7';

my $dbh = DBI->connect($dsn, $username, $password);

die "failed to connect to MySQL database:DBI->errstr()" unless($dbh);

say "Connected to MySQL Server successfully."; 

my $sth = $dbh->prepare("CALL prepend('abcdefg', \@inOutParam);") or die "prepare statement failed: $dbh->errstr()";
 
$sth->execute() or die "execution failed: $dbh->errstr()"; 

# $sth->dump_results();

my $row = $sth->fetchrow();

say($row); 

$sth->more_results;

# $sth->dump_results();

$row = $sth->fetchrow();

say($row); 

$sth->finish();

$dbh->disconnect();


=pod
DROP DATABASE IF EXISTS procdb;
DELIMITER $$
CREATE DATABASE procdb;$$
DELIMITER ;


USE procdb;
DROP PROCEDURE IF EXISTS multiply;
DELIMITER $$
CREATE PROCEDURE multiply
(
 IN pFac1 INT, 
 IN pFac2 INT, 
 OUT pProd INT
)
BEGIN
  SET pProd := pFac1 * pFac2;
END;$$
DELIMITER ;

USE procdb;
CALL multiply(5, 5, @Result);
SELECT @Result;


USE procdb;
DROP PROCEDURE IF EXISTS concat;
DELIMITER $$
CREATE PROCEDURE concat
(
 IN pStr1 VARCHAR(20), 
 IN pStr2 VARCHAR(20),
 OUT pConCat VARCHAR(100)
)
BEGIN
  SET pConCat := CONCAT(pStr1, pStr2);
END;$$
DELIMITER ;

USE procdb;
CALL concat('My', 'SQL', @Result);
SELECT @Result;


USE procdb;
DROP PROCEDURE IF EXISTS prepend;
DELIMITER $$
CREATE PROCEDURE prepend
(
 IN inParam VARCHAR(255), 
 INOUT inOutParam INT
)
BEGIN
 DECLARE z INT;
 SET z = inOutParam + 1;
 SET inOutParam = z;
 SELECT inParam;
 SELECT CONCAT('zyxw', inParam);
END;$$
DELIMITER ;

USE procdb;
CALL prepend('abcdefg', @inOutParam);
=cut