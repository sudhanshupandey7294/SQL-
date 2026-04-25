/*
Window Functions
SELECT col1,col2 , win_fun OVER () FROM table_name;
*/
USE amazon;
SHOW TABLES;
SELECT * FROM employee;
UPDATE employee SET eadd='Delhi' WHERE eadd IS NULL;
SELECT eadd , SUM(esal) FROM employee GROUP BY eadd;
SELECT sum(esal) FROM employee;

# aggregate (behave like a win fun)
#SELECT *, SUM(esal)  FROM employee; 
 #we cannot print total salary column with each column so, we use window function
SELECT *, SUM(esal) OVER() AS Total_Budget FROM employee;

# IF we want to show total salary of particular department like hr, it, admin linkeed with the each department salary 
#like this----
   # eid     ename         eadd        desg        esal           Total
-- 154	Aman	Noida	Admin	     42784.00	                  42784.00
-- 103	Yogesh Saini	Noida	HR	36384.00	                121621.00
-- 106	Riya Sharma	Nanital	HR	85237.00	                   121621.00
-- 101	Rahul Sharma	Noida	IT	86523.00	               573798.00
-- 104	Shiva Yadav	Delhi	IT	95724.00	                   573798.00

SELECT * , SUM(esal) OVER (PARTITION BY edesg) AS Total FROM employee;   
#it shows total salary of IT ,HR, Admin beside the each "esal" of each column  ...This is only possible with window function

SELECT * , SUM(esal) OVER (PARTITION BY eadd ORDER BY esal)
AS Total FROM employee;

SELECT * , SUM(esal) OVER( ORDER BY esal) FROM employee;

# win_fun
# row_number

SELECT ename, esal, ROW_NUMBER() OVER() FROM employee;
SELECT ename,esal,ROW_NUMBER() OVER (ORDER BY ename)
AS RowNumber FROM employee;

SELECT ename , esal, ROW_NUMBER() OVER( ORDER BY esal DESC )
AS RowNo FROM employee;

#RANK
SELECT * , RANK() OVER (ORDER BY esal DESC) FROM employee; 

#IF some column has same rank then counter of rank incresed by 1 so dense rank prevent it from this situation 
# DENSE_RANK
SELECT * , DENSE_RANK() OVER (ORDER BY esal DESC)
AS rnk FROM employee; 

SELECT * , LAG (esal) OVER (ORDER BY esal) FROM employee;

# CTE (Common Table Expression)
/*
WITH new_table_name AS(
	Your Query;
) SELECT * FROM new_table_name;
*/
#Another example 
# FIND THE THIRD HIGHEST SALARY's EMPLOYEE DETAIL
WITH mytable AS (
SELECT * , DENSE_RANK() OVER (ORDER BY esal DESC) AS rnk FROM employee
) SELECT * FROM mytable WHERE rnk=3;

SELECT *, esal*0.20 AS Bonus FROM employee;
# we have created a column named as "Bonus" but ythis is only virtual,, if we want to print "Bonus" It will give error "Unknown column 'Bonus' 
SELECT Bonus FROM employee;# error
SELECT *, esal*0.20 AS Bonus FROM employee WHERE Bonus>6000; # error no Bonus column

# SO using CTE we can create a new column and add it in our virtualy created table

WITH myemployee_ AS (
SELECT *, esal*0.20 AS Bonus FROM employee
) SELECT * FROM myemployee_;         # NOW using CTE it will create a virtual table "myemployee" originated from "employee" table and run "Bonus"  

SELECT * FROM myemploye_; # IT will not work bacause myemployee is a virtual table 

#So we use "VIEW " widow fxn IT make the real new table of a preexisting table by the name of a virtual viewing table to print the virtual created column like "Bonus"
           
CREATE VIEW bonustable AS
SELECT *, esal*0.20 AS Bonus FROM employee;

SELECT* FROM bonustable;    # NOw Bonus column will be printed as real column using VIEW fxn
-- ename           eadd    eid  edesg  esal     Bonus    
-- Rahul Sharma	Noida	101	IT	86523.00	17304.6000
-- Yogesh Saini	Noida	103	HR	36384.00	7276.8000
-- Shiva Yadav	Delhi	104	IT	95724.00	19144.8000
-- Abhishek	GZB	105	IT	64269.00	12853.8000


# WINDOW FUNCTION
# NTILE  - It divides data into equal parts
SELECT * FROM employee;
SELECT * FROM employee ORDER BY esal DESC;
SELECT *,ROW_NUMBER() OVER (ORDER BY esal DESC) FROM employee;

SELECT *,NTILE(2) OVER (ORDER BY esal DESC) FROM employee; 
SELECT *,NTILE(4) OVER (ORDER BY esal DESC) FROM employee;
SELECT *,NTILE(3) OVER (ORDER BY esal DESC) FROM employee; 


# LAG
SELECT * FROM employee;
SELECT eid,ename,esal FROM employee;
SELECT eid,ename,esal,LAG(esal) OVER() AS PrevSalary FROM employee;
SELECT eid,ename,esal,LAG(esal) OVER(ORDER BY esal DESC)
AS PrevSalary FROM employee;


# LEAD 
SELECT * FROM employee;
SELECT eid,ename,esal FROM employee;
SELECT eid,ename,esal,LEAD(esal) OVER(ORDER BY esal) AS NextSalary
FROM employee;

# first_value
SELECT * FROM employee ORDER BY esal DESC LIMIT 1;
SELECT *,first_value( esal ) OVER( ORDER BY esal DESC) FROM employee;



