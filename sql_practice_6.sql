-- Databricks notebook source
-- MAGIC %md
-- MAGIC #### 151. List	all	the	emps	by	name	and	number	along	with	their	Manager’s	name and	number.	Also	List	KING	who	has	no	‘Manager’.

-- COMMAND ----------

select e.ename, m.ename, e.empno, m.empno
from emp e join emp m
on e.mgr = m.empno

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 152. Find	all	the	emps	who	earn	the	minimum	Salary	for	each	job	wise	in ascending	order.

-- COMMAND ----------

select * from emp where sal in (select min(sal) from emp group by job)
order by sal asc

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 153. Find	out	all	the	emps	who	earn	highest	salary	in	each	job	type.	Sort	in descending	salary	order.

-- COMMAND ----------

select * from emp where sal in(select max(sal) from emp group by job)
order by sal desc

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 154. Find	out	the	most	recently	hired	emps	in	each	Dept	order	by	Hiredate.

-- COMMAND ----------

select * from emp where hiredate in (select max(hiredate) from emp group by deptno)
order by hiredate

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 155. List	the	employee	name,Salary	and	Deptno	for	each	employee	who	earns a	salary	greater	than	the	average	for	their	department	order	by	Deptno.

-- COMMAND ----------

select ename, sal, deptno
from emp e
where sal > (
  select avg(sal)
  from emp
  where deptno = e.deptno
)
order by deptno

-- COMMAND ----------

SELECT ename, sal, deptno
FROM Emp e
WHERE sal > (
  SELECT AVG(sal)
  FROM Emp
  WHERE deptno = e.deptno AND sal IS NOT NULL
)
ORDER BY deptno, sal DESC;

/*
The inner query calculates the average salary for the department of the current employee.
deptno = e.deptno is the correlation: it links the inner query to the outer query’s current row.
This is called a correlated subquery, because the inner query depends on a value from the outer query.

So, for each employee e, the subquery runs:

SELECT AVG(sal) FROM Emp WHERE deptno = <that employee's deptno>
*/

-- COMMAND ----------

SELECT e.ename, e.sal, e.deptno
FROM Emp e join emp d on e.deptno = d.deptno
WHERE e.sal > (
  SELECT AVG(sal)
  FROM Emp
  WHERE d.deptno = e.deptno AND sal IS NOT NULL
)
ORDER BY deptno, sal DESC;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 156. List	the	Deptno	where	there	are	no	emps.

-- COMMAND ----------


SELECT d.deptno
FROM Dept d
LEFT JOIN Emp e
  ON e.deptno = d.deptno
GROUP BY d.deptno
HAVING COUNT(e.empno) = 0;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 157. List	the	No.of	emp’s	and	Avg	salary	within	each	department	for	each	job.

-- COMMAND ----------

select count(*), avg(sal) from emp
group by deptno, job

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 158. Find	the	maximum	average	salary	drawn	for	each	job	except	for ‘President’.

-- COMMAND ----------


-- Maximum of job-level average salaries, excluding 'PRESIDENT'
SELECT MAX(avg_sal) AS max_avg_sal
FROM (
  SELECT AVG(sal) AS avg_sal
  FROM Emp
  WHERE UPPER(job) <> 'PRESIDENT'
       AND sal IS NOT NULL
  GROUP BY job
)

-- COMMAND ----------


WITH job_avgs AS (
  SELECT
    job,
    AVG(sal) AS avg_sal
   FROM Emp
  WHERE UPPER(job) <> 'PRESIDENT' AND sal IS NOT NULL
  GROUP BY job
),
ranked AS (
  SELECT
    job,
    avg_sal,
    DENSE_RANK() OVER (ORDER BY avg_sal DESC) AS rnk
  FROM job_avgs
)
SELECT job, avg_sal
FROM ranked


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 159. Find	the	name	and	Job	of	the	emps	who	earn	Max	salary	and	Commission.

-- COMMAND ----------

select * from emp where sal = (select max(sal) from emp)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 160. List	the	Name,	Job	and	Salary	of	the	emps	who	are	not	belonging	to	the department	10	but	who	have	the	same	job	and	Salary	as	the	emps	of	dept	10.

-- COMMAND ----------

select ename, job, sal from emp where deptno <> 10
and job in (select job from emp where deptno = 10)
and sal in (select sal from emp where deptno = 10)

-- COMMAND ----------


SELECT e.ename, e.job, e.sal
FROM Emp e
JOIN (
  SELECT DISTINCT job, sal
  FROM Emp
  WHERE deptno = 10
) d10
  ON d10.job = e.job
 AND d10.sal = e.sal
WHERE e.deptno <> 10
ORDER BY e.deptno, e.job, e.sal, e.ename;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 161. List	the	Deptno,	Name,	Job,	Salary	and	Sal+Comm	of	the	SALESMAN who	are	earning	maximum	salary	and	commission	in	descending	order.

-- COMMAND ----------

select d.deptno, e.ename, e.job, e.sal, max(e.sal+e.comm) as sal_com
from emp e join dept d
on e.deptno = d.deptno
where e.job='SALESMAN'
and e.sal in (select max(sal+comm) from emp)
group by d.deptno, e.ename, e.job, e.sal
order by max(sal+comm) desc

-- COMMAND ----------


SELECT 
  d.deptno,
  e.ename,
  e.job,
  e.sal,
  (e.sal + COALESCE(e.comm, 0)) AS sal_com
FROM emp e
JOIN dept d
  ON e.deptno = d.deptno
WHERE e.job = 'SALESMAN'
  AND (e.sal + COALESCE(e.comm, 0)) = (
        SELECT MAX(sal + COALESCE(comm, 0))
        FROM emp
        WHERE job = 'SALESMAN'
      )
ORDER BY sal_com DESC;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 162. List	the	Deptno,	Name,	Job,	Salary	and	Sal+Comm	of	the	emps	who	earn the	second	highest	earnings	(sal	+	comm.).

-- COMMAND ----------


WITH comp AS (
  SELECT
    e.empno,
    e.ename,
    e.job,
    e.deptno,
    e.sal,
    (e.sal + COALESCE(e.comm, 0)) AS total_comp,
    DENSE_RANK() OVER (ORDER BY (e.sal + COALESCE(e.comm, 0)) DESC) AS rnk
  FROM emp e
)
SELECT
  c.deptno,
  c.ename AS name,
  c.job,
  c.sal AS salary,
  c.total_comp AS sal_plus_comm
FROM comp c
WHERE c.rnk = 2
ORDER BY c.total_comp DESC, c.deptno, c.ename;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 163. List	the	Deptno	and	their	average	salaries	for	dept	with	the	average	salary less	than	the	averages	for	all	department

-- COMMAND ----------


WITH dept_avg AS (
  SELECT deptno, AVG(sal) AS avg_salary
  FROM emp
  GROUP BY deptno
)
SELECT d.deptno, dp.dname, d.avg_salary
FROM dept_avg d
JOIN dept dp ON d.deptno = dp.deptno
WHERE d.avg_salary < (SELECT AVG(sal) FROM emp)
ORDER BY d.avg_salary ASC, d.deptno;


-- COMMAND ----------

	select	deptno,avg(sal)	from	emp	group	by	deptno
having	avg(sal)	<(select	avg(Sal)	from	emp);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 164. List	out	the	Names	and	Salaries	of	the	emps	along	with	their	manager names	and	salaries	for	those	emps	who	earn	more	salary	than	their	Manager.

-- COMMAND ----------

select e.ename, e.sal, m.mgr, m.sal 
from emp e 
join emp m on e.mgr = m.empno 
where e.sal > m.sal

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 165. List	out	the	Name,	Job,	Salary	of	the	emps	in	the	department	with	the highest	average	salary.

-- COMMAND ----------

select e.ename, e.job, e.sal, d.dname
from emp e join dept d on e.deptno = d.deptno


-- COMMAND ----------


WITH dept_avg AS (
  SELECT
    deptno,
    AVG(sal) AS avg_sal
  FROM emp
  GROUP BY deptno
),
top_depts AS (
  SELECT deptno
  FROM dept_avg
  WHERE avg_sal = (SELECT MAX(avg_sal) FROM dept_avg)
)
SELECT
  e.ename AS name,
  e.job,
  e.sal AS salary
FROM emp e
JOIN top_depts t
  ON e.deptno = t.deptno
ORDER BY e.sal DESC, e.ename;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 166. List	the	empno,sal,comm.	Of	emps.

-- COMMAND ----------

select empno, sal, comm from emp;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 167. List	the	details	of	the	emps	in	the	ascending	order	of	the	sal.

-- COMMAND ----------

select * from emp
order by sal 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 168. List	the	dept	in	the	ascending	order	of	the	job	and	the	desc	order	of	the emps	print	empno,	ename.

-- COMMAND ----------

select empno, ename from emp
order by job asc, ename desc

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 169. Display	the	unique	dept	of	the	emps.

-- COMMAND ----------

select distinct deptno from emp;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 170. Display	the	unique	dept	with	jobs

-- COMMAND ----------

select distinct deptno, job from emp;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 172. List	all	the	clerks

-- COMMAND ----------

select * from emp where job = 'CLERK'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 173. list	all	the	employees	joined	on	1st	may	81.

-- COMMAND ----------

-- select * from emp where hiredate = '1981-05-01'
--OR

SELECT *
FROM emp
WHERE year(hiredate) = 1981
  AND month(hiredate) = 5
  AND day(hiredate) = 1;

--OR


-- If hiredate looks like '01-05-1981'
SELECT *
FROM emp
WHERE to_date(hiredate, 'dd-MM-yyyy') = DATE '1981-05-01';


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 174. List	the	empno,ename,sal,deptno	of	the	dept	10	emps	in	the	ascending order	of	salary.

-- COMMAND ----------

select empno, ename, sal, deptno from emp
where deptno = 10
order by sal asc

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 175. List	the	emps	whose	salaries	are	less	than	3500.

-- COMMAND ----------

select * from emp where sal < 3500;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 176. List	the	empno,ename,sal	of	all	the	emp	joined	before	1	apr	81.

-- COMMAND ----------

select empno, ename, sal from emp 
where hiredate < '1981-04-01'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 177. List	the	emp	whose	annual	sal	is	<25000	in	the	asc	order	of	the	salaries.

-- COMMAND ----------

select * from emp where (12*sal) <25000 order by sal; 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 178. List	the	empno,ename,annsal,dailysal		of	all	the	salesmen	in	the	asc	ann sal

-- COMMAND ----------

select empno, ename, (12*sal) as annual_sal, (sal/30) as daily_sal from emp
where job = 'SALESMAN'
order by annual_sal asc;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 179. List	the	empno,ename,hiredate,current	date	&	exp	in	the	ascending	order of	the	exp.

-- COMMAND ----------

select empno, ename, hiredate, current_date as todays_date, datediff(current_date,hiredate) as exp from emp
order by exp ;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 180. List	the	emps	whose	exp	is	more	than	10	years.

-- COMMAND ----------

select * from emp where datediff(current_date(), hiredate) >= 3650;

-- COMMAND ----------

--OR

SELECT *
FROM emp
WHERE datediff(current_date(), hiredate) / 365 > 10;

--OR

SELECT *
FROM emp
WHERE months_between(current_date(), hiredate) / 12 > 10;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 82. List	the	emps	who	are	working	as	managers.

-- COMMAND ----------


SELECT empno, ename, job
FROM emp
WHERE UPPER(job) = 'MANAGER'
ORDER BY ename;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 183. List	the	emps	who	are	either	clerks	or	managers.

-- COMMAND ----------

select * from emp where job = 'CLERK' OR job = 'MANAGER';

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 184. List	the	emps	who	have	joined	on	the	following	dates	1	may	81,17	nov 81,30	dec	81

-- COMMAND ----------

select * from emp where hiredate in ('1981-05-01', '1981-11-17', '1981-12-30')

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 185. List	the	emps	who	have	joined	in	the	year	1981.

-- COMMAND ----------

select * from emp where year(hiredate) = '1981'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 186. List	the	emps	whose	annual	sal	ranging	from	23000	to	40000.

-- COMMAND ----------

select * from emp where (12*sal) as annual_Sal between '23000' and '40000';
--You cannot use AS annual_sal inside the WHERE clause.

--OR

SELECT empno, ename, job, sal, (12 * sal) AS annual_sal
FROM emp
WHERE (12 * sal) BETWEEN 23000 AND 40000
ORDER BY annual_sal DESC;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 187. List	the	emps	working	under	the	mgrs	7369,7890,7654,7900.

-- COMMAND ----------

select * from emp where mgr in(7369, 7890, 7654, 7900);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 188. List	the	emps	who	joined	in	the	second	half	of	82

-- COMMAND ----------

select * from emp where hiredate between '1981-01-01' and '1981-06-30';

--OR

select * from emp where year(hiredate) = '1981'
and month(hiredate) >=7;

--OR

SELECT empno, ename, job, hiredate
FROM emp
WHERE hiredate >= '1982-07-01'
  AND hiredate <= '1982-12-31';

  -- OR

  
SELECT empno, ename, job, hiredate
FROM emp
WHERE to_date(hiredate, 'dd-MM-yyyy') BETWEEN DATE '1982-07-01' AND DATE '1982-12-31';


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 189. List	all	the	4char	emps.

-- COMMAND ----------

select * from emp where len(ename) = 4

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 190. List	the	emp	names	starting	with	‘M’	with	5	chars.

-- COMMAND ----------

select * from emp where where ename like 'M___%'
