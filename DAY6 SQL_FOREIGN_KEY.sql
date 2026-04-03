
### FOREIGN KEY ##

# shows the inter relation and interconnection between two table ...

#________________________________________________________________________________________
DROP DATABASE college;

CREATE DATABASE college;
USE college;

CREATE TABLE course(
cid INT PRIMARY KEY AUTO_INCREMENT,
cname VARCHAR(20) NOT NULL,
cfee DECIMAL(8,2) DEFAULT 0.0);

INSERT INTO course VALUE(302,"Data Analytics",76450);
INSERT INTO course VALUE(305,"Data science",76423);

CREATE TABLE student(
sid INT PRIMARY KEY AUTO_INCREMENT  ,
sname VARCHAR(30) NOT NULL  ,
sadd VARCHAR(30) NOT NULL ,
cid INT NOT NULL ,
FOREIGN KEY (cid) REFERENCES course(cid)
); 

## course is parent and student is child now

INSERT INTO student VALUE(101,"Raman","Noida",301);   #301 id is not available in course  so it give error because both table are inter relationship with eachother using FOREIGN KEY
INSERT INTO student VALUE(101,"Raman","Noida",302); #this will run 
 
DELETE FROM course WHERE cid=302; 
UPDATE course SET cid=310 WHERE cid=305;

# IF YOU WANT TO DELETE ALL DATA FROM A TABLE WITHOUT CHANGING ITS STRUCTURE
TRUNCATE student;
SELECT * FROM student;

DELETE  FROM student;

DROP TABLE student;
DROP TABLE course;
#___________________________________________________________________________________________________

CREATE TABLE course(
cid INT PRIMARY KEY AUTO_INCREMENT ,
cname VARCHAR(20) NOT NULL , 
cfee DECIMAL(8,2) DEFAULT 0.0
);

CREATE TABLE student(
sid INT PRIMARY KEY AUTO_INCREMENT  ,
sname VARCHAR(30) NOT NULL  ,
sadd VARCHAR(30) NOT NULL ,
cid INT NOT NULL ,
FOREIGN KEY (cid) REFERENCES course(cid) ON UPDATE CASCADE ON DELETE CASCADE
); 

INSERT INTO course VALUE(301,"Data Analytics",76450);
INSERT INTO student VALUE(101,"Raman","Noida",301); 

SELECT * FROM student;
SELECT * FROM course;

UPDATE course SET cid=305 WHERE cid=301;   ## using ON UPDATE CASCADE with FOREIGN KEY column we can Update (change and re set) the parent table 
DELETE FROM course WHERE cid=305;    ## using ON DELETE CASCADE with FOREIGN KEY we can delete the parent table

