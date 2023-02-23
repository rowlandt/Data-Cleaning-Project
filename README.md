# Data Cleaning Project
 Quick data cleaning project in SQL using MySQL Workbench.
 
 Clean up MySQL student data in a MySQL database using SQL commands in MySQL Workbench.  

Three Course Objectives:

1.	Use SQL REGEX to check and clean the address in the MySQL table. 
2.	Create a Query to display the atomic values within the address field. 
3.	Use SQL to Insert the Data into the address table using existing data.

Project Structure:
Task 1: Analyze an existing people database table for Normalization. 
Task 2: Use SQL REGEX to check and clean the address in the MySQL table. 
Task 3: Create a Query to display the atomic values within the address field. 
Task 4: Use the existing address field to create an address table. 
Task 5: Use SQL to Insert the Data into the address table using existing data. 

TASK 1: Connect to the database. Observed the company db and people table. Check for normalization: are there fields that aren’t atomic(one value per field)
TASK 2: Observe the data in the address field. Generate a regular expression to detect the expected format. Run the not regular expression to detect and repair incorrect entries. 
	Checked and cleaned address using regexp.
TASK 3: begin w/ the SELECT statement. Use the substring_index function to return the given number of strings separated by a delimiter. Use the outer substring_index to return the last string in the list. Label each string to give it meaning.
TASK 4: Use the create table SQL. Add the fields as labeled in the Address query. Pay attention to required varchar width. Add a field to associate the address to a person. 
TASK 5: Use an sql insert to insert into the address table. Form the insert based on the address table names. Insert the people table address data as atomic values based on the substring_index query. Add an id to associate the address with a person. 
