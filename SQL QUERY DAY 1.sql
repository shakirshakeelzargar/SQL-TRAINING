CREATE table emp1_shakir(EmpID INT PRIMARY KEY IDENTITY(1,1),EmpName VARCHAR(100),EmpSalary FLOAT, DeptID INT)
SELECT*FROM emp1_shakir
INSERT INTO emp1_shakir
SELECT 'Kristen',50000,2 UNION ALL
SELECT 'Julia',24567,3 UNION ALL
SELECT 'Rick',44555,NULL UNION ALL
SELECT 'Andrew',43346,NULL

CREATE TABLE dep1_shakir(depid INT PRIMARY KEY IDENTITY(1,1),deptname VARCHAR(100))
INSERT INTO dep1_shakir
SELECT 'software' UNION ALL
SELECT 'HR' UNION ALL
SELECT 'accounts' UNION ALL
SELECT 'QA' UNION ALL
SELECT 'Production'


SELECT*FROM dep1_shakir
SELECT*FROM emp1_shakir

SELECT*FROM emp1_shakir
INNER JOIN dep1_shakir ON emp1_shakir.deptid=dep1_shakir.depid

SELECT *
FROM emp1_shakir e
INNER JOIN dep1_shakir d on e.deptid=d.depid


SELECT *
FROM emp1_shakir e
full JOIN dep1_shakir d ON e.deptid=d.depid


SELECT *
FROM emp1_shakir e
full JOIN dep1_shakir d ON e.deptid=d.depid
WHERE d.depid IS NULL

SELECT *
FROM emp1_shakir e
full JOIN dep1_shakir d ON e.deptid=d.depid
WHERE e.empname IS NULL

ALTER TABLE emp1_shakir
ADD managerid INT

UPDATE  emp1_shakir
SET managerid=NULL
WHERE EMPid BETWEEN 3 AND 4

SELECT *
FROM emp1_shakir e
full JOIN dep1_shakir d ON e.deptid=d.depid
WHERE e.managerid IS NULL AND e.DeptID IS NOT NULL

ALTER TABLE emp1_shakir
ADD FOREIGN KEY (deptid) REFERENCES dep1_shakir(depid)

INSERT INTO emp1_shakir VALUES ('Jhon',99000,3,2)

ALTER TABLE emp1_shakir
ADD FOREIGN KEY (managerid) REFERENCES emp1_shakir(empid)
