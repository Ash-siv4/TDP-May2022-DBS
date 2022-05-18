#View all databases - DDL
show databases;

#Create a new database -DDL
create database mcdonalds;

#Creates a new database if it doesn't exist - DDL
create database if not exists mcdonalds;

#Use a specific databse
use mcdonalds;

#View all the tables in the specified database
show tables;

#Create a table - DDL
CREATE TABLE items (
    id INT UNIQUE NOT NULL AUTO_INCREMENT,
    item_name VARCHAR(100) NOT NULL,
    #1234.56
    price DECIMAL(6,2) NOT NULL,
    descript VARCHAR(255) DEFAULT 'Description TBC',
    PRIMARY KEY (id)
    );
    
#Describes the tables definition
DESCRIBE items;

#View what is in a table - DML
SELECT * FROM items;

SELECT item_name, price FROM items;

SELECT item_name FROM items WHERE price > 2;

SELECT item_name FROM items WHERE price > 2 & price <= 3.50; 

SELECT * FROM items WHERE price != 1.50;

SELECT * FROM items WHERE item_name='Fries';

SELECT * FROM items WHERE item_name LIKE '%Mc%';

SELECT * FROM items WHERE price BETWEEN 1.5 AND 3;

SELECT * FROM items ORDER BY item_name ASC;#ASCENDING ORDER
SELECT * FROM items ORDER BY item_name DESC;#DESCENDING ORDER

SELECT * FROM items LIMIT 3;

SELECT * FROM items ORDER BY id DESC LIMIT 2;

#Add a new record - DML
INSERT INTO items(item_name, price, descript) VALUES('Fries',0.99,'');
INSERT INTO items(item_name, price) VALUES('McSpicy',3.99),('Mozzerella',1.99),('McFlurry5',1.50);

#Update a record - DML
UPDATE items SET descript='cheesy' WHERE id=3;

#Delete a record - DML
DELETE FROM items WHERE id=2;

#Updating the schema (table/database layout) -DDL
#add another colum to the table
ALTER TABLE items ADD `description` VARCHAR(250);
#modifying existing columns
ALTER TABLE items MODIFY item_name VARCHAR(150) NOT NULL;
#removing a column from the table
ALTER TABLE items DROP COLUMN descript;

#Delete a table/databse - DDL
DROP TABLE items;

DROP DATABASE mcdonalds;


#Different types of SQL queries
#         C          R         U         D
# DDL    CREATE    SHOW      ALTER     DROP
# DML    INSERT    SELECT    UPDATE    DELETE

# DDL - Data Definition Lanuage - defining the schema
# DML - Data Manipulation Language - manipulating the data/records
