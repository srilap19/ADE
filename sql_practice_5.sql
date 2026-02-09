-- Databricks notebook source
-- MAGIC %md
-- MAGIC #### 130. List	the	emps	with	Hire	date	in	format	June	4,	1988.

-- COMMAND ----------

select ename, date_format(hiredate, 'MM-dd-yyyy') as hiredate from emp

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 131. Print	a	list	of	emp’s	Listing	‘just	salary’	if	Salary	is	more	than	1500,	on target	if	Salary	is	1500	and	‘Below	1500’	if	Salary	is	less	than	1500.

-- COMMAND ----------

select ename, 
  case
    when sal > 1500 then 'just salary'
    when sal = 1500 then 'on target'
    when sal < 1500 then '1500'
    --else 'nothing'
  end as sal_status
from emp

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 132 Write	a	query	which	return	the	day	of	the	week	for	any	date	entered	in format	‘DD-MM-YY’.

-- COMMAND ----------

select ename, dayofweek(hiredate) as dayofweek from emp

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 133.	Write	a	query	to	calculate	the	length	of	service	of	any	employee	with	the company

-- COMMAND ----------

select *, datediff(current_date(), hiredate) as joindate from emp;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 135. Emps	hired	on	or	before	15th	of	any	month	are	paid	on	the	last	Friday	of that	month	those	hired	after	15th	are	paid	on	the	first	Friday	of	the	following month.	Print	a	list	of	emps	their	hire	date	and	the	first	pay	date.	Sort	on	hire	date.

-- COMMAND ----------

SELECT
  e.ename,
  date_format(e.hiredate, 'yyyy-MM-dd') AS hire_date,
  date_format(
    CASE
      WHEN dayofmonth(e.hiredate) <= 15
        THEN next_day(date_add(last_day(e.hiredate), -7), 'FRI')
      ELSE next_day(date_add(date_add(last_day(e.hiredate), 1), -1), 'FRI')
    END,
    'yyyy-MM-dd'
   ) AS first_pay_date
FROM Emp e
WHERE e.hiredate IS NOT NULL

/*
last_day(date): gives the last day of the month for date.
date_add(date, n): adds n days (can be negative to subtract).
next_day(date, 'FRI'): returns the next Friday strictly after date.

Goal: Get the last Friday of the same month.
Why it works

last_day(e.hiredate) → last calendar day of that month (e.g., if hiredate = 2025-12-10, last_day = 2025-12-31).
date_add(..., -7) → go back one week to 2025-12-24.
next_day(..., 'FRI') → find the next Friday after 2025-12-24, which is 2025-12-26.

Because we started one week before month end, the “next Friday” we hit is guaranteed to be the final Friday of that month.
Mini example

Month end: Dec 31, 2025 (Wednesday)
Back 7 days: Dec 24, 2025 (Wednesday)
Next Friday after Dec 24: Dec 26, 2025 → last Friday of Dec 2025 ✅
*/

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 36. Count	the	no.	of	characters	with	out	considering	spaces	for	each	name.

-- COMMAND ----------

select ename,
length(replace(ename, " ", "")) as char_count from emp;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 137. Find	out	the	emps	who	are	getting	decimal	value	in	their	Sal	without	using like	operator.

-- COMMAND ----------

select ename from emp 
where sal is not null
and cast(sal as string) like '%.%'

-- COMMAND ----------


-- Employees whose salary has a fractional (decimal) part
SELECT
  ename,
  sal
FROM Emp
WHERE sal IS NOT NULL
  AND MOD(sal, 1) <> 0;      -- fractional part exists


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 138. List	those	emps	whose	Salary	contains	first	four	digit	of	their	Deptno.

-- COMMAND ----------

select e.ename 
from emp e join dept d on e.deptno = d.deptno
where e.sal in (select e.sal from emp e where e.sal = substring(d.deptno, 1,4))

-- COMMAND ----------


SELECT
  e.ename,
  e.sal,
  d.deptno
FROM Emp e
JOIN Dept d
  ON e.deptno = d.deptno
WHERE REPLACE(CAST(e.sal AS STRING), '.', '') LIKE CONCAT(SUBSTRING(CAST(d.deptno AS STRING), 1, 4), '%');

/*

Convert both sal and deptno to strings.
Take the first 4 characters of deptno (if it has fewer than 4, this just takes all its digits).
Check if the salary string contains that substring.
*/

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 138. List those emps whose Salary contains last four digit of their Deptno.

-- COMMAND ----------


-- Employees whose salary contains the last 4 digits of their deptno
SELECT
  e.ename,
  e.sal,
  d.deptno
FROM Emp e
JOIN Dept d
  ON e.deptno = d.deptno
WHERE REPLACE(CAST(e.sal AS STRING), '.', '') LIKE CONCAT('%', RIGHT(CAST(d.deptno AS STRING), 4), '%');

/*
RIGHT(CAST(d.deptno AS STRING), 4) → last four digits of deptno.
REPLACE(CAST(e.sal AS STRING), '.', '') → salary digits without the decimal point.
LIKE '%…%' → checks if those four digits appear anywhere in the salary

*/

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 139. List	those	Managers	who	are	getting	less	than	his	emps	Salary.

-- COMMAND ----------

select m.ename as mgrname, e.ename as empname, e.sal, m.sal
from emp e join emp m
on e.mgr = m.empno
where m.sal < e.sal

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 140. Print	the	details	of	all	the	emps	who	are	sub-ordinates	to	Blake.

-- COMMAND ----------


-- Direct reports of Blake
SELECT e.*
FROM Emp e
JOIN Emp m
  ON e.mgr = m.empno
WHERE m.ename = 'BLAKE';  --


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 41. List	the	emps	who	are	working	as	Managers	using	co-related	sub-query.

-- COMMAND ----------

select e.ename as empname, m.ename as manager_name
from emp e join emp m 
on e.mgr = m.empno 
where m.ename = 'mgr'

-- COMMAND ----------

select e.ename as empname, m.ename as manager_name
from emp e join emp m 
on e.mgr = m.empno 
where m.ename in (select e.ename from emp e where e.ename = 'mgr')

-- COMMAND ----------

select	*	from	emp	where	empno	in	(select	mgr	from	emp)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 42.	List	the	emps	whose	Mgr	name	is	‘Jones’	and	also	with	his	Manager name.

-- COMMAND ----------

select e.ename as empname, m.ename as manager_name
from emp e join emp m 
on e.mgr = m.empno
where m.ename = "JONES"

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 144. Find	out	how	may	Managers	are	their	in	the	company.

-- COMMAND ----------

select count(*) from emp where job = 'MANAGER'


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 145. Find	Average	salary	and	Average	total	remuneration	for	each	Job	type. Remember	Salesman	earn	commission.secommm

-- COMMAND ----------

select job, avg(sal) as avg_Sal, 
avg(case 
  when upper(job) = 'SALESMAN' THEN sal + coalesce(comm, 0)
  else sal
  end) as avg_sal from emp
group by job
order by job

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 46. Check	whether	all	the	emps	numbers	are	indeed	unique.

-- COMMAND ----------

select empno, count(*) from emp group by empno having count(*)>1;

-- COMMAND ----------

SELECT
  CASE
    WHEN EXISTS (
      SELECT empno
      FROM Emp
      GROUP BY empno
      HAVING COUNT(*) > 1
    ) THEN 'Duplicates Found'
    ELSE 'All empnos are unique'
  END AS result

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 147. List	the	emps	who	are	drawing	less	than	1000	Sort	the	output	by	Salary.

-- COMMAND ----------

select empno from emp where empno in(select empno from emp where sal<1000 order by sal asc)

-- COMMAND ----------

select empno from emp where sal < 1000 order by empno asc;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 148. List	the	employee	Name,	Job,	Annual	Salary,	deptno,	Dept	name	and grade	who	earn	36000	a	year	or	who	are	not	CLERKS.

-- COMMAND ----------

SELECT e.ename,
       e.job,
       d.dname,
       (12*e.sal) as annual_sal,
       d.deptno,
       s.grade
FROM emp e
JOIN dept d ON e.deptno = d.deptno
JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
where (12*e.sal) = '36000'
or 
e.job <> 'CLAARK'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 149. Find	out	the	Job	that	was	filled	in	the	first	half	of	1983	and	same	job	that was	filled	during	the	same	period	of	1984.

-- COMMAND ----------

select job, hiredate
from emp
where hiredate between date('1983-01-01') and date('1983-01-30')

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 150. Find	out	the	emps	who	joined	in	the	company	before	their	Managers

-- COMMAND ----------

select e.ename as empname, m.ename as mgr_name, e.hiredate, m.hiredate
from emp e join emp m 
on e.mgr = m.empno
where e.hiredate <  m.hiredate;
