/*
Transaction :- A group of queries execute to complete a single task

ACID
A - Atomicity - All or Nothing
C - Consistency - Data Remains Valid
I - Isolation - Transaction do not interfare
D - Durability - Once Commited, Data is saved permanently


*/

CREATE DATABASE  bank;
USE bank;
CREATE TABLE accounts(
aid INT PRIMARY KEY AUTO_INCREMENT,
aname VARCHAR(30),
balance decimal(8,2) DEFAULT 0.0);

INSERT INTO accounts VALUES
(5536,'Aman Kumar',7237),
(5537,'Rahul Singh',3528),
(5538,'Yogesh Saini',2534);

SELECT * FROM accounts;

# Aman wants to send 1000/- to Rahul
UPDATE accounts SET balance=balance-1000 WHERE aid ='5536';
UPDATE accounts SET balance=balance+1000 WHERE aid ='5537';
 
 SELECT * FROM accounts;

# To perform a transaction we should start a TRANSACTION

START TRANSACTION;
# Aman wants to send 1000/- to Rahul
UPDATE accounts SET balance=balance-1000 WHERE aid=5536;
UPDATE accounts SET balance=balance+1000 WHERE aid=5537;
ROLLBACK; 

# Aman wants to send 1000/- to Rahul
UPDATE accounts SET balance=balance-1000 WHERE aid=5536;
UPDATE accounts SET balance=balance+1000 WHERE aid=5537;
 SELECT * FROM accounts;
COMMIT;
ROLLBACK;
 SELECT * FROM accounts;  #Once committed we cannot Rollback ie.transaction suucessful we cannot re obtain the balance back to aur account  using ROLLBACK
 
 # Aman wants to send 1000/- to Rahul
# Rahul needs to send 1750/- to Yogesh

SELECT * FROM accounts;
START TRANSACTION;
# Transaction 1
UPDATE accounts SET balance=balance-1000 WHERE aid=5536;
UPDATE accounts SET balance=balance+1000 WHERE aid=5537;
SAVEPOINT s1;
# Transaction 2
UPDATE accounts SET balance=balance-1750 WHERE aid=5537;
UPDATE accounts SET balance=balance+1750 WHERE aid=5538;
COMMIT;
ROLLBACK TO s1;  # to prevent lot of transaction so that some of them not mitakenly COMMIT so we use SAVEPOINT....