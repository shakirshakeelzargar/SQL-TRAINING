

--CREATING TABLE EMP USING PROCEDURE USING HARD CODING
CREATE PROCEDURE PROCESS1
AS BEGIN
DROP TABLE SHAKIR_EMP
CREATE TABLE SHAKIR_EMP(EMP_ID INT,EMP_NAME VARCHAR(100),TITLE VARCHAR(100),EMP_ADDRESS VARCHAR(100),SALARY FLOAT,DEPT_ID INT,MGR_ID INT)
INSERT INTO SHAKIR_EMP
SELECT 1,'SHAKIR','TRAINEE','SRINAGAR',90000,1,5 UNION ALL
SELECT 2,'JHON','HR','AMERICA',40000,3,5 UNION ALL
SELECT 3,'DIVYA','ANALYST','CHENNAI',50000,1,5 UNION ALL
SELECT 4,'ANDREW','DEVELOPER','AUSTRALIA',60000,4,5 UNION ALL
SELECT 5,'RAJESH','LEAD','DELHI',70000,2,NULL UNION ALL
SELECT 6,'RAHUL','PROJECT MANAGER','HARYANA',45000,4,9 UNION ALL
SELECT 7,'WATSON','DEVELOPER','AFRICA',56000,4,9 UNION ALL
SELECT 8,'DHONI','TRAINEE','RANCHI',67000,5,9 UNION ALL
SELECT 9,'KOHLI','HR','DELHI',43000,2,NULL UNION ALL
SELECT 10,'HARDIK','ANALYST','DELHI',77000,5,9

SELECT * FROM SHAKIR_EMP
END
EXEC PROCESS1



---------------------------------------------------------------------------------------------------



--CREATING DEPT TABLE USING HARD CODING
CREATE PROCEDURE PROCESS2
AS BEGIN
DROP TABLE SHAKIR_DEPT
CREATE TABLE SHAKIR_DEPT(DEPT_ID INT,DEPT_NAME VARCHAR(100))
INSERT INTO SHAKIR_DEPT
SELECT 1,'SOFTWARE' UNION ALL
SELECT 2,'HR' UNION ALL
SELECT 3,'FINANCE' UNION ALL
SELECT 4,'DELIVERY' UNION ALL
SELECT 5,'NETSYS'

SELECT * FROM SHAKIR_DEPT
END
EXEC PROCESS2



--------------------------------------------------------------------------------------------------------------------------------------



--INSERTING VALUES INTO EMP TABLE USING PARAMETER PASSING
CREATE PROCEDURE PROCESS4 (@id int, @name varchar(100),@title varchar(100),@address varchar(100),@salary float,@dept int,@mgr int)
AS BEGIN
INSERT INTO SHAKIR_EMP(EMP_ID ,EMP_NAME ,TITLE,EMP_ADDRESS ,SALARY ,DEPT_ID ,MGR_ID) 
VALUES
( @id , @name ,@title ,@address ,@salary ,@dept ,@mgr)
END


EXEC PROCESS4 12,'SWATI','DEVELOPER','CHENNAI',50000,3,2

SELECT * FROM SHAKIR_EMP



-----------------------------------------------------------------------------------------------------------------




--VIEWING EMP ID,Name,ManagerID,Manager Name using procedures and user input
CREATE PROCEDURE PROCESS5(@empid int)
AS
BEGIN
SELECT 
  SHAKIR_EMP.EMP_NAME AS "EMPLOYEE_NAME", 
  SHAKIR_EMP.EMP_ID AS "EMP_ID", 
  SHAKIR_EMP.MGR_ID AS "MGR_ID",
  M.EMP_NAME AS "MANAGER"
FROM 
SHAKIR_EMP
LEFT OUTER JOIN SHAKIR_EMP M ON
SHAKIR_EMP.MGR_ID = M.EMP_ID
WHERE SHAKIR_EMP.EMP_ID=@empid
END


EXEC PROCESS5 10



---------------------------------------------------------------------------------------------------------------------



--VIEWING TOP n NO OF EARNING EMPLOYEES USING PROCEDURES
CREATE PROCEDURE PROCESS6 (@n int)
AS
BEGIN
SELECT  TOP (@n) EmployeeId,FirstName,LastName,Salary FROM EMPLOYEES
ORDER BY Salary DESC
END

EXEC PROCESS6 2



-------------------------------------------------------------------------------------------------------



--VIEWING ORDERS ON BASED ON USER INPUT(COUNTRY)
CREATE PROCEDURE PROCESS7(@c VARCHAR(100))
AS
BEGIN
SELECT OrderID,E.EmployeeID,LastName,ShipAddress,ShipCountry  FROM ORDERS O
INNER JOIN Employees E ON O.EmployeeID=E.EmployeeID
WHERE ShipCountry = @c
END


EXEC PROCESS7 BRAZIL
