# DDL Data Definition Language
#    CREATE , ALTER , DROP


/*
How To Create A Database?
Syntax:-
CREATE DATABASE database_name;
*/
CREATE DATABASE school;
# SQL is not case sensitive
create database abcd;

# How to Select A Database
# USE database_name;
USE school;

# How to create a table?
# CREATE TABLE table_name( col_name DType , col_name Dtype );
CREATE TABLE student(
stid INT,
stname TEXT,
stadress TEXT,
stmobile TEXT);


# ALTER
# How to add a new column?
# ALTER TABLE table_name ADD COLUMN col_name DType;
ALTER TABLE student ADD COLUMN stemail TEXT;

# How to describe a table?
# DESCRIBE table_name;
DESCRIBE student;



# How to delete a column in a Table
ALTER TABLE student DROP COLUMN stmobile ;
DESCRIBE student;

# How to change the Dtype of a column?
ALTER TABLE student MODIFY stid TEXT;


DROP TABLE student;
DROP DATABASE school; 