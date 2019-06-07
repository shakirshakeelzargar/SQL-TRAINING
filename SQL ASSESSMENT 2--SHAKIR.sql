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


--1.	Display the manager number and the salary of the lowest paid employee for that manager. 
--Exclude anyone whose manager is not known. Exclude any groups where the minimum salary is $6,000 or less. 
--Sort the output in descending order of salary




--method1
SELECT ename,MGR, MIN(SAL)
FROM EMP
WHERE MGR IS NOT NULL
GROUP BY MGR,ENAME
HAVING MIN(SAL) > 6000
ORDER BY MIN(SAL) DESC ;


--method2
SELECT DISTINCT MGR, MIN(SAL) OVER (PARTITION BY MGR ORDER BY MGR) MINN
FROM EMP
WHERE MGR IS NOT NULL
GROUP BY MGR,SAL
HAVING MIN(SAL) > 6000


--2.	Write a query to display each department’s name, location, number of employees, and the average salary for all employees in that department. 
--Label the columns Name, Location, Number of People, and Salary, respectively.  
--Round the average salary to two decimal place

SELECT D.DNAME,D.LOC,COUNT(*) [COUNT OF EMPLOYEES], ROUND(AVG(E.SAL),2) AVGsAL
FROM EMP E
INNER JOIN DEPT D ON E.DEPT=D.DEPTNO
GROUP BY DNAME, LOC


--3.	Show the department number, name, number of employees, and average salary of all departments, 
--together with the names, salaries, and jobs of the employees working in each department


SELECT d.deptno, d.dname, 
COUNT(ENAME) OVER (PARTITION BY e.dept ORDER BY e.dept) dept_countm,
avg(sal) over (PARTITION BY e.dept ORDER BY e.dept) dept_avg_sal,
ename, job
FROM EMP E
INNER JOIN DEPT D ON E.DEPT=D.DEPTNO
GROUP BY DNAME, LOC,ENAME,DEPT,DEPTNO,SAL,JOB
ORDER BY DEPTNO


--4.	Show the department number and the lowest salary of the department with the highest average salary

SELECT  DNAME DEPARTMENT_NAME,AVG(SAL) AVERAGE_HIGHEST_SALARY,MIN(SAL) MINIMUM_SALARY
FROM EMP E
INNER JOIN DEPT D ON E.DEPT=D.DEPTNO
GROUP BY DEPT,DNAME


--5.	Show the department numbers, names, and locations of the departments where no sales representatives work


SELECT DEPTNO,DNAME,LOC
FROM EMP E
INNER JOIN DEPT D ON E.DEPT=D.DEPTNO
WHERE JOB NOT LIKE '%SALES I%'
GROUP BY DNAME,DEPTNO,LOC


--method 2
SELECT DEPTNO,DNAME,LOC
FROM EMP E
INNER JOIN DEPT D ON E.DEPT=D.DEPTNO
WHERE DNAME NOT LIKE '%SALES%'
GROUP BY DNAME,DEPTNO,LOC


--6.	Show the department number, department name, and the number of employees working in each department that:
--a.   Includes fewer than 3 employees:
--b.   Has the highest number of employees:
--c.   Has the lowest number of employees:


--a: Includes fewer than 3 employees:
;WITH CTE
AS
(
SELECT DEPTNO,DNAME,COUNT(*) NO_OF_EMP
FROM EMP E
INNER JOIN DEPT D ON E.DEPT=D.DEPTNO
GROUP BY DEPTNO,DNAME
)
SELECT *
 FROM CTE
WHERE NO_OF_EMP<3


--b: Has the highest number of employees:
;WITH CTE
AS
(
SELECT DEPTNO,D.DNAME,D.LOC,COUNT(*) COUNTOFEMPLOYEES
FROM EMP E
INNER JOIN DEPT D ON E.DEPT=D.DEPTNO
GROUP BY DNAME,LOC,DEPTNO
)

SELECT TOP 1
    *,
    RANK() OVER (
        ORDER BY COUNTOFEMPLOYEES DESC
    ) myrank
FROM
    CTE;



--c: Has the lowest number of employees:
;WITH CTE
AS
(
SELECT DEPTNO,D.DNAME,D.LOC,COUNT(*) COUNTOFEMPLOYEES
FROM EMP E
INNER JOIN DEPT D ON E.DEPT=D.DEPTNO
GROUP BY DNAME,LOC,DEPTNO
)

SELECT TOP 1
    *,
    RANK() OVER (
        ORDER BY COUNTOFEMPLOYEES 
    ) myrank
FROM
    CTE;



--7.	Write a query to display the number of people with the same job
SELECT JOB,COUNT(*) NO_OF_EMP FROM EMP
GROUP BY JOB


--8.	Determine the number of managers without listing them. Label the column Number of
--Managers.  Hint: Use the MGR column to determine the number of managers
;WITH CTE
AS
(
SELECT DISTINCT MGR
FROM EMP
)
SELECT COUNT(MGR) NO_OF_MANAGERS
FROM CTE



--9.	Write a query that displays the difference between the highest and lowest salaries. Label the column DIFFERENCE
SELECT MAX(SAL) MAX_SAL, MIN(SAL) MIN_SAL, MAX(SAL)-MIN(SAL) DIFF
FROM EMP


--method 2
SELECT DEPT,MAX(SAL) MAX_SAL, MIN(SAL) MIN_SAL, MAX(SAL)-MIN(SAL) DIFF
FROM EMP
GROUP BY DEPT



--10.	Display the highest, lowest, sum, and average salary of all employees. 
--Label the columns Maximum, Minimum, Sum, and Average, respectively.  
--Round your results to the nearest whole number

SELECT ROUND(MAX(SAL),0) HIGHEST_SAL,ROUND(MIN(SAL),0) LOWEST_SAL,ROUND(AVG(SAL),0) AVG_SAL,ROUND(SUM(SAL),0) SUM_OF_SAL
FROM EMP



--method 2
SELECT DEPT, ROUND(MAX(SAL),0) HIGHEST_SAL,ROUND(MIN(SAL),0) LOWEST_SAL,ROUND(AVG(SAL),0) AVG_SAL,ROUND(SUM(SAL),0) SUM_OF_SAL
FROM EMP
GROUP BY DEPT
















