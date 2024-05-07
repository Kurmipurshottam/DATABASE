-- Create the Bank_data database and switch to it
CREATE DATABASE Bank_data;
USE Bank_data;

-- Create the Bank table to store bank branch details
CREATE TABLE Bank_Details (
    Branch_id INT PRIMARY KEY,
    Branch_name VARCHAR(30),
    Branch_city VARCHAR(20)
);

-- Create the Loan_table to store loan details
CREATE TABLE Loan_details (
    Loan_no INT PRIMARY KEY,
    Loan_amount INT,
    Loan_type VARCHAR(20),
    Branch_id INT,
    account_holders_id INT
);

-- Create the Account_holder table to store account holder information
CREATE TABLE Account_holder (
    account_holders_id INT PRIMARY KEY,
    account_holders_name VARCHAR(20),
    City TEXT,
    Contact VARCHAR(10),
    Date_of_account_created DATE,
    Account_status VARCHAR(10),
    Account_type VARCHAR(20),
    Balance INT
);

-- Modify Loan_no to be primary key in Loan_details
ALTER TABLE Loan_details MODIFY Loan_no INT PRIMARY KEY;

-- Insert data into the Bank_Details table
INSERT INTO Bank_Details (Branch_id, Branch_name, Branch_city) VALUES
(101, "BOB", "Ahmedabad"),
(102, "SBI", "Gandinager"),
(103, "Axis", "Rajkot"),
(104, "SBI", "Amreli"),
(105, "Kotak Mahindra", "Palanpur");

-- Insert data into the Loan_details
INSERT INTO Loan_details 
VALUES
(10, 100000, 'Student Loan', 101, 1),
(20, 100000, 'Home Equity Loan', 102, 2),
(30, 50000, 'Auto Loan', 102, 2),
(40, 650000, 'Personal Loan', 103, 3),
(50, 350000, 'Small Business Loan', 104, 3);

-- Insert data into the Account_holder table
INSERT INTO Account_holder (account_holders_id, account_holders_name, City, Contact, Date_of_account_created, 
Account_status, Account_type, Balance) 
VALUES
(1, "SAURABH", "Ahmedabad", "9506510346", '2013-05-15', "Active", "Savings", 50000),
(2, "NIKHIL", "Surat", "9865243687", '2013-04-14', "Terminated", "Current", 60000),
(3, "SMIT", "Rajkot", "9998676647", '2013-05-02', "Active", "Fixed Deposite", 80000),
(4, "AJIT", "Ahmedabad", "6359452317", '2013-05-15', "Active", "Recurring Deposite", 30000),
(5, "PRASHANT", "Surat", "9106523346", '2013-05-20', "Terminated", "Savings", 80000);

-- Deduct $100 from account A 

UPDATE Account_holder
SET balance = balance - 100.00
WHERE account_holders_id = 1;

-- Add $100 to Account B

UPDATE Account_holder
SET balance = balance + 100.00
WHERE account_holders_id = 2;

-- Fetch account holders from Surat and Ahmedabad cities
SELECT *
FROM Account_holder
WHERE City IN ("Rajkot", "Ahmedabad");

-- Fetch account number and account holder name for accounts created after 15th of any month
SELECT account_holders_id, account_holders_name
FROM Account_holder
WHERE DAY(Date_of_account_created) > 15;

-- Display city name and count the branches in that city
SELECT Branch_city, COUNT(*) AS Count_Branch
FROM Bank_Details
GROUP BY Branch_city;   

-- Display account holder’s id, name, branch id, and loan amount for people who have taken loans
SELECT ah.account_holders_id, ah.account_holders_name, lt.Branch_id, lt.Loan_amount
FROM Account_holder as ah
JOIN Loan_details as lt ON ah.account_holders_id = lt.account_holders_id;
