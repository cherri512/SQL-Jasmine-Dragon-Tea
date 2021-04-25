--Code by: Fikay Abolade, Peter Carlson, Corey Cherrington, Charles Frahm
--3/11/2021, IMT 543 - Team 7
--Master Code: DDL Create Procedure (Jasmine Dragon Tea Shop Online Operations)
--tblCountry Insert

CREATE PROCEDURE cac_Country
@CountryName VARCHAR(50),
@CountryDescr VARCHAR(50)
AS
INSERT INTO tblcountry (country_name, country_descr)
VALUES (@CountryName, @CountryDescr)
GO

--FIVE INSERTS WITH STORED PROCEDURE
EXEC cac_Country
@CountryName = 'Earth Kingdom',
@CountryDescr = 'The kingdom of Earth benders, including Flopsy.'
GO
 
EXEC cac_Country
@CountryName = 'Water Tribe',
@CountryDescr = 'A sovereignty of waterbenders & Nonbenders'
GO
 
EXEC cac_Country
@CountryName = 'Fire Nation',
@CountryDescr = 'Home to both firebenders and nonbenders alike'
GO
 
EXEC cac_Country
@CountryName = 'Air Nomads',
@CountryDescr = 'The collective of the airbender people.'
GO
 
EXEC cac_Country
@CountryName = 'United States of America, US',
@CountryDescr = '50 States in N. America'
GO

--tblState_province Stored Procedure
CREATE PROCEDURE cac_StateProvince
@CountryName VARCHAR(50), 
@StateProvName varchar(50),
@StateProvDescr varchar(50)
AS 
 
DECLARE @C_ID INT
SET @C_ID = (SELECT CountryID From tblcountry WHERE country_name = @CountryName)
 
INSERT INTO tblstate_province (countryID, stateprov_name, stateprov_descr)
VALUES (@C_ID, @StateProvName, @StateProvDescr)
GO
 
ALTER PROCEDURE cac_StateProvince
@CountryName VARCHAR(50),
@StateProvName varchar(50),
@StateProvDescr varchar(50)
AS
DECLARE @C_ID INT
 
EXECUTE CAC_CountryIDLookUp2
@CountryName2 = @CountryName,
@C_ID2 = @C_ID OUTPUT
 
INSERT INTO tblstate_province (countryID, stateprov_name, stateprov_descr)
VALUES (@C_ID, @StateProvName, @StateProvDescr)
GO
 
Create PROCEDURE CAC_CountryIDLookUp2
@CountryName2 varchar(50),
@C_ID2 INT OUTPUT
AS
SET @C_ID2 = (SELECT CountryID FROM tblCountry WHERE @CountryName2 = Country_Name)
GO

--FIVE INSERTS WITH STORED PROCEDURE

EXECUTE cac_StateProvince
@CountryName = 'Fire Nation',
@StateProvName = 'Fire Islands',
@StateProvDescr = 'Very hot, but beautiful.'
 
EXECUTE cac_StateProvince
@CountryName = 'Earth Kingdom',
@StateProvName = 'Omashu',
@StateProvDescr = 'Built by Oma and Shu.'
 
EXECUTE cac_StateProvince
@CountryName = 'Earth Kingdom',
@StateProvName = 'Ba Sing Se',
@StateProvDescr = 'Very hot, but beautiful.'

EXECUTE cac_StateProvince
@CountryName = 'United States of America, US',
@StateProvName = 'Florida, FL',
@StateProvDescr = NULL
 
EXECUTE cac_StateProvince 
@CountryName = 'Brazil, BR',
@StateProvName = 'Amazonas',
@StateProvDescr = 'Rain Forest zone'
tblCustomer Stored Procedure (Corey)

--Stored procedure for tblCustomer inserts
CREATE PROCEDURE CAC_NewCustomer1
@SPName varchar(50),
@CustFName varchar(50),
@CustLName varchar(50),
@CustPhone char(8),
@CustEmail varchar(50),
@CustDOB DATE,
@CustAddress varchar(100),
@CustCity varchar(50),
@CustZip char(5)
 
AS
 
DECLARE @SP_ID INT
SET @SP_ID = (SELECT StateProvID 
                FROM tblState_Province 
                WHERE @SPName = StateProv_Name)
 
BEGIN TRAN T1
INSERT INTO tblCustomer (StateProvID, Customer_Fname, Customer_lname, Customer_phone, Customer_Email, Customer_DOB, Street_Address, City, Zipcode)
VALUES (@SP_ID, @CustFName, @CustLName, @CustPhone, @CustEmail, @CustDOB, @CustAddress, @CustCity, @CustZip)
IF @SP_ID IS NULL
    BEGIN 
        PRINT 'Yo, its null bro.'
        ROLLBACK TRAN T1
 
    END
ELSE 
    COMMIT TRAN T1
GO

--FIVE INSERTS WITH STORED PROCEDURE
EXEC CAC_NewCustomer1
@SPName = 'Ba Sing Se',
@CustFName  = 'Uncle Iroh',
@CustLName = 'Dragon of the West',
@CustPhone = '284-6594',
@CustEmail = 'uncle.Iroh165@vbguernseypaintinc.com',
@CustDOB = '1945-01-01',
@CustAddress  = '55555 Jasmine Dragon',
@CustCity  = 'Inner Circle',
@CustZip  = '00000'
GO
 
EXEC CAC_NewCustomer1
@SPName = 'Ba Sing Se',
@CustFName  = 'Fire Lord',
@CustLName = 'Zuko',
@CustPhone = '111-5216',
@CustEmail = 'FireLord.Zuko595@mdcalhounflightinc.com',
@CustDOB = '1995-11-16',
@CustAddress  = '55555 Jasmine Dragon',
@CustCity  = 'Inner Circle',
@CustZip  = '00000'
GO
 
EXEC CAC_NewCustomer1
@SPName = 'Ba Sing Se',
@CustFName  = 'Toph',
@CustLName = 'Beifong',
@CustPhone = '270-5815',
@CustEmail = 'toph.beifong5555@earthkingdom.net',
@CustDOB = '1987-09-26',
@CustAddress  = '545 My Own Way',
@CustCity  = 'Earth Paradise',
@CustZip  = '11111'
GO
 
EXEC CAC_NewCustomer1
@SPName = 'South Pole',
@CustFName  = 'Katara',
@CustLName = 'Southern',
@CustPhone = '821-3233',
@CustEmail = 'Katara.Southern184@dmbarbergasdiesel.com',
@CustDOB = '1996-08-07',
@CustAddress  = '555 Water Way',
@CustCity  = 'Kanna',
@CustZip  = '00002'
GO
 
EXEC CAC_NewCustomer1
@SPName = 'Florida, FL',
@CustFName  = 'Sanda',
@CustLName = 'Bowell',
@CustPhone = '892-9998',
@CustEmail = 'Sanda.Bowell618@pbalamedadistributorsinc.com',
@CustDOB = '1956-07-18',
@CustAddress  = '10305 North Araucaria View Boulevard',
@CustCity  = 'Vero Beach',
@CustZip  = '32964'
GO


--tblOrder Stored Procedure
CREATE PROCEDURE JDGetCustID
@CFName varchar(50),
@CLName varchar(50),
@CUST_ID INT OUTPUT
AS 
SET @CUST_ID = (Select CustomerID 
                FROM tblCustomer 
                WHERE customer_fname = @CFName 
                AND @CLName = customer_lname)
GO
 
CREATE PROCEDURE CACNewOrder
@CustomerFName varchar(50),
@CustomerLName varchar(50),
@Ord_Descr varchar(50),
@Ord_Date DATE
 
AS
 
DECLARE @C_ID INT
 
EXEC JDGetCustID
@CFName = @CustomerFName,
@CLName = @CustomerLName,
@CUST_ID = @C_ID OUTPUT
 
BEGIN TRAN JD1
INSERT INTO tblorder (customerID, order_descr, order_date)
VALUES (@C_ID, @Ord_Descr, @Ord_Date)
COMMIT TRAN JD1
 
GO
 
--To execute this SP, use: 
Exec CACNewOrder
@CustomerFName = '',
@CustomerLName = '',
@Ord_Descr = '',
@Ord_Date = ''
 
--FIVE ROWS FILLED IN WITH STORED PROCEDURE
Exec CACNewOrder
@CustomerFName = 'Tenzen',
@CustomerLName = 'Avatar',
@Ord_Descr = 'Tenzen',
@Ord_Date = '2020-01-01'
GO
 
Exec CACNewOrder
@CustomerFName = 'Avatar',
@CustomerLName = 'Aang',
@Ord_Descr = 'must arrive asap',
@Ord_Date = '2019-05-04' 
GO 
 
Exec CACNewOrder
@CustomerFName = 'Tho',
@CustomerLName = 'Due',
@Ord_Descr = 'Lots of tea',
@Ord_Date = '2020-03-08'
GO
 
Exec CACNewOrder
@CustomerFName = 'Sokka',
@CustomerLName = 'Southern',
@Ord_Descr = 'One of our best customers!',
@Ord_Date = '2019-02-02'
GO
 
Exec CACNewOrder
@CustomerFName = 'Toph',
@CustomerLName = 'Beifong',
@Ord_Descr = 'highest quality only',
@Ord_Date = '2021-01-01'
GO 
 
--tblOrder_Product Stored Procedure
CREATE PROCEDURE JD_GetOrderID
@CustomerFN varchar(50),
@CustomerLN varchar(50),
@OrderDate DATE,
@Order_ID INT OUTPUT
AS 
SET @Order_ID = (SELECT OrderID 
                FROM tblorder O 
                    JOIN tblcustomer CU ON O.customerID = CU.customerID
                WHERE @OrderDate = order_date 
                AND CU.customer_fname = @CustomerFN
                AND CU.customer_lname = @CustomerLN)
GO
 
CREATE PROCEDURE JD_GetProductID
@ProductName varchar(50),
@ProductID INT OUTPUT
AS
SET @ProductID = (SELECT ProductID FROM tblproduct WHERE @ProductName = product_name)
GO
 
CREATE PROCEDURE JD_GetMeasurementID
@MeasurementShortName varchar(10),
@Measurement_ID INT OUTPUT
AS 
SET @Measurement_ID = (SELECT MeasurementID FROM tblmeasurement WHERE @MeasurementShortName = measurement_short_name)
GO
 
CREATE PROCEDURE JD_NEWOrderProduct
@Customer1stName varchar(50),
@CustomerLstName varchar(50),
@O_Date Date,
@P_Name VARCHAR(50),
@MS_Name varchar(50),
@OP_Descr varchar(500),
@OP_Quantity NUMERIC(6,0)
 
AS 
 
DECLARE @O_ID INT, @P_ID INT, @M_ID INT
 
EXEC JD_GetOrderID
@CustomerFN = @Customer1stName,
@CustomerLN = @CustomerLstName,
@OrderDate = @O_Date,
@Order_ID = @O_ID OUTPUT
 
EXEC JD_GetProductID
@ProductName = @P_Name,
@ProductID = @P_ID OUTPUT
 
EXEC JD_GetMeasurementID
@MeasurementShortName = @MS_Name,
@Measurement_ID = @M_ID OUTPUT
 
BEGIN TRAN JD2
INSERT INTO tblorder_product (orderID, productID, measurementID, orderproduct_descr, orderproduct_quantity)
VALUES (@O_ID, @P_ID, @M_ID, @OP_Descr, @OP_Quantity)
COMMIT TRAN JD2
GO
 
--FIVE ROWS FILLED IN WITH STORED PROCEDURE
EXEC JD_NEWOrderProduct
@Customer1stName = 'Tenzen',
@CustomerLstName = 'Avatar',
@O_Date = '2020-01-01',
@P_Name = 'Zukos Graphic T-Shirt',
@MS_Name = 'pcs',
@OP_Descr = 'Tenzen orders 5 t-shirts',
@OP_Quantity = '5'
 
EXEC JD_NEWOrderProduct
@Customer1stName = 'Tenzen',
@CustomerLstName = 'Avatar',
@O_Date = '2020-01-01',
@P_Name = 'Jasmine Dragon Carrier Mug',
@MS_Name = 'pcs',
@OP_Descr = 'Tenzen orders 1 mug',
@OP_Quantity = '1'
 
EXEC JD_NEWOrderProduct
@Customer1stName = 'Avatar',
@CustomerLstName = 'Aang',
@O_Date = '2019-05-04',
@P_Name = 'Firebreath Green Tea',
@MS_Name = 'lbs',
@OP_Descr = '1 pound of green tea - Aang',
@OP_Quantity = '1'
 
EXEC JD_NEWOrderProduct
@Customer1stName = 'Avatar',
@CustomerLstName = 'Aang',
@O_Date = '2019-05-04',
@P_Name = 'Earth Nation Special Blend',
@MS_Name = 'lbs',
@OP_Descr = '1 pound of Earth Special - Aang',
@OP_Quantity = '2'
 
EXEC JD_NEWOrderProduct
@Customer1stName = 'Toph',
@CustomerLstName = 'Beifong',
@O_Date = '2021-01-01',
@P_Name = 'Fire Nation Frenzy',
@MS_Name = 'lbs',
@OP_Descr = 'Must be best quality.',
@OP_Quantity = '1'

--To execute this sp use: 
EXEC JD_NEWOrderProduct
@Customer1stName = '',
@CustomerLstName = '',
@O_Date = '',
@P_Name = '',
@MS_Name = '',
@OP_Descr = '',
@OP_Quantity = ''
tblPosition_Type Insert

--Insert statements for tblposition_type
INSERT INTO tblposition_type (positiontype_name, positiontype_descr)
VALUES ('Part-time', 'Works less than 40 hrs/wk'), 
    ('Full-Time', 'Works 40hr/wk or more.'), 
    ('Contingent', NULL), 
    ('Temporary', 'Short-term position'), 
    ('Executive', 'Leadership Role')

--New Row in tblProduct Stored Procedure:
CREATE PROCEDURE JD_insertproduct5
@pname varchar(50),
@ptname varchar(50),
@pdescr varchar(500),
@pprice NUMERIC (6,2)
AS
DECLARE @PT_ID INT
 
SET @PT_ID = (SELECT producttypeID
             FROM tblproduct_type
             WHERE producttype_name = @ptname)
 
Begin TRAN C3
INSERT INTO tblproduct (producttypeID, product_name, product_descr, product_price)
VALUES (@PT_ID, @pname, @pdescr, @pprice)
COMMIT TRAN C3
GO
 
EXEC JD_insertproduct
@pname = 'Earth Nation Special Blend',
@ptname = 'ORGANIC BULK Dried Leaf',
@pdescr = 'Essences of fresh cut slate',
@pprice = '39.99'
GO
 
EXEC JD_insertproduct
@pname = 'Zukos Graphic T-Shirt',
@ptname = 'JD Merchandise',
@pdescr = 'Zukos hidden talent',
@pprice = '19.99'
GO
 
EXEC JD_insertproduct
@pname = 'Jasmine Dragon Carrier Mug',
@ptname = 'JD Merchandise',
@pdescr = 'Made out of rock',
@pprice = '4.99'
GO
 
EXEC JD_insertproduct
@pname = 'Freeze Dried White Leaf Blend',
@ptname = 'ORGANIC Packets',
@pdescr = 'Water Nation Special',
@pprice = '17.99'
GO
 
EXEC JD_insertproduct5
@pname = 'Ultimate brand tea',
@ptname = 'BULK Dried Leaf',
@pdescr = 'Dont ask, its ultimate bro',
@pprice = '99.99'
Go
 
--New Row in tblproduct_ingredient Stored Procedure:
CREATE PROCEDURE JD_insertingredientproduct
@iname varchar(50),
@mname varchar(50),
@pdname varchar(50),
@piquantity NUMERIC(6,0)
AS
DECLARE @I_ID INT, @M_ID INT, @P_ID INT
 
SET @I_ID = (SELECT ingredientID
             FROM tblingredient
             WHERE ingredient_name = @iname)
 
SET @M_ID = (SELECT measurementID
             FROM tblmeasurement
             WHERE measurement_name = @mname)
 
SET @P_ID = (SELECT productID
             FROM tblproduct
             WHERE product_name = @pdname)
 
Begin TRAN C2
INSERT INTO tblproduct_ingredient(ingredientID, measurementID, productID, productingredient_quantity)
VALUES (@I_ID, @M_ID, @P_ID, @piquantity)
COMMIT TRAN C2
GO
 
--Firebreath Green Tea
EXEC JD_insertingredientproduct
@iname = 'Dried Green Tea Leaf',
@mname = 'ounces',
@pdname = 'Firebreath Green Tea',
@piquantity = '20'
GO

EXEC JD_insertingredientproduct
@iname = 'Essence of Firebreath',
@mname = 'ounces',
@pdname = 'Firebreath Green Tea',
@piquantity = '5'
GO
EXEC JD_insertingredientproduct
@iname = 'Lavender',
@mname = 'ounces',
@pdname = 'Firebreath Green Tea',
@piquantity = '5'
GO
 
-- Earth Nation Special Blend
EXEC JD_insertingredientproduct
@iname = 'Powedered Slate',
@mname = 'grams',
@pdname = 'Earth Nation Special Blend',
@piquantity = '100'
GO
EXEC JD_insertingredientproduct
@iname = 'ORGANIC Green Tea Leaf',
@mname = 'kilograms',
@pdname = 'Earth Nation Special Blend',
@piquantity = '1'
GO


--New Row into tblingredient Stored Procedure:
CREATE PROCEDURE JD_insertingredient1
@iname varchar(50),
@slname varchar(50),
@idescr varchar(500)
AS
DECLARE @SL_ID INT
 
SET @SL_ID = (SELECT shelflifeID
             FROM tblshelf_life
             WHERE shelflife_name = @slname)
 
Begin TRAN C1
INSERT INTO tblingredient(shelflifeID, ingredient_name, ingredient_descr)
VALUES (@SL_ID, @iname, @idescr)
COMMIT TRAN C1
GO
 
EXEC JD_insertingredient1
@iname = 'Dried Green Tea Leaf',
@slname = 'Standard',
@idescr = 'Best if used within 3 months '
GO
 
EXEC JD_insertingredient1
@iname = 'Dried White Tea Leaf',
@slname = 'Standard',
@idescr = 'Best if used within 6 months '
GO
 
EXEC JD_insertingredient1
@iname = 'Lavender',
@slname = 'Sensitive',
@idescr = 'Best if used within 1 month '
GO
 
EXEC JD_insertingredient1
@iname = 'Salt',
@slname = 'Highly Stable',
@idescr = 'Dry-cured Salt from the Norther Water Tribe'
GO
 
EXEC JD_insertingredient1
@iname = 'Evaporated Milk',
@slname = 'Highly Stable',
@idescr = 'Pure Sky Bison Milk Blend thats Been Evaporated for Shelf Stability'
GO

CREATE PROCEDURE insertemployee
@stateprovname VARCHAR(50),
@efirst VARCHAR(50),
@elast VARCHAR(50),
@ephone CHAR(10),
@eemail VARCHAR(50),
@eaddress VARCHAR(75),
@ebday DATE,
@ECity VARCHAR (100),
@Ezip CHAR(10)
 
AS 
DECLARE @SPID INT
 
SET @SPID=(SELECT stateprovID
            FROM tblstate_province
            WHERE stateprov_name=@stateprovname)
BEGIN TRAN P3
INSERT INTO tblemployee(StateProvID,employee_fname,employee_lname,employee_phone,employee_email,employee_address,employee_dob,city,zipcode)
VALUES (@SPID,@efirst,@elast,@ephone,@eemail,@eaddress,@ebday,@ECity,@Ezip)
COMMIT TRAN P3
GO
 
EXEC insertemployee
@stateprovname = 'Fire Island'
@efirst = 'General'
@elast = 'Iroh'
@ephone = '206-123-0987'
@eemail = 'Gen.Iroh@jasiminedragon.com'
@eaddress = '2401 Utah Ave S'
@ebday = '1970-12-4'
@ECity = 'Fire'
@Ezip = '98011'
 GO
 
EXEC insertemployee
@stateprovname = 'Fire Island'
@efirst = 'Prince'
@elast = 'Zuko'
@ephone = '206-123-0969'
@eemail = 'Prince.Zuko@jasiminedragon.com'
@eaddress = '4101 SW Admiral Way'
@ebday = '1990-1-1'
@ECity = 'Fire'
@Ezip = '98012'
 GO
 
EXEC insertemployee
@stateprovname = 'Ba sing Se'
@efirst = 'Tophe'
@elast = 'Beifong'
@ephone = '2061230911'
@eemail = 'T.Beifong@jasiminedragon.com'
@eaddress = '4115 4th Ave S'
@ebday = '1981-2-2'
@ECity = 'Earth'
@Ezip = 80867
 GO
 
EXEC insertemployee
@stateprovname = 'Ba sing Se'
@efirst = 'Chris'
@elast = 'Sokka'
@ephone = '2064230990'
@eemail = 'C.Sokka@jasiminedragon.com'
@eaddress = '4101 SW Peter Way'
@ebday = '1969-10-1'
@ECity = 'Water'
@Ezip = '68032'
 GO
 
EXEC insertemployee
@stateprovname = 'Ba sing Se'
@efirst = 'Princess'
@elast = 'Azula'
@ephone = '2064436784'
@eemail = 'P.Azula@jasiminedragon.com'
@eaddress = '2742 Boundeless St'
@ebday = '1980-12-13'
@ECity = 'Water'
@Ezip = '68902'
 GO
 
EXEC insertemployee
@stateprovname = 'Ba sing Se'
@efirst = 'Byung'
@elast = 'Wiseman'
@ephone = '4254438384'
@eemail = 'B.Wiseman@jasiminedragon.com'
@eaddress = '2742 Mateo Ave SW'
@ebday = '1969-10-1'
@ECity = 'Water'
@Ezip = '68032'
 GO
 
 
CREATE PROCEDURE insertemployeeposition
@posname VARCHAR(50),
@efname VARCHAR(50),
@elname VARCHAR(50),
@begindate DATE,
@enddate DATE,
@hourlywage NUMERIC(6,2)
AS
DECLARE @POID INT, @EMID INT
 
SET @POID= (SELECT positionID
            FROM tblposition
            WHERE position_name=@posname)
SET @EMID=(SELECT employeeID 
            FROM tblemployee
            WHERE employee_fname=@efname
            AND employee_lname=@elname)
 
BEGIN TRAN P5 
INSERT INTO tblemployee_position(positionID, employeeID, begin_date, end_date, hourly_wage)
VALUES(@POID,@EMID, @begindate, @enddate,@hourlywage)
COMMIT TRAN P5
GO
 
EXEC insertemployeeposition
@posname= 'Assistant Manager'
@efname= ‘Byung’
@elname= ‘Wiseman’
@begindate= ‘2020-1-1’
@enddate= 
@hourlywage= ‘19’
GO
 
EXEC insertemployeeposition
@posname= Owner
@efname= ‘General’
@elname= ‘Iroh’
@begindate= ‘2000-1-1’
@enddate= 
@hourlywage= ‘30’
 GO
 
 
EXEC insertemployeeposition
@posname= Manager
@efname= ‘Prince’
@elname= ‘Zuko’
@begindate= ‘2020-1-1’
@enddate= 
@hourlywage= ‘25’
 GO
 
EXEC insertemployeeposition
@posname= Barista
@efname= ‘Tophe’
@elname= ‘Beifong’
@begindate= ‘2018-1-1’
@enddate= 
@hourlywage= ‘18’
 GO
 
EXEC insertemployeeposition
@posname= Barista
@efname= ‘Princess’
@elname= ‘Azula’
@begindate= ‘2019-1-1’
@enddate= 
@hourlywage= ‘19’
 GO
 
EXEC insertemployeeposition
@posname= Barista
@efname= ‘Chris’
@elname= ‘Sokka’
@begindate= ‘2020-1-1’
@enddate= 
@hourlywage= ‘19’
 GO
 
 
 
CREATE PROCEDURE insertshipment
@carriername VARCHAR(50),
@empFname VARCHAR(50),
@empLname VARCHAR(50),
@shipmentdate DATE
AS
DECLARE @CID INT, @EID INT
 
SET @CID = (SELECT carrierID
            FROM tblcarrier
            WHERE carrier_name=@carriername)
 
SET @EID = (SELECT employeeID
            FROM tblemployee
            WHERE employee_fname=@empFname
            AND employee_lname=@empLname)
 
BEGIN TRAN P1
INSERT INTO tblshipment(carrierID, employeeID, shipment_date)
VALUES(@CID,@EID,@shipmentdate)
COMMIT TRAN P1
GO
 
EXEC insertshipment
@carriername= 'UPS'
@empFname= 'Prince'
@empLname= 'Zuko'
@shipmentdate= 2020-01-02'
 GO
 
EXEC insertshipment
@carriername= 'FedEx'
@empFname= 'Tophe'
@empLname= 'Beifong'
@shipmentdate= '2020-03-10'
 GO
 
EXEC insertshipment
@carriername= 'Ontrac'
@empFname= 'General'
@empLname= 'Iroh'
@shipmentdate= '2019-03-09'
 GO
 
EXEC insertshipment
@carriername= 'UPS'
@empFname= ‘Prince’
@empLname= ’Zuko’
@shipmentdate= '2021-01-02'
 GO
 
EXEC insertshipment
@carriername= 'UPS'
@empFname= 'General'
@empLname= 'Iroh'
@shipmentdate= 2019-05-05
 GO
 
 
CREATE PROCEDURE insertposition
@ptypename VARCHAR(50),
@Pname VARCHAR(50),
@Pdesc VARCHAR(500)
AS
DECLARE @PTID INT 
 
SET @PTID = (SELECT positiontypeID
            FROM tblposition_type
            WHERE positiontype_name=@Pname)
BEGIN TRAN P4
INSERT INTO tblposition(positiontypeID,position_name,position_descr)
VALUES(@PTID,@Pname,@Pdesc)
COMMIT TRAN P4
GO
 
EXEC insertposition
@ptypename= 'Full-Time'
@Pname=  ‘Assistant Manager’
@Pdesc= 'Works 40hr/wk or more.'
 GO
 
EXEC insertposition
@ptypename= 'Full-Time'
@Pname=  ‘Manager’
@Pdesc= 'Works 40hr/wk or more.'
 GO
 
EXEC insertposition
@ptypename= 'Executive'
@Pname=  ‘Owner’
@Pdesc= 'Leadership Role'
 GO
 
EXEC insertposition
@ptypename= 'Temporary’
@Pname=  ‘Barista’ 
@Pdesc= 'Short-term position'
 GO
 
 
 
CREATE PROCEDURE insertPO
@suppliername VARCHAR(50),
@podate DATE,
@POtotal NUMERIC(6,2)
AS 
DECLARE @SUPID INT
SET @SUPID=(SELECT supplierID 
            FROM tblsupplier
            WHERE supplier_name=@suppliername)
BEGIN TRAN P6
INSERT INTO tblpurchase_order(supplierID,purchaseorder_date,purchaseorder_total)
VALUES(@SUPID,@podate,@POtotal)
COMMIT TRAN P6
GO
 
EXEC insertPO
@suppliername = 'Earth Benders United',
@podate = '2-16-2019',
@POtotal = '8000.00'
GO
 
EXEC insertPO
@suppliername = 'Earth Benders United',
@podate = '8-30-2019',
@POtotal = '8000.00'
GO
 
EXEC insertPO
@suppliername = 'Earth Benders United',
@podate = '2-3-2020',
@POtotal = '9000.00'
GO
 
EXEC insertPO
@suppliername = 'Hodors Hodor',
@podate = '6-27-2020',
@POtotal = '500.00'
GO
 
EXEC insertPO
@suppliername = 'Sokkas Boxes',
@podate = '1-27-2020',
@POtotal = '600.00'
GO
 
CREATE PROCEDURE insertPOIngredient
@pordate DATE,
@portotal NUMERIC(6,2),
@ingname VARCHAR(50),
@mname  VARCHAR(50),
@POingdesc VARCHAR(500),
@POingq NUMERIC(6,0)
AS DECLARE @MID INT, @IID INT, @PORID INT
 
SET @MID = (SELECT measurementID
            FROM tblmeasurement
            WHERE measurement_name=@mname)
SET @IID = (SELECT IngredientID
            FROM tblingredient
            WHERE ingredient_name=@ingname)
SET @PORID= (SELECT purchaseorderID
            FROM tblpurchase_order
            WHERE purchaseorder_total=@portotal
            AND purchaseorder_date=@pordate)
BEGIN TRAN P7
INSERT INTO tblpurchase_order_ingredient(purchaseorderID,ingredientID,measurementID,purchaseorderingredient_descr,purchaseorderingredient_quantity)
VALUES(@PORID,@IID,@MID,@POingdesc,@POingq)
COMMIT TRAN P7
GO
 
EXEC insertPOIngredient
@pordate = '2-16-2019',
@portotal = '8000.00',
@ingname = 'Dried Green Tea Leaf',
@mname = 'pounds',
@POingdesc = 'Spring/Summer Leaves',
@POingq = '2'
GO
 
EXEC insertPOIngredient
@pordate = '2-16-2019',
@portotal = '8000.00',
@ingname = 'Dried White Tea Leaf',
@mname = 'pounds',
@POingdesc = 'Spring/Summer Leaves',
@POingq = '2'
GO
 
EXEC insertPOIngredient
@pordate = '2-16-2019',
@portotal = '8000.00',
@ingname = 'Dried Black Tea Leaf',
@mname = 'pounds',
@POingdesc = 'Spring/Summer Leaves',
@POingq = '2'
GO
 
EXEC insertPOIngredient
@pordate = '2-16-2019',
@portotal = '8000.00',
@ingname = 'ORGANIC Green Tea Leaf',
@mname = 'pounds',
@POingdesc = 'Spring/Summer Leaves',
@POingq = '1'
GO
 
EXEC insertPOIngredient
@pordate = '2-16-2019',
@portotal = '8000.00',
@ingname = 'ORGANIC Black Tea Leaf',
@mname = 'pounds',
@POingdesc = 'Spring/Summer Leaves',
@POingq = '1'
GO

CREATE PROCEDURE insertPackage
@orderproductdesc VARCHAR(100),
@orderproductsub NUMERIC(10,2),
@orderpoductq NUMERIC(6,0),
@shipment_date DATE,
@Carriertracknum CHAR(20),
@Carriern VARCHAR(50)
AS
DECLARE @OPID INT, @SID INT
 
SET @OPID = (SELECT orderproductID 
            FROM tblorder_product
            WHERE orderproduct_descr=@orderproductdesc
            AND orderproduct_quantity=@orderpoductq
            AND Order_Product_Subtotal=@orderproductsub)
SET @SID = (SELECT shipmentID 
            FROM tblshipment S
            JOIN tblcarrier C ON C.carrierID=S.carrierID
            WHERE shipment_date=@shipment_date
            AND carrier_name=@Carriern)
 
BEGIN TRAN P2
INSERT INTO tblpackage(orderproductID,shipmentID,carrier_tracking_num)
VALUES(@OPID,@SID,@Carriertracknum)
COMMIT TRAN P2
GO
 
Exec insertPackage
@orderproductdesc= 'Tenzen orders 5 t-shirts',
@orderproductsub='99.95',
@orderpoductq='5',
@shipment_date='2020-01-02',
@Carriertracknum='00014',
@Carriern='UPS'
 
 
Exec insertPackage
@orderproductdesc= 'Tenzen orders 1 mug',
@orderproductsub='4.99',
@orderpoductq='1',
@shipment_date='2020-03-10',
@Carriertracknum='00015',
@Carriern='Fedex'
 
Exec insertPackage
@orderproductdesc= '1 pound of green tea - Aang',
@orderproductsub='14.99',
@orderpoductq='1',
@shipment_date='2019-03-09',
@Carriertracknum='00018',
@Carriern='Ontrac'
 
Exec insertPackage
@orderproductdesc= '1 pound of Earth Special - Aang',
@orderproductsub='39.99',
@orderpoductq='1',
@shipment_date='2021-01-02',
@Carriertracknum='00019',
@Carriern='UPS'
 
Exec insertPackage
@orderproductdesc= 'Bulk order',
@orderproductsub='100',
@orderpoductq='1',
@shipment_date='2019-05-05',
@Carriertracknum='00012',
@Carriern='UPS'

INSERT INTO tblposition (positiontypeID, position_name, position_descr)
VALUES ('2', 'Manager', '40hrs a week oversees shop operations')
GO
