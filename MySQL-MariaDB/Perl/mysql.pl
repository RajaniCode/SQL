use feature ':5.22';
use strict;
use warnings;
# Git CMD # > ppm install DBD-mysql
use DBI;

# MySQL
my $dsn = "DBI:mysql:sampledb";
my $username = "root";
my $password = 'My$ql@Server#5.7';

my $dbh = DBI->connect($dsn, $username, $password);

die "failed to connect to MySQL database:DBI->errstr()" unless($dbh);

say "Connected to MySQL Server successfully."; 

# my $sth = $dbh->prepare("SELECT * FROM users;") or die "prepare statement failed: $dbh->errstr()";
my $sth = $dbh->prepare("SELECT id, username, login_date, login_time, created_at, updated_at FROM users;") or die "prepare statement failed: $dbh->errstr()";

$sth->execute() or die "execution failed: $dbh->errstr()"; 

$sth->dump_results();

=pod
# "my" variable $username masks earlier declaration in same scope # $user_name
# my ($id, $user_name, $login_date, $login_time, $created_at, $updated_at);
 
my $row_count = 0;
while(my ($id, $user_name, $login_date, $login_time, $created_at, $updated_at) = $sth->fetchrow()) {
    say("$id $user_name $login_date $login_time $created_at $updated_at");
    $row_count++;                
}
say("Number of Row(s) = $row_count");
=cut
 
$sth->finish();

$dbh->disconnect();


=pod
DROP DATABASE IF EXISTS `sampledb`;
CREATE DATABASE `sampledb`;

USE `sampledb`;

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`
(
    `id` INT NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(50) NOT NULL, 
    `login_date` DATE NOT NULL,
    `login_time` TIME NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,    
    CONSTRAINT `pk_id` PRIMARY KEY(`id`),
    CONSTRAINT `idx_username` UNIQUE(`username`)    
);

SELECT * FROM users;

INSERT INTO users(username, login_date, login_time, created_at, updated_at)
VALUES('Foo', '2016-11-06', '10:49:35', '2016-11-06 10:49:35.0', '2016-11-06 10:49:35.0');

SELECT * FROM users;
=cut