--Code by: Fikay Abolade, Peter Carlson, Corey Cherrington, Charles Frahm
--3/11/2021, IMT 543 - Team 7
--#1 No new products can be created starting with the letter W.This procedure can be applied to eliminate repeated names of products. 
CREATE FUNCTION fn_nonewproductsletterW()
RETURNS INTEGER
AS
BEGIN
    DECLARE @RET INTEGER = 0
        IF EXISTS (SELECT *
            FROM tblproduct P
            WHERE P.product_name LIKE 'W%')
        BEGIN
            SET @RET = 1
        END
RETURN @RET
END
GO
ALTER TABLE tblproduct WITH NOCHECK
ADD CONSTRAINT CK_newproductsletterW
CHECK (dbo.fn_nonewproductsletterW() =0)
GO
 
--#2 Only individuals over 18 years old can place an order
CREATE FUNCTION fn_adultcustomersonly3()
RETURNS INTEGER
AS
BEGIN
    DECLARE @RET INTEGER = 0
        IF EXISTS (SELECT *
            FROM tblorder O
               JOIN tblcustomer C ON O.customerID = C.customerID
            WHERE C.Age <= 18)
        BEGIN
            SET @RET = 1
        END
RETURN @RET
END
GO
ALTER TABLE tblorder WITH NOCHECK
ADD CONSTRAINT CK_noteighteen3
CHECK (dbo.fn_adultcustomersonly3() =0)
GO

--#3 Business Rule for No Shipping Date before Order Date (Corey)
--EXPLANATION OF BUSINESS RULE: This business rule prevents a shipping date from being entered into the database if that date is before the date that an order was placed 
--(i.e. you can't ship something somewhere without it being ordered first)
CREATE FUNCTION fn_NoShipDateB4OrderDate() 
RETURNS INTEGER
AS
BEGIN
    DECLARE @RET INTEGER = 0
        IF EXISTS (SELECT *
            FROM tblshipment SH
                JOIN tblPackage P ON SH.shipmentID = P.shipmentID
                JOIN tblorder_product OP ON P.orderproductID = OP.orderproductID
                JOIN tblorder O ON OP.orderID = O.orderID
            WHERE SH.shipment_date < O.order_date)
        BEGIN
            SET @RET = 1
        END
RETURN @RET
END
GO
ALTER TABLE tblShipment WITH NOCHECK
ADD CONSTRAINT CK_NoShipDateB4OrderDate
CHECK (dbo.fn_NoShipDateB4OrderDate() =0)
GO

--#4 Business Rule No delivering green tea to non US residents
CREATE FUNCTION fn_greenteaonlyintheUSofAbaby()
RETURNS INTEGER
AS
BEGIN
    DECLARE @RET INTEGER = 0
        IF EXISTS (SELECT *
            FROM tblproduct P
                JOIN tblorder_product OP ON OP.productID=P.productID
                JOIN tblorder O ON O.orderID=OP.orderID
                JOIN tblcustomer C ON C.customerID=O.customerID
                JOIN tblstate_province SP ON SP.stateprovID=C.stateprovID
                JOIN tblcountry CO ON CO.countryID=SP.countryID
            WHERE P.product_name  LIKE '%Green Tea%'
            AND country_name= 'United States of America, US')
        BEGIN
            SET @RET = 1
        END
RETURN @RET
END
GO
ALTER TABLE tblorder
ADD CONSTRAINT PC_greenteainUS
CHECK (dbo.fn_greenteaonlyintheUSofAbaby() =0)
GO

--#5 No ducks allowed business rule
CREATE FUNCTION fn_noducksallowed()
RETURNS INTEGER
AS
BEGIN
    DECLARE @RET INTEGER = 0
        IF EXISTS (SELECT *
            FROM tblorder O
                JOIN tblcustomer C ON C.customerID=O.customerID
            WHERE C.customer_email  LIKE '%oregon.edu'
            AND C.city= 'Eugene')
        BEGIN
            SET @RET = 1
        END
RETURN @RET
END
GO
ALTER TABLE tblcustomer
ADD CONSTRAINT PC_noducks
CHECK (dbo.fn_noducksallowed() =0)
GO
 
 
--#6 Non Domestic orders must be over $49.99 in total
CREATE FUNCTION fn_nondomesticorderlimit()
RETURNS INTEGER
AS
BEGIN
    DECLARE @RET INTEGER = 0
        IF EXISTS (SELECT *
            FROM tblorder_product OP
                JOIN tblProduct P ON OP.ProductID = P.productID
                JOIN tblproduct_ingredient PI ON P.productID = PI.productID
                JOIN tblingredient I ON PI.ingredientID = I.ingredientID
                JOIN tblorder O ON OP.orderID = O.orderID
                JOIN tblcustomer CU ON O.customerID = CU.customerID
                JOIN tblstate_province SP ON CU.stateprovID = SP.stateprovID
                JOIN tblcountry CO ON SP.countryID = CO.countryID
            WHERE CO.country_name = 'United States of America, US'
            AND OP.Order_Product_Subtotal <= 49.99)
        BEGIN
            SET @RET = 1
        END
RETURN @RET
END
GO
ALTER TABLE tblorder WITH NOCHECK
ADD CONSTRAINT PC_nondomesticorderlimit
CHECK (dbo.fn_nondomesticorderlimit() =0)
GO
 
--#7 Cannot place a PO for more than 3 gallons of any milk ingredients
CREATE FUNCTION FN_3galmilklimit()
Returns INTEGER
AS 
BEGIN
    DECLARE @RET INTEGER = 0
        IF EXISTS (SELECT *
                    FROM tblpurchase_order_ingredient POI
                        JOIN tblmeasurement M ON M.measurementID=POI.measurementID
                        JOIN tblingredient I ON I.ingredientID=POI.ingredientID
                    WHERE m.measurement_name= 'gallons'
                    AND ingredient_name LIKE '%milk%'
                    AND purchaseorderingredient_quantity > 3)
                BEGIN
                SET @RET = 1
                END
                Return @RET
                END
                GO
 
ALTER TABLE tblpurchase_order_ingredient
ADD CONSTRAINT PC_nomorethan3galmilk
CHECK (dbo.FN_3galmilklimit()=0)
GO
 
--#8 Business Rule for No Black Tea for Avatar Roku
--EXPLANATION OF BUSINESS RULE: This business rule bans Avatar Roku from buying any black tea products (he became addicted and needed to be limited).
CREATE FUNCTION fn_NoBlackTea4Roku()
RETURNS INTEGER
AS
BEGIN
    DECLARE @RET INTEGER = 0
        IF EXISTS (SELECT *
            FROM tblorder_product OP 
                JOIN tblproduct P ON OP.productID = P.productID
                JOIN tblproduct_ingredient PI ON P.productID = PI.productID
                JOIN tblingredient I ON PI.ingredientID = I.ingredientID
                JOIN tblorder O ON OP.orderID = O.orderID
                JOIN tblcustomer CU ON O.customerID = CU.customerID
            WHERE I.Ingredient_name LIKE '%Black%Tea%'
            AND CU.Customer_Fname = 'Roku'
            AND CU.Customer_Lname = 'Avatar')
        BEGIN
            SET @RET = 1
        END
RETURN @RET
END
GO
