use feature ':5.22';
use strict;
use warnings;
# Git CMD # > ppm install DBD-Pg
use DBI;

# PostgreSQL
my $dsn = "DBI:Pg:dbname=sampledb";
my $username = "postgres";
my $password = "P0stgre\$ql\@Server#9.5";
my $dbh = DBI->connect($dsn, $username, $password);

die "failed to connect to MySQL database:DBI->errstr()" unless($dbh);

say "Connected to PostgreSQL Server successfully."; 

my $sth = $dbh->prepare("SELECT * FROM users;") or die "prepare statement failed: $dbh->errstr()";
 
$sth->execute() or die "execution failed: $dbh->errstr()"; 

$sth->dump_results();

=pod
# "my" variable $username masks earlier declaration in same scope # $user_name
# my ($id, $user_name, $login_date, $login_time, $created_at, $updated_at);
 
while(my ($id, $user_name, $login_date, $login_time, $created_at, $updated_at) = $sth->fetchrow()) {
    say("$id $user_name $login_date $login_time $created_at $updated_at");                   
}
=cut
 
$sth->finish();

$dbh->disconnect();


=pod
DROP DATABASE IF EXISTS sampledb;

CREATE DATABASE sampledb;

-- \connect sampledb;

DROP TABLE IF EXISTS users;
CREATE TABLE users
(
    id SERIAL NOT NULL,
    username VARCHAR(50) NOT NULL, 
    login_date DATE NOT NULL DEFAULT CURRENT_DATE,
    login_time TIME NOT NULL DEFAULT CURRENT_TIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    
    CONSTRAINT pk_id PRIMARY KEY(id),
    CONSTRAINT idx_username UNIQUE(username)    
);

SELECT * FROM users;

INSERT INTO users(username, login_date, login_time, created_at, updated_at)
VALUES('Foo', '2016-11-06', '10:49:35', '2016-11-06 10:49:35.0', '2016-11-06 10:49:35.0');

SELECT * FROM users;
=cut