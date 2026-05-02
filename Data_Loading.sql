CREATE DATABASE DATASET;
USE DATASET;
CREATE TABLE emp
(eid INT,
ename VARCHAR(100),
eadd VARCHAR(100),
esal VARCHAR (100) );

# DATA LOADING 
-- LOAD DATA LOCAL INFILE '"C:/Users/sudhanshu pandey/Desktop/employee.csv"'
-- INTO TABLE emp
-- FIELDS TERMINATED BY ','
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;

-- SET GLOBAL local in_file = 1;

#LOCAL IS NOT VALID 
# IT will say "loading LOCAL data is disabled. this must be enabled on both the client and server sides...
# since, LOCAL cannot load on the server side data it only load client side data thats why it show error so we used SET GLOBAL local_infile =1 as it was 0 ie.false before but after
# ET GLOBAL local_infile =1; IT also give error of " request rerjected due to file access restriction" so better is not to use 'LOCAL'

LOAD DATA  INFILE "C:/Users/sudhanshu pandey/Desktop/employee.csv"
INTO TABLE emp
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

# NOW it shows error " The MySQL server is running with the --secure-file-priv" option so it cannot execute the state"

#  MEANS the path of the file  which we have given is unable to be fetched bythe mysql
# SO inorder to see the exact path and loaction of the file we run a command SHOW VARIABLES LIKE "secure_file_priv"; it will show the exact path;

SHOW VARIABLES LIKE "secure_file_priv";
# it shows me the path "secure_file_priv	C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\" means our file must be saved in Uploads folder in Program files..

#C:\ProgramData\MySQL\MySQL Server 8.0\Uploads  now this the exact location path of files..

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employee.csv"
INTO TABLE emp
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS ;

SELECT * FROM emp;
TRUNCATE TABLE emp;

#Suppose we have some missing data in our file so we first fetch it and then correct it using queries

LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employee.csv"
INTO TABLE emp
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM emp; # we have seen that the eadd of some employees are blank so we fill it with NULL
SET SQL_SAFE_UPDATES=0;
UPDATE emp SET eadd='Noida' WHERE eid = 104;
SELECT * FROM emp;  


#__________________________________________
TRUNCATE TABLE emp;
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/employee.csv"
INTO TABLE emp
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(eid, ename, eadd, esal) SET
ename = IF(ename='', 'NoName',ename),
eadd = IF(eadd ='','NoAddress', eadd),
esal = IF(esal ='','0.0', esal);


SELECT * FROM emp;  










