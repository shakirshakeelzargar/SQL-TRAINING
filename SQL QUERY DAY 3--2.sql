SELECT * FROM fact_sales

--TOTAL SUM OF AMOUNT
SELECT SUM(Total_Amount)
FROM FACT_SALES

--TOTAL SUM OF AMOUNT SHIPPER WISE
SELECT SHIPPER,SUM(Total_Amount)
FROM FACT_SALES
GROUP BY SHIPPER

--TOTAL COUNT OF ORDERS SHIPPER WISE
SELECT SHIPPER,COUNT(SHIPPER)
FROM FACT_SALES
GROUP BY SHIPPER

SELECT * FROM [Order Details]

--PRODUCTS WHOSE QUANTITY IS MORE THAN 10
SELECT * FROM [Order Details]
WHERE QUANTITY>10

--COUNT OF PRODUCTS ORDERED CUSTOMER WISE
SELECT CUSTOMER_ID,COUNT(ORDER_ID)
FROM FACT_SALES
GROUP BY CUSTOMER_ID
ORDER BY CUSTOMER_ID


