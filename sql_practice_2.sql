-- Databricks notebook source
select * from emp

-- COMMAND ----------

select * from dept;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.31. List	all	the	emps	who	joined	before	or	after	1981.

-- COMMAND ----------


SELECT * FROM emp WHERE YEAR(hiredate) <> 1981;
--OR SELECT * FROM emp WHERE YEAR(hiredate) != 1981;
--OR SELECT * FROM emp WHERE YEAR(hiredate) not like 1981;
--OR SELECT * FROM emp WHERE YEAR(hiredate) not in 1981;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.32. List	the	emps	whose	Empno	not	starting	with	digit78.

-- COMMAND ----------

select * from emp where empno not like '78%'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.33. List	the	emps	who	are	working	under	‘MGR’

-- COMMAND ----------

SELECT e.empno, e.ename, e.job, e.mgr, e.hiredate, e.sal, e.comm, e.deptno
FROM emp e
JOIN emp m ON e.mgr = m.empno
WHERE m.job = 'MGR';

/*
--Note- if we write m.mgr = e.empno then its not correct
You're joining on m.mgr = e.empno, which means you're trying to find employees who are managers of someone whose manager is them — this logic is reversed.
You're essentially saying: “Find employees who are managers of managers whose job is 'MGR'”, which is not what you want.
This correctly:

Joins each employee e to their manager m using e.mgr = m.empno.
*/

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.34.List	the	emps	who	joined	in	any	year	but	not	belongs	to	the	month	of March.

-- COMMAND ----------


SELECT empno, ename, job, mgr, hiredate, sal, comm, deptno
FROM emp
WHERE MONTH(hiredate) <> 3;

--OR select * from emp where date_format(hiredate, 'MMMM') <> 'March'

--OR select * from emp WHERE date_format(CAST(hiredate AS DATE), 'MMMM') <> 'March';


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.35. List	all	the	Clerks of	Deptno	20.

-- COMMAND ----------

select * from emp where job = 'CLERK' and deptno = 20

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.36. List	the	emps	of	Deptno	30	or	10	joined	in	the	year	1981.

-- COMMAND ----------

select * from emp where deptno =  30 or deptno = 10 and year(hiredate) = 1981

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.37.Display	the	details	of	SMITH.

-- COMMAND ----------

select * from emp where ename = 'SMITH'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.38. Display	the	location	of SMITH.

-- COMMAND ----------

select loc from emp e
join dept d
on e.deptno = d.deptno
where e.ename = 'SMITH'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.39. List	the	total	information	of	EMP	table	along	with	DNAME	and	Loc	of all	the	emps	Working	Under	‘ACCOUNTING’	&	‘RESEARCH’	in	the	asc Deptno.

-- COMMAND ----------

select e.empno, e.ename, e.job, d.dname, d.loc from emp e
join dept d
on e.deptno = d.deptno
where d.dname in ('ACCOUNTING', 'RESEARCH') order by d.deptno asc


-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.40.	List	the	Empno,	Ename,	Sal,	Dname	of	all	the	‘MGRS’	and	‘ANALYST’ working	in	New	York,	Dallas	with	an	exp	more	than	7	years	without	receiving the	Comm	asc	order	of	Loc.

-- COMMAND ----------

SELECT e.empno, e.ename, e.sal, d.dname, e.job, d.loc
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE e.job IN ('MANAGER', 'ANALYST')
  AND d.loc IN ('New York', 'Dallas')
  AND (YEAR(current_date()) - YEAR(e.hiredate)) > 7
  AND e.comm IS NULL
ORDER BY d.loc ASC;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.41. Display	the	Empno,	Ename,	Sal,	Dname,	Loc,	Deptno,	Job	of	all	emps working	at	CHICAGO	or	working	for	ACCOUNTING	dept	with	Ann Sal>28000,	but	the	Sal	should	not	be=3000	or	2800	who	doesn’t	belongs	to	the Mgr	and	whose	no	is	having	a	digit	‘7’	or	‘8’	in	3rd	position	in	the	asc	order	of Deptno	and	desc	order	of	job

-- COMMAND ----------

--Method 1
select e.empno, e.ename, e.sal, d.dname, d.loc, e.deptno, e.job
from emp e join dept d
on e.deptno = d.deptno
where d.loc = 'CHICAGO' or d.dname = 'ACCOUNTING'
and e.sal*12 > 28000 and e.sal != 3000 or e.sal != 2800 
and e.job <> 'Manager'
and substring(e.empno, 3,1) in ('7','8') 
order by e.deptno asc, e.job desc

-- COMMAND ----------

--Method 2
select e.empno, e.ename, e.sal, d.dname, d.loc, e.deptno, e.job
from emp e join dept d
on e.deptno = d.deptno
where d.loc = 'CHICAGO' or d.dname = 'ACCOUNTING'
and e.sal*12 > 28000 and e.sal != 3000 or e.sal != 2800 
and e.job <> 'Manager'
and substring(cast(e.empno as string), 3,1) in ('7','8') 
order by e.deptno asc, e.job desc

-- COMMAND ----------

--Method 3
select e.empno, e.ename, e.sal, d.dname, d.loc, e.deptno, e.job
from emp e join dept d
on e.deptno = d.deptno
where (d.loc = 'CHICAGO' or d.dname = 'ACCOUNTING')
and e.sal*12 > 28000 and e.sal != 3000 or e.sal != 2800 
and e.job <> 'Manager'
and e.empno like '__7%' or e.empno like '__8%'
order by e.deptno asc, e.job desc

-- COMMAND ----------

CREATE TABLE salgrade (
    grade INT,
    losal INT,
    hisal INT
);

INSERT INTO salgrade VALUES (1, 700, 1200);
INSERT INTO salgrade VALUES (2, 1201, 1400);
INSERT INTO salgrade VALUES (3, 1401, 2000);
INSERT INTO salgrade VALUES (4, 2001, 3000);
select * from salgrade;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.42. Display	the	total	information	of	the	emps	along	with	Grades	in	the	asc order.

-- COMMAND ----------

select	*	from	emp	e	,salgrade	s	where	e.sal	between	s.losal	and	s.hisal		order
 by	grade	asc;

-- COMMAND ----------

select * from emp e, salgrade s
where e.sal > s.losal and e.sal < s.hisal
order by s.grade asc

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.43. List	all	the	Grade2	and	Grade	3	emps.

-- COMMAND ----------

select * from emp e, salgrade s where e.sal between s.losal and s.hisal and s.grade in (2,3)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.44. Display	all	Grade	4,5	Analyst	and	Mgr.

-- COMMAND ----------

select * from emp e, salgrade s 
where e.sal between s.losal and s.hisal
and e.job in ('MANAGER','ANALYST')
and s.grade in (4,5)


-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.45.	List	the	Empno,	Ename,	Sal,	Dname,	Grade,	Exp,	and	Ann	Sal	of	emps working	for	Dept10	or20.

-- COMMAND ----------

select e.empno, e.ename, e.sal, d.dname, s.grade, year(current_date) - year(e.hiredate) as exp, (e.sal*12) as annual_sal
from emp e inner join dept d
on e.deptno = d.deptno
inner join salgrade s
on e.sal between s.losal and s.hisal
where d.deptno = 10 or d.deptno =20

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.46. List	all	the	information	of	emp	with	Loc	and	the	Grade	of	all	the	emps belong	to	the	Grade	range	from	2	to	4	working	at	the	Dept	those	are	not	starting with	char	set	‘OP’	and	not	ending	with	‘S’	with	the	designation	having	a	char	‘a’ any	where	joined	in	the	year	1981	but	not	in	the	month	of	Mar	or	Sep	and	Sal not	end	with	‘00’	in	the	asc	order	of	Grades

-- COMMAND ----------

--Method 1
SELECT e.empno, e.ename, e.job, e.sal, e.hiredate, d.loc, s.grade
FROM emp e
JOIN dept d ON e.deptno = d.deptno
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE s.grade IN (2, 3, 4)
  AND d.dname NOT LIKE 'OP%'
  AND d.dname NOT LIKE '%S'
  AND e.job ILIKE '%a%'                -- designation contains 'a'
  AND YEAR(e.hiredate) = 1981          -- joined in 1981
  AND MONTH(e.hiredate) NOT IN (3, 9)  -- not March or September
  AND CAST(e.sal AS STRING) NOT LIKE '%00' -- salary not ending with 00
ORDER BY s.grade ASC;


-- COMMAND ----------

--Method 2
select e.*, d.loc, s.grade 
from emp e join dept d
on e.deptno = d.deptno
join salgrade s
on e.sal between s.losal and s.hisal
where s.grade in (2,3,4)
and d.dname not like 'OP%'
and d.dname not like '%S'
and e.job like '%A%'
and year(e.hiredate) = 1981
and month(e.hiredate) not in (3,9) 
and (e.sal) not like '%00'
order by s.grade asc 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.47 List	the	details	of	the	Depts	along	with	Empno,	Ename	or	without	the emps
-- MAGIC  

-- COMMAND ----------

SELECT
    d.deptno,
    d.dname,
    d.loc,
    e.empno,
    e.ename
FROM Dept d
LEFT JOIN Emp e
ON d.deptno = e.deptno
ORDER BY d.deptno;

--this can be achieved using left join so that all departments are listed, even if they have no employees. Here’s the query:

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.48 List	the	details	of	the	emps	whose	Salaries	more	than	the	employee BLAKE.

-- COMMAND ----------

select * from emp where sal > (select sal from emp where ename = 'BLAKE')

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.49.List	the	emps	whose	Jobs	are	same	as	ALLEN.

-- COMMAND ----------

SELECT * FROM EMP WHERE JOB = (SELECT job from emp where ename = 'ALLEN')

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.50. List	the	emps	who	are	senior	to	King.

-- COMMAND ----------

select * from emp where hiredate>(select hiredate from emp where ename = 'KING')

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.51.	List	the	Emps	who	are	senior	to	their	own	MGRS.

-- COMMAND ----------

SELECT
    e.empno AS EmployeeNo,
    e.ename AS EmployeeName,
    e.hiredate AS EmployeeHireDate,
    m.empno AS ManagerNo,
    m.ename AS ManagerName,
    m.hiredate AS ManagerHireDate
FROM Emp e
JOIN Emp m
ON e.mgr = m.empno
WHERE e.hiredate < m.hiredate
ORDER BY e.hiredate;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.52.List	the	Emps	of	Deptno	20	whose	Jobs	are	same	as	Deptno10.

-- COMMAND ----------

select empno, ename, job, deptno from emp where deptno = 20 
and job in (select job from emp where deptno = 10)


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.53.List	the	Emps	whose	Sal	is	same	as	FORD	or	SMITH	in	desc	order	of Sal.

-- COMMAND ----------

select * from emp where sal in (select sal from emp where (ename = 'FORD' or ename = 'SMITH')) order by sal desc

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.54. List	the	emps	Whose	Jobs	are	same	as	MILLER	or	Sal	is	more	than ALLEN.

-- COMMAND ----------

select * from emp where job in(select job from emp where ename = 'MILLER') 
or sal >(select sal from emp where ename = 'ALLEN')

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.55. List	the	Emps	whose	Sal	is	>	the	total	remuneration	of	the	SALESMAN.

-- COMMAND ----------

SELECT *
FROM emp 
WHERE sal > (
    SELECT SUM(sal + COALESCE(comm, 0)) AS total_remuneration
    FROM emp 
    WHERE job = 'SALESMAN'
);

/*
sal: This is the employee's base salary.
comm: This is the commission (extra earnings), which can be NULL for many employees.
COALESCE(comm, 0):

COALESCE is a SQL function that returns the first non-NULL value from its arguments.
So if comm is NULL, it will return 0 instead.
This prevents errors and ensures the calculation works even when commission is missing.

*/

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.56.	List	the	emps	who	are	senior	to	BLAKE	working	at	CHICAGO	& BOSTON.

-- COMMAND ----------

SELECT
    e.empno,
    e.ename,
    e.job,
    e.hiredate,
    d.dname,
    d.loc
FROM Emp e
JOIN Dept d ON e.deptno = d.deptno
WHERE e.hiredate < (
    SELECT hiredate 
    FROM Emp 
    WHERE ename = 'BLAKE'
)
AND d.loc IN ('CHICAGO', 'BOSTON')
ORDER BY e.hiredate;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.57.	List	the	Emps	of	Grade	3,4	belongs	to	the	dept	ACCOUNTING	and RESEARCH	whose	Sal	is	more	than	ALLEN	and	exp	more	than	SMITH	in	the asc	order	of	EXP.

-- COMMAND ----------

SELECT e.empno, e.ename, e.job, e.sal, e.hiredate, d.dname, s.grade
FROM Emp e
JOIN Dept d ON e.deptno = d.deptno
JOIN Salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE s.grade IN (3, 4)
  AND d.dname IN ('ACCOUNTING', 'RESEARCH')
  AND e.sal > (SELECT sal FROM Emp WHERE ename = 'ALLEN')
  AND e.hiredate < (SELECT hiredate FROM Emp WHERE ename = 'SMITH')
ORDER BY e.hiredate ASC;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.58. List	the	emps	whose	jobs	same	as	SMITH	or	ALLEN.

-- COMMAND ----------

select * from emp where job in (select job from emp where ename = 'SMITH' OR ename = 'ALLEN')

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.59.Write	a	Query	to	display	the	details	of	emps	whose	Sal	is	same	as	of
-- MAGIC * 1-Employee	Sal	of	EMP1	table.
-- MAGIC * 2-  ¾	Sal	of	any	Mgr	of	EMP2	table.
-- MAGIC * 3- The	sal	of	any	person	with	exp	of	5	years	belongs	to	the	sales	dept	of	emp3 table.
-- MAGIC * 4- Any	grade	2	employee	of	emp4	table.
-- MAGIC * 5- Any	grade	2	and	3	employee	working	fro	sales	dept	or	operations	dept joined	in	89.

-- COMMAND ----------

--Q1- 1-Employee Sal of EMP1 table.

select * from emp where sal in (select sal from emp1)

-- COMMAND ----------

--2- ¾ Sal of any Mgr of EMP2 table.

select * from emp where sal in (select sal * 0.75 from emp2 where job = 'MANAGER')

-- COMMAND ----------

--3- The sal of any person with exp of 5 years belongs to the sales dept of emp3 table.

SELECT * from emp where sal in (select sal from emp e3 join dept d on e3.deptno = d.deptno
where d.dname = 'SALES' and year(hiredate = 5))

or

SELECT * from emp where sal in (select sal from emp e3 join dept d on e3.deptno = d.deptno
where d.dname = 'SALES' and datediff(current_date(), e.hiredate)/365>=5)

-- COMMAND ----------

--4- Any grade 2 employee of emp4 table.

select * from emp where sal in (select e.sal from emp4 e join salgrade s on e.sal between s.losal and s.hisal where s.grade = 2;

-- COMMAND ----------

--5- Any grade 2 and 3 employee working from sales dept or operations dept joined in 89.

select * from emp where sal in(select e.sal from emp e join dept d on e.deptno = d.deptno
join gradesal s on e.sal between s.locsal and s.hisal where s.grade in (2,3)
and d.name in ('sales')

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.60.	Any	jobs	of	deptno	10	those	that	are	not	found	in	deptno	20.

-- COMMAND ----------

select job from emp deptno = 10 
except
select job from emp where deptno = 20; 
