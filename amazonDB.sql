CREATE DATABASE amazon;
USE amazon;

CREATE TABLE customer(
cust_id INT UNIQUE NOT NULL AUTO_INCREMENT,
cust_name VARCHAR(100) NOT NULL,
cust_addr VARCHAR(200) NOT NULL,
card_no INT UNIQUE NOT NULL,
PRIMARY KEY (cust_id)
);

SHOW TABLES;

CREATE TABLE orders(
order_id INT UNIQUE NOT NULL AUTO_INCREMENT,
fk_cust_id INT NOT NULL,
order_total DECIMAL(6,2) DEFAULT 0.00,
order_date DATETIME DEFAULT current_timestamp,
PRIMARY KEY(order_id),
FOREIGN KEY (fk_cust_id) REFERENCES customer(cust_id)
);

DESCRIBE customer;
DESCRIBE orders;

INSERT INTO customer(cust_name, cust_addr, card_no) VALUES('ash','1 abc lane',1234),('luke','2 x drive',1111),('john','5 z road',4322);

SELECT * FROM customer;

INSERT INTO orders(fk_cust_id) VALUES(3);

SELECT * FROM orders;

SELECT * FROM orders o JOIN customer c ON o.fk_cust_id=c.cust_id;
