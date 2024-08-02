require 'mysql2'

begin
 puts "Connecting to MySQL database..."
 client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "My$ql@Server#5.7", :database => "sampledb") 
 if client.ping
  puts "...connection established."
 else
  puts "...connection failed."
 end
 # results = client.query("SELECT * FROM users;")
 results = client.query("SELECT id, username, login_date, login_time, created_at, updated_at FROM users;");
 if !results.nil?
  # puts results.count
  results.each do |row|
   counter = 0
   row.each do |column|
    x = column[1]
    if x.nil?
     print "nil" 
    elsif x.class.equal? BigDecimal
      print "%.2f" % x
    else
      print x
    end
    counter = counter + 1
    if counter <  row.count
     print " - "
    end
   end
   puts 
  end
 end
rescue Mysql2::Error => e
 puts e.errno
 puts e.error
ensure
 if !client.nil?
  client.close 
  puts "Connection close."
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