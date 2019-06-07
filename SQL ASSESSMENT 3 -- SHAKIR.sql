USE SQLAssessment


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
SELECT * FROM Dept
SELECT * FROM EMP


--1. Write a query to display the name and hire date of any employee in the samedepartment as ADAMS. Exclude ADAMS.

SELECT ENAME, HireDate
FROM EMP
WHERE DEPT = (SELECT DEPT
FROM EMP
WHERE ENAME = 'ADAMS')
AND ENAME <> 'ADAMS'


--2. Create a query to display the employee numbers and names of all employees who earn more than the average salary.
--Sort the results in ascending order of salary.

SELECT * FROM
EMP
WHERE SAL> (SELECT AVG(SAL) FROM EMP)
ORDER BY SAL


--3. Write a query that displays the employee numbers and names of all employees who work in a department with any employee whose last name contains a u. 

SELECT DEPT, ENAME
FROM EMP
WHERE DEPT IN (SELECT DEPT FROM employees WHERE ENAME like '%u%');
--This will not give any value as no employee has a 'u' in their name

--USING Employees Table
SELECT EmployeeID, Lastname
FROM Employees
WHERE EmployeeID IN (SELECT EmployeeID FROM employees WHERE Lastname like '%u%');


--4. . Display the name, department number, and job of all employees whose department location is ATLANTA.

SELECT ENAME, DEPT, JOB
FROM EMP E
INNER JOIN DEPT D ON E.DEPT=D.DEPTNO
WHERE LOC='ATLANTA'

--USING SUB QUERY
SELECT ENAME,DEPT,JOB
FROM EMP
WHERE ENAME IN (SELECT ENAME FROM EMP E
INNER JOIN DEPT D ON E.DEPT=D.DEPTNO
WHERE LOC='ATLANTA')


--5.. Display the name and salary of every employee who reports to JACKSON.
SELECT * FROM EMP
WHERE MGR=(SELECT EMPNO FROM EMP WHERE ENAME LIKE '%JACKSON%')


--6. Display the department number, name, and job for every employee in the ACCOUNTING department.
--WITHOUT SUBQUERY
SELECT * FROM
EMP E
INNER JOIN DEPT D ON E.DEPT=D.DEPTNO
WHERE DNAME LIKE '%ACCOUNTING%'

--WITH SUBQUERY
SELECT DEPT, ENAME, JOB
FROM EMP
WHERE EMPNO = (SELECT EMPNO FROM
EMP E
INNER JOIN DEPT D ON E.DEPT=D.DEPTNO
WHERE DNAME LIKE '%ACCOUNTING%')

--METHOD 2, WITHOUT JOIN
SELECT DEPT, ENAME, JOB
FROM EMP
WHERE DEPT = (SELECT DEPTNO FROM DEPT WHERE DNAME LIKE '%ACCOUNTING%')


--7. Modify the above query to display the employee numbers, names, and salaries of all employees 
--who earn more than the average salary and who work in a department with any employee with a u in their name.



SELECT EmployeeID, Lastname, Salary
FROM Employees
WHERE EmployeeID IN (SELECT EmployeeID FROM employees WHERE Lastname like '%u%') AND Salary>(SELECT AVG(Salary) FROM EMPLOYEES)


--8. Write a query to display the top three earners in the EMPLOYEES table. Display their names and salaries. 

--METHOD 1, Without Sub Query
SELECT TOP 3 EmployeeId,FirstName,LastName,Salary FROM EMPLOYEES
ORDER BY Salary DESC

--Method 2, Using RANK
SELECT TOP 3 *,EmployeeID,FirstName,LastName, DENSE_RANK() OVER (ORDER BY SALARY DESC) RANKK
FROM Employees

--Method 3, Using Sub Query
SELECT TOP 3 * FROM EMPLOYEES WHERE Salary IN (SELECT Salary FROM Employees) ORDER BY Salary DESC


--Method 2 using user defined input and procedures
ALTER PROCEDURE TOPEARNING(@m INT,@n INT)
AS
BEGIN
;WITH CTE
AS
(SELECT EmployeeID,FirstName,LastName,Salary, DENSE_RANK() OVER (ORDER BY SALARY DESC) RANKK
FROM Employees)
SELECT * FROM CTE
WHERE RANKK BETWEEN @m AND @n
END

EXEC TOPEARNING 1,3


--9. Write a query to display the name, department number, and salary of any employee 
--whose department number and salary both match the department number and salary of any employee who earns a commission.


SELECT ENAME, DEPT, sal
FROM emp
WHERE (sal ) IN (SELECT sal FROM emp ) AND DEPT IN (SELECT DEPT FROM EMP ) AND COMM IS NOT NULL

SELECT ENAME, DEPT, sal
FROM emp
WHERE (sal ) IN (SELECT sal FROM emp WHERE COMM IS NOT NULL  ) AND DEPT IN (SELECT DEPT FROM EMP WHERE COMM IS NOT NULL ) AND COMM IS NULL




--10. Create a query to display the last name, hire date, and salary for all employees who have the same salary and commission as POLK.
SELECT * FROM EMP
WHERE (SAL) IN (SELECT SAL FROM EMP WHERE ENAME LIKE '%POLK%' ) AND COMM IN (SELECT COMM FROM EMP WHERE ENAME LIKE '%POLK%')