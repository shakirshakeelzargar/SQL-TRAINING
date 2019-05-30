SELECT * FROM ORDERS
SELECT * FROM EMPLOYEES
SELECT * FROM PRODUCTS
SELECT * FROM SUPPLIERS
SELECT * FROM CATEGORIES
SELECT * FROM CUSTOMERS
SELECT * FROM [Order Details]
SELECT * FROM [Orders Qry]
SELECT * FROM Territories
SELECT * FROM EmployeeTerritories



--1.	Display the product names along with their supplier name
SELECT ProductName,CompanyName
FROM PRODUCTS P
INNER JOIN SUPPLIERS S ON P.SupplierID=S.SupplierID


--2.	Display the product names and the category which the products fall under. Also display the supplier’s name
SELECT ProductName,CompanyName,CategoryName
FROM PRODUCTS P
INNER JOIN SUPPLIERS S ON P.SupplierID=S.SupplierID
INNER JOIN CATEGORIES C ON P.CategoryID=C.CategoryID


--3.	Display the Order_id, Contact name and the number of products purchased by the customer
SELECT ContactName,O.OrderID,COUNT(O.OrderID) [NO OF ORDERS]
FROM ORDERS O 
INNER JOIN CUSTOMERS C ON O.CustomerID=C.CustomerID
GROUP BY ContactName,O.OrderID
ORDER BY ContactName


SELECT CONTACTNAME,COUNT(ORDERID)
FROM ORDERS O
INNER JOIN CUSTOMERS C ON O.CustomerID=C.CustomerID
GROUP BY CONTACTNAME


--4.	Display the Order_Id, Contact name and the shipping company name having Brazil as the ship country
SELECT OrderID,C.ContactName,ShipName,ShipCountry
FROM ORDERS O
INNER JOIN CUSTOMERS C ON O.CustomerID=C.CustomerID
WHERE O.ShipCountry='BRAZIL'



--5.	Display the Order_Id, contact name along with the employee’s name who handled that sale. Also display the total amount of that particular order 
SELECT O.OrderID,C.ContactName,E.FirstName EmployeeName,SUM(ExtendedPrice) TOTALAMT
FROM ORDERS O
INNER JOIN CUSTOMERS C ON O.CustomerID=C.CustomerID
INNER JOIN EMPLOYEES E ON O.EmployeeID=E.EmployeeID
INNER JOIN [Order Details Extended] OE ON O.OrderID=OE.OrderID
INNER JOIN PRODUCTS P ON OE.ProductID=P.ProductID
GROUP BY O.OrderId,C.ContactName,E.FirstName

--6.	Display the product names that were sold by the sales manager 
SELECT P.ProductName
FROM ORDERS O
INNER JOIN EMPLOYEES E ON O.EmployeeID=E.EmployeeID
INNER JOIN [Order Details Extended] OE ON O.OrderID=OE.OrderID
INNER JOIN PRODUCTS P ON OE.ProductID=P.ProductID
WHERE E.Title='Sales Manager'



--7.	Fetch all the columns from suppliers with the corresponding product id and product name. If the Region is Null concatenate the first letters of country and city, should be in Upper case.
SELECT * ,
		case when S.Region is null then SUBSTRING(S.City, 1, 1 ) + SUBSTRING(S.Country, 1, 1 )

		ELSE S.Region
		END AS NEWREGION
		FROM PRODUCTS P
FULL JOIN SUPPLIERS S ON P.SupplierID=S.SupplierID



--8.	Display the company name, contact name, city along with the Unit price from products. Fetch all the records from suppliers. Handle the null values
SELECT CompanyName,ContactName,City,ProductName,(UnitPrice)
FROM SUPPLIERS S
LEFT JOIN PRODUCTS P ON S.SupplierID=P.ProductID


SELECT CompanyName,ContactName,City,ProductName,(UnitPrice)
FROM PRODUCTS P
LEFT JOIN SUPPLIERS S ON P.SupplierID=S.SupplierID
GROUP BY CompanyName,ContactName,City,ProductName,UnitPrice



--9.	Select customer id, ship name, ship city, territory description, unit price and discount where in the territory id should not exceed four characters and the ship via should be 1 or 2..
SELECT CustomerID,ShipName,ShipCity,TerritoryDescription,UnitPrice,Discount ,T.TerritoryID
FROM Orders O
INNER JOIN [Order Details Extended] OE ON O.OrderID=OE.OrderID
INNER JOIN EmployeeTerritories ET ON O.EmployeeID=ET.EmployeeID
INNER JOIN Territories T ON ET.TerritoryID=T.TerritoryID
WHERE ShipVia BETWEEN 1 AND 2 AND T.TerritoryID<=9999



SELECT * FROM ORDERS
SELECT * FROM EMPLOYEES
SELECT * FROM PRODUCTS
SELECT * FROM SUPPLIERS
SELECT * FROM CATEGORIES
SELECT * FROM CUSTOMERS
SELECT * FROM [Order Details]
SELECT * FROM [Orders Qry]
SELECT * FROM Territories
SELECT * FROM EmployeeTerritories
SELECT * FROM 


--10.	Display the order id, customer id, Unit price, quantity where the discount should be greater than zero.
SELECT O.OrderID,O.CustomerID,P.UnitPrice,Quantity,Discount
FROM Orders O
INNER JOIN [Order Details] OE ON O.OrderID=OE.OrderID
INNER JOIN Products P ON OE.ProductID=P.ProductID
INNER JOIN SUPPLIERS S ON P.SupplierID=S.SupplierID
INNER JOIN Categories C ON P.CategoryID=C.CategoryID
WHERE Discount>0.0



--11.	Select the category id, category name, description, product name, and supplier id and unit price. Where the description should not exceed two subcategories.


;WITH CTE AS
(
SELECT *, CAST([Description] AS varchar(100)) DESC2
from Categories
),
CTE2 AS
(
SELECT * , len(DESC2) - len(replace(DESC2, ',', '')) COMMAS,case when DESC2 LIKE '%and%' THEN 'YES'
ELSE 'NO'
END AS ANDS
FROM CTE
)
SELECT * FROM Products P
INNER JOIN CTE2 ON P.CategoryID=CTE2.CategoryID
WHERE COMMAS=0 AND ANDS = 'NO'




--METHOD 2



;WITH CTE AS
(
SELECT *, CAST([Description] AS varchar(100)) DESC2
from Categories
),
CTE1 AS
(
SELECT * , replace(DESC2, 'AND',',') DESC3
FROM CTE
),
CTE2 AS
(
SELECT * , len(DESC2) - len(replace(DESC2, ',', '')) COMMAS
FROM CTE1
)
SELECT * FROM Products P
INNER JOIN CTE2 ON P.CategoryID=CTE2.CategoryID
WHERE COMMAS<=1









--12.	Write a query to select only the first letter in each word present in the column 'Contact Name'. (E.g.: A Beautiful Mind-ABM) and name this column as 'Short Name'. Do order by ‘Short Form' (use Suppliers table)
SELECT * ,
		case when S.ContactName is not null then SUBSTRING(S.ContactName, 1, 1 ) + SUBSTRING(S.ContactName, 0, CHARINDEX(' ', S.ContactName,3))

		ELSE S.Region
		END AS SHORTNAME
FROM Suppliers S

----METHOD 2
;WITH CTE
AS
(
select *,
    SUBSTRING(ContactName, 1, CHARINDEX(' ', ContactName) - 1) as firstname , 
    SUBSTRING(ContactName, CHARINDEX(' ', ContactName) + 1, LEN(ContactName)) as lastname 
from Suppliers
)
SELECT * ,SUBSTRING(CTE.firstname, 1, 1 ) + SUBSTRING(CTE.lastname, 1, 1 ) SHORTNAME

FROM CTE





--13.	Display the Delivery time (in days) for each order and sort it by delivery day.
;WITH CTE AS
(
SELECT OrderID,ShippedDate, DATEDIFF(DAY,OrderDate,ShippedDate) AS DateDiff,DATENAME(DW,ShippedDate) AS DAY
FROM Orders
)
SELECT * FROM CTE
WHERE ShippedDate IS NOT NULL
--ORDER BY[DateDiff]
--ORDER BY ShippedDate
ORDER BY [Day]



--14.	Display the order id along with its delivery status.
         --   Delivery status: If order Delivered within 7 days, then status will be ‘ON-TME’ 
                             --    Delivered after 7 days, then status will be ‘Delayed’
                              --   Delivered before 4 days, then status will be ‘Delivered Early’.

;WITH CTE AS
(
SELECT OrderID,ShippedDate, DATEDIFF(DAY,OrderDate,ShippedDate) AS DateDiff,DATENAME(DW,ShippedDate) AS DAY
FROM Orders
)
SELECT * ,
		case when DateDiff BETWEEN 4 AND 7 THEN 'ONTIME'
		     when DateDiff>7 THEN 'DELAYED'
		     when DateDiff<4 THEN 'EARLY DELIVERED'
	
		END AS STATUS
FROM CTE




--15.	Display the employee name along with their appraisal date (Add 6 months to hire date)
SELECT EmployeeID,FirstName,LastName,DATEADD(MONTH, 6, HireDate) AS AppraisalDate
FROM Employees


























































