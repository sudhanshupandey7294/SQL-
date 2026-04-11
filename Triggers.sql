/*
Trigger:- Trigger is a stored query, which will fires automatically
when an event will occur.
EVENT : INSERT , DELETE , UPDATE

*/

USE amazon;
SHOW TABLES;

SELECT* FROM employee;

CREATE TABLE emp_log(
logid INT PRIMARY KEY AUTO_INCREMENT,
eid INT,
ename VARCHAR(100),
eadd VARCHAR(100),
edesg VARCHAR(100),
esal DECIMAL(8,2),
time_ TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
event_ VARCHAR (100));


INSERT INTO employee(ename,eadd,edesg, esal) VALUE('Mohit', 'Noida', 'IT', 85275);
SELECT* FROM employee;

INSERT INTO emp_log(eid,ename,eadd,edesg,esal,event_) 
VALUE(108,'Mohit','Noida','IT',85273,'Joined');              # we create a log file (log table) to store our databse as backup when deleted using time stap and event to identify it in future
														     # SO inorder to keep all the sql codes in one time we create TRIGGER which help to  upload all the codes in one go ratther than writing lots of code for each columns

SELECT * FROM emp_log;

# Syntax
/*
DELIMITER $$
CREATE TRIGGER trigger_name
BEFORE|AFTER INSERT|DELETE|UPDATE ON table_name
FOR EACH ROWS
BEGIN
	-- SQL ;
END $$ DELIMITER ;
*/ 

DELIMITER $$
CREATE TRIGGER ins_emp
AFTER INSERT ON employee 
FOR EACH ROW 
BEGIN
INSERT INTO emp_log (eid ,ename, eadd, edesg, esal, event_)VALUES
(NEW.eid, NEW.ename,NEW.edesg, NEW.esal, 'Joined');
END $$ DELIMITER ;

INSERT INTO employee(ename,eadd,edesg,esal) 
VALUE('Suryansh','Delhi','HR',73654); 

INSERT INTO emp_log(eid,ename,eadd,edesg,esal,event_) 
VALUE(108,'Mohit','Noida','IT',85273,'Joined');

SELECT * FROM emp_log;
# ______________________________________________________________________________________________________
DELIMITER //
CREATE TRIGGER del_emp
BEFORE DELETE ON employee
FOR EACH ROW
BEGIN 
	INSERT INTO emp_log(eid,ename,eadd,edesg,esal,event_) VALUE
(OLD.eid,OLD.ename,OLD.eadd,OLD.edesg,OLD.esal,'Resigned');
END // DELIMITER ;

SELECT * FROM employee;
SELECT * FROM emp_log;
DELETE FROM employee WHERE eid=102;


#____________________________________________________________________________________
DELIMITER //
CREATE TRIGGER upd_emp
BEFORE UPDATE ON employee
FOR EACH ROW
BEGIN
	INSERT INTO emp_log(eid,ename,eadd,edesg,esal,event_) VALUE
(NEW.eid,NEW.ename,NEW.eadd,NEW.edesg,NEW.esal,'Updated');
END // DELIMITER ;

SELECT * FROM employee;
UPDATE employee SET esal=85000 WHERE eid=109;
SELECT * FROM emp_log; 
#_______________________________________________________________________________________
DELIMITER //
CREATE TRIGGER check_salary
BEFORE UPDATE ON employee
FOR EACH ROW
BEGIN
	IF NEW.esal < OLD.esal THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = "Salary can not be decreased";
	END IF;
END // DELIMITER ;

SELECT * FROM employee;
SELECT * FROM emp_log;

UPDATE employee SET esal=65000 WHERE eid=103; 
UPDATE employee SET ename="Yogesh Kumar" WHERE eid=103; 

DESCRIBE employee;


# NAME length should not be less then 4 charcters_____________________________________________________________________________----
DELIMITER //
CREATE TRIGGER validate_name
BEFORE INSERT ON employee
FOR EACH ROW
BEGIN
	IF LENGTH(NEW.ename)<4 THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Name should be at least 4 characters';
    END IF;
END // DELIMITER ;

INSERT INTO employee(ename , eadd , edesg , esal)
VALUE('EVE' , 'Noida' , 'IT' , 75238);

SHOW WARNINGS;
SET @myname = "Mohit Kumar";
SELECT @myname; 
