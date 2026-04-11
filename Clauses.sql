/*
Clauses
*/
CREATE DATABASE amazon;
USE amazon;
CREATE TABLE employee(
eid INT PRIMARY KEY AUTO_INCREMENT , 
ename VARCHAR(100) NOT NULL ,
eadd VARCHAR(100) NOT NULL ,
edesg VARCHAR(100) NOT NULL,
esal DECIMAL(8,2) DEFAULT 0.0
);
INSERT INTO employee VALUES
(101,'Rahul Sharma','Noida','IT',86523),
(102,'Simran Khurana','Delhi','HR',46764),
(103,'Yogesh Saini','Noida','HR',56384),
(104,'Shiva Yadav','Delhi','IT',75724),
(105,'Abhishek','GZB','IT',64269);

# SELECT
SELECT * FROM employee;
# FROM
SELECT * FROM employee;
# WHERE
SELECT * FROM employee WHERE esal>60000;
SELECT * FROM employee WHERE eadd='Delhi';

# DISTINCT
SELECT eadd FROM employee;
SELECT DISTINCT eadd FROM employee;

# Aggregate Functions
#   sum , avg , min , max , count
SELECT esal FROM employee;
SELECT sum(esal) FROM employee;
SELECT min(esal) FROM employee;
SELECT max(esal) FROM employee;
SELECT count(esal) FROM employee;
SELECT count(*) FROM employee;
SELECT avg(esal) FROM employee;

# HOW MANY CITIES WE HAVE 
SELECT COUNT(DISTINCT eadd) FROM employee;

# ORDER BY  (use to sort)
SELECT * FROM employee;
SELECT * FROM employee ORDER BY esal;   # By default -> ASC
SELECT * FROM employee ORDER BY esal ASC;
SELECT * FROM employee ORDER BY esal DESC;

# LIMIT
SELECT * FROM employee;
SELECT * FROM employee LIMIT 2;

# NAME OF THE HIGHEST SALARY EMPLOYEE
SELECT * FROM employee ORDER BY esal DESC LIMIT 1;
# NAME OF THE LOWEST SALARY EMPLOYEE
SELECT * FROM employee ORDER BY esal ASC LIMIT 1;

# OFFSET
SELECT * FROM employee LIMIT 2 OFFSET 2;

# SECOND HIGHEST SALARY
SELECT * FROM employee ORDER BY esal DESC LIMIT 1 OFFSET 1;

# GROUP BY
SELECT sum(esal) FROM employee;
SELECT sum(esal) FROM employee GROUP BY edesg;
SELECT edesg,sum(esal) FROM employee GROUP BY edesg;
SELECT eadd,sum(esal) FROM employee GROUP BY eadd;

# SALARIES IN EVERY ADDRES IN ASCENDING ORDER
SELECT eadd, sum(esal) FROM employee GROUP BY eadd ORDER BY sum(esal);
SELECT eadd, sum(esal) AS Salary FROM employee GROUP BY eadd ORDER BY Salary;

# HAVING
SELECT eadd, sum(esal) FROM employee GROUP BY eadd
HAVING sum(esal)>100000;

SELECT * FROM employee WHERE esal>60000;
SELECT * FROM employee HAVING esal>60000;   # Where and Having are same but we cannot use WHERE with GROUPBY ...

# JOIN
# ON
# USING

# LIKE 
# WILDCARD  ( % , _ )
SELECT * FROM employee;
INSERT INTO employee(ename,eadd,edesg,esal) VALUES
('Riya Sharma','Nanital','HR',85237),
('Siya Singh','Nagpur','IT',64237);

SELECT * FROM employee;
SELECT * FROM employee WHERE eadd='Noida';


# LIKE
SELECT * FROM employee WHERE eadd LIKE 'Noida';
SELECT * FROM employee WHERE eadd LIKE 'N%';
SELECT * FROM employee WHERE eadd LIKE 'Na%';

SELECT * FROM employee WHERE eadd LIKE '%i%';
SELECT * FROM employee WHERE eadd LIKE '%i';

SELECT * FROM employee WHERE ename LIKE "R%";

# _
SELECT * FROM employee WHERE eadd LIKE '_a%';
SELECT * FROM employee WHERE eadd LIKE '__i%';

# AND OR NOT
SELECT * FROM employee;
SELECT * FROM employee WHERE eadd!='Noida';
SELECT * FROM employee WHERE NOT eadd='Noida';

SELECT * FROM employee WHERE esal>50000 AND eadd='Delhi';
SELECT * FROM employee WHERE esal>50000 AND esal<80000;

SELECT * FROM employee WHERE esal>80000 OR eadd='Noida';

# BETWEEN , IN
SELECT * FROM employee WHERE esal BETWEEN 50000 AND 80000;
SELECT * FROM employee WHERE eadd IN ('Noida','Delhi');

# UNION , UNION ALL

# CASE
SELECT * FROM employee;

SELECT * ,
CASE 
	WHEN esal<50000 THEN 'Below_Average'
    WHEN esal<80000 THEN 'Average'
	ELSE 'Above_Average'
END AS 'Status'
FROM employee; 