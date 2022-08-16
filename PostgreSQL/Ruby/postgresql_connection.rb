require 'pg'

begin
 conn = PG::Connection.open(:host => "localhost", :user => "postgres", :password => "P0stgre$ql@Server#9.5", :dbname => "sampledb")
 puts("Connected to the PostgreSQL server successfully.")
 # puts(conn.class.instance_methods(false)) 
 # puts(conn.class.methods(false)) 
 # puts(conn.status)
 # puts(conn.class.ping)
rescue PG::Error => e
 puts e.message
ensure
 if !conn.nil?
  conn.close 
 end
end


=begin
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
=end