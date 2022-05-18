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
FOREIGN KEY (fk_cust_id) REFERENCES customer(cust_id) ON DELETE CASCADE
);

DESCRIBE customer;
DESCRIBE orders;

INSERT INTO customer(cust_name, cust_addr, card_no) VALUES('ash','1 abc lane',1234),('luke','2 x drive',1111),('john','5 z road',4322);
INSERT INTO customer(cust_name, cust_addr, card_no) VALUES('eeyore','tbc',3232),('mickey','disney land',2222);
SELECT * FROM customer;

INSERT INTO orders(fk_cust_id) VALUES(3);
INSERT INTO orders(fk_cust_id) VALUES(5),(2),(1),(4);
SELECT * FROM orders;
SELECT * FROM orders o JOIN customer c ON o.fk_cust_id=c.cust_id;

CREATE TABLE items(
item_id INT UNIQUE NOT NULL AUTO_INCREMENT,
item_name VARCHAR(100) NOT NULL,
price DECIMAL(6,2) NOT NULL,
stock INT,
PRIMARY KEY (item_id)
);

INSERT INTO items(item_name,price,stock) VALUES('Pepsi',1.50,234),('Kinder bar',0.50,1200),('Hobbit book',21.99,56),('Big teddy',30.00,112),('Dreamcatcher',60.00,500);
SELECT * FROM items;

CREATE TABLE orderitems(
oi_id INT UNIQUE NOT NULL AUTO_INCREMENT,
fk_order_id INT NOT NULL,
fk_item_id INT NOT NULL,
quantity INT,
orderline_total DECIMAL(6,2) DEFAULT 0.00,
PRIMARY KEY(oi_id),
FOREIGN KEY (fk_order_id) REFERENCES orders(order_id),
FOREIGN KEY (fk_item_id) REFERENCES items(item_id)
);

INSERT INTO orderitems(fk_order_id,fk_item_id,quantity) VALUES(1,2,5),(1,5,1),(2,3,2),(3,4,1),(4,1,10),(5,1,2),(2,4,1),(2,5,2),(1,1,8),(5,3,1);
SELECT * FROM orderitems;

SELECT * FROM orders o JOIN customer c ON o.fk_cust_id=c.cust_id JOIN orderitems oi ON oi.fk_order_id=o.order_id JOIN items i ON oi.fk_item_id=i.item_id;
SELECT o.order_id, c.cust_id, c.cust_name, c.cust_addr, i.item_name, i.price, oi.quantity FROM orders o JOIN customer c ON o.fk_cust_id=c.cust_id JOIN orderitems oi ON oi.fk_order_id=o.order_id JOIN items i ON oi.fk_item_id=i.item_id;

DELETE FROM orders WHERE order_id=5;

#AGGREGATE FUNCTIONS
SELECT SUM(stock) FROM items;
SELECT MIN(stock) FROM items;
SELECT MAX(stock) FROM items;
SELECT AVG(stock) FROM items;
SELECT COUNT(stock) FROM items;

#NESTED QUERIES - query within a query - select within a select
SELECT fk_cust_id FROM orders WHERE order_id=2;
SELECT * FROM customer WHERE cust_id=5;

SELECT * FROM customer WHERE cust_id=(SELECT fk_cust_id FROM orders WHERE order_id=2);

SELECT fk_item_id FROM orderitems WHERE oi_id=2;
SELECT * FROM items WHERE item_id=5;

SELECT * FROM items WHERE item_id=(SELECT fk_item_id FROM orderitems WHERE oi_id=2);

SELECT * FROM customer WHERE cust_id=4;
SELECT * FROM orders WHERE fk_cust_id=4;
SELECT * FROM orderitems WHERE fk_order_id=5;
SELECT * FROM items WHERE item_id=1;
-- SELECT * FROM items WHERE item_id=3;
-- SELECT * FROM items WHERE item_id=1 OR item_id=3;

INSERT INTO customer(cust_name, cust_addr, card_no) VALUES('A','A',1);
INSERT INTO orders(fk_cust_id) VALUES(6);

SELECT * FROM items WHERE item_id=(SELECT fk_item_id FROM orderitems WHERE fk_order_id=(SELECT order_id FROM orders WHERE fk_cust_id=4) LIMIT 1);
SELECT fk_item_id FROM orderitems WHERE fk_order_id=(SELECT order_id FROM orders WHERE fk_cust_id=4) LIMIT 1;

