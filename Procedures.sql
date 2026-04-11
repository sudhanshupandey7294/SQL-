/*
Procedures:- A procedure is a stored query which fires when a user
called. 
It is like a user define function.

CREATE PROCEDURE procedure_name(parameters)
BEGIN
	-- SQL ;
END ;
CALL procedure_name(arguments);
 
*/

USE amazon;
SHOW TABLES;
SELECT * FROM employee;
INSERT INTO employee(ename,eadd,edesg, esal)
 VALUES('Bhanu', 'Noida', 'IT', 88885);


#___________________
 DELIMITER //
CREATE PROCEDURE total_salary()
BEGIN
SELECT sum(esal) FROM employee; 
END  // DELIMITER ;

CALL total_salary;
#________________________________________________________________________________
##NOW the question is , if we want to show the total salary of the employees of particular department like HR, IT , Admin etc..
# Then , we create a function by passing the parameters...
DELIMITER //
CREATE PROCEDURE salarybyDesignation()
BEGIN
SELECT sum(esal) FROM employee WHERE edesg='HR';
END // DELIMITER ;

CALL salarybyDesignation();
#_________________________________________________________________________________________________
#THIS IS ONLY FOR HR, NOW WHAT IF WE WANT FOR IT and ADMIN ,,we need to create different different procedure for each ,,BUT here is the solution by [passing parameter..alter

DELIMITER //
CREATE PROCEDURE salaryBYDesg(IN mydesg VARCHAR(100))
BEGIN
SELECT sum(esal) FROM employee WHERE edesg=mydesg;
END // DELIMITER ;

CALL salaryBYDesg('HR');
CALL salaryBYDesg('IT');

#______________________________________________________________________________________
DELIMITER //
CREATE PROCEDURE ins_emp(IN name VARCHAR(100) , IN adds VARCHAR(100) , IN desg VARCHAR(100) , IN sal DECIMAL(8,2) )
BEGIN
	INSERT INTO employee(ename,eadd,edesg,esal)
	VALUE(name,adds,desg,sal);
END // DELIMITER ;

CALL ins_emp('Ramandeep' , 'GZB' , 'Admin' , 96238);
SELECT * FROM employee;

CALL ins_emp('Aman','Noida','Admin',42784);

SHOW PROCEDURE STATUS WHERE db='amazon';
SHOW CREATE PROCEDURE ins_emp;
DROP PROCEDURE total_salary;


DELIMITER $$
CREATE PROCEDURE total_salary(IN desg VARCHAR(100))
BEGIN
	SELECT sum(esal) FROM employee WHERE edesg=desg;
END $$ DELIMITER ;

CALL total_salary('Admin');


DELIMITER $$
CREATE PROCEDURE total_salary(IN desg TEXT,OUT salary DECIMAL(8,2))
BEGIN
	SELECT sum(esal) INTO salary FROM employee WHERE edesg=desg;
END $$ DELIMITER ;

CALL total_salary('Admin',@salary);

SELECT @salary;

