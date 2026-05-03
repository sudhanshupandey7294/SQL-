# DCL : Data Control Language (GRANT, REVOKE)

#TO SHOW CURRENT USER
SELECT CURRENT_USER(); #'root@localhost'

# HOW TO CREATE USER
#create user 'username'@'localhost' identified by 'password';

CREATE USER 'admin'@'localhost' IDENTIFIED BY '1234';

#Now a user is created where all the access goes to this user you can check in command prompt
-- Go to cmd
-- msql
-- PS C:\Users\sudhanshu pandey> mysql -u admin -p
-- Enter password: ****
-- mysql> show databases;
-- +--------------------+
-- | Database           |
-- +--------------------+
-- | information_schema |      # BY default isdme 2 hi databases honge ..saare nhi honge qki ye ek created user ka khud ka apna ek server ban chuka h "admin" nam se ab ye private h
-- | performance_schema |
-- +--------------------+
-- 2 rows in set (0.01 sec)

-- mysql> select current_user();
-- +-----------------+
-- | current_user()  |
-- +-----------------+
-- | admin@localhost |
-- +-----------------+
-- 1 row in set (0.00 sec)

#HOW to login in command line mysql using different a/cache 
#mysql -u username -p enter then write password

SELECT USER();

#HOW TO DISPLAY ALL USERS
SELECT USER, HOST FROM mysql.user;

#HOW TO DELETE A USER
DROP USER 'admin' @'localhost';
#___________________________________________________________________________________________________________________
CREATE USER 'admin'@'localhost' IDENTIFIED BY '1234';
USE amazon;
SHOW tables;

#GRANT PRIVILEGES ON amazon.employee TO 'admin'@'localhost';   error


-- PRIVILEGES = SELECT, DELETE, UPDATE , INSERT 
GRANT SELECT , INSERT ON amazon.employee TO 'admin'@'localhost';  # ie we have granted the permission to the "adminlocalhost" on employee table of amazon db which has only the permission to 
                                                                  #  --apply SELECT and INSERT command 
                                                                  
  #NOW check on cmd
  -- mysql> show databases;
-- +--------------------+
-- | Database           |
-- +--------------------+
-- | amazon             |
-- | information_schema |
-- | performance_schema |
-- +--------------------+
-- 3 rows in set (0.01 sec)   here, amazon db also got permission in "admin localhost"  after we used the coding inside admin user ..so we can say we have Grant the permission 

-- mysql> USE amazon;
-- Database changed
-- mysql> SHOW tables;
-- +------------------+
-- | Tables_in_amazon |
-- +------------------+
-- | employee         |
-- +------------------+
-- 1 row in set (0.00 sec)   # we already know that amazon db has 3 or 4 tables but here only one "employee" is showing because we have granted the permission to use ionly "employee" in coding
                 
--                  
--                  mysql> SELECT * FROM employee;
-- +-----+--------------+---------+-------+----------+
-- | eid | ename        | eadd    | edesg | esal     |
-- +-----+--------------+---------+-------+----------+
-- | 101 | Rahul Sharma | Noida   | IT    | 86523.00 |
-- | 103 | Yogesh Saini | Noida   | HR    | 36384.00 |
-- | 104 | Shiva Yadav  | Delhi   | IT    | 95724.00 |
-- | 105 | Abhishek     | GZB     | IT    | 64269.00 |
-- | 106 | Riya Sharma  | Nanital | HR    | 85237.00 |
-- | 107 | Siya Singh   | Nagpur  | IT    | 64237.00 |
-- | 108 | Mohit        | Noida   | IT    | 85275.00 |
-- | 152 | Bhanu        | Noida   | IT    | 88885.00 |
-- | 153 | Bhanu        | Noida   | IT    | 88885.00 |
-- | 154 | Aman         | Noida   | Admin | 42784.00 |
-- +-----+--------------+---------+-------+----------+
-- 10 rows in set (0.01 sec)   WE have granted the "SELECT " commmand permission in coding thats why it has run 

-- mysql> DELETE FROM employee WHERE eid=101;
-- ERROR 1142 (42000): DELETE command denied to user 'admin'@'localhost' for table 'employee'  
-- BUT when we used DELETE query it failed as we didn't give permission of DELETE only SELECT AND INSERT is granted 


#BY using ALL PRIVILEGES it means all the permission is granted DELETE , INSERT , SELECT, UPDATE 
GRANT ALL PRIVILEGES ON amazon.employee TO 'admin'@'localhost';


# REVOKE PERMISSION
REVOKE DELETE ON amazon.employee FROM 'admin'@'localhost';
#IT means, we removed the permission of DELETE ie. we cannot delete the data from employee table ..we can do everything but not DELETE 

REVOKE ALL PRIVILEGES ON amazon.employee FROM 'admin'@'localhost';
# it will remove all the permissions 

GRANT SELECT ON amazon.employee TO 'admin'@'localhost';    #NOW only SELECT query has the permission to work 

# DDL - Data Definition Language
	# CREATE , DROP , ALTER , TRUNCATE
# DML - Data Manipulation Language
	# INSERT DELETE UPDATE SELECT
# DQL - Data Query Language
	# SELECT (joins , subqueries , group by etc)
# TCL - Transaction Control Language
	# START TRANSACTION , COMMIT , ROLLBACK , SAVEPOINT
# DCL - Data Control Language
	# GRANT , REVOKE
