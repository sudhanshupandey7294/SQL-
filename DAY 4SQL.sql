CREATE DATABASE college;
USE  college;
#DROP DATABASE college;
CREATE TABLE Students(
sid INT PRIMARY KEY AUTO_INCREMENT,
sname VARCHAR(40) NOT NULL,
semail VARCHAR(50) UNIQUE NOT NULL,
sage INT NOT NULL CHECK(sage>17),
sgender VARCHAR(10) DEFAULT 'Male',
sfee DECIMAL(8,2) DEFAULT 0.0	 
);
INSERT INTO Students(sname,semail,sage) 
VALUE('RAHUL', 'rahul123@gmail.com', 23);

SELECT * FROM Students;
INSERT INTO Students(sname,semail,sage)   #id will automatic printed as 1
VALUE('RAHUL', 'rahul123@gmail.com', 23);
INSERT INTO Students(sid,sname,semail,sage) 
VALUE(105,'Shyam', 'shyam123@gmail.com', 24);# id will auto assigned as 105 and further it will count from 105
INSERT INTO Students(sname,semail,sage,sgender) 
VALUE('Riya', 'riya123@gmail.com', 25, 'Female'); #couter will count id as 106

INSERT INTO Students(sname,semail,sage,sgender) 
VALUE('Riya', 'riya123@gmail.com', 25, 'Female');

INSERT INTO Students(sname,semail,sage,sgender) 
VALUE('Siya', 'siya123@gmail.com', 20, 'Female');

SELECT * FROM Students;
INSERT INTO Students(sname,semail,sage) 
VALUE('Mohan','mohan123@gmail.com',24);

INSERT INTO Students(sid,sname,semail,sage) 
VALUE(111,'Sohan','sohan123@gmail.com',26);

#INSERT INTO Students(sname,semail,sage) 
#VALUE('Raman','raman123@gmail.com',12);   # since the age must greater than 17 I am using 12 it will cause error but the Autoincrement counter will not be increased because the CHECK run first than AUTOINCREMENT
#CHECK will  check the condition if false condition then terminate in building db..
SELECT * FROM Students;
 
INSERT INTO Students(sname,semail,sage) 
VALUE('Raman','raman123@gmail.com',30);


#CLAUSES
#LIMIT

SELECT * FROM Students;

SELECT *FROM Students LIMIT 3;  #show only 3 limited columns

ALTER TABLE Students ADD COLUMN sadd  VARCHAR(20) NOT NULL;

#AGGREGATE FUNCTIONS
# sum, min, max , count, avg

SELECT *FROM Students;
SELECT max(sage) FROM Students;
SELECT count(*) FROM Students;
SELECT sum(sfee) FROM Students;
SELECT max(sage) FROM Students;
SELECT min(sage) FROM Students;
SELECT avg(sage) FROM Students;

#GROUP BY

SELECT  count(*) FROM Students;
SELECT sadd,count(*) FROM Students GROUP BY sadd;
SELECT sage,sum(sfee) FROM Students GROUP BY sage;
#SELECT sname,sum(sage) FROM student GROUP BY sadd;  #Group By work only with same column name which we use in group 
SELECT sage,max(sfee) FROM Students GROUP BY sage;  # It means select max fes from students table in sage group i.e age 23 walo ka max fee ==.... , age 24 walo ka max fees =... and so on.. 





