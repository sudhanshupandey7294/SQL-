
CREATE DATABASE Union_bank;
USE Union_bank;
CREATE TABLE accounts ( 
account_id INT PRIMARY KEY, 
account_name VARCHAR(50), 
balance DECIMAL(10,2) 
); 
INSERT INTO accounts VALUES 
(1, 'Alice', 5000), 
(2, 'Bob', 3000), 
(3, 'Charlie', 7000); 

-- 1. Start a transaction and transfer ₹1000 from Alice to Bob.  
-- 2. Perform a transaction where ₹2000 is deducted from Bob, but rollback before commit.  
-- 3. Transfer ₹500 from Charlie to Alice and commit the transaction.  
-- 4. Try transferring ₹10000 from Bob (insufficient balance). Rollback if balance goes negative.  
-- 5. Perform multiple transfers in one transaction and rollback all if any one fails.

#1 
START TRANSACTION;
UPDATE accounts SET balance=balance-1000 WHERE account_id= 1;
UPDATE accounts SET balance=balance+1000 WHERE account_id= 2;

#2
START TRANSACTION;
UPDATE accounts SET balance=balance-2000 WHERE account_id= 2;
SELECT * FROM accounts;
ROLLBACK;
COMMIT;

#3
START TRANSACTION;
UPDATE accounts SET balance=balance-500 WHERE account_id= 3;
UPDATE accounts SET balance=balance+500 WHERE account_id= 1;
COMMIT;

#4
START TRANSACTION;
UPDATE accounts 
SET balance = balance - 10000 
WHERE account_id= 2;

-- Check balance
SELECT balance FROM accounts WHERE account_name = 'Bob';
#IF balance<0
ROLLBACK;
#ELSE 
COMMIT;

#5
START TRANSACTION;

-- Transfer 1
UPDATE accounts SET balance = balance - 500 WHERE account_name = 'Alice';
UPDATE accounts SET balance = balance + 500 WHERE account_name = 'Bob';

-- Transfer 2
UPDATE accounts SET balance = balance - 300 WHERE account_name = 'Charlie';
UPDATE accounts SET balance = balance + 300 WHERE account_name = 'Alice';

-- Transfer 3 (problem case)
UPDATE accounts SET balance = balance - 10000 WHERE account_name = 'Bob';

-- If any issue → rollback everything
ROLLBACK;

-- If all valid → COMMIT;

-- Schema 2: E-Commerce Orders 
CREATE TABLE products ( 
product_id INT PRIMARY KEY, 
product_name VARCHAR(50), 
stock INT 
); 
CREATE TABLE orders ( 
order_id INT PRIMARY KEY, 
product_id INT, 
quantity INT 
); 
INSERT INTO products VALUES 
(1, 'Laptop', 10), 
(2, 'Phone', 20); 

SELECT *FROM products;

#Q6. Start a transaction and place an order for 2 laptops. Reduce stock accordingly. 

START TRANSACTION;
SET SQL_SAFE_UPDATES=0;
UPDATE orders SET quantity ='2' WHERE product_id ='1';
UPDATE products SET stock=stock-2 WHERE product_id ='1';
SELECT *FROM products;

#Q7. Place an order where stock is insufficient. Rollback the transaction. 

-- MAKE STOCK 0
START TRANSACTION;
UPDATE orders SET quantity ='8' WHERE product_id ='1';
UPDATE products SET stock=stock-8 WHERE product_id ='1';
SELECT *FROM products;

-- After 0 stock Rollback
UPDATE orders SET quantity ='10' WHERE product_id ='1';
UPDATE products SET stock=stock-10 WHERE product_id ='1';
# Stock is negative ie insufficient
ROLLBACK;
SELECT *FROM products;

#Q8. Insert order and update stock in a single transaction. Commit only if both succeed. 
INSERT INTO orders VALUES(1,1, 10);
START TRANSACTION;
UPDATE products SET stock= stock-10 WHERE product_id='1';
COMMIT;
SELECT* FROM orders;
SELECT* FROM products;

#Q9 Simulate failure after inserting order but before updating stock. Rollback changes. 
START TRANSACTION;

INSERT INTO orders (order_id, product_id, quantity)
VALUES (3, 1, 2);

-- Simulated failure
ROLLBACK;


#Q10 Perform bulk order inserts and rollback if any product stock becomes negative. 
INSERT INTO orders VALUES(2, 1, 30);
UPDATE products SET stock=stock-30 WHERE product_id='1';
SELECT* FROM orders;
SELECT* FROM products;
#product stock is negative as it has only 10 But i have ordered 30 
-- So Rollback it
ROLLBACK;

-- Schema 3: Employee Salary Update 
CREATE TABLE employees ( 
emp_id INT PRIMARY KEY, 
emp_name VARCHAR(50), 
salary DECIMAL(10,2) 
); 
INSERT INTO employees VALUES 
(1, 'John', 40000), 
(2, 'Jane', 45000), 
(3, 'Mike', 50000);

#Q11. Increase salary of all employees by 10% using a transaction.  

START TRANSACTION;
SET SQL_SAFE_UPDATES=0;
UPDATE employees SET salary=salary +0.10*salary;
SELECT* FROM employees;