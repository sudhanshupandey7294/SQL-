USE amazon;
SELECT * FROM employee;
START TRANSACTION; 
UPDATE employee SET esal=esal-10000 WHERE eid=103;
UPDATE employee SET esal=esal+10000 WHERE eid=104;
ROLLBACK;

# Aggregate Functions
# sum , count , max , min , avg

SELECT esal FROM employee;
SELECT SUM(esal) FROM employee;
SELECT MAX(esal) FROM employee;
SELECT MIN(esal) FROM employee;
SELECT AVG(esal) FROM employee;
SELECT count(*) FROM employee;

# Text Functions
# UPPER , LOWER , TRIM , LENGTH , SUBSTRING , REPLACE , CONCAT

SELECT * FROM employee;
SELECT ename FROM employee;
SELECT UPPER(ename) FROM employee;
SELECT LOWER(ename) FROM employee;
SELECT ename , LENGTH(ename) FROM employee;
SELECT CONCAT(ename," - ",eadd) FROM employee;
SELECT ename , TRIM(ename) FROM employee;  # remove extra spaces from leading and trailing
SELECT ename , SUBSTRING(ename,4) FROM employee;
SELECT ename , SUBSTRING(ename,1,3) FROM employee;
SELECT ename , UPPER(SUBSTRING(ename,1,3)) FROM employee;
SELECT replace("Hello India","India","World");
SELECT ename , REPLACE(ename,"S","Z") FROM employee;
SELECT email,REPLACE(email,"@gmail.com","@hotmail.com") FROM employee;


# Mathematical Functions
# ROUND , CEIL , FLOOR , MOD , POWER , RAND
SELECT esal , ROUND(esal) FROM employee;
SELECT esal , ROUND(esal,1) FROM employee;
SELECT esal , FLOOR(esal) FROM employee;
SELECT esal , CEIL(esal) FROM employee;
SELECT esal , MOD(esal , 100) FROM employee;
SELECT esal FROM employee;
SELECT esal ,FLOOR(esal/1000) AS KM , MOD(esal,1000) AS m FROM employee;
SELECT esal ,CONCAT(FLOOR(esal/1000) ,"KM ", MOD(esal,1000),"m")  FROM employee;
SELECT eid FROM employee;
SELECT eid,POWER(eid,2) FROM employee;
SELECT RAND();
SELECT RAND()*100;
SELECT CEIL(RAND()*100);

# DATE AND TIME FUNCTIONS
# NOW , TODAY , CURRENT_DATE , CURRENT_TIMESTAMP 

SELECT NOW();
SELECT CURDATE();
SELECT CURTIME();
SELECT CURRENT_TIMESTAMP();
SELECT CURRENT_DATE();
SELECT CURRENT_TIME();
SELECT YEAR(CURDATE());
SELECT MONTH(CURDATE());
SELECT DAY(CURDATE());

# Conditional Formula
# IF , IFNULL , NULLIF , CASE
SELECT * FROM employee;
SELECT ename , esal , IF(esal>85000,"HIGH","LOW") FROM employee;
SELECT * FROM employee;
SELECT ename,eadd FROM employee;
SELECT ename , IFNULL(eadd,"No Address") FROM employee;
SELECT * FROM employee;

SELECT ename , esal , IF(esal>85000,"HIGH","LOW") FROM employee;
SELECT ename , esal , 
	CASE
		WHEN esal>70000 THEN "Above_Average"
        WHEN esal>50000 THEN "Average_Salary"
		ELSE "Below Average" 
    END AS Status
FROM employee;