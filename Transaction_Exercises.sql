
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