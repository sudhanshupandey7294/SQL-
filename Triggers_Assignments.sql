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

#______________________________________________________________________________________________________________________________________
#Exercise 6: BEFORE DELETE 
#Backup account details into deleted_accounts before deletion 
DELIMITER //
CREATE TRIGGER backup_account
BEFORE DELETE ON accounts
FOR EACH ROW 
BEGIN
INSERT INTO deleted_accounts(account_id, customer_id, balance, account_type)
VALUES (OLD.account_id, OLD.customer_id, OLD.balance, OLD.account_type);
END // DELIMITER ;

DELETE FROM accounts
WHERE account_id = 2;
SELECT * FROM accounts;
SELECT * FROM deleted_accounts;

#_______________________________________________________________________________________________________________________________
#Exercise 7: BEFORE DELETE 
#Prevent deletion of accounts with balance greater than 0 

DELIMITER //
CREATE TRIGGER prevent_deletion
BEFORE DELETE ON accounts
FOR EACH ROW 
BEGIN
IF balance>0 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Balance greater than cannot be deleted';
END IF ;
END // DELIMITER ;

SELECT * FROM accounts;
DELETE FROM accounts
WHERE account_id=3;

#__________________________________________________________________________________________________________________
#Exercise 8: AFTER INSERT (Transactions) 
#When a DEPOSIT happens, automatically increase account balance

DELIMITER //
CREATE TRIGGER auto_increase_balance
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
IF NEW.transaction_type = 'DEPOSIT' THEN
        UPDATE accounts
        SET balance = balance + NEW.amount
        WHERE account_id = NEW.account_id;
    END IF;
END //DELIMITER ;

INSERT INTO transactions (account_id, amount, transaction_type)
VALUES (3, 2000, 'DEPOSIT');

SELECT * FROM transactions;

#_________________________________________________________________________________------
#Exercise 9: AFTER INSERT (Transactions) 
#When a WITHDRAW happens: - Deduct amount from balance - Prevent withdrawal if insufficient balance 

-- DELIMITER //
-- CREATE TRIGGER w_d_p
-- BEFORE INSERT ON transactions
-- FOR EACH ROW
-- BEGIN
-- IF NEW.transaction_type='WITHDRAW' THEN UPDATE accounts SET balance= balance - NEW.amount
-- WHERE account_id= NEW.account_id;
-- IF balance=0 THEN 
-- SIGNAL SQLSTATE '45000'
-- SET MESSAGE_TEXT = ' INSUFFICIET BALANCE, CANNOT WITHDRAW';
-- END IF;
-- END IF;
-- END //DELIMITER ;


# 1. BEFORE INSERT -check_balance
DELIMITER $$
CREATE TRIGGER b_check
BEFORE INSERT ON transactions
FOR EACH ROW
BEGIN
    IF NEW.transaction_type = 'WITHDRAW' AND 
       (SELECT balance FROM accounts WHERE account_id = NEW.account_id) < NEW.amount
    THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Insufficient balance';
    END IF;
END $$ DELIMITER ;
		
#2 AFTER INSERT -Update_balance

DELIMITER $$
CREATE TRIGGER w_update
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
    IF NEW.transaction_type = 'WITHDRAW' THEN
        UPDATE accounts
        SET balance = balance - NEW.amount
        WHERE account_id = NEW.account_id;
    END IF;
END $$ DELIMITER ;


#_______________________________________________________________________________________________________________________________
#Exercise 10: AFTER INSERT 
#Log every transaction in audit_log

DELIMITER //
CREATE TRIGGER log_in_audit
AFTER INSERT ON accounts
FOR EACH ROW
BEGIN
INSERT INTO audit_log(table_name_, action_type, record_id) VALUES('accounts', 'INSERT', NEW.account_id);
END // DELIMITER ;

#_______________________________________________________________________________________________________________________________
#Exercise 11: BEFORE UPDATE 
#Prevent changing account_type once created 

DELIMITER //
CREATE TRIGGER prev_acc_type
BEFORE UPDATE ON accounts
FOR EACH ROW
BEGIN
IF OLD.account_type <> NEW.account_type THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Account type cannot be changed';
END IF;
END //DELIMITER ;

#________________________________________________________________________________________________________________________________

#Exercise 12: AFTER UPDATE 
#Track account type changes in audit_log 


select* FROM audit_log;

DELIMITER $$
CREATE TRIGGER track_account_type
AFTER UPDATE ON accounts
FOR EACH ROW
BEGIN
IF OLD.account_type<> NEW.account_type THEN
INSERT INTO audit_log(table_name_, action_type, record_id, old_value, new_value)
VALUES('accounts', 'UPDATE_TYPE',NEW.account_id, OLD.account_type, NEW.account_type);
END IF;
END $$ DELIMITER ;

#________________________________________________________________________________________________________
#Prevent changing city to NULL 

DELIMITER //
CREATE TRIGGER prev_change_city
BEFORE UPDATE ON customers
FOR EACH ROW
BEGIN
IF NEW.city IS NULL THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT= 'CITY cannot be changed';
END IF;
END // DELIMITER ;


#________________________________________________________________
#Automatically create a default account for every new customer
DELIMITER //
CREATE TRIGGER create_default_account
AFTER INSERT ON customers
FOR EACH ROW
BEGIN
INSERT INTO accounts(customer_id, balance, account_type)
VALUEs(NEW.customer_id, 10000, 'SAVINGS');
END // DELIMITER ;

#__________________________________________________
#Exercise 13: BEFORE INSERT (Customers) 
#Ensure email is unique (even without unique constraint) 
DELIMITER $$

CREATE TRIGGER unique_email_update
BEFORE UPDATE ON customers
FOR EACH ROW
BEGIN
    IF NEW.email <> OLD.email AND 
       (SELECT COUNT(*) FROM customers WHERE email = NEW.email) > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Email already exists';
    END IF;
END $$

DELIMITER ;
#________________________________________________________________________________
#Exercise 16 
#Maintain a separate table to count total transactions per account

CREATE TABLE account_transaction_count (
    account_id INT PRIMARY KEY,
    total_transactions INT DEFAULT 0,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);
DELIMITER //
CREATE TRIGGER transaction_acc_
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
INSERT INTO account_transaction_count(account_id, total_transactions)
VALUES(NEW.account_id, 1);
#ON DUPLICATE KEY UPDATE 
 #   total_transactions = total_transactions + 1;
END // DELIMITER ;
#____________________________________________________________________________________________________--
#Exercise 20 
#Maintain a history table for all balance changes 
CREATE TABLE balance_history (
    history_id INT AUTO_INCREMENT PRIMARY KEY,
    account_id INT,
    old_balance DECIMAL(10,2),
    new_balance DECIMAL(10,2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

DELIMITER $$

CREATE TRIGGER track_balance_history
AFTER UPDATE ON accounts
FOR EACH ROW
BEGIN
    IF OLD.balance <> NEW.balance THEN
        INSERT INTO balance_history (account_id, old_balance, new_balance)
        VALUES (NEW.account_id, OLD.balance, NEW.balance);
    END IF;
END $$

DELIMITER ;

#___________________________________________________________________________
#Exercise 18 
#Prevent more than 3 withdrawals per day per account 

DELIMITER $$

CREATE TRIGGER limit_daily_withdrawals
BEFORE INSERT ON transactions
FOR EACH ROW
BEGIN
    IF NEW.transaction_type = 'WITHDRAW' THEN
        IF (
            SELECT COUNT(*) 
            FROM transactions
            WHERE account_id = NEW.account_id
              AND transaction_type = 'WITHDRAW'
              AND DATE(transaction_time) = CURDATE()
        ) >= 3 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Daily withdrawal limit exceeded';
        END IF;
    END IF;
END $$

DELIMITER ;
