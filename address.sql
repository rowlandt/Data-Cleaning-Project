-- Observing data in the people table. 399 records
SELECT *
FROM people;

/* Check the values in the address rows are consistent. Looking at the address field that is how we do the 
obtain the figues. The first part is the street address, which consists of numbers upper and lower case and periods. 
Then the next part is the city also containing upper and lower case. Then the state with only upper and then 
the zipcode with only numbers */
SELECT address
FROM people
WHERE address regexp '^[0-9a-zA-Z\. ]+;[a-zA-Z ]+;[A-Z ]+;[0-9 ]+$';

-- To see how many we are getting. Which is 396 out of 399. So we know that the address field is not consistent. 
SELECT count(address)
FROM people
WHERE address regexp '^[0-9a-zA-Z\. ]+;[a-zA-Z ]+;[A-Z ]+;[0-9 ]+$';

/*Putting a NOT in front of the regexp to get the three rows that are not following the expression.
Which upon investigation notice they are missing semicolons .*/
SELECT address
FROM people
WHERE address not regexp '^[0-9a-zA-Z\. ]+;[a-zA-Z ]+;[A-Z ]+;[0-9 ]+$';

/* We have to fix these rows. So we go to the people table, right click and select 'select rows limit 1000'
This brings up a new tab. Then use search field to look up rows. */

/*We want to eventaully extract the data fields and store them into a separate table. 
substring_index used a delimiter to extract the strings from the field */
SELECT substring_index(address, ';',1)
FROM people;
-- To get just the city, we use a substring of the substring. 
SELECT substring_index(substring_index(address, ';',2), ';', -1)
FROM people;
-- To get the state we again use substring index.
SELECT substring_index(substring_index(address, ';',3), ';', -1)
FROM people;
-- To get the zipcode we again use substing_index. 
SELECT substring_index(substring_index(address, ';',4), ';', -1)
FROM people;
-- We are going to combine in one SELECT statement. 
SELECT substring_index(address, ';',1) AS street,
substring_index(substring_index(address, ';',2), ';', -1) AS city,
substring_index(substring_index(address, ';',3), ';', -1) AS state,
substring_index(substring_index(address, ';',4), ';', -1) AS zip
FROM people;

/* We now want to create the address table itself to hold the atomic values we obtained from the 
existing table. This will allow us to improve queries and protect the data as well and keep it clean and valid*/

CREATE TABLE address (
id INT NOT NULL auto_increment,
street VARCHAR(255) NOT NULL,
city VARCHAR(255) NOT NULL,
state VARCHAR(2) NOT NULL,
zip VARCHAR(10) NOT NULL,
pfk INT, -- relate the address back to the pweson. person foreign key
primary key (id) -- primary key identifier
);

/* Create insertion statement. Next use the SELECCT statement to obtain the corresponding fields in the
people address table using the same substring_index from previous tasks.*/
INSERT INTO address(street, city, state, zip, pfk)
SELECT substring_index(address, ';',1) AS street,
substring_index(substring_index(address, ';',2), ';', -1) AS city,
substring_index(substring_index(address, ';',3), ';', -1) AS state,
substring_index(substring_index(address, ';',4), ';', -1) AS zip, 
id 
FROM people;

/* We obtained an error stating data too long for state column. Two characters were observed for state.
There are spaces that need to be removed and therefore TRIM will be used to remove any space before and after the string*/
INSERT INTO address(street, city, state, zip, pfk)
SELECT trim(substring_index(address, ';',1)) AS street,
trim(substring_index(substring_index(address, ';',2), ';', -1)) AS city,
trim(substring_index(substring_index(address, ';',3), ';', -1)) AS state,
trim(substring_index(substring_index(address, ';',4), ';', -1)) AS zip, 
id 
FROM people;

/* Gives us the original people table with the address table with the columns added as atomic values*/
SELECT * 
FROM company.people, company.address
WHERE people.id = address.pfk;