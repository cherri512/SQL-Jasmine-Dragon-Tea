--Zipcodes of Customers who have ordered the most items that are 18 years old and up that 
--have also spent more than $100 at the Jasmine Dragon in the past two years
SELECT C.CustomerID, C.Customer_fname, C.Customer_lname, C.zipcode, Count(DISTINCT OP.orderproductID) AS NumProductsOrdered, Total$Spent_2Yrs
FROM tblCustomer C
    JOIN tblstate_province SP on C.stateprovID = sp.stateprovID
    JOIN tblOrder O ON C.customerID = O.customerID
    JOIN tblorder_product OP ON O.orderID = OP.orderID
    JOIN (SELECT C.CustomerID, C.Customer_fname, C.Customer_lname, C.zipcode, SUM(O.Order_Subtotal) AS Total$Spent_2Yrs
            FROM tblOrder O
                JOIN tblCustomer C on O.CustomerID = C.customerID
            WHERE Order_Date > DATEADD(YEAR, -2, GetDate())
            GROUP BY C.CustomerID, C.Customer_fname, C.Customer_lname, C.zipcode
            HAVING SUM(O.Order_Subtotal) > '100') AS Subq1 ON C.customerID = Subq1.customerID
Where C.Customer_DOB < DATEADD(YEAR, -18, GetDate())
GROUP BY C.CustomerID, C.Customer_fname, C.Customer_lname, C.zipcode, Total$Spent_2Yrs
ORDER BY Count(OP.orderProductID) DESC

--Customers who ordered products containing green tea in the past three years 
--THAT ALSO spent less than $1000 at the Jasmine Dragon and are from the 'Water Tribe' country.
SELECT CU.CustomerID, CU.Customer_fname, CU.customer_lname, COUNT(*) AS NumGreenTeaProducts, MoneySpent
FROM tblOrder O
    JOIN tblCustomer CU ON O.customerID = CU.customerID
    JOIN tblorder_product OP ON O.orderID = OP.orderID
    JOIN tblproduct P ON OP.productID = P.productID
    JOIN tblproduct_ingredient PI ON P.ProductID = PI.ProductID
    JOIN tblingredient I on PI.ingredientID = I.ingredientID
    JOIN (SELECT CU.CustomerID, CU.Customer_fname, CU.customer_lname, Sum(O.order_Subtotal) AS MoneySpent
            FROM tblOrder O
                JOIN tblCustomer CU ON O.customerID = CU.customerID
                JOIN tblorder_product OP ON O.orderID = OP.orderID
                JOIN tblproduct P ON OP.productID = P.productID
                JOIN tblproduct_ingredient PI ON P.ProductID = PI.ProductID
                JOIN tblingredient I on PI.ingredientID = I.ingredientID
                JOIN tblstate_province SP on CU.stateprovID = SP.stateprovID
                JOIN tblcountry CO ON SP.countryID = CO.countryID
            WHERE CO.country_name = 'Water Tribe'
            GROUP BY CU.CustomerID, CU.Customer_fname, CU.customer_lname
            HAVING SUM(O.Order_Subtotal) < 1000) AS subq1 ON CU.customerID = subq1.customerID
WHERE I.ingredient_name LIKE '%Green%'
AND O.order_date >= DATEADD(YEAR, -3, GETDate())
GROUP BY CU.CustomerID, CU.Customer_fname, CU.customer_lname, MoneySpent
ORDER BY COUNT(*) DESC


-- People from the Water Tribe country who have spent more than $700 in order_subtotal and who have bought at least 1 t-shirt? 
--They have won a free T-Shirt from Zuko’s new collection with their next purchase!
SELECT C.CustomerID, C.Customer_fname, C.customer_lname, COUNT(*) AS TshirtProductpurchase, DollarsSpent
FROM tblOrder O
   JOIN tblCustomer C ON O.customerID = C.customerID
   JOIN tblorder_product OP ON O.orderID = OP.orderID
   JOIN tblproduct P ON OP.productID = P.productID
   JOIN (SELECT C.CustomerID, C.Customer_fname, C.customer_lname, Sum(O.order_Subtotal) AS DollarsSpent
           FROM tblOrder O
               JOIN tblCustomer C ON O.customerID = C.customerID
               JOIN tblorder_product OP ON O.orderID = OP.orderID
               JOIN tblproduct P ON OP.productID = P.productID
               JOIN tblproduct_ingredient PI ON P.ProductID = PI.ProductID
               JOIN tblingredient I on PI.ingredientID = I.ingredientID
               JOIN tblstate_province SP on C.stateprovID = SP.stateprovID
               JOIN tblcountry CO ON SP.countryID = CO.countryID
           WHERE CO.country_name = 'Water Tribe'
           GROUP BY C.CustomerID, C.Customer_fname, C.customer_lname
           HAVING SUM(O.Order_Subtotal) > 700) AS subq1 ON C.customerID = subq1.customerID
WHERE P.product_name LIKE '%T-Shirt%'
GROUP BY C.CustomerID, C.Customer_fname, C.customer_lname, DollarsSpent
ORDER BY COUNT(*) DESC


--Top 5 states with the most orders of Green Tea
SELECT TOP 5 with ties S.stateprovID, S.stateprov_name, COUNT(O.orderID) AS totalorders
FROM tblstate_province S
   JOIN tblCustomer C ON S.stateprovID = C.stateprovID
   JOIN tblorder O ON C.customerID = O.orderID
   JOIN tblorder_product OP ON O.orderID = OP.orderID
   JOIN tblproduct P ON OP.productID = P.productID
WHERE P.product_name LIKE '%Green%'
GROUP BY S.stateprovID, S.stateprov_name
ORDER BY COUNT(O.orderID) DESC
 

--Top 3 selling products all time
SELECT TOP 3 WITH ties  P.productID, P.Product_name, sum(O.Order_Subtotal)AS TotalItemRevenue
FROM tblorder O 
JOIN tblorder_product OP ON OP.orderID=O.orderID
JOIN tblproduct P on P.productID=OP.productID
GROUP BY P.productID, P.product_name
ORDER BY SUM(O.Order_Subtotal) DESC

--Best selling product all time for each country
SELECT  a.countryID, a.country_name, MAX(a.Product_name) AS Productname, MAX(a.TotalItemRevenue) AS totalrev
FROM tblcountry C 
JOIN
(SELECT  C.countryID, C.country_name,P.productID,  P.Product_name, sum(O.Order_Subtotal)AS TotalItemRevenue
FROM tblcountry C 
    JOIN tblstate_province SP ON  C.countryID=SP.countryID
    JOIN tblcustomer CU ON SP.stateprovID=CU.stateprovID
    JOIN tblorder O ON CU.customerID=O.customerID
    JOIN tblorder_product OP ON OP.orderID=O.orderID
    JOIN tblproduct P ON P.productID=OP.productID
GROUP BY  C.countryID,C.country_name, P.productID,P.Product_name) a on c.countryID=a.countryID
GROUP BY a.countryID, a.country_name
ORDER BY MAX(a.TotalItemRevenue)

--Top 3 Customers and (Zipcodes of customers) over 18 years old who have bought at least 2 products that have also spent more than $100 in the past two years
SELECT TOP 3 C.CustomerID, C.Customer_fname, C.Customer_lname, C.zipcode, Count(DISTINCT OP.orderproductID) AS NumProductsOrdered, Total$Spent_2Yrs
FROM tblCustomer C
    JOIN tblstate_province SP on C.stateprovID = sp.stateprovID
    JOIN tblOrder O ON C.customerID = O.customerID
    JOIN tblorder_product OP ON O.orderID = OP.orderID
    JOIN (SELECT C.CustomerID, C.Customer_fname, C.Customer_lname, C.zipcode, SUM(O.Order_Subtotal) AS Total$Spent_2Yrs
            FROM tblOrder O
                JOIN tblCustomer C on O.CustomerID = C.customerID
            WHERE Order_Date > DATEADD(YEAR, -2, GetDate())
            GROUP BY C.CustomerID, C.Customer_fname, C.Customer_lname, C.zipcode
            HAVING SUM(O.Order_Subtotal) > '100') AS Subq1 ON C.customerID = Subq1.customerID
Where C.Customer_DOB < DATEADD(YEAR, -18, GetDate())
GROUP BY C.CustomerID, C.Customer_fname, C.Customer_lname, C.zipcode, Total$Spent_2Yrs
HAVING COUNT(DISTINCT OP.orderproductID) > 2
ORDER BY Total$Spent_2Yrs DESC

--Top 3 Customers and (Zipcodes of customers) over 18 years old who have bought at least 2 products that have also spent more than $100 in the past two years
SELECT TOP 3 C.CustomerID, C.Customer_fname, C.Customer_lname, C.zipcode, Count(DISTINCT OP.orderproductID) AS NumProductsOrdered, Total$Spent_2Yrs
FROM tblCustomer C
    JOIN tblstate_province SP on C.stateprovID = sp.stateprovID
    JOIN tblOrder O ON C.customerID = O.customerID
    JOIN tblorder_product OP ON O.orderID = OP.orderID
    JOIN (SELECT C.CustomerID, C.Customer_fname, C.Customer_lname, C.zipcode, SUM(O.Order_Subtotal) AS Total$Spent_2Yrs
            FROM tblOrder O
                JOIN tblCustomer C on O.CustomerID = C.customerID
            WHERE Order_Date > DATEADD(YEAR, -2, GetDate())
            GROUP BY C.CustomerID, C.Customer_fname, C.Customer_lname, C.zipcode
            HAVING SUM(O.Order_Subtotal) > '100') AS Subq1 ON C.customerID = Subq1.customerID
Where C.Customer_DOB < DATEADD(YEAR, -18, GetDate())
GROUP BY C.CustomerID, C.Customer_fname, C.Customer_lname, C.zipcode, Total$Spent_2Yrs
HAVING COUNT(DISTINCT OP.orderproductID) > 2
ORDER BY Total$Spent_2Yrs DESC

--Three customers that bought the least in the last 3 years (in dollars)
SELECT TOP 3 CU.CustomerID, CU.Customer_fname, CU.Customer_lname, SUM(O.Order_Subtotal) AS Customer$Spent
FROM tblOrder O
    JOIN tblorder_product OP ON O.orderID = OP.orderID
    JOIN tblCustomer CU ON O.customerID = CU.customerID
WHERE O.Order_date > DATEADD(YEAR, -3, GetDate())
GROUP BY CU.CustomerID, CU.Customer_fname, CU.Customer_lname
ORDER BY Customer$Spent ASC
GO

--Three customers that bought the least in the last 6 months (in dollars)
SELECT TOP 3 CU.CustomerID, CU.Customer_fname, CU.Customer_lname, SUM(O.Order_Subtotal) AS Customer$Spent
FROM tblOrder O
    JOIN tblorder_product OP ON O.orderID = OP.orderID
    JOIN tblCustomer CU ON O.customerID = CU.customerID
WHERE O.Order_date > DATEADD(MONTH, -6, GetDate())
GROUP BY CU.CustomerID, CU.Customer_fname, CU.Customer_lname
ORDER BY Customer$Spent ASC
GO

--Top 5 best-selling products in the last year (by quantity sold)
SELECT TOP 5 P.productID, P.product_name, P.product_descr, SUM(OP.orderproduct_quantity) AS QtyProductsSold
FROM tblProduct P
    JOIN tblorder_product OP ON P.productID = OP.productID
    JOIN tblorder O ON OP.orderID = O.orderID
WHERE OP.productID = P.productID
AND O.Order_date > DATEADD(YEAR, -1, GetDate())
GROUP BY P.productID, P.product_name, P.product_descr
ORDER BY QtyProductsSold DESC
GO
 
--Top 5 best-selling products in the last 6 months (by quantity sold)
SELECT TOP 5 P.productID, P.product_name, P.product_descr, SUM(OP.orderproduct_quantity) AS QtyProductsSold
FROM tblProduct P
    JOIN tblorder_product OP ON P.productID = OP.productID
    JOIN tblorder O ON OP.orderID = O.orderID
WHERE OP.productID = P.productID
AND O.Order_date > DATEADD(MONTH, -6, GetDate())
GROUP BY P.productID, P.product_name, P.product_descr
ORDER BY QtyProductsSold DESC
GO
