/*
Sub-Query:- A query in a query is called sub-query. or
# A query inside a query

*/
USE amazon;
SHOW TABLES;
SELECT * FROM employee;
# 2nd Highest Salary Employee
SELECT * FROM employee ORDER BY esal DESC LIMIT 1 OFFSET 1;

# 1st Highest max Salary
SELECT max(esal) FROM employee;
# 2nd Highest max Salary
SELECT max(esal) FROM employee WHERE esal<97527.46;
# 2nd Highest Salary with sub-query
SELECT max(esal) FROM employee 
WHERE esal<(SELECT max(esal) FROM employee);

SELECT * FROM employee;
# SHOW ALL EMPPLOYEES WHO EARN LESS THEN AVERAGE SALARY
SELECT * FROM employee 
WHERE esal<(SELECT avg(esal) FROM employee);

# SHOW ALL EMPPLOYEES WHO EARN ABOVE THEN AVERAGE SALARY
SELECT * FROM employee 
WHERE esal>(SELECT avg(esal) FROM employee);

# SHOW name of the employees who are from noida city using their eid
SELECT ename FROM employee;
SELECT ename FROM employee WHERE eadd='Noida';
SELECT ename FROM employee WHERE 
eid IN (SELECT eid FROM employee WHERE eadd='Noida');

USE store;
# PRINT the name of the customers of have placed the orders
SELECT cname FROM customer AS c WHERE EXISTS 
(SELECT * FROM orders AS o WHERE c.cid = o.cid);

# PRINT the name of the customers of had not placed the orders
SELECT cname FROM customer AS c WHERE NOT EXISTS 
(SELECT * FROM orders AS o WHERE c.cid = o.cid);

USE amazon;
SELECT eid,ename,esal,(SELECT avg(esal) FROM employee) FROM employee;
SELECT eid,ename,esal,avg(esal) OVER() FROM employee;

SELECT * FROM employee;
SELECT * FROM employee WHERE esal>50000 AND eadd='Delhi';

SELECT * FROM 
(SELECT eid,ename,eadd,esal FROM employee WHERE eadd='Delhi')
AS newTable WHERE esal>50000; 