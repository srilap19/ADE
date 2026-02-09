-- Databricks notebook source
-- DBTITLE 1,Cell 1
use sql_catalog.sql_schema

-- COMMAND ----------

--%sql
CREATE TABLE emp (
    empno INT,
    ename STRING,
    job STRING,
    mgr INT,
    hiredate DATE,
    sal INT,
    comm INT,
    deptno INT
);

INSERT INTO emp VALUES
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600, 300, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250, 500, 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250, 1400, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1982-12-09', 3000, NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500, 0, 30),
(7876, 'ADAMS', 'CLERK', 7788, '1983-01-12', 1100, NULL, 20),
(7900, 'JAMES', 'CLERK', 7698, '1981-12-03', 950, NULL, 30),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000, NULL, 20),
(7934, 'MILLER', 'CLERK', 7782, '1982-01-23', 1300, NULL, 10);
select * from emp;

-- COMMAND ----------

--%sql    --Department table
CREATE TABLE dept (
    deptno INT,
    dname STRING,
    loc STRING
);

INSERT INTO dept VALUES
(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO'),
(40, 'OPERATIONS', 'BOSTON');
select * from dept;

-- COMMAND ----------

select * from dept;

-- COMMAND ----------

select * from salgrade;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####Q 2.1. Display all the information of the EMP table?[](url)

-- COMMAND ----------

select * from emp;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### Q 2.2. Display unique Jobs from EMP table?

-- COMMAND ----------

-- DBTITLE 1,Cell 9
select distinct job from emp;
--select unique job from emp;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.3. List the emps in the asc order of their Salaries?
-- MAGIC

-- COMMAND ----------

select * from emp order by sal asc

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.4. List the details of the emps in asc order of the Dptnos and desc of
-- MAGIC Jobs?

-- COMMAND ----------

select * from sql_catalog.sql_schema.emp order by deptno asc, job desc;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.5. Display all the unique job groups in the descending order?
-- MAGIC

-- COMMAND ----------

select distinct job from emp order by job desc;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.6. Display all the details of all ‘Mgrs’

-- COMMAND ----------

select * from emp where empno in(select mgr from emp) 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.7. List the emps who joined before 1981.
-- MAGIC

-- COMMAND ----------

select * from emp where hiredate < '1981-01-01'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.8. List the Empno, Ename, Sal, Daily sal of all emps in the asc order of
-- MAGIC Annualsal.
-- MAGIC

-- COMMAND ----------

select empno ,ename ,sal,sal/30,sal*12 as Annualsal from emp order by Annualsal asc;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.9. Display the Empno, Ename, job, Hiredate, Exp of all Mgrs

-- COMMAND ----------

-- finding the exp in months
select empno, ename, job, hiredate, months_between(current_date, hiredate) as exp_in_months
from emp where empno in (select mgr from emp)

-- COMMAND ----------

-- finding the exp in years
select empno, ename, job, hiredate, round(months_between(current_date, hiredate)/12, 2) as exp_years
from emp where empno in (select mgr from emp)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.10. List the Empno, Ename, Sal, Exp of all emps working for Mgr 7369.
-- MAGIC

-- COMMAND ----------

select empno, ename, sal, round(months_between(current_date, hiredate)/12,2) as exp 
from emp where mgr = 7369;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.11. Display all the details of the emps whose Comm. Is more than their Sal.
-- MAGIC

-- COMMAND ----------

select * from emp where comm > sal

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.12. List the emps in the asc order of Designations of those joined after the second half of 1981.
-- MAGIC

-- COMMAND ----------

select * from emp
where hiredate > '1981-06-30'
order by job asc;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.13. List the emps along with their Exp and Daily Sal is more than Rs.100.
-- MAGIC

-- COMMAND ----------


SELECT 
    empno,ename, job, hiredate,sal, 
    ROUND((sal / 30), 2) AS daily_sal,
    ROUND(MONTHS_BETWEEN(current_date, hiredate) / 12, 2) AS exp_years
FROM Emp
WHERE (sal / 30) > 100;

--OR 

select empno,ename, job, hiredate,sal,year(current_date)- year(hiredate) as exp, round((sal/30), 2) AS daily_sal from emp where (sal/30) >100;



-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.14. List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order

-- COMMAND ----------

select * from emp where job = 'CLERK' OR job = 'ANALYST' ORDER BY job desc

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.15. List the emps who joined on 1-MAY-81,3-DEC-81,17-DEC-81,19-JAN80 in asc order of seniority.
-- MAGIC

-- COMMAND ----------

select * from emp where hiredate IN ('1981-05-01', '1981-12-03', '1981-12-17', '1980-01-19') order by hiredate asc;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.16. List the emp who are working for the Deptno 10 or20.

-- COMMAND ----------

select * from emp where deptno = 10 or deptno = 20

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.17. List the emps who are joined in the year 81.
-- MAGIC

-- COMMAND ----------

select * from emp where year(hiredate) = '1981'
--OR 
select * from emp where hiredate between '1981-01-01' and '1981-12-31';

--OR

SELECT * FROM emp
WHERE hiredate BETWEEN TO_DATE('01-jan-81', 'dd-MMM-yy') 
                  AND TO_DATE('31-dec-81', 'dd-MMM-yy');

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.18. List the emps who are joined in the month of Aug 1980.
-- MAGIC

-- COMMAND ----------

--Option 1: Using MONTH() and YEAR():
select * from emp where month(hiredate) = '8' and year(hiredate) = '1980'

-- COMMAND ----------


--Option 2: Using BETWEEN with date range:
select * from emp where hiredate between '1980-08-01' and '1980-08-31';

--OR


SELECT * FROM emp
WHERE hiredate BETWEEN DATE('1980-08-01') AND DATE('1980-08-31');


-- COMMAND ----------

-- Option 3: Using TO_DATE() with custom format:

SELECT *FROM emp
WHERE hiredate BETWEEN TO_DATE('01-aug-80', 'dd-MMM-yy') 
                  AND TO_DATE('31-aug-80', 'dd-MMM-yy');


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.19. List the emps Who Annual sal ranging from 22000 and 45000.

-- COMMAND ----------

select * from emp where sal*12 between '22000' and '45000'

--OR

select * from emp where 12*sal between 22000 and 45000

--OR

SELECT empno, ename, job, hiredate, sal, (sal * 12) AS annual_sal
FROM emp
WHERE (sal * 12) BETWEEN 22000 AND 45000;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.20. List the Enames those are having five characters in their Names.
-- MAGIC

-- COMMAND ----------

select ename from emp where length(ename) = 5; 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.21.					
-- MAGIC List	the	Enames	those	are	starting	with	‘S’	and	with	five	characters.

-- COMMAND ----------

select ename from emp where where ename like 'S%' and length(ename) = 5; 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.22.					
-- MAGIC List	the	emps	those	are	having	four	chars	and	third	character	must	be	‘r’.

-- COMMAND ----------

select * from emp where length(ename) = 4 and ename like '__R%';

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.23.					
-- MAGIC List	the	Five	character	names	starting	with	‘S’	and	ending	with	‘H’.

-- COMMAND ----------

select * from	emp	where	length(ename)	=	5	and	ename	like	'S%H'
--OR
select * from	emp	where	length(ename)	=	5	and	ename	like	'S%' and	ename	like	'%H'

-- COMMAND ----------

select * from	emp	where	length(ename)	=	5	and	ename	like	'S%H'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.24. List	the	emps	who	joined	in	January.

-- COMMAND ----------


SELECT *
FROM emp
WHERE hiredate BETWEEN DATE('1981-01-01') AND DATE('1981-01-31');

--OR

select * from emp where month(hiredate) = 1


-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.25.	List	the	emps	who	joined	in	the	month	of	which	second	character	is	‘a’.

-- COMMAND ----------


SELECT *
FROM emp
WHERE SUBSTRING(date_format(hiredate, 'MMMM'), 2, 1) = 'a'

-- date_format(hiredate, 'MMMM'): Converts the hiredate into the full month name (e.g., "January", "February").
--SUBSTRING(..., 2, 1):

--The first argument (2) is the starting position — so it starts from the second character of the month name.
--The second argument (1) is the length — it extracts 1 character starting from position 2.



--So:

/*For "January" → second character is 'a'
For "March" → second character is 'a'
For "May" → second character is 'a'
*/


-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.26. List	the	emps	whose	Sal	is	four	digit	number	ending	with	Zero.

-- COMMAND ----------

select * from emp where length(sal) = 4 and sal like '%0';

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.27.	List	the	emps	whose	names	having	a	character	set	‘ll’	together.

-- COMMAND ----------

select * from emp where ename like '%LL%'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.28.	List	the	emps	those	who	joined	in	80’s.

-- COMMAND ----------

select * from emp where year(hiredate) = '80'

--OR

select * from	emp	where	to_date(hiredate,'yy') like	'80%';

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.29.	List	the	emps	who	does	not	belong	to	Deptno	20.

-- COMMAND ----------

select * from emp where deptno != 20

--OR select * from emp where deptno not like 20 

--OR select * from emp where deptno not in (20)

--OR select * from emp where deptno <> 20 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.30.	List	all	the	emps	except	‘PRESIDENT’	&	‘MGR”	in	asc	order	of Salaries.

-- COMMAND ----------

select * from emp where job not in ('PRESIDENT', 'MANAGER') order by sal asc

--OR select * from emp where job not like 'PRESIDENT' and job not like 'MANAGER' order by sal asc

--OR select * from emp where job != 'PRESIDENT' and job <> 'MANAGER' order by sal asc
