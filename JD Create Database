--Fikay Abolade, Peter Carlson, Corey Cherrington, Charles Frahm
--3/11/2021, IMT 543 - Team 7
--Master Code: DDL for Create Database, Create Table, & Backup
 
CREATE DATABASE IMT543_Proj_07
USE IMT543_Proj_07
GO
 
USE IMT543_Proj_07
--Creating tables
--supplier table
CREATE TABLE tblsupplier
(supplierID INTEGER IDENTITY(1,1) PRIMARY KEY,
supplier_name VARCHAR(50) NOT NULL,
supplier_descr VARCHAR(500) NULL);
GO
 
-- measurement table
CREATE TABLE tblmeasurement
(measurementID INTEGER IDENTITY(1,1) PRIMARY KEY,
measurement_name VARCHAR(50) NOT NULL,
measurement_descr VARCHAR(100) NULL,
measurement_short_name VARCHAR(10) NULL);
GO
 
-- shelf life table
CREATE TABLE tblshelf_life
(shelflifeID INTEGER IDENTITY(1,1) PRIMARY KEY,
shelflife_name VARCHAR(50),
shelflife_descr VARCHAR (100),
shelflife_quantity NUMERIC (6,0) NOT NULL);
GO
 
--ingredient table
CREATE TABLE tblingredient
(ingredientID INTEGER IDENTITY(1,1) PRIMARY KEY,
shelflifeID INT FOREIGN KEY REFERENCES tblshelf_life (shelflifeID) NOT NULL,
ingredient_name VARCHAR (50) NOT NULL,
ingredient_descr VARCHAR (500) NULL);
GO
 
-- product_type table
CREATE TABLE tblproduct_type
(producttypeID INTEGER IDENTITY(1,1) PRIMARY KEY,
producttype_name VARCHAR (50) NOT NULL,
producttype_descr VARCHAR(500) NULL);
GO
 
-- product table
CREATE TABLE tblproduct
(productID INTEGER IDENTITY(1,1) PRIMARY KEY,
producttypeID INT FOREIGN KEY REFERENCES tblproduct_type (producttypeID) NOT NULL,
product_name VARCHAR(50) NOT NULL,
product_descr VARCHAR(50) NULL);
GO
 
-- product_ingredient table
CREATE TABLE tblproduct_ingredient
(productingredientID INTEGER IDENTITY(1,1) PRIMARY KEY,
ingredientID INT FOREIGN KEY REFERENCES tblingredient (ingredientID) NOT NULL,
measurementID INT FOREIGN KEY REFERENCES tblmeasurement (measurementID) NOT NULL,
productID INT FOREIGN KEY REFERENCES tblproduct (productID) NOT NULL,
productingredient_quantity NUMERIC (6,0) NOT NULL);
GO
 
--country
CREATE TABLE tblcountry
(countryID INTEGER IDENTITY(1,1) PRIMARY KEY,
country_name VARCHAR(50) NOT NULL,
country_descr VARCHAR(500) NULL);
GO
 
--empolyeeID
CREATE TABLE tblemployee
(employeeID INTEGER IDENTITY(1,1) PRIMARY KEY,
StateProvID INT FOREIGN KEY REFERENCES tblstate_province (StateprovID) NOT NULL,
employee_fname VARCHAR(50) NOT NULL,
employee_lname VARCHAR(50) NOT NULL,
employee_phone CHAR(10) NOT NULL,
employee_email VARCHAR(50) NOT NULL,
employee_address VARCHAR(75) NOT NULL,
employee_dob DATE NOT NULL,
city VARCHAR(100) NOT NULL,,
zipcode CHAR(10) NOT NULL);
GO

--shipmentID
CREATE TABLE tblshipment
(shipmentID INTEGER IDENTITY(1,1) PRIMARY KEY,
carrierID INT FOREIGN KEY REFERENCES tblcarrier (carrierID) NOT NULL,
employeeID INT FOREIGN KEY REFERENCES tblemployee (employeeID) NOT NULL,
shipment_date DATE NOT NULL);
GO

--order
CREATE TABLE tblorder
(orderID INTEGER IDENTITY(1,1) PRIMARY KEY,
customerID INT FOREIGN KEY REFERENCES tblcustomer (customerID) NOT NULL,
order_name VARCHAR(50) NOT NULL,
order_descr VARCHAR(50) NULL,
order_date DATE NOT NULL,
order_total NUMERIC(6,2) NOT NULL);
GO

--order_product
CREATE TABLE tblorder_product
(orderproductID INTEGER IDENTITY(1,1) PRIMARY KEY,
orderID INT FOREIGN KEY REFERENCES tblorder (orderID) NOT NULL,
productID INT FOREIGN KEY REFERENCES tblproduct (productID) NOT NULL,
measurementID INT FOREIGN KEY REFERENCES tblmeasurement (measurementID) NOT NULL,
orderproduct_descr VARCHAR(500) NULL,
orderproduct_quantity NUMERIC(6,0) NOT NULL);
GO

--employee-position
CREATE TABLE tblemployee_position
(employeepositionID INTEGER IDENTITY(1,1) PRIMARY KEY,
positionID INT FOREIGN KEY REFERENCES tblposition (positionID) NOT NULL,
employeeID INT FOREIGN KEY REFERENCES tblemployee (employeeID) NOT NULL,
begin_date DATE NOT NULL,
end_date DATE NULL,
hourly_wage NUMERIC(6,2) NOT NULL);
GO

Alter table tblemployee_position ADD CurrentStatus AS 
 (CASE WHEN end_date IS NULL THEN 'Active'
ELSE 'Contract Terminated'
END)
 
-- carrier
CREATE TABLE tblcarrier
(carrierID INTEGER IDENTITY(1,1) PRIMARY KEY,
carrier_name VARCHAR(50) NOT NULL,
carrier_desc VARCHAR(500) NULL
);
GO
 
-- position_type
CREATE TABLE tblposition_type
(positiontypeID INTEGER IDENTITY(1,1) PRIMARY KEY,
positiontype_name VARCHAR(50) NOT NULL,
positiontype_descr VARCHAR(500) NULL
);
GO
--purchase_order
CREATE TABLE tblpurchase_order
(purchaseorderID INTEGER IDENTITY(1,1) PRIMARY KEY,
supplierID INT FOREIGN KEY REFERENCES tblsupplier (supplierID) NOT NULL,
purchaseorder_date DATE NOT NULL,
purchaseorder_total NUMERIC(6,2) NOT NULL
);
GO
 
 
-- position
CREATE TABLE tblposition
(positionID INTEGER IDENTITY(1,1) PRIMARY KEY,
positiontypeID INT FOREIGN KEY REFERENCES tblposition_type (positiontypeID) NOT NULL,
position_name VARCHAR(50) NOT NULL,
position_descr VARCHAR(500) NULL
);
GO
 
 
--state_province
CREATE TABLE tblstate_province
(stateprovID INTEGER IDENTITY(1,1) PRIMARY KEY,
countryID INT FOREIGN KEY REFERENCES tblcountry (countryID) NOT NULL,
stateprov_name VARCHAR(50) NOT NULL,
stateprov_descr VARCHAR(500) NULL
);
GO
 
-- customer
CREATE TABLE tblcustomer
(customerID INTEGER IDENTITY(1,1) PRIMARY KEY,
stateprovID INT FOREIGN KEY REFERENCES tblstate_province (stateprovID) NOT NULL,customer_fname VARCHAR(50) NOT NULL,
customer_lname VARCHAR(50) NOT NULL,
customer_phone CHAR(10) NOT NULL,
customer_email VARCHAR(50) NULL,
customer_dob DATE NULL,
street_address VARCHAR(100) NOT NULL,
city VARCHAR(50) NOT NULL,
zipcode CHAR(10) NOT NULL
);
GO

-- package
CREATE TABLE tblpackage
(packageID INTEGER IDENTITY(1,1) PRIMARY KEY,
orderproductID INT FOREIGN KEY REFERENCES tblorder_product (orderproductID) NOT NULL,
shipmentID INT FOREIGN KEY REFERENCES tblshipment (shipmentID) NOT NULL,
carrier_tracking_num CHAR(20) NOT NULL
);
GO
 
-- purchase_order_ingredient
CREATE TABLE tblpurchase_order_ingredient
(purchaseorderingredientID INTEGER IDENTITY(1,1) PRIMARY KEY,
purchaseorderID INT FOREIGN KEY REFERENCES tblpurchase_order (purchaseorderID) NOT NULL,
ingredientID INT FOREIGN KEY REFERENCES tblingredient (ingredientID) NOT NULL,
measurementID INT FOREIGN KEY REFERENCES tblmeasurement (measurementID) NOT NULL,
purchaseorderingredient_descr VARCHAR(500) NULL,
purchaseorderingredient_quantity NUMERIC(6,0) NOT NULL
);
GO
