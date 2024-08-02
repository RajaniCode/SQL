require 'mysql2'

begin
 puts "Connecting to MySQL database..."
 client = Mysql2::Client.new(:host => "localhost", :username => "root", :password => "My$ql@Server#5.7", :database => "classicmodels") 
 if client.ping
  puts "...connection established."
 else
  puts "...connection failed."
 end
 # results = client.query("SELECT * FROM customers ORDER BY customerNumber DESC LIMIT 2;")
 results = client.query("SELECT * FROM customers;")
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
  puts "Connection closed."
 end
end