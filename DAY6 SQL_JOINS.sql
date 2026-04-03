USE store;
SELECT * FROM customer;
SELECT c.*,pname,price,qty,price*qty AS Amount,
 price*qty*0.18 AS TAX,price*qty+price*qty*0.18 AS NetAmount
 FROM customer c JOIN orders o ON c.cid=o.cid JOIN product p ON p.pid= o.pid;
 
 # LEFT / LEFT OUTER Join
 SELECT * FROM customer c 
 LEFT JOIN orders o ON c.cid=o.cid; 
 
  SELECT * FROM customer c 
 LEFT OUTER JOIN orders o ON c.cid=o.cid;
 
 #RIGHT /RIGHT OUTER Join
 SELECT * FROM customer c 
 RIGHT JOIN orders o ON c.cid=o.cid; 
 
 SELECT * FROM customer c 
 RIGHT OUTER JOIN orders o ON c.cid=o.cid;
 
 # FULL OUTER JOIN ( DO NOT SUPPORT IN MySQL )
# UNION
SELECT * FROM customer c
LEFT JOIN orders o
ON c.cid = o.cid
UNION
SELECT * FROM customer c
RIGHT JOIN orders o
ON c.cid = o.cid;

# SELF JOIN
SELECT * FROM customer c1
JOIN customer c2
ON c1.cid = c2.cid;


 