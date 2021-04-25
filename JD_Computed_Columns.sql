--Fikay Abolade, Peter Carlson, Corey Cherrington, Charles Frahm
--3/11/2021, IMT 543 - Team 7
--#1 - Computed Column for Order Product Subtotal
CREATE FUNCTION fn_JDOrderProductSubtotal (@PK INT)
RETURNS NUMERIC (10,2)
AS
BEGIN
    DECLARE @RET NUMERIC(10,2) = (SELECT SUM(P.Product_Price * OP.orderproduct_quantity)
                                    FROM tblProduct P
                                        JOIN tblorder_product OP ON P.ProductID = OP.productID
                                    WHERE OP.OrderProductID = @PK)
RETURN @RET
END
GO
ALTER TABLE tblorder_product
ADD Order_Product_Subtotal AS (dbo.fn_JDOrderProductSubtotal (OrderProductID))
 
--#2 - Computed Column for tblOrder, Order Total
CREATE FUNCTION fn_JDOrderTotal (@PK INT)
RETURNS NUMERIC (10,2)
AS
BEGIN
    DECLARE @RET NUMERIC(10,2) = (SELECT SUM(OP.Order_Product_Subtotal)
                                    FROM tblorder_product OP
                                        JOIN tblORDER O ON OP.orderID = O.orderID
                                    WHERE OP.OrderID = @PK
                                    GROUP BY O.OrderID)
RETURN @RET
END
GO
ALTER TABLE tblorder
ADD Order_Subtotal AS (dbo.fn_JDOrderTotal2 (OrderID))

--#3 - Computed Column for Customer Age
CREATE FUNCTION FN_calcAge1 (@PK INT)
RETURNS INT
AS
BEGIN
DECLARE @RET INT = (SELECT Datediff(Year, C.customer_dob, GETDATE())
FROM tblcustomer C
WHERE @PK = C.CustomerID)
RETURN @RET
END
GO
 
ALTER TABLE tblcustomer
ADD Age AS (dbo.FN_calcAge1 (CustomerID))
GO

--#4 - Computed Column into tblorder: find out how many ingredients are in each order
CREATE FUNCTION FN_numberofingredient (@PK INT)
RETURNS INT
AS
BEGIN
DECLARE @RET INT = (SELECT COUNT(DISTINCT PG.productingredientID)
FROM tblproduct_ingredient PG
   JOIN tblproduct P ON PG.productID = P.productID
   JOIN tblorder_product OP ON P.productID = OP.productID
   JOIN tblorder O ON OP.orderID = O.orderID  
WHERE @PK = O.orderID)
RETURN @RET
END
GO
 
ALTER TABLE tblorder
ADD NumberofIngredients AS (dbo.FN_numberofingredient(OrderID))
GO
 
--# 5 - Calculate age of employee in tblemployee
CREATE FUNCTION fn_ageofemployee (@PK INT)
Returns INT
AS BEGIN 
DECLARE @RET INT =(SELECT Datediff(Year,E.employee_dob,GETDATE())
FROM tblemployee E
WHERE @PK=E.employeeID)
RETURN @RET
END
GO
 
ALTER TABLE tblemployee
ADD Age AS (dbo.fn_ageofemployee (employeeID))
GO

--#6 - Calculate current status of employee
Alter table tblemployee_position ADD CurrentStatus AS
 (CASE WHEN end_date IS NULL THEN 'Active'
ELSE 'Contract Terminated'
END)


--#7 - Computed Column how many total orders per customer
CREATE FUNCTION fn_totalorder (@PK INT)
Returns INT
AS BEGIN 
DECLARE @RET INT =(SELECT count(orderid)
FROM tblorder o
JOIN tblcustomer c on o.customerID=c.customerID
WHERE @PK=c.customerID)
RETURN @RET
END
GO
 
ALTER TABLE tblcustomer
ADD totalorders AS (dbo.fn_totalorder (customerID))
GO
