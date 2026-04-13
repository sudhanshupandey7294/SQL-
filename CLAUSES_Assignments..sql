CREATE DATABASE company_db;
USE company_db;
CREATE TABLE employees(
emp_id INT PRIMARY KEY AUTO_INCREMENT, 
emp_name VARCHAR (50),
emp_department VARCHAR(50),
emp_salary DECIMAL(8,2),
emp_age INT,
emp_city VARCHAR(50),
joining_date DATE);

INSERT INTO employees (emp_name, emp_department, emp_salary, emp_age, emp_city, joining_date) VALUES
('Amit', 'IT', 60000, 28, 'Delhi', '2022-03-15'),
('Riya', 'HR', 45000, 25, 'Mumbai', '2021-06-10'),
('John', 'IT', 75000, 32, 'Bangalore', '2020-01-20'),
('Sara', 'Finance', 50000, 29, 'Delhi', '2023-02-12'),
('David', 'IT', 80000, 35, 'Mumbai', '2019-11-05'),
('Neha', 'HR', 47000, 27, 'Delhi', '2022-07-19'),
('Raj', 'Finance', 52000, 31, 'Bangalore', '2021-09-23'),
('Priya', 'IT', 62000, 26, 'Delhi', '2023-01-01');
#Q1 1. Display all employee details 
SELECT * FROM employees;
#Q2. Show only employee names and salaries 
SELECT emp_name , emp_salary from employees;

#Q3. Find employees with salary > 60000
SELECT emp_name, emp_salary FROM employees WHERE emp_salary >60000;

#Q4. Find employees from Delhi
SELECT emp_name,emp_city FROM employees WHERE emp_city LIKE 'Delhi';
#OR
SELECT emp_name,emp_city FROM employees WHERE emp_city IN ('Delhi');
#OR
SELECT emp_name , emp_city FROM employees WHERE emp_city='Delhi';
#OR
SELECT emp_name , emp_city FROM employees WHERE emp_city LIKE 'D%';
#OR 
SELECT emp_name , emp_city FROM employees WHERE emp_city LIKE '_e%';
#Q5. Find employees aged between 25 and 30
SELECT emp_name ,emp_age FROM employees WHERE emp_age BETWEEN 25 AND 30;
#OR
SELECT emp_name ,emp_age FROM employees WHERE emp_age >25 AND emp_age<30;

#Q6. Sort employees by salary (ascending)
SELECT emp_name,emp_salary FROM employees ORDER BY emp_salary ASC;

#Q7. Sort employees by age (descending) 
SELECT emp_name, emp_age FROM employees ORDER BY emp_age DESC;

#Q8. Show employees sorted by department, then salary 
SELECT * FROM employees  ORDER BY emp_department ,emp_salary ;

#Q9. List unique departments 
SELECT DISTINCT emp_department FROM employees ;

#Q10. List unique cities
SELECT DISTINCT emp_city FROM employees;

#Q11. Show top 3 highest paid employees
SELECT emp_name ,emp_salary FROM employees LIMIT 3;

#Q12. Show 2 youngest employees 
SELECT emp_name , emp_age FROM employees ORDER BY emp_age ASC LIMIT 2;

#Q13. Find total number of employees
SELECT COUNT(*) FROM employees;
#Q14. Find average salary
SELECT AVG(emp_salary) FROM employees;

#Q15. Find maximum salary
SELECT MAX(emp_salary) FROM employees;

#Q16. Find minimum salary
SELECT MIN(emp_salary) FROM employees;

#Q17. Find total salary of all employees
SELECT SUM(emp_salary) FROM employees;

#Q18 18. Count employees in each department

SELECT COUNT(emp_id) AS TotalEmployees, emp_department FROM employees GROUP BY emp_department;

#Q19. Find average salary per department 
SELECT AVG(emp_salary) AS AverageSalary , emp_department FROM employees GROUP BY emp_department;

#Q20. Find total salary per city
SELECT SUM(emp_salary) AS Total_Salary, emp_city FROM employees GROUP BY emp_city;

#**************************************************************
#Q21. Show departments with more than 2 employees
SELECT emp_department, COUNT(emp_id) FROM employees GROUP BY emp_department HAVING COUNT(emp_id )>2;

#********#Q22. Show departments where average salary > 60000 
SELECT emp_department ,AVG(emp_salary) FROM employees GROUP BY emp_department HAVING AVG(emp_salary) >6000;

#Q23. Find employees whose name starts with 'A'
SELECT emp_name FROM employees 
WHERE emp_name LIKE 'A%';

#Q24. Find employees whose name ends with 'a'
SELECT emp_name FROM employees 
WHERE emp_name LIKE '%a';
#***************************
#Q25. Find employees whose name contains 'i'
SELECT emp_name FROM employees 
WHERE emp_name LIKE '%i%';


#IN / NOT IN
#Q26. Find employees from Delhi or Mumbai
SELECT emp_name FROM employees 
WHERE  emp_city IN ('Delhi','Mumbai');

#Q27. Find employees NOT in IT department
SELECT emp_name, emp_department FROM employees 
WHERE  emp_department NOT IN ('IT');

#Q28. Find employees with salary between 50000 and 70000 
SELECT emp_name ,emp_salary FROM employees WHERE emp_salary BETWEEN 50000 and 70000;

#Q29. Find employees who joined between 2021 and 2023
SELECT emp_name, joining_date FROM employees WHERE joining_date BETWEEN '2021-01-01' AND '2023-12-31';

#Q30. Increase salary of all IT employees by 10%
SET SQL_SAFE_UPDATES =0;
UPDATE employees  SET emp_salary=emp_salary* 1.10;

#31. Delete employees with salary < 45000
DELETE FROM employees WHERE emp_salary <45000;

#Q32. Categorize employees:
#• Salary > 70000 → 'High'
#• 50000–70000 → 'Medium'
#• < 50000 → 'Low

SELECT emp_name, emp_salary, CASE
WHEN emp_salary > 70000 THEN 'High'
WHEN emp_salary BETWEEN 50000 AND 70000 THEN 'Medium'
ELSE 'low'
END AS Salary_category 
FROM employees;




