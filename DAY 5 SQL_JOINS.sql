CREATE DATABASE store;
USE store;
CREATE TABLE customer(
cid INT PRIMARY KEY AUTO_INCREMENT,
cname VARCHAR(30) NOT NULL,
cadd VARCHAR(100) NOT NULL,
cmob VARCHAR(15) UNIQUE NOT NULL);

INSERT INTO customer VALUES(101, 'Rohan singh',' Noida','9834357451');
INSERT INTO customer(cname, cadd, cmob) VALUES
('Mohan Singh','Delhi','9389483435'),
('Suresh Kumar','GZB','8752736834'),
("Riya Singh",'Noida','8623639745');

SELECT * FROM customer;

CREATE TABLE product(
pid INT PRIMARY KEY AUTO_INCREMENT,
pname VARCHAR(50) NOT NULL,
price DECIMAL (8,2));

INSERT INTO product VALUES(501,'Keyboard', 980);
INSERT INTO product(pname,price)VALUES
('Mouse',530),
("SSD",9750),
("HDD",4270),
("Monitor",5300);
SELECT * FROM product;

CREATE TABLE orders(
oid INT PRIMARY KEY AUTO_INCREMENT,
cid INT NOT NULL,
pid INT NOT NULL,
qty INT DEFAULT 1
);

INSERT INTO orders(cid,pid,qty) VALUES
(101, 501,5),
(102, 503, 2),
(104, 505, 4),
(107, 503, 8);

SELECT * FROM orders;

# JOIN
# JOIN is use to display data from more then one table
# JOIN / CROSS JOIN 

SELECT * FROM customer JOIN orders;
SELECT *  FROM customer CROSS JOIN orders;  # JOIN alone is a cross join ie, Union of both tables

# JOIN / INNER JOIN  (INTERSECTION/COMMON)
SELECT * FROM customer  JOIN  orders ON customer.cid=orders.cid;  ## when we use condition in JOIN then it is called INNER JOIN (common)
SELECT * FROM customer INNER JOIN orders ON customer.cid=orders.cid;  

SELECT * FROM customer INNER JOIN orders;   ## When we use INNER JOIN without condition then it will treat as cross join(Union) 

SELECT * FROM customer AS c JOIN orders AS o ON c.cid=o.cid;  # ALLias naming the tables from our side (order AS o customer AS c)

SELECT * FROM customer c JOIN orders o ON c.cid = o.cid;  # WE can give Alias without using "AS" command 
#---------------------------------------

SELECT * FROM customer
JOIN orders                       # "USING" command in place of "ON"
USING (cid);

SELECT * FROM customer c 
JOIN orders o ON c.cid=o.cid                            #INNER JOIN of all 3 tables
JOIN product p ON o.pid= p.pid;

SELECT c.*,pname,price, qty FROM customer c 
JOIN orders o
ON c.cid=o.cid
JOIN product p
ON o.pid=p.pid;

SELECT c.cid,cname,cadd,cmob,pname,price,qty, price*qty AS Amt FROM customer c
JOIN orders o
ON c.cid=o.cid
JOIN product p
ON p.pid=o.pid;


 
