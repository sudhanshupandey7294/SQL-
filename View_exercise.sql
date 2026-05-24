CREATE DATABASE company_practice;
USE company_practice;

CREATE TABLE departments 
(dept_id INT PRIMARY KEY,
dept_name VARCHAR(50) NOT NULL,
location VARCHAR(50)
);

CREATE TABLE employees
(emp_id INT PRIMARY KEY,
emp_name VARCHAR(50) NOT NULL,
salary DECIMAL(10,2),
dept_id INT, 
manager_id INT,
hire_date DATE,
FOREIGN KEY(dept_id) REFERENCES departments(dept_id));

INSERT INTO  departments VALUES
(1, 'HR', 'Delhi'), 
(2, 'IT', 'Noida'), 
(3, 'Sales', 'Mumbai'), 
(4, 'Finance', 'Bangalore'); 

INSERT INTO employees VALUES
(101, 'Amit', 50000, 1, NULL, '2020-01-15'), 
(102, 'Neha', 75000, 2, 101, '2019-03-10'), 
(103, 'Raj', 60000, 2, 102, '2021-06-20'), 
(104, 'Simran', 45000, 3, 101, '2022-02-11'), 
(105, 'Karan', 80000, 2, 102, '2018-07-05'), 
(106, 'Priya', 55000, 4, 101, '2023-01-25'); 

-- PART 2 – VIEW Practice Questions 
-- Basic Level 
#_____________________________________________________________________________________________________________________
#Q Create a view showing employee name and salary. 
-- View Name: v_employee_salary

CREATE VIEW v_employee_salary AS 
SELECT emp_name, salary FROM employees;

SELECT * FROM v_employee_salary;

#_______________________________________________________________________________
#Q.Create a view showing employee name and department name. 
-- View Name: v_employee_department 

CREATE VIEW v_employee_department AS
SELECT emp_name, dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id;

SELECT * FROM v_employee_department;

#______________________________________________________________________
#Q.Create a view for employees earning more than 60,000. 
-- View Name: v_high_salary 

CREATE VIEW v_high_salary AS 
SELECT emp_name , salary FROM employees WHERE salary > 60000;

SELECT * FROM v_high_salary;

#_______________________________________________________________________________________________________________________________________
#Q.Create a department-wise total salary view. 
-- View Name: v_dept_total_salary 
-- Output: 
-- • dept_name 
-- • total_salary 

CREATE VIEW v_dept_total_salary AS
SELECT dept_name, SUM(salary)AS total_salary FROM employees e JOIN departments d ON e.dept_id=d.dept_id GROUP BY dept_name;

SELECT * FROM v_dept_total_salary;

#___________________________________________________________
#Q.Create a secure view that hides salary but shows: 
-- • emp_id 
-- • emp_name 
-- • dept_name

CREATE VIEW secure_view AS
SELECT emp_id, emp_name, dept_name FROM employees e JOIN departments d ON e.dept_id=d.dept_id ;

SELECT * FROM secure_view;

#_____________________________________________________
#Q.Update salary of Amit using v_employee_salary.

SET SQL_SAFE_UPDATES=0;
UPDATE v_employee_salary SET salary=90000 WHERE emp_name ='Amit';
SELECT * FROM v_employee_salary;
 
 
 #____________________________________________________________
 #Q.Drop view safely if exists. 
 DROP VIEW v_employee_salary;
 
 #______________________________________________________________________________________________________________________________________________________________________
 -- PART 3 – CTE Practice Questions 
-- Basic CTE 
#Q.Use CTE to find employees earning above average salary.

 