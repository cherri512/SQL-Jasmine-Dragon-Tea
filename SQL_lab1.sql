--Code by: Corey Cherrington
--Lab #1 
--1.) Write the SQL code to determine which customers are from the zip code 80471.

SELECT CustomerFname, CustomerLname, CustomerZip
FROM tblCUSTOMER
WHERE CustomerZip = 80471


--2.) Write the SQL code to determine which customers have ‘Blvd’ in their address.

SELECT CustomerFname, CustomerLname, CustomerAddress
FROM tblCUSTOMER
WHERE CustomerAddress LIKE '%Blvd%'


--3.) Write the SQL code to determine which customers have last names that match the pattern ‘F**R’ (read ‘F in position one and R in position four’) and reside in either Florida or Texas.

SELECT CustomerFname, CustomerLname, CustomerState
FROM tblCUSTOMER
WHERE CustomerLname LIKE 'F__R'
AND CustomerState IN ('Florida, FL', 'Texas, TX')
ORDER BY CustomerFname ASC


--4.) Write the SQL code to determine which customers have a first name beginning with ‘Ra’
and live in California.
SELECT CustomerFname, CustomerLname, CustomerState
FROM tblCUSTOMER
WHERE CustomerFname LIKE 'Ra%'
AND CustomerState IN ('California, CA')


--5.) Write the SQL code to determine which customers have ‘Leaf’ in their address and have the two letters ‘ba’ together in any part of the county they live in.

SELECT CustomerFname, CustomerLname, CustomerAddress, CustomerCounty
FROM tblCUSTOMER
WHERE CustomerAddress LIKE '%Leaf%'
AND CustomerCounty LIKE '%ba%'


--6.) Write the SQL code to determine which states have at least 100,000 customers.

SELECT CustomerState, COUNT(*) AS TotalCustomers
FROM tblCustomer
GROUP BY CustomerState
HAVING COUNT(*) > 100000


--7.) Write the SQL code to determine which customers are at least 65 years-old and do NOT live in Wyoming, Iowa, Colorado or Nebraska.

SELECT *
FROM tblCUSTOMER
WHERE DateOfBirth < DateAdd(Year, -65, GetDate())
AND CustomerState NOT IN ('Wyoming, WY', 'Colorado, CO', 'Nebraska, NE,', 'Iowa, IA')

--8.) Write the SQL code to determine which customers are younger than 50, have a phone
--number in area code '206', '360' or '425' and also have a last name beginning with 'J'.

SELECT *
FROM tblCUSTOMER
WHERE DateOfBirth > DateAdd(Year, -50, GetDate())
AND CustomerLname LIKE 'J%'
AND AreaCode IN (206, 360, 425)
ORDER BY DateOfBirth ASC


--9.) Write the SQL code to determine who the oldest customer is from Florida.
SELECT Top 1 with ties CustomerFname, CustomerLname, CustomerState, DateDiff(YYYY,
DateOfBirth, GetDate()) AS Age
FROM tblCUSTOMER
WHERE CustomerState = 'Florida, FL'
ORDER BY DateOfBirth ASC


--10.) Write the SQL code to determine the average age of all customers from Oregon.
SELECT AVG(DateDiff(DD, DateOfBirth, GetDate()) / 365.25) AS AverageOregonianLifespan
FROM tblCUSTOMER
WHERE CustomerState = 'Oregon, OR
