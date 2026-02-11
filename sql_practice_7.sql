-- Databricks notebook source
-- MAGIC %md
-- MAGIC #### 191. List	the	emps	end	with	‘H’	all	together	5	chars.

-- COMMAND ----------

select * from emp where ename like '%____M'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 192. List	names	start	with	‘M’.

-- COMMAND ----------

select * from emp where ename like 'M%'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 193. List	the	emps	who	joined	in	the	year	81.

-- COMMAND ----------

select * from emp where year(hiredate) = '1981'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 194. List	the	emps	whose	sal	is	ending	with	00?

-- COMMAND ----------

select * from emp where sal like '%00'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 195. List	the	emp	who	joined	in	the	month	of	JAN

-- COMMAND ----------

select * from emp where month(hiredate) = '01'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 196. Who	joined	in	the	month	having	char	‘a’.

-- COMMAND ----------

select * from emp where date_format(hiredate, 'M') = '%A%'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 197. Who	joined	in	the	month	having	second	char	‘a’

-- COMMAND ----------

select * from emp where date_format(hiredate, 'MMMM') = '_A%'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 198. List	the	emps	whose	salary	is	4	digit	number.

-- COMMAND ----------

select * from emp where len(sal) = 4;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 199. List	the	emp	who	joined	in	80’s.

-- COMMAND ----------

select * from emp where year(hiredate) between '1980' and '1989'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 200. List	the	emp	who	are	clerks	who	have	exp	more	than	8ys.

-- COMMAND ----------


SELECT 
  ename,
  job,
  FLOOR(months_between(current_date(), date(hiredate)) / 12) AS exp_years
FROM emp
WHERE job = 'CLERK'
  AND months_between(current_date(), date(hiredate)) > 8 * 12;


-- COMMAND ----------

--Method 2

SELECT 
  ename,
  job,
  FLOOR(datediff(current_date(), date(hiredate)) / 365) AS exp_years
FROM emp
WHERE job = 'CLERK'
  AND datediff(current_date(), date(hiredate)) > 8 * 365
ORDER BY exp_years DESC, ename;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 201. List	the	mgrs	of	dept	10	or	20.

-- COMMAND ----------

select mgr from emp where deptno in(10, 20)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 202. List	the	emps	joined	in	jan	with	salary	ranging	from	1500	to	4000.

-- COMMAND ----------

select * from emp where month(hiredate) = '01' and sal between 1500 and 4000;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 203. List	the	unique	jobs	of	dept	20	and	30	in	desc	order.

-- COMMAND ----------

select distinct job from emp where deptno in(20, 30)
order by job desc;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 204. List	the	emps	along	with	exp	of	those	working	under	the	mgr	whose number	is	starting	with	7	but	should	not	have	a	9	joined	before	1983.

-- COMMAND ----------

select ename, datediff(current_date(), hiredate) as exp from emp
where mgr like '7%' and mgr not like '%9%'
and year(hiredate) <= '1981'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 205. List	the	emps	who	are	working	as	either	mgr	or	analyst	with	the	salary ranging	from	2000	to	5000	and	with	out	comm.

-- COMMAND ----------

select * from emp 
where job = 'MANAGER' OR job = 'ANALYST'
AND sal between 2000 and 5000
and comm is null;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 206. List	the	empno,ename,sal,job	of	the	emps	with	/ann	sal	<34000	but receiving	some	comm.	Which	should	not	be>sal	and	desg	should	be	sales	man working	for	dept	30.

-- COMMAND ----------

select empno, ename, sal, job, (12*sal) as annual_sal from emp 
where (12*sal) < 34000
and comm is not null
and comm < sal
and job = 'SALESMAN'
AND deptno = 30

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 207. List	the	emps	who	are	working	for	dept	10	or	20	with	desgs	as	clerk	or analyst	with	a	sal	is	either	3	or	4	digits	with	an	exp>8ys	but	does	not	belong	to mons	of	mar,apr,sep	and	working	for	mgrs	&no	is	not	ending	with	88	and	56.

-- COMMAND ----------

select * from emp
where deptno = 10 or deptno = 20
and job = 'CLERK' or job = 'ANALYST'
AND LEN(SAL) = 3 OR LEN(SAL) = 4
AND months_between(current_date(), DATE(hiredate)) > 8 *12
and MONTH(hiredate) NOT IN (3,4,9)
AND MGR NOT IN(88, 56)

--or 

-- COMMAND ----------

select * from emp
where deptno = 10 or deptno = 20
and job = 'CLERK' or job = 'ANALYST'
AND LEN(SAL) = 3 OR LEN(SAL) = 4
AND months_between(current_date(), DATE(hiredate)) > 8 *12
and MONTH(hiredate) NOT IN (3,4,9)
AND MGR NOT IN(88, 56)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 208. List	the	empno,ename,sal,job,deptno&exp	of	all	the	emps	belongs	to	dept 10	or	20	with	an	exp	6	to	10	y	working	under	the	same	mgr	with	out	comm. With	a	job	not	ending	irrespective	of	the	position	with	comm.>200	with exp>=7y	and	sal<2500	but	not	belongs	to	the	month	sep	or	nov	working	under the	mgr	whose	no	is	not	having	digits	either	9	or	0	in	the	asc	dept&	desc	dept?

-- COMMAND ----------

WITH base AS (
  SELECT
    empno,
    ename,
    sal,
    job,
    mgr,
    hiredate,
    comm,
    deptno,
    CAST(FLOOR(months_between(current_date, hiredate) / 12) AS INT) AS exp_years
  FROM Emp
),
set_a AS (
  SELECT 'A' AS set_id, empno, ename, sal, job, deptno, exp_years AS exp, mgr
  FROM base
  WHERE deptno IN (10, 20)
    AND exp_years BETWEEN 6 AND 10
    AND (comm IS NULL OR comm = 0)
    AND mgr IN (SELECT mgr FROM Emp GROUP BY mgr HAVING COUNT(*) > 1)
),
set_b AS (
  SELECT 'B' AS set_id, empno, ename, sal, job, deptno, exp_years AS exp, mgr
  FROM base
  WHERE lower(job) NOT LIKE '%man'
    AND comm > 200
    AND exp_years >= 7
    AND sal < 2500
    AND month(hiredate) NOT IN (9, 11)
    AND CAST(mgr AS STRING) NOT RLIKE '.*(9|0).*'
)
SELECT *
FROM (
  SELECT set_id, empno, ename, sal, job, deptno, exp, mgr FROM set_a
  UNION ALL
  SELECT set_id, empno, ename, sal, job, deptno, exp, mgr FROM set_b
) t
ORDER BY
  set_id,
  CASE WHEN set_id = 'A' THEN deptno END ASC,
  CASE WHEN set_id = 'B' THEN deptno END DESC,
  ename ASC;

-- COMMAND ----------

SELECT empno, ename, sal, job, deptno,
       YEAR(CURRENT_DATE) - YEAR(hiredate) AS emp
FROM emp
WHERE (deptno = 10 OR deptno = 20)
  AND (YEAR(CURRENT_DATE) - YEAR(hiredate)) BETWEEN 6 AND 10
  AND comm IS NULL
  AND job <> ''   -- specify the job you want to exclude
  AND (YEAR(CURRENT_DATE) - YEAR(hiredate)) >= 7
  AND sal < 2500
  AND MONTH(hiredate) NOT IN (9, 11)
  AND mgr NOT LIKE '%9%'
  AND mgr NOT LIKE '%0%'
ORDER BY deptno ASC;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 209. List	the	details	of	the	emps	working	at	Chicago.

-- COMMAND ----------

select e.* from emp e join dept d on e.deptno = d.deptno 
where d.loc = 'CHICAGO'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 210. List	the	empno,ename,deptno,loc	of	all	the	emps.

-- COMMAND ----------

select e.empno, e.ename, e.deptno, d.loc from emp e join dept d on e.deptno = d.deptno


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 211. List	the	empno,ename,loc,dname	of	all	the	depts.,10	and	20.

-- COMMAND ----------

select e.empno, e.ename, e.deptno, d.loc, d.dname from emp e join dept d on e.deptno = d.deptno
where d.deptno in (10, 20)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 212. List	the	empno,	ename,	sal,	loc	of	the	emps	working	at	Chicago	dallas with	an	exp>6ys.

-- COMMAND ----------

select e.empno, e.ename, e.sal, d.loc, d.dname from emp e join dept d on e.deptno = d.deptno
where d.loc in ('DALLAS', 'CHICAGO')
AND (year(current_date()) - year(e.hiredate))>6

-- COMMAND ----------

-- OR

SELECT
  e.empno,
  e.ename,
  e.sal,
  d.loc
FROM Emp e
JOIN Dept d
  ON e.deptno = d.deptno
WHERE upper(d.loc) IN ('DALLAS', 'CHICAGO')
  AND CAST(FLOOR(months_between(current_date, e.hiredate) / 12) AS INT) > 6
ORDER BY d.loc ASC, e.ename ASC;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 213. List	the	emps	along	with	loc	of	those	who	belongs	to	dallas	,newyork	with sal	ranging	from	2000	to	5000	joined	in	81.

-- COMMAND ----------

select e.*, d.loc from emp e join dept d on e.deptno = d.deptno
where d.loc = 'DALLAS' or d.loc = 'YEWYORK'
and e.sal between 2000 and 5000
and year(hiredate) = 1981;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 214. List	the	empno,ename,sal,grade	of	all	emps.

-- COMMAND ----------

select e.empno, e.ename, e.sal, s.grade from emp e join salgrade s on e.sal between s.losal and s.hisal

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 215. List	the	grade	2	and	3	emp	of	Chicago.

-- COMMAND ----------

select e.empno, e.ename, e.sal, s.grade from emp e join salgrade s on e.sal between s.losal and s.hisal
where s.grade between 2 and 3;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 216. List	the	emps	with	loc	and	grade	of	accounting	dept	or	the	locs	dallas	or Chicago	with	the	grades	3	to	5	&exp	>6y

-- COMMAND ----------

select e.*, d.loc, s.grade from emp e join dept d 
on e.deptno = d.deptno
join salgrade s on e.sal between s.losal and s.hisal
where e.job = 'ACCOUNT' 
OR d.loc = 'DALLAS' OR d.loc = 'CHICAGO'
AND s.grade between 3 and 5
and cast(floor(months_between(current_date(), e.hiredate) /12) as int) > 6;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 217. List	the	grades	3	emps	of	research	and	operations	depts..	joined	after	1987 and	whose	names	should	not	be	either	miller	or	allen.

-- COMMAND ----------

select e.*, d.loc, s.grade from emp e join dept d 
on e.deptno = d.deptno
join salgrade s on e.sal between s.losal and s.hisal
where d.dname IN ('RESEARCH', 'OPERATIONS')
AND YEAR(hiredate) = '1987'
and e.ename <> 'MILLER' OR e.ename <> 'ALLEN'  

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 218. List	the	emps	whose	job	is	same	as	smith.

-- COMMAND ----------

SELECT * from emp where job in (select job from emp where ename = 'SMITH')

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 219. List	the	emps	who	are	senior	to	miller.

-- COMMAND ----------

SELECT * from emp where hiredate < (select hiredate from emp where ename = 'MILLER')

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 220. List	the	emps	whose	job	is	same	as	either	allen	or	sal>allen.

-- COMMAND ----------

select * from emp where job = (select job from emp where ename = 'ALLEN')
OR SAL >(select SAL from emp where ename = 'ALLEN')
