DROP DATABASE IF EXISTS spdb;
DELIMITER $$
CREATE DATABASE spdb;$$
DELIMITER ;

USE spdb;

DROP TABLE IF EXISTS `customer`;
DELIMITER $$
CREATE TABLE `customer` (
  `customer_id` int unsigned NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `date_of_bith` date NOT NULL,
  `income` double NOT NULL,
  `credit_limit` decimal(10,2) DEFAULT NULL,
  `create_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`)
);$$
DELIMITER ;

SELECT * FROM customer;

USE spdb;

INSERT INTO 
`customer`
(`customer_name`, `email`, `date_of_bith`, `income`, `credit_limit`) 
VALUES
('Bill Gates', 'billgates@microsoft.com', '1955-10-28', 97.9, 9.79);

INSERT INTO 
`customer`
(`customer_name`, `email`, `date_of_bith`, `income`, `credit_limit`) 
VALUES
('Paul Allen', 'paulallen@microsoft.com', '1953-01-21', 20.2, 2.02);

INSERT INTO 
`customer`
(`customer_name`, `email`, `date_of_bith`, `income`, `credit_limit`) 
VALUES
('Larry Page', 'larrypage@abc.xyz', '1973-3-26', 55.2, 5.52);

INSERT INTO 
`customer`
(`customer_name`, `email`, `date_of_bith`, `income`, `credit_limit`) 
VALUES
('Sergey Brin', 'sergeybrin@abc.xyz', '1973-08-21', 55.7, 5.57);

INSERT INTO 
`customer`
(`customer_name`, `email`, `date_of_bith`, `income`, `credit_limit`) 
VALUES
('Tim Cook', 'timcook@apple.com', '1960-11-01', 0.78, 0.07);

INSERT INTO 
`customer`
(`customer_name`, `email`, `date_of_bith`, `income`, `credit_limit`) 
VALUES
('Steve Wozniak', 'stevewozniak@apple.com', '1950-08-11', 0.1, 0.01);

INSERT INTO 
`customer`
(`customer_name`, `email`, `date_of_bith`, `income`, `credit_limit`) 
VALUES
('Jeff Bezos', 'jeffbezos@amazon.com', '1964-01-12', 165.0, 16.50);

INSERT INTO 
`customer`
(`customer_name`, `email`, `date_of_bith`, `income`, `credit_limit`) 
VALUES
('Mark Zuckerberg', 'markzuckerberg@facebook.com', '1984-05-14', 67.1, 6.71);

INSERT INTO 
`customer`
(`customer_name`, `email`, `date_of_bith`, `income`, `credit_limit`) 
VALUES
('Pierre Omidyar', 'pierreomidyar@ebay.com', '1967-06-21', 10.5, 1.05);

INSERT INTO 
`customer`
(`customer_name`, `email`, `date_of_bith`, `income`, `credit_limit`) 
VALUES
('Elon Musk', 'elonmusk@tesla.com', '1971-06-28', 19.8, 1.98);

USE spdb;

SELECT * FROM customer;


USE spdb;

DROP TABLE IF EXISTS `rental`;
DELIMITER $$

CREATE TABLE `rental` (
  `rental_id` int(11) NOT NULL AUTO_INCREMENT,
  `rental_date` datetime NOT NULL,
  `customer_id` int unsigned NOT NULL,
  `return_date` datetime DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`rental_id`),
  CONSTRAINT `fk_rental_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`) ON UPDATE CASCADE
);$$
DELIMITER ;

SELECT * FROM rental;

USE spdb;
INSERT INTO `rental`
(`rental_date`, `customer_id`, `return_date`, `status`)
VALUES
('2018-01-01', 1, '2018-01-22', 'Shipped'),
('2018-01-02', 1, '2018-01-23', 'Shipped'),
('2018-01-03', 1, '2018-01-24', 'Canceled'),
('2018-01-04', 1, '2018-01-25', 'Resolved'),
('2018-01-05', 1, '2018-01-26', 'Disputed'),
('2018-01-06', 1, '2018-01-27', 'Shipped'),
('2018-01-07', 1, '2018-01-28', 'Shipped'),
('2018-01-08', 1, '2018-01-29', 'Resolved'),
('2018-01-09', 1, '2018-01-30', 'Shipped'),
('2018-01-10', 1, '2018-01-31', 'Shipped'),

('2018-02-01', 2, '2018-02-19', 'Shipped'),
('2018-02-02', 2, '2018-02-20', 'Shipped'),
('2018-02-03', 2, '2018-02-21', 'Canceled'),
('2018-02-04', 2, '2018-02-22', 'Resolved'),
('2018-02-05', 2, '2018-02-23', 'Canceled'),
('2018-02-06', 2, '2018-02-24', 'Resolved'),
('2018-02-07', 2, '2018-02-25', 'Disputed'),
('2018-02-08', 2, '2018-02-26', 'Resolved'),
('2018-02-09', 2, '2018-02-27', 'Resolved'),
('2018-02-10', 2, '2018-02-28', 'Shipped'),

('2018-03-01', 3, '2018-03-22', 'Shipped'),
('2018-03-02', 3, '2018-03-23', 'Shipped'),
('2018-03-03', 3, '2018-03-24', 'Canceled'),
('2018-03-04', 3, '2018-03-25', 'Resolved'),
('2018-03-05', 3, '2018-03-26', 'Disputed'),
('2018-03-06', 3, '2018-03-27', 'Resolved'),
('2018-03-07', 3, '2018-03-28', 'Disputed'),
('2018-03-08', 3, '2018-03-29', 'Resolved'),
('2018-03-09', 3, '2018-03-30', 'Shipped'),
('2018-03-10', 3, '2018-03-31', 'Shipped'),

('2018-04-01', 4, '2018-04-21', 'Shipped'),
('2018-04-02', 4, '2018-04-22', 'Canceled'),
('2018-04-03', 4, '2018-04-23', 'Shipped'),
('2018-04-04', 4, '2018-04-24', 'Resolved'),
('2018-04-05', 4, '2018-04-25', 'Disputed'),
('2018-04-06', 4, '2018-04-26', 'Resolved'),
('2018-04-07', 4, '2018-04-27', 'Disputed'),
('2018-04-08', 4, '2018-04-28', 'Resolved'),
('2018-04-09', 4, '2018-04-29', 'Shipped'),
('2018-04-10', 4, '2018-04-30', 'Shipped'),


('2018-05-01', 5, '2018-05-22', 'Shipped'),
('2018-05-02', 5, '2018-05-23', 'Shipped'),
('2018-05-03', 5, '2018-05-24', 'Shipped'),
('2018-05-04', 5, '2018-05-25', 'Resolved'),
('2018-05-05', 5, '2018-05-26', 'Disputed'),
('2018-05-06', 5, '2018-05-27', 'Canceled'),
('2018-05-07', 5, '2018-05-28', 'Shipped'),
('2018-05-08', 5, '2018-05-29', 'Resolved'),
('2018-05-09', 5, '2018-05-30', 'Shipped'),
('2018-05-10', 5, '2018-05-31', 'Shipped'),

('2018-06-01', 6, '2018-06-21', 'Canceled'),
('2018-06-02', 6, '2018-06-22', 'Shipped'),
('2018-06-03', 6, '2018-06-23', 'Canceled'),
('2018-06-04', 6, '2018-06-24', 'Resolved'),
('2018-06-05', 6, '2018-06-25', 'Disputed'),
('2018-06-06', 6, '2018-06-26', 'Resolved'),
('2018-06-07', 6, '2018-06-27', 'Disputed'),
('2018-06-08', 6, '2018-06-28', 'Resolved'),
('2018-06-09', 6, '2018-06-29', 'Resolved'),
('2018-06-10', 6, '2018-06-30', 'Shipped'),

('2018-07-01', 7, '2018-07-22', 'Shipped'),
('2018-07-02', 7, '2018-07-23', 'Shipped'),
('2018-07-03', 7, '2018-07-24', 'Canceled'),
('2018-07-04', 7, '2018-07-25', 'Resolved'),
('2018-07-05', 7, '2018-07-26', 'Disputed'),
('2018-07-06', 7, '2018-07-27', 'Shipped'),
('2018-07-07', 7, '2018-07-28', 'Shipped'),
('2018-07-08', 7, '2018-07-29', 'Shipped'),
('2018-07-09', 7, '2018-07-30', 'Resolved'),
('2018-07-10', 7, '2018-07-31', 'Shipped'),

('2018-08-01', 8, '2018-08-22', 'Shipped'),
('2018-08-02', 8, '2018-08-23', 'Shipped'),
('2018-08-03', 8, '2018-08-24', 'Disputed'),
('2018-08-04', 8, '2018-08-25', 'Resolved'),
('2018-08-05', 8, '2018-08-26', 'Canceled'),
('2018-08-06', 8, '2018-08-27', 'Shipped'),
('2018-08-07', 8, '2018-08-28', 'Shipped'),
('2018-08-08', 8, '2018-08-29', 'Shipped'),
('2018-08-09', 8, '2018-08-30', 'Resolved'),
('2018-08-10', 8, '2018-08-31', 'Shipped'),

('2018-09-01', 9, '2018-09-21', 'Canceled'),
('2018-09-02', 9, '2018-09-22', 'Resolved'),
('2018-09-03', 9, '2018-09-23', 'Canceled'),
('2018-09-04', 9, '2018-09-24', 'Shipped'),
('2018-09-05', 9, '2018-09-25', 'Disputed'),
('2018-09-06', 9, '2018-09-26', 'Resolved'),
('2018-09-07', 9, '2018-09-27', 'Disputed'),
('2018-09-08', 9, '2018-09-28', 'Resolved'),
('2018-09-09', 9, '2018-09-29', 'Resolved'),
('2018-09-10', 9, '2018-09-30', 'Shipped'),

('2018-10-01', 10, '2018-10-22', 'Shipped'),
('2018-10-02', 10, '2018-10-23', 'Shipped'),
('2018-10-03', 10, '2018-10-24', 'Disputed'),
('2018-10-04', 10, '2018-10-25', 'Resolved'),
('2018-10-05', 10, '2018-10-26', 'Canceled'),
('2018-10-06', 10, '2018-10-27', 'Resolved'),
('2018-10-07', 10, '2018-10-28', 'Shipped'),
('2018-10-08', 10, '2018-10-29', 'Shipped'),
('2018-10-09', 10, '2018-10-30', 'Shipped'),
('2018-10-10', 10, '2018-10-31', 'Shipped');

SELECT * FROM rental;
SELECT count(*) FROM rental;

USE spdb;
SELECT * FROM rental;
SELECT count(*) FROM rental;