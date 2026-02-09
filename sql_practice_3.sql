-- Databricks notebook source
-- MAGIC %md
-- MAGIC ####  2.61.	List	of	emps	of	emp1	who	are	not	found	in	emp2.

-- COMMAND ----------

--select * from emp where empno not in (select empno from emp2)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.62.Find	the	highest	sal	of	EMP	table.
-- MAGIC

-- COMMAND ----------

select max(sal) as hig_sal from emp;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.64. Find	the	highest	paid	employee	of	sales	department

-- COMMAND ----------

select d.dname, max(e.sal) as hig_Sal from emp e join dept d
on e.deptno = d.deptno
where d.dname = 'SALES'
group by d.dname

-- COMMAND ----------

select d.dname, e.sal from emp e join dept d
on e.deptno = d.deptno
where d.dname = 'SALES'
and e.sal = (select max(sal) from emp where deptno = d.deptno)


-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.65.	List	the	most	recently	hired	emp	of	grade3	belongs	to		location CHICAGO.

-- COMMAND ----------

SELECT e.empno, e.ename, e.job, e.sal, e.hiredate, d.dname, d.loc, s.grade
FROM Emp e
JOIN Dept d ON e.deptno = d.deptno
JOIN Salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE s.grade = 3
  AND d.loc = 'CHICAGO'
ORDER BY e.hiredate DESC;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.66.	List	the	employees	who	are	senior	to	most	recently	hired	employee working	under	king

-- COMMAND ----------

SELECT e.empno, e.ename, e.job, e.hiredate, e.sal, e.deptno
FROM Emp e
WHERE e.hiredate < (
    SELECT hiredate
    FROM Emp
    WHERE mgr = (SELECT empno FROM Emp WHERE ename = 'KING')
    ORDER BY hiredate DESC
    LIMIT 1
)
ORDER BY e.hiredate ASC;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.67.	List	the	details	of	the	employee	belongs	to	newyork	with	grade	3	to	5 except	‘PRESIDENT’	whose	sal>	the	highest	paid	employee	of	Chicago	in	a group	where	there	is	manager	and	salesman	not	working	under	king

-- COMMAND ----------

SELECT e.empno, e.ename, e.job, e.sal, e.deptno, d.dname, d.loc, s.grade
FROM Emp e
JOIN Dept d ON e.deptno = d.deptno
JOIN Salgrade s ON e.sal BETWEEN s.losal AND s.hisal
WHERE d.loc = 'NEW YORK'
  AND s.grade BETWEEN 3 AND 5
  AND e.job <> 'PRESIDENT';
  AND e.sal > (
        SELECT MAX(e2.sal)
        FROM Emp e2
        JOIN Dept d2 ON e2.deptno = d2.deptno
        WHERE d2.loc = 'CHICAGO'
      )
  AND not exists (SELECT 1 FROM Emp WHERE mgr in (select empno from emp where ename = 'KING' ) and job in ('MANAGER' ,'SALESMAN'));
  

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.68.	List	the	details	of	the	senior	employee	belongs	to	1981.

-- COMMAND ----------

select * from emp where hiredate in (select min(hiredate) from emp where year(hiredate) = 1981)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.69.	List	the	employees	who	joined	in	1981	with	the	job	same	as	the	most senior	person	of	the	year	1981.

-- COMMAND ----------

select * from emp where year(hiredate) = 1981 and job in (select job from emp where year(hiredate) = 1981
order by hiredate asc)

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.70. List	the	most	senior	empl	working	under	the	king	and	grade	is	more	than	3.

-- COMMAND ----------

select e.empno, e.ename, e.job, e.hiredate, e.sal, s.grade from emp e
join salgrade s on e.sal between s.losal and s.hisal
where e.mgr = (select empno from emp where ename = 'KING') 
and s.grade > 3
order by e.hiredate asc;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.71.	Find	the	total	sal	given	to	the	MGR

-- COMMAND ----------

SELECT SUM(sal) AS total_mgr_salary
FROM emp
WHERE job = 'MANAGER';

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.72.	Find	the	total	annual	sal	to	distribute	job	wise	in	the	year	81.

-- COMMAND ----------

select job, sum(sal*12) as total_sal from emp where year(hiredate) = '1981'
group by job;

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.73. Display	total	sal	employee	belonging	to	grade	3.

-- COMMAND ----------

select sum(e.sal) as total_sal from emp e
join workspace.default.salgrade s on e.sal between s.losal and s.hisal
where s.grade = 3;
 

-- COMMAND ----------

-- MAGIC %md
-- MAGIC #### 2.74. Display	the	average	salaries	of	all	the	clerks

-- COMMAND ----------

select avg(sal) as avg_Sal from emp where job = 'CLERK'

-- COMMAND ----------

-- MAGIC %md
-- MAGIC ####  2.75.	 List	the	employee in	dept	20	whose	sal	is	> the	average	sal	Of	dept	10 emps.

-- COMMAND ----------

SELECT * from emp e join dept d on e.deptno = d.deptno
where d.deptno = 20 and e.sal > (select avg(e.sal) as avg_sal from emp e where e.deptno = 10)

-- COMMAND ----------


