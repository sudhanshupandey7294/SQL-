CREATE DATABASE trigger_exercises;
USE trigger_exercises;
#-- Customers table
CREATE TABLE customers (
 customer_id INT PRIMARY KEY AUTO_INCREMENT,
 name_ VARCHAR(50),
 email VARCHAR(100),
 city VARCHAR(50)
);

INSERT INTO customers (name_, email, city) VALUES('Ram', 'ram123@gmail.com', 'Ayodhya');
INSERT INTO customers (name_, email, city) VALUES('Rahul', 'rahul123@gmail.com', 'Delhi');
SELECT * FROM customers;

#-- Accounts table
CREATE TABLE accounts (
 account_id INT PRIMARY KEY AUTO_INCREMENT,
 customer_id INT,
 balance DECIMAL(10,2),
 account_type VARCHAR(20),
 FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
#-- Transactions table
CREATE TABLE transactions (
 transaction_id INT PRIMARY KEY AUTO_INCREMENT,
 account_id INT,
 amount DECIMAL(10,2),
 transaction_type VARCHAR(10), -- 'DEPOSIT' or 'WITHDRAW'
 transaction_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);
#-- Audit log table
CREATE TABLE audit_log (
 log_id INT PRIMARY KEY AUTO_INCREMENT,
 table_name_ VARCHAR(50),
 action_type VARCHAR(20),
 record_id INT,
 action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
#-- Backup table for deleted accounts
CREATE TABLE deleted_accounts (
 account_id INT,
 customer_id INT,
 balance DECIMAL(10,2),
 account_type VARCHAR(20),
 deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
#____________________________________________________________________________________________________________________
#Trigger Exercise Questions
#Exercise 1: BEFORE INSERT Prevent creating an account with negative balance
DELIMITER //
CREATE TRIGGER preventAcc
BEFORE INSERT ON accounts
FOR EACH ROW
BEGIN
IF NEW.balance<0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Balance cannot be negative';
END IF;

END // DELIMITER ;

INSERT INTO accounts(customer_id, balance, account_type) VALUES( 1, 5000, 'Saving account');
SELECT * FROM accounts;
INSERT INTO accounts(customer_id, balance, account_type) VALUES( 1, -5000, 'Saving account');  # SIGNAL ----BALANCE cannot be negative 

#_________________________________________________________________________________________________
#Exercise 2: BEFORE INSERT 
#Automatically set minimum balance = 1000 if inserted balance is less than 1000

DELIMITER //
CREATE TRIGGER set_minimum_balance
BEFORE INSERT ON accounts
FOR EACH ROW
BEGIN
IF
 NEW.balance<1000 THEN 
SET NEW.balance=1000;
END IF;

END //DELIMITER ;

INSERT INTO accounts(customer_id, balance, account_type) VALUES( 1, 100, 'Saving account');  # I have given balance =500 which is less than 1000 then it will automatically set as 1000

SELECT * FROM accounts;
#____________________________________________________________________________________________________________________
#Exercise 3: AFTER INSERT 
#Log every new account creation in audit_log 

DELIMITER $$
CREATE TRIGGER log_account_creation
AFTER INSERT ON accounts
FOR EACH ROW
BEGIN
INSERT INTO audit_log(table_name_, action_type, record_id) 
VALUES('accounts',' INSERT', 'NEW.account_id');
END $$ DELIMITER ;

SELECT* FROM accounts;

SELECT* FROM audit_log;

INSERT INTO audit_log(table_name_, action_type, record_id) VALUES( 'accounts', 'INSERT', 2);
SELECT* FROM audit_log;


#_____________________________________________________________________________________________________-
#Exercise 4: BEFORE UPDATE 
#Prevent account balance from becoming negative after update 

 DELIMITER //
 CREATE TRIGGER non_negative_balance_
 BEFORE UPDATE ON accounts
 FOR EACH ROW 
 BEGIN
 IF NEW.balance <0 THEN
 SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Balance cannot be negative';
END IF;
 END // DELIMITER ;

SELECT * FROM accounts;
UPDATE accounts SET balance= -3000 WHERE account_id=2;
UPDATE accounts SET balance= 300000 WHERE account_id=2;

#_________________________________________________________________________________________________________
#Exercise 5: AFTER UPDATE 
#Log old and new balance changes in audit_log 
  
  ALTER TABLE audit_log
ADD COLUMN old_value DECIMAL(10,2),
ADD COLUMN new_value DECIMAL(10,2);
  
DELIMITER //
CREATE TRIGGER Log_old_new_balance
AFTER UPDATE ON accounts
FOR EACH ROW
BEGIN
IF OLD.balance <> NEW.balance THEN
INSERT INTO audit_log(table_name_, action_type, record_id, old_value, new_value) 
VALUES('accounts', 'INSERT', NEW.account_id, OLD.balance, NEW.balance);
END IF;
END //DELIMITER ;
