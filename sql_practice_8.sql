-- Databricks notebook source
-- MAGIC %md
-- MAGIC #### 221. List	the	emps	who	are	senior	to	their	own	manager.

-- COMMAND ----------

select e.ename as empname, e.hiredate as emphiredate, m.hiredate as mgr_hire_date
from emp e join emp m
on m.empno = e.mgr
where e.hiredate > m.hiredate 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 222. List	the	emps	whose	sal	greater	than	blakes	sal.

-- COMMAND ----------

select * from emp where sal>(select sal from emp where ename = 'BLAKE')

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 223. List	the	dept	10	emps	whose	sal>allen	sal.

-- COMMAND ----------

SELECT * 
from emp where deptno = 10 and sal >(select sal from emp where ename = 'ALLEN')

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 224. List	the	mgrs	who	are	senior	to	king	and	who	are	junior	to	smith.

-- COMMAND ----------

SELECT * from emp where empno in  
(select mgr from emp where hiredate < (select hiredate from emp where ename = 'KING')
AND hiredate > (select hiredate from emp where ename  ='SMITH'))
and mgr is not null;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 225. List	the	empno,ename,loc,sal,dname,loc	of	the	all	the	emps	belonging	to king	dept.

-- COMMAND ----------

select e.empno, e.ename, d.loc, e.sal, d.dname from emp e join dept d on e.deptno = d.deptno 
where d.deptno in(select deptno from emp where ename = 'KING')

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 226. List	the	emps	whose	salgrade	are	greater	than	the	grade	of	miller.

-- COMMAND ----------

select e.* 
from emp e 
join salgrade s on e.sal between s.losal and s.hisal 
where s.grade > (select grade from salgrade sg 
                 join emp em on em.sal between sg.losal and sg.hisal 
                 where em.ename = 'MILLER')

-- COMMAND ----------

-- OR

SELECT
  e.empno,
  e.ename,
  e.job,
  e.mgr,
  e.hiredate,
  e.sal,
  e.comm,
  e.deptno,
  s.grade AS salgrade
FROM Emp e
JOIN Salgrade s
  ON e.sal BETWEEN s.losal AND s.hisal
WHERE s.grade > (
  SELECT MAX(s2.grade)               -- handles multiple MILLER rows safely
  FROM Emp m
  JOIN Salgrade s2
    ON m.sal BETWEEN s2.losal AND s2.hisal
  WHERE upper(m.ename) = 'MILLER'
)
ORDER BY s.grade DESC, e.sal DESC, e.ename ASC;


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 227. List	the	emps	who	are	belonging	dallas	or	Chicago	with	the	grade	same	as adams or	exp	more	than	smith.

-- COMMAND ----------

select e.* 
from emp e 
join dept d on e.deptno = d.deptno
join salgrade s on e.sal between s.losal and s.hisal 
where 
  (d.loc = 'DALLAS' or d.loc = 'CHICAGO')
  and s.grade = (
    select max(s2.grade)
    from emp e2 
    join salgrade s2 on e2.sal between s2.losal and s2.hisal 
    where e2.ename = 'ADAMS'
  )
  or months_between(current_date(), e.hiredate) > (
    select months_between(current_date(), hiredate) from emp where ename = 'SMITH'
  )

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 228. List	the	emps	whose	sal	is	same	as	ford	or	blake.

-- COMMAND ----------

select * from emp where sal in (select sal from emp where ename IN ('FORD','BLAKE'))

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 229. List	the	emps	whose	sal	is	same	as	any	one	of	the	following.

-- COMMAND ----------

select	*	from	emp	where	sal		in	
(select	sal	from	emp	e	where	emp.empno	<>	e.empno);

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 230. Sal	of	any	clerk	of	emp1	table.

-- COMMAND ----------

	select	*	from	emp	where	job	=	'CLERK';

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 231. Any	emp	of	emp2	joined	before	82.

-- COMMAND ----------

select * from emp where year(hiredate) < 1982

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 232 .The	total	remuneration	(sal+comm.)	of	all	sales	person	of	Sales	dept belonging	to	emp3	table.

-- COMMAND ----------

select * from emp where (sal+comm) in (select (sal+comm)  from emp e join dept d on e.deptno = d.deptno
where d.dname = 'SALES' AND e.job = 'SALESMAN')


-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 233. Any	Grade	4	emps	Sal	of	emp	4	table.

-- COMMAND ----------

select * from emp e join salgrade s on e.sal between s.losal and s.hisal where s.grade = 4;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 234. Any	emp	Sal	of	emp5	table.

-- COMMAND ----------

select * from emp where empno = 5;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 235. List	the	highest	paid	emp.

-- COMMAND ----------

select * from emp where sal in(select max(sal) from emp)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 236. List	the	details	of	most	recently	hired	emp	of	dept	30.

-- COMMAND ----------

select * from emp where hiredate in(select max(hiredate) from emp where deptno = 30)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 237. List	the	highest	paid	emp	of	Chicago	joined	before	the	most recently hired	emp	of	grade	2.

-- COMMAND ----------

select	*	from	emp
where	sal	=	(	select	max(sal)	from	emp	e,dept	d	where	e.deptno	=	
d.deptno	and	d.loc	=	'CHICAGO'	and
hiredate	<(select	max(hiredate)	from	emp	e	,salgrade	s								
where	e.sal	between	s.losal	and	s.hisal	and	s.grade	=	2))

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 238. List	the	highest	paid	emp	working	under	king.

-- COMMAND ----------

select * from emp where sal in (select max(sal)from emp where mgr in(select empno from emp where ename = 'KING'))
