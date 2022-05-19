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

SELECT * FROM customer c JOIN orders o ON c.cust_id=o.fk_cust_id;
SELECT c.cust_name, o.order_id, o.order_total, o.order_date FROM customer c JOIN orders o ON c.cust_id=o.fk_cust_id;
SELECT c.cust_name, o.order_id, o.order_total, o.order_date, oi.quantity FROM customer c JOIN orders o ON c.cust_id=o.fk_cust_id JOIN orderitems oi ON oi.fk_order_id=o.order_id;


SELECT * FROM orders o JOIN customer c ON o.fk_cust_id=c.cust_id JOIN orderitems oi ON oi.fk_order_id=o.order_id JOIN items i ON oi.fk_item_id=i.item_id;

SELECT o.order_id, c.cust_id, c.cust_name, c.cust_addr, i.item_name, i.price, oi.quantity FROM orders o JOIN customer c ON o.fk_cust_id=c.cust_id JOIN orderitems oi ON oi.fk_order_id=o.order_id JOIN items i ON oi.fk_item_id=i.item_id;

DELETE FROM orders WHERE order_id=5;

UPDATE orderitems SET orderline_total=2 WHERE oi_id=4;

#AGGREGATE FUNCTIONS
SELECT SUM(stock) FROM items;
SELECT MIN(stock) FROM items;
SELECT MAX(stock) FROM items;
SELECT AVG(stock) FROM items;
SELECT COUNT(stock) FROM items;
#Details on the item with the least stock
SELECT * FROM items WHERE stock=(SELECT MIN(stock) FROM items);
#Group by:
SELECT * FROM orderitems;
SELECT fk_order_id,fk_item_id,MAX(orderline_total) FROM orderitems GROUP BY fk_order_id;#find the most expensive item in an order
SELECT fk_order_id,SUM(orderline_total) FROM orderitems GROUP BY fk_order_id;

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
INSERT INTO orderitems(fk_order_id,fk_item_id,quantity) VALUES(6,5,1);

SELECT * FROM items WHERE item_id=(SELECT fk_item_id FROM orderitems WHERE fk_order_id=(SELECT order_id FROM orders WHERE fk_cust_id=4) LIMIT 1);
SELECT fk_item_id FROM orderitems WHERE fk_order_id=(SELECT order_id FROM orders WHERE fk_cust_id=4) LIMIT 1;

SELECT * FROM items WHERE item_id=(SELECT fk_item_id FROM orderitems WHERE fk_order_id=(SELECT order_id FROM orders WHERE fk_cust_id=6));


UPDATE orderitems SET orderline_total=81.00 WHERE oi_id=1;

SELECT * FROM orderitems LIMIT 10;

#Write a query which updates the orderline_total to the price of the item multiplied by its quantity.
#price - items
select * from items;
#quantity - orderitems
select * from orderitems;
#orderitem 1
SELECT price FROM items WHERE item_id=2;#0.50
SELECT quantity FROM orderitems WHERE oi_id=1;#5
-- UPDATE orderitems SET orderline_total=() WHERE oi_id=1;

SELECT oi.oi_id, i.price, oi.quantity, i.price*oi.quantity AS total FROM items i JOIN orderitems oi ON i.item_id=oi.fk_item_id ORDER BY oi.oi_id LIMIT 1;

SELECT i.price*oi.quantity FROM items i JOIN orderitems oi ON i.item_id=oi.fk_item_id where oi.oi_id=1;

UPDATE orderitems SET orderline_total=(SELECT i.price*oi.quantity FROM items i JOIN orderitems oi ON i.item_id=oi.fk_item_id where oi.oi_id=1) WHERE oi_id=1;

SELECT price FROM items where item_id=1;
UPDATE orderitems SET orderline_total=(SELECT quantity FROM orderitems where fk_item_id=1) WHERE oi_id=2;


SELECT * FROM orders;
SELECT * FROM orderitems WHERE fk_order_id=1;
SELECT SUM(orderline_total) FROM orderitems WHERE fk_order_id=1;

UPDATE orders SET order_total=(SELECT SUM(orderline_total) FROM orderitems WHERE fk_order_id=1) WHERE order_id=1; 

UPDATE orderitems oi JOIN items i ON i.item_id=oi.fk_item_id SET orderline_total=i.price*oi.quantity WHERE oi_id=1;

