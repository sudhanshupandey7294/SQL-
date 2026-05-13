CREATE DATABASE Organizations;
USE Organizations;
CREATE TABLE departments ( 
dept_id INT PRIMARY KEY, 
dept_name VARCHAR(50) 
); 
INSERT INTO departments VALUES( '1' , 'HR'),
('2', 'Admin');
CREATE TABLE employeez( 
emp_id INT PRIMARY KEY, 
emp_name VARCHAR(50), 
dept_id INT, 
salary INT, 
hire_date DATE, 
city VARCHAR(50), 
FOREIGN KEY (dept_id) REFERENCES departments(dept_id) 
); 
CREATE TABLE order_ ( 
order_id INT PRIMARY KEY, 
emp_id INT, 
order_amount DECIMAL(10,2), 
order_date DATE, 
FOREIGN KEY (emp_id) REFERENCES employeez(emp_id) 
);

-- String Functions 
#1. Display employee names in uppercase. 
INSERT INTO employeez(emp_id,emp_name,salary,city) VALUES('1', 'rahul kumar', '40000', 'Noida') ;
INSERT INTO employeez(emp_id,emp_name,salary,city) VALUES('2', 'Aman kumar', '48000', 'Delhi') ;
SELECT emp_name, upper(emp_name) FROM employeez;

#2 Show first 3 characters of each employee name. 
SELECT emp_name, SUBSTRING(emp_name, 1,3) FROM employeez;

#3Replace city name "Delhi" with "New Delhi"
SELECT city, REPLACE(city, 'Delhi', 'New Delhi')FROM employeez;

#4. Find length of each employee name.  
SELECT *, LENGTH(emp_name) FROM employeez;

#5. Concatenate employee name and city.  
SELECT *, CONCAT(emp_name ,"--", city) FROM employeez;

-- Numeric Functions 
#6. Round order_amount to nearest integer.  
INSERT INTO order_ VALUES('1', '1', 45000,'25-01-26');
INSERT INTO order_ VALUES('2', '2', 48999.9, '22-01-26');
SELECT order_amount, ROUND(order_amount, 1) FROM order_;

SELECT order_amount, ROUND(order_amount) FROM order_;

#7. Find average salary of employees.  
SELECT AVG(salary) FROM employeez;

#8. Show highest and lowest salary.  
SELECT MAX(salary) FROM employeez;
SELECT MIN(salary) FROM employeez;

#9. Find total order amount.  
SELECT SUM(order_amount) FROM order_;

#10. Display salary divided by 2.  
SELECT emp_name, salary, salary / 2 AS half_salary
FROM employeez;


-- Date Functions 
-- 11. Extract year from hire_date.  
-- 12. Find number of days employee has worked till today.  
-- 13. Display current date.  
-- 14. Add 30 days to hire_date.  
-- 15. Find difference between two dates.

#11. EXTRACT year 
SELECT YEAR(order_date) FROM order_;

#12.  Find number of days employee has worked till today. 
SELECT DAY(order_date) FROM order_;

#13.DISPLAY CURRENT date
SELECT CURRENT_DATE();

#14.Add 30 days to oderdate
-- SELECT DAY(order_date)+30 FROM order_;
SELECT order_date,
       DATE_ADD(order_date, INTERVAL 30 DAY) AS new_date
FROM order_;

#15. Find difference between two dates.
-- SELECT CURRENT_DATE() - order_date FROM order_;
SELECT order_date, CURRENT_DATE() ,
DATEDIFF(CURRENT_DATE(), order_date) AS date_difference FROM order_;
#__________________________________________________________________________________________________________________
-- Aggregate Functions 
-- 16. Count total employees.  
-- 17. Count employees per department.  
-- 18. Find total salary per department.  
-- 19. Find average order amount.  
-- 20. Find max order per employee.  

#16. 
SELECT COUNT(*) FROM employeez;
#17
#SELECT COUNT(*) FROM employeez  GROUP BY dept_id;
SELECT dept_name, COUNT(emp_id) FROM departments d JOIN employeez e ON d.dept_id=e.dept_id GROUP BY dept_name;

#18
SELECT dept_name, SUM(salary) FROM employeez e JOIN departments d ON e.dept_id=d.dept_id GROUP BY dept_name;

#19 Find average order amount. 
SELECT AVG(order_amount) FROM order_;

#20.FInd max order Per employee
SELECT emp_name , MAX(order_amount) FROM employeez e JOIN order_ o ON e.emp_id=o.emp_id GROUP BY emp_name;

#______________________________________________________________________________________________________________________
-- PART 2: WINDOW FUNCTION EXERCISES 
-- Ranking Functions 
-- 21. Assign row number to employees based on salary.  
-- 22. Rank employees based on salary (with gaps).  
-- 23. Assign dense rank based on salary.  
-- 24. Rank employees within each department.  
-- 25. Find top 3 highest-paid employees per department.  

#21 Assign row number to employees based on salary.

SELECT *,ROW_NUMBER() OVER(ORDER BY salary DESC) FROM employeez;
#22 Rank employees based on salary (with gaps). 
SELECT *, RANK() OVER(ORDER BY salary DESC) FROM employeez;
#23. Assign dense rank based on salary. 
SELECT*, DENSE_RANK() OVER(ORDER BY salary) FROM employeez;
#24.Rank employees within each department. 
SELECT *, RANK() OVER(PARTITION BY dept_id ORDER BY salary) FROM employeez;

#25.Find top 3 highest-paid employees per department. 
WITH 3highestpaid AS( 
SELECT * ,RANK() OVER(PARTITION BY dept_id ORDER BY salary) AS rnk FROM employeez) SELECT * FROM 3highestpaid WHERE rnk<3;

#_____________________________________________________________________________________________________
-- LAG / LEAD 
-- 26. Show previous salary of each employee.  
-- 27. Show next salary of each employee.  
-- 28. Find salary difference between current and previous employee.  
-- 29. Show previous order amount per employee.  
-- 30. Compare current order with next order.  

#Q26.Show previous salary of each employee.
SELECT *, LAG(salary) OVER(PARTITION BY dept_id ORDER  BY salary) FROM employeez;

#27. Show next salary of each employee. 
SELECT *, LEAD(salary) OVER( PARTITION BY dept_id ORDER  BY salary) FROM employeez;

#*****28. Find salary difference between current and previous employee.  
SELECT *, LAG(salary) OVER(ORDER BY emp_id) AS previous_sal, salary - LAG(salary) OVER(ORDER BY emp_id) AS difference_in_salary FROM employeez;

#29.Show previous order amount per employee.
SELECT*, LAG(order_amount) OVER (PARTITION BY emp_id ORDER BY order_date) AS prev_order FROM order_;

#30 Compare current order with next order. 
SELECT *, LEAD(order_amount) OVER(PARTITION BY emp_id ORDER BY order_date) AS next_order, 
LEAD(order_amount) OVER(PARTITION BY emp_id ORDER BY order_date) -order_amount
AS compared_amount FROM order_;

#_________________________________________________________________________________________________________________________
-- Aggregate Window Functions 
-- 31. Calculate running total of salaries.  
-- 32. Calculate running total of order_amount.  
-- 33. Find department-wise total salary using window function.  
-- 34. Find average salary per department using window function.  
-- 35. Count employees per department using window.

#31.Calculate running total of salaries. 
SELECT *, SUM(salary) OVER(ORDER BY emp_id) AS running_sal FROM employeez;
#32. Calculate running total of order_amount. 
SELECT *, SUM(order_amount) OVER(ORDER BY emp_id) AS running_order FROM order_; 

 -- 33. Find department-wise total salary using window function.  
SELECT *, SUM(salary) OVER(PARTITION BY dept_id) AS dept_wise_sal FROM employeez;

-- 34. Find average salary per department using window function.  
SELECT *, AVG(salary) OVER(PARTITION BY dept_id) AS sal_per_dept FROM employeez;
-- 35. Count employees per department using window.
SELECT *, COUNT(emp_name) OVER(PARTITION BY emp_id) AS employees_per_dept FROM employeez;

#_____________________________________________________________________________________________________________________
-- FIRST_VALUE / LAST_VALUE 
-- 36. Show highest salary in entire table for each row.  
-- 37. Show lowest salary per department.  
-- 38. Show first hired employee in each department.  
-- 39. Show last hired employee overall.  

#36. Show highest salary in entire table for each row.  
WITH highest_sal_table AS(
SELECT *, DENSE_RANK() OVER(ORDER BY salary DESC) AS highest_sal_rank FROM employeez) 
SELECT * FROM highest_sal_table WHERE highest_sal_rank=1;

#BUT FOR EACH ROW --TO PRINT max salary
SELECT *,MAX(salary) OVER() AS Highest_salary FROM employeez;

#***USING first_value()
SELECT *, FIRST_VALUE(salary) OVER(ORDER BY salary DESC) FROM employeez;

#37. Show lowest salary per department.  
SELECT *, FIRST_VALUE(salary) OVER( PARTITION BY dept_id ORDER BY salary ASC) FROM employeez;

#****-- 38. Show first hired employee in each department.  
SELECT FIRST_VALUE(emp_name) OVER(PARTITION BY dept_id ORDER BY hire_date) FROM employeez;

#39. Show last hired employee overall.  
SELECT LAST_VALUE(emp_name) OVER(ORDER BY hire_date) FROM employeez;

#______________________________________________________________________________________________________________
#NTILE 
#40. Divide employees into 4 salary groups.
SELECT *, NTILE(4) OVER(ORDER BY salary DESC) FROM employeez;  
#41. Divide orders into 3 buckets based on amount. 
SELECT *, NTILE(3) OVER(ORDER BY order_amount DESC) FROM order_;

#_______________________________________________________________________________________________________________________________________________
#Advanced Window Problems 
#Q42. Find employees earning more than department average. 
SELECT * FROM employeez e WHERE salary > (SELECT AVG(salary) FROM employeez  WHERE dept_id= e.dept_id);

SELECT * FROM 
(SELECT *, AVG(salary) OVER(PARTITION BY dept_id) AS dept_avg_salary FROM employeez) AS emp
 WHERE salary > dept_avg_salary;
 
 #43. Find second highest salary per department.  
 #SELECT emp_name, salary FROM employeez ORDER BY salary DESC LIMIT 2;
WITH second_highest_sal AS(
SELECT *, DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS rnk FROM employeez) 
SELECT * FROM second_highest_sal WHERE rnk=2;

#44. Find duplicate salaries within same department.  
SELECT dept_id, salary, COUNT(*) AS total FROM employeez GROUP BY dept_id, salary 
HAVING COUNT(*)>1;

#45. Find employees whose salary is greater than previous employee. 
	WITH sal_greaterthan_prev AS 
    (SELECT *,LAG(salary) OVER(PARTITION BY emp_id ORDER BY salary) AS prev_salary FROM employeez)
    SELECT * FROM sal_greaterthan_prev WHERE salary > prev_salary;
 
#46. Find gap between consecutive hire dates.  
SELECT *, LAG(hire_date) OVER(ORDER BY hire_date) AS prev_hire_date, DATEDIFF(hire_date, LAG(hire_date) OVER(ORDER BY hire_date) )
AS hire_gap 
FROM employeez;

#47. Identify increasing salary trend.  
    WITH salary_trend AS (
    SELECT emp_id,emp_name,salary,LAG(salary) OVER (ORDER BY emp_id) AS prev_salary
    FROM employeez)
SELECT * FROM salary_trend
WHERE salary > prev_salary;
    
#48.Find cumulative average salary.  
SELECT emp_id,
       emp_name,
       salary,
       AVG(salary) OVER (
           ORDER BY emp_id
       ) AS cumulative_avg_salary
FROM employees;

#49. Find top-performing employees based on total orders.  
SELECT emp_name, SUM(order_amount) AS total_order FROM employeez e JOIN order_ o ON e.dept_id=o.emp_id GROUP BY  emp_name ORDER BY total_order DESC LIMIT 1;

#50. Show percentage contribution of each employee's salary to department total.  
SELECT emp_name, salary, salary*100/SUM(salary) OVER(PARTITION BY dept_id) AS salary_percentage FROM employeez;


#51. Find employees who never made any orders.  
SELECT * FROM employeez e JOIN order_ o ON e.emp_id =o.emp_id WHERE o.order_id IS NULL;

#52. Find employees whose salary is above overall average.  
WITH sal_above_overall_table AS(
SELECT emp_name, salary, AVG(salary) OVER() AS AVG_sal FROM employeez 
)SELECT * FROM sal_above_overall_table WHERE salary> AVG_sal;

#53. Find employees who made highest order in each department.  
WITH highest_order AS (
SELECT emp_name, order_amount, DENSE_RANK() OVER(PARTITION BY e.dept_id ORDER BY order_amount DESC) AS Rnk FROM employeez e JOIN order_ o ON 
e.emp_id=o.emp_id ) 
SELECT * FROM highest_order WHERE Rnk=1;

#54. Find running difference between order amounts.  
#55. Detect outliers in salary using window functions.  