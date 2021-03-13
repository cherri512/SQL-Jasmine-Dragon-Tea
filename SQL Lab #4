/* 1.) Write the DDL statements to establish an eighttable database diagram of the following tables to track cars brought into a repair shop:
MANUFACTURER, MODEL, CAR, CUSTOMER, SERVICE_TYPE, EMPLOYEE, SERVICE, CUSTOMER_SERVICE */

CREATE DATABASE CAC_LAB4

USE CAC_Lab4

CREATE TABLE tblManufacturer
    (ManufacturerID INT Identity(1,1) PRIMARY KEY,
    ManufacturerName varchar(50) NOT NULL,
    ManufacturerDescr VARCHAR(500) NULL)
GO

CREATE TABLE tblModel
    (ModelID INT IDENTITY(1,1) PRIMARY KEY,
    ManufacturerID INT FOREIGN KEY REFERENCES tblManufacturer (ManufacturerID),
    ModelName varchar(50) NOT NULL,
    ModelDescr varchar(500) NULL)
GO

CREATE TABLE tblCar
    (CarID INT IDENTITY(1,1) PRIMARY KEY,
    ManufacturerID INT FOREIGN KEY REFERENCES tblManufacturer (ManufacturerID) NOT NULL,
    ModelID INT FOREIGN KEY REFERENCES tblModel (ModelID) NOT NULL,
    CarName varchar(50) NOT NULL,
    CarDescr varchar(500) NULL)
GO

CREATE TABLE tblCustomer
    (CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerFName VARCHAR(100) NOT NULL,
    CustomerLName VARCHAR(100) NOT NULL,
    CustomerPhone char(8) NOT NULL,
    CustomerEmail varchar(100) NULL,
    CustomerAddress VARCHAR(500) NOT NULL,
    CustCity VARCHAR(100) NOT NULL,
    CustState varchar(100) NOT NULL,
    CustZipcode CHAR(5) NOT NULL) 
GO

CREATE TABLE tblService_Type
    (Service_TypeID INT IDENTITY(1,1) PRIMARY KEY,
    Service_Type_Name varchar(50) NOT NULL,
    Service_Type_Descr varchar(500) NULL)
GO

CREATE TABLE tblEmployee
    (EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeFName varchar(100) NOT NULL,
    EmployeeLName varchar(100) NOT NULL,
    EmployeePhone char(8) NOT NULL,
    EmployeeEmail VARCHAR(100) not NULL,
    EmployeeAddress varchar(200) NOT NULL,
    EmployeeCity varchar(50)NOT NULL,
    EmployeeState varchar(50) NOT NULL,
    EmployeeZipcode char(5) NOT NULL,
 EmployeeBirthDate DATE NOT NULL)
GO

CREATE TABLE tblService
    (ServiceID INT Identity(1,1) PRIMARY KEY,
    Service_TypeID INT FOREIGN KEY REFERENCES tblService_Type (Service_TypeID) NOT NULL,
    ServiceName varchar(50) NOT NULL,
    ServiceDescr varchar(500) NULL,
 ServicePrice NUMERIC(12,2) NOT NULL)
GO

CREATE TABLE tblCustomer_Service
    (Customer_ServiceID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES tblCustomer (CustomerID) NOT NULL,
    ServiceID INT FOREIGN KEY REFERENCES tblService (ServiceID) NOT NULL,
    EmployeeID INT FOREIGN KEY REFERENCES tblEmployee (EmployeeID) NOT NULL,
    CarID INT FOREIGN KEY REFERENCES tblCar (CarID) NOT NULL,
    Customer_ServiceName varchar(100) NOT NULL,
    Customer_ServiceDescr varchar(500) NULL,
    CustServStartDate DATE NOT NULL,
    CustServEndDate DATE NULL,
    Price NUMERIC(12,2))
GO


/* 2.) Populating tables with Data w/ INSERT statements and Stored Procedured and
Nested Stored procedures */

--tblManufacturer
INSERT INTO tblManufacturer (ManufacturerName, ManufacturerDescr)
VALUES ('Toyota', 'Japanese multinational automotive manufacture'),
        ('Ford', 'American multinational automaker'),
        ('Honda', 'Japanese public multinational conglomerate manufacturer')
GO

--tblModel w/ FK ManufacturerID
CREATE PROCEDURE CAC_LookUpModelID
@ManuName varchar(50),
@Man_ID INT OUTPUT
AS
SET @Man_ID = (SELECT ManufacturerID
 FROM tblManufacturer
 WHERE @ManuName = ManufacturerName)
GO

CREATE PROCEDURE CAC_NewtblModel
@ManufactName varchar(50),
@ModName varchar(50),
@ModDescr varchar(500)
AS
DECLARE @M_ID INT

EXECUTE CAC_LookUpModelID
@ManuName = @ManufactName,
@Man_ID = @M_ID OUTPUT

INSERT INTO tblModel (ManufacturerID, ModelName, ModelDescr)
VALUES (@M_ID, @ModName, @ModDescr)
GO

EXECUTE CAC_NewtblModel
@ManufactName = 'Toyota',
@ModName = 'RAV4',
@ModDescr = 'SUV'
GO

EXECUTE CAC_NewtblModel
@ManufactName = 'Ford',
@ModName = 'Ranger',
@ModDescr = 'Pickup Truck'
GO

EXECUTE CAC_NewtblModel
@ManufactName = 'Honda',
@ModName = 'Civic',
@ModDescr = 'Subcompact Car'
GO

--tblCar w/ FKs for Model and Manufacturer
CREATE PROCEDURE CAC_ModelLookup
@ModelName varchar(50),
@Mod_ID INT OUTPUT
AS
SET @Mod_ID = (SELECT ModelID FROM tblModel WHERE ModelName = @ModelName)
CREATE PROCEDURE CAC_tblCarNew
@ManuName1 varchar(50),
@ModName varchar(50),
@CarName varchar(50),
@CarDescr varchar(500)
AS
DECLARE @MA_ID INT, @MO_ID INT

EXECUTE CAC_LookUpModelID
@ManuName = @ManuName1,
@Man_ID = @MA_ID OUTPUT

EXECUTE CAC_ModelLookup
@ModelName = @ModName,
@Mod_ID = @MO_ID OUTPUT

INSERT INTO tblCar (ManufacturerID, ModelID, CarName, CarDescr)
VALUES (@MA_ID, @MO_ID, @CarName, @CarDescr)

EXECUTE CAC_tblCarNew
@ManuName1 = 'Toyota',
@ModName = 'RAV4',
@CarName = '2021 Toyota RAV4',
@CarDescr = 'New Model of the RAV4'
GO

EXECUTE CAC_tblCarNew
@ManuName1 = 'Ford',
@ModName = 'Ranger',
@CarName = '2021 Ford Ranger',
@CarDescr = 'Ford Ranger - New Stuff'
GO

EXECUTE CAC_tblCarNew
@ManuName1 = 'Honda',
@ModName = 'Civic',
@CarName = '2021 Honda Civic',
@CarDescr = 'Good as ever.'
GO

--tblCustomer
INSERT INTO tblCustomer(CustomerFname, CustomerLname, CustomerPhone, CustomerEmail, Cu
stomerAddress, CustCity, CustState, CustZipcode)
VALUES ('Lelouche', 'Lamperouge', '545-
0000', 'LouLou75@thisisanemial.com', '1219 Ashford Academy Street', 'San Diego', 'Cali
fornia, CA', '22434'),
    ('Kallen', 'Stadtfeld', '555-
5555', 'Kallen.S@thisisanemail.com', '1111 Fake Address Street', 'Miami', 'Florida, FL
', '33101'),
    ('Shirley', 'Fenette', '555-
5515', 'Shirley.Fenette@thisisanemail.com', '541 Street Avenue', 'Seattle', 'Washingto
n, WA', '98105')

--tblService_Type
INSERT INTO tblService_Type (Service_Type_Name, Service_Type_Descr)
Values ('Routine Maintenance', 'Oil changes, tire rotations, etc.'),
    ('Body Work/Repair', 'Dents, replacements, etc.'),
    ('Occasional Party', 'Come hang out with your friendly neighborhood mechanics.')

--tblEmployee
INSERT INTO tblEmployee (EmployeeFName, EmployeeLName, EmployeePhone, EmployeeEmail, E
mployeeAddress, EmployeeCity, EmployeeState, EmployeeZipcode, EmployeeBirthDate)
VALUES ('Cornelia','Britannia', '555-
5511', 'Cornelia.Britannia@emailBritannia.com', '1 Brittania Road', 'Sacramento', 'Cal
ifornia, CA', '94203', '1980-09-09'),
    ('Milly','Ashford', '555-
1555', 'Milly.Ashford@emailBritannia.com', '5 Pudding Street', 'Oaklahoma City', 'Oakl
ahoma, OK', '73008', '1999-01-01'),
    ('Nunnally','Lamperouge', '515-
5555', 'Nunnally.Lamperouge@emailBritannia.com', '23 King Arthur Avenue', 'Olympia', '
Washington, WA', '98501', '2004-04-18')

--tblService
CREATE PROCEDURE CAC_ServiceLookUp
@ServiceTypeName VARCHAR(50),
@ServTypeID INT OUTPUT
AS
SET @ServTypeID = (SELECT Service_TypeID FROM tblService_Type WHERE Service_Type_Name = @ServiceTypeName)
GO

CREATE PROCEDURE Cac_NewService
@STName varchar(50),
@ServiceName varchar(50),
@ServiceDescr varchar(500),
@ServPrice NUMERIC(12,2)
AS
DECLARE @ST_ID INT
EXEC CAC_ServiceLookUp
@ServiceTypeName = @STName,
@ServTypeID = @ST_ID OUTPUT

BEGIN TRAN C1
INSERT INTO tblService (Service_TypeID, ServiceName, ServiceDescr, ServicePrice)
VALUES (@ST_ID, @ServiceName, @ServiceDescr, @ServPrice)
IF @ST_ID IS NULL
    BEGIN
        PRINT 'Check spelling of service Type'
    END
COMMIT TRAN C1

EXECUTE Cac_NewService
@STName = 'Body Work/Repair',
@ServiceName = 'Dent Removal',
@ServiceDescr = 'Removing a dent in the car.',
@ServPrice = 64.50
GO

EXECUTE Cac_NewService
@STName = 'Routine Maintenance',
@ServiceName = 'Oil Change',
@ServiceDescr = 'Changing the oil when it needs to be changed.',
@ServPrice = 35.80
GO

EXECUTE Cac_NewService
@STName = 'Occasional Party',
@ServiceName = 'Car Appreciation Party',
@ServiceDescr = 'Bring pizza and popcorn.',
@ServPrice = 99.99
GO

EXECUTE Cac_NewService
@STName = 'Body Work/Repair',
@ServiceName = 'Engine Re-build',
@ServiceDescr = 'Re-build of entire engine.',
@ServPrice = 4999.99
GO

/* 3.) Write the SQL to create a stored procedure to populate transactional table CUSTOMER_SERVICE. 
Pass-in parameters of “names” and dates; use variables to look up required FK values. */
--Part I:
CREATE PROCEDURE CAC_GetCustomerID
@CustFN varchar(50),
@CustLN varchar(50),
@Cust_ID INT OUTPUT
AS
SET @Cust_ID = (SELECT CustomerID FROM tblCustomer WHERE @CustFN = CustomerFName AND @
CustLN = CustomerLName)
GO

CREATE PROCEDURE CAC_getServiceID
@SName VARCHAR(50),
@Serv_ID INT OUTPUT
AS
SET @Serv_ID = (SELECT ServiceID FROM tblService WHERE @SName = ServiceName)
GO

CREATE PROCEDURE CAC_GetEmployeID
@EmpFN varchar(50),
@EmpLn varchar(50),
@Emp_ID INT OUTPUT
AS
SET @Emp_ID = (SELECT EmployeeID FROM tblEmployee WHERE EmployeeFName = @EmpFN AND Emp
loyeeLName = @EmpLN)
GO

CREATE PROCEDURE CAC_GetCarID
@CarN varchar(50),
@Car_ID2 INT OUTPUT
AS
SET @Car_ID2 = (SELECT CarID FROM tblCar WHERE CarName = @CarN)
GO

CREATE PROCEDURE CAC_GetPrice 
@ServN varchar(50),
@Price2 NUMERIC(12,2) OUTPUT
AS
SET @Price2 = (SELECT ServicePrice FROM tblService WHERE @ServN = ServiceName)
GO

--Part II:
CREATE PROCEDURE Cac_NewCustomerService
@CustomerFName varchar(50),
@CustomerLName varchar(50),
@ServiceName varchar(50),
@EmployeeFName varchar(50),
@EmployeeLName varchar(50),
@CarName varchar(50),
@CS_Name varchar(100),
@CS_Descr varchar(500),
@CS_StartDate DATE,
@CS_EndDate DATE
AS
DECLARE @C_ID INT, @S_ID INT, @E_ID INT, @Car_ID INT, @Price NUMERIC(12,2)

EXECUTE CAC_GetCustomerID
@CustFN = @CustomerFName,
@CustLN = @CustomerLName,
@Cust_ID = @C_ID OUTPUT

EXECUTE CAC_getServiceID
@SName = @ServiceName,
@Serv_ID = @S_ID OUTPUT

EXECUTE CAC_GetEmployeID
@EmpFN = @EmployeeFName,
@EmpLn = @EmployeeLName,
@Emp_ID = @E_ID OUTPUT

EXECUTE CAC_GetCarID
@CarN = @CarName,
@Car_ID2 = @Car_ID OUTPUT

EXECUTE CAC_GetPrice
@ServN = @ServiceName,
@Price2 = @Price OUTPUT

INSERT INTO tblCustomer_Service (CustomerID, ServiceID, EmployeeID, CarID, Customer_Se
rviceName, Customer_ServiceDescr, CustServStartDate, CustServEndDate, Price) 
VALUES (@C_ID, @S_ID, @E_ID, @Car_ID, @CS_Name, @CS_Descr, @CS_StartDate, @CS_EndDate,
@Price)
GO

--Part III: Testing the Nested Stored Procedures
EXECUTE Cac_NewCustomerService
@CustomerFName = 'Lelouche',
@CustomerLName = 'Lamperouge',
@ServiceName = 'Oil?Change',
@EmployeeFName = 'Nunnally',
@EmployeeLName = 'Lamperouge',
@CarName = '2021 Toyota RAV4',
@CS_Name = 'Removing Dent',
@CS_Descr = 'Nunnally removes dent from car',
@CS_StartDate = '2010-03-03',
@CS_EndDate = '2010-04-04'

EXECUTE Cac_NewCustomerService
@CustomerFName = 'Kallen',
@CustomerLName = 'Stadtfeld',
@ServiceName = 'Car Appreciation Party',
@EmployeeFName = 'Nunnally',
@EmployeeLName = 'Lamperouge',
@CarName = '2021 Ford Ranger',
@CS_Name = 'Party for Cars',
@CS_Descr = 'A party recognizing cars everywhere',
@CS_StartDate = '2020-03-03',
@CS_EndDate = '2020-03-04'

EXECUTE Cac_NewCustomerService
@CustomerFName = 'Shirley',
@CustomerLName = 'Fenette',
@ServiceName = 'Engine re-build',
@EmployeeFName = 'Cornelia',
@EmployeeLName = 'Britannia',
@CarName = '2021 Honda Civic',
@CS_Name = 'Re-building Engine',
@CS_Descr = 'Engine to be re-built',
@CS_StartDate = '2020-01-03',
@CS_EndDate = '2020-01-04'


/* 4.) Write the SQL to enforce the following business rule: no employee younger than 21 may provide service of ‘engine Re-build’ on cars from manufacturer ‘Toyota’ */
CREATE FUNCTION fn_NoEngineRBToyota() 
RETURNS INTEGER
AS
BEGIN
    DECLARE @RET INTEGER = 0
        IF EXISTS (SELECT *
            FROM tblEmployee E
                JOIN tblCustomer_Service CS ON E.EmployeeID = CS.EmployeeID
                JOIN tblService S ON CS.ServiceID = S.ServiceID
                JOIN tblCar C ON CS.CarID = C.CarID
                JOIN tblManufacturer MA ON C.ManufacturerID = MA.ManufacturerID
 JOIN tblService_Type ST ON S.Service_TypeID = ST.Service_TypeID
            WHERE MA.ManufacturerName = 'Toyota'
            AND S.ServiceName LIKE '%Engine%re%build%'
 AND ST.Service_Type_Name LIKE 'Body%Work%Repair'
            AND  E.EmployeeBirthDate > = DateAdd([YEAR], -21, GetDate()))
        BEGIN
            SET @RET = 1
        END
RETURN @RET
END
GO

ALTER TABLE tblCustomer_Service WITH NOCHECK
ADD CONSTRAINT CK_NoEngineRBT
CHECK (dbo.fn_NoEngineRBToyota() =0)
GO

--TEST (NOT Breaking the Rule):
EXECUTE Cac_NewCustomerService
@CustomerFName = 'Shirley',
@CustomerLName = 'Fenette',
@ServiceName = 'Oil Change',
@EmployeeFName = 'Cornelia',
@EmployeeLName = 'Britannia',
@CarName = '2021 Honda Civic',
@CS_Name = 'Changing that oil',
@CS_Descr = 'A superb oil change.',
@CS_StartDate = '2020-05-10',
@CS_EndDate = '2020-05-14'
 --Row successfully entered

--Test (Breaking the rule)
EXECUTE Cac_NewCustomerService
@CustomerFName = 'Lelouche',
@CustomerLName = 'Lamperouge',
@ServiceName = 'Engine re-build',
@EmployeeFName = 'Nunnally',
@EmployeeLName = 'Lamperouge', 
@CarName = '2021 Toyota RAV4',
@CS_Name = 'Re-building Engine',
@CS_Descr = 'Engine to be re-built',
@CS_StartDate = '2020-01-05',
@CS_EndDate = '2020-01-06'
--INSERT FAILS! Business Rule works!!


/* 5.) Write the SQL code to implement a computed column to track total dollars spent by each customer with the business in the immediate past 3 years. */
CREATE FUNCTION fn_total$Spent3Yrs_CAC (@PK INT)
RETURNS NUMERIC (12,2)
AS
BEGIN
    DECLARE @RET NUMERIC(12,2) = (SELECT SUM(CS.Price)
                                    FROM tblCustomer_Service CS
                                        JOIN tblCustomer CU ON CS.CustomerID = CU.CustomerID
                                    WHERE CU.CustomerID = @PK
                                    AND CustServEndDate > DateAdd(YEAR, -3, GetDate()))
RETURN @RET
END
GO

ALTER TABLE tblCustomer
ADD TotalSpent3Yrs AS (dbo.fn_total$Spent3Yrs_CAC (CustomerID))
