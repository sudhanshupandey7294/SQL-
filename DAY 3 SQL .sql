CREATE DATABASE schools;
USE schools;
CREATE TABLE students(
std_id INT,
std_name TEXT,
std_address TEXT,
std_mob TEXT
);

ALTER TABLE students ADD COLUMN std_email TEXT;
DESCRIBE students;

#DML (Data Manipulation Language)
# INSERT
# INSERT INTO table_name VALUE(val1,val2,..);
INSERT INTO students VALUES (
101, 'Sudhanshu', 'Noida', '6392255364', 'sudhanshupandey738@gmail.com' 
);

# SELECT 
# SELECT col1,col2,.. FROM table_name;
SELECT std_id, std_name , std_address FROM students;

SELECT * FROM students;  # to show all columns

INSERT INTO students VALUES
(102, 'Bhanu', 'Prayagraj', '8318345728', 'nishadbhanu5728@gmail.com'),
(103, 'Shaurabh', 'Jaunpur', '9156782345', 'pal123@gmail.com'),
(104, 'Rahul', 'Prayagraj', '9823456712', 'rahul123@gmail.com');

SELECT * FROM students;

INSERT INTO students VALUES
(105, 'Aman', NULL, '985673456', 'aman123@gmail.com'),
(106, 'Ritik', 'Dellhi', NULL, 'ritik234@gmail.com'),
(107, 'Kantara', NULL, '9876543210', NULL);

SELECT * FROM students;
SELECT std_id , std_name FROM students;

#WHERE clause
SELECT std_id, std_name FROM students WHERE std_address ='Prayagraj';

SELECT * FROM students;

# IF safe mode is ON and you are unable to delete anything
SET SQL_SAFE_UPDATES = 0;

#UPDATE
# UPDATE table_name SET col_name=values;
UPDATE students SET std_name='Yashu' WHERE std_name='Sudhanshu';
UPDATE students SET std_name='Yashu';

#DELETE 
DELETE FROM students WHERE std_address='Jaunpur';







