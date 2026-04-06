CREATE DATABASE company;

USE company;

CREATE TABLE Departments (
 dept_id INT PRIMARY KEY,
 dept_name VARCHAR(50)
);

CREATE TABLE Employees(
emp_id INT PRIMARY KEY,
emp_name VARCHAR(50),
dept_id INT ,
salary INT,
FOREIGN KEY (dept_id) REFERENCES Departments(dept_id));

CREATE TABLE Projects(
project_id INT PRIMARY KEY,
project_name VARCHAR(50),
emp_id INT,
FOREIGN KEY (emp_id) REFERENCES Employees(emp_id));

## "Departments" is the parent of "Employees" and "Employees" is the parent of "Projects"

INSERT INTO Departments VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');

INSERT INTO Employees VALUES
(101, 'Amit', 1, 30000),
(102, 'Neha', 2, 50000),
(103, 'Raj', 2, 45000),
(104, 'Simran', 3, 40000),
(105, 'Karan', NULL, 35000);

INSERT INTO Projects VALUES
(1, 'Website', 102),
(2, 'App', 103),
(3, 'Audit', 104),
(4, 'Recruitment', 101);

SELECT *FROM Employees E JOIN Departments D ON E.dept_id=D.dept_id;

##Que.1: Show all employees along with their department names
 SELECT emp_name, dept_name FROM Employees E JOIN Departments D ON E.dept_id=D.dept_id;

#Que2.: List all employees who do not belong to any department. 
SELECT emp_name, dept_name FROM Employees E LEFT JOIN Departments D ON E.dept_id=D.dept_id WHERE D.dept_name IS NULL;

#QUE 3: Display all departments and their employees (including empty departments).
SELECT dept_name, emp_name FROM Departments D LEFT JOIN Employees E ON D.dept_id= E.dept_id;

#Que.4: Retrieve employee names and their salaries along with department names.
SELECT emp_name , salary FROM Employees E  JOIN Departments D ON E.dept_id=D.dept_id;

#Que.5:Show all projects with assigned employee names.
SELECT project_name, emp_name FROM Projects P JOIN Employees E ON P.emp_id=E.emp_id;

#QUE 6:. List employees who are not assigned to any department. 
SELECT  emp_name, dept_name FROM Employees E LEFT JOIN Departments D ON  E.dept_id=D.dept_id ORDER BY E.emp_id DESC LIMIT 1;
#OR
SELECT  emp_name, dept_name FROM Employees E LEFT JOIN Departments D ON  E.dept_id=D.dept_id WHERE D.dept_name IS NULL;

#QUE 7:Display all employees and project names (including employees without projects). 
 #SELECT * FROM Employees E LEFT JOIN Projects P ON E.emp_id= P.emp_id ORDER BY E.emp_id DESC; 
 SELECT emp_name, project_name FROM Employees E LEFT JOIN Projects P ON E.emp_id= P.emp_id; #ORDER BY E.emp_id DESC; 
 
 #QUE 8. Show departments that have no employees. 
 #SELECT dept_name, emp_name FROM Departments D RIGHT JOIN Employees E ON D.dept_id=E.dept_id ORDER BY D.dept_id ASC LIMIT 1;
 #OR
SELECT dept_name
FROM Departments d
LEFT JOIN Employees e
ON d.dept_id = e.dept_id
WHERE e.emp_id IS NULL;

######__________________________________Intermediate Level
#Q9. Find employees working in the "HR" department.
SELECT emp_name, dept_name FROM Employees E LEFT JOIN Departments D ON E.dept_id=D.dept_id LIMIT 1;
#OR
SELECT emp_name , dept_name FROM Employees E LEFT JOIN Departments D ON E.dept_id=D.dept_id WHERE D.dept_name ='HR';

#Q10.Display employee name, department name, and project name.
SELECT emp_name, dept_name , project_name FROM Employees E JOIN Departments D ON E.dept_id=D.dept_id JOIN Projects P ON E.emp_id=P.emp_id;

#Q11.List employees who are assigned to more than one project.
SELECT emp_name,COUNT(P.project_id) AS Total_projects FROM Employees E  JOIN Projects P ON E.emp_id=P.emp_id GROUP BY E.emp_id, E.emp_name HAVING COUNT(P.project_id)>1;

#Q12.Show the total number of employees in each department.
SELECT  dept_name, COUNT(E.emp_id) AS Total_Employees FROM Departments D  LEFT JOIN Employees E ON D.dept_id=E.dept_id GROUP BY D.dept_name;

#Q13. Find departments with more than 2 employees. 
SELECT dept_name, COUNT(E.emp_id) AS Total_Employees FROM Departments D INNER JOIN Employees E ON D.dept_id=E.emp_id GROUP BY D.dept_name HAVING COUNT(E.emp_id)>2;

#Q14. Display employees who are not assigned to any project. 
SELECT e.emp_name
FROM Employees e
LEFT JOIN Projects p
ON e.emp_id = p.emp_id
WHERE p.project_id IS NULL;

#Q15 15. Show all projects that do not have any employee assigned.
#SELECT emp_name , COUNT(project_id) AS Total_project FROM Projects P LEFT JOIN Employees E ON P.emp_id=E.emp_id GROUP BY emp_name HAVING COUNT(project_id) IS NULL;
SELECT project_name , emp_name FROM Projects P LEFT JOIN Employees E ON P.emp_id=E.emp_id WHERE E.emp_id IS NULL;

#Q 16. List employees whose salary is greater than 40,000 along with their department.
SELECT emp_name, salary, dept_name FROM Employees E LEFT JOIN Departments D ON E.dept_id =D.dept_id  HAVING salary>40000;

#Q 17.Display employee names along with their manager (self join if applicable). 
#Advanced Level
#18. Find the highest salary in each department
SELECT dept_name, MAX(salary)AS Highest_salary FROM Employees E  JOIN Departments D ON E.dept_id=D.dept_id GROUP BY dept_name;
