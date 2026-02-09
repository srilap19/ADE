# Databricks notebook source
# MAGIC %md
# MAGIC ####  2.List	the	name	,job,	dname,	location	for	those	who	are	working	as	MGRS.

# COMMAND ----------

# MAGIC %sql
# MAGIC select e.ename, e.job, d.dname, d.loc
# MAGIC from emp e join dept d on e.deptno = d.deptno
# MAGIC where e.job = 'MANAGER'

# COMMAND ----------

# MAGIC %md
# MAGIC ####  3.	List	the	emps	whose	mgr	name	is	jones	and	also	list	their	manager	name.

# COMMAND ----------

# MAGIC %sql
# MAGIC select e.ename, e.job, e.empno
# MAGIC from emp e join emp m
# MAGIC on e.mgr = m.empno
# MAGIC where m.ename = 'JONES'

# COMMAND ----------

# MAGIC %md
# MAGIC #### 4.	List	the	name	and	salary	of	ford	if	his	salary	is	equal	to	hisal	of	his	grade.

# COMMAND ----------

# MAGIC %sql
# MAGIC select e.ename, e.sal from emp e join salgrade s on e.sal between s.losal and s.hisal 
# MAGIC where e.ename = 'FORD'
# MAGIC and e.sal = s.hisal 

# COMMAND ----------

# MAGIC %md
# MAGIC #### 5.	Lit	the	name,	job,	dname	,sal,	grade	dept	wise

# COMMAND ----------

# MAGIC
# MAGIC %sql
# MAGIC SELECT e.ename,
# MAGIC        e.job,
# MAGIC        d.dname,
# MAGIC        e.sal,
# MAGIC        s.grade
# MAGIC FROM emp e
# MAGIC JOIN dept d ON e.deptno = d.deptno
# MAGIC JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
# MAGIC ORDER BY d.dname, e.ename;
# MAGIC

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT d.dname,
# MAGIC        COUNT(e.empno) AS emp_count,
# MAGIC        AVG(e.sal)     AS avg_salary
# MAGIC FROM emp e
# MAGIC JOIN dept d ON e.deptno = d.deptno
# MAGIC GROUP BY d.dname
# MAGIC ORDER BY d.dname;
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC ####  6. List	the	emp	name,	job,	sal,	grade	and	dname	except	clerks	and	sort	on	the basis	of	highest	sal.

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT e.ename,
# MAGIC        e.job,
# MAGIC        d.dname,
# MAGIC        e.sal,
# MAGIC        s.grade
# MAGIC FROM emp e
# MAGIC JOIN dept d ON e.deptno = d.deptno
# MAGIC JOIN salgrade s ON e.sal BETWEEN s.losal AND s.hisal
# MAGIC where e.job <> 'CLERK'
# MAGIC order by s.hisal 

# COMMAND ----------

# MAGIC %md
# MAGIC #### 7.	List	the	emps	name,	job		who	are	with	out	manager.

# COMMAND ----------

# MAGIC %sql
# MAGIC select e.ename, e.job, m.mgr
# MAGIC from emp e join emp m
# MAGIC on m.empno = e.mgr
# MAGIC where e.mgr is null

# COMMAND ----------

# MAGIC %md
# MAGIC #### 8.List	the	names	of	the	emps	who	are	getting	the	highest	sal	dept	wise.

# COMMAND ----------

# MAGIC %sql
# MAGIC 	select	e.ename,d.dname, e.sal 
# MAGIC   from	emp	e	join dept d on e.deptno = d.deptno
# MAGIC where	e.sal	in (select max(sal) from emp)
# MAGIC

# COMMAND ----------

# MAGIC
# MAGIC %sql
# MAGIC SELECT e.ename,
# MAGIC        e.deptno,
# MAGIC        e.sal
# MAGIC FROM emp e
# MAGIC WHERE e.sal = (
# MAGIC   SELECT MAX(sal)
# MAGIC   FROM emp
# MAGIC   WHERE deptno = e.deptno
# MAGIC )
# MAGIC ORDER BY e.deptno, e.ename;
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC ####  9.	List	the	emps	whose	sal	is	equal	to	the	average	of	max	and	minimum

# COMMAND ----------

# MAGIC
# MAGIC %sql
# MAGIC SELECT ename,
# MAGIC        sal
# MAGIC FROM emp
# MAGIC WHERE sal = (
# MAGIC     SELECT (MAX(sal) + MIN(sal)) / 2
# MAGIC     FROM emp
# MAGIC );
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC #### 10.	List	the	no.	of	emps	in	each	department	where	the	no.	is	more	than	3.

# COMMAND ----------

# MAGIC %sql
# MAGIC select count(empno) as emp_count, deptno from emp where deptno >=3
# MAGIC group by deptno

# COMMAND ----------

# MAGIC %md
# MAGIC ####  11.	List	the	names	of	depts.	Where	atleast	3	are	working	in	that	department.

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT d.dname, count(*)
# MAGIC FROM emp e
# MAGIC JOIN dept d ON e.deptno = d.deptno
# MAGIC
# MAGIC group by d.dname
# MAGIC having count(*)>=3

# COMMAND ----------

# MAGIC %md
# MAGIC ####  12.	List	the	managers	whose	sal	is	more	than	his	employess	avg	salary.

# COMMAND ----------

# MAGIC %sql
# MAGIC select m.empno, m.ename, avg(e.sal) as avg_sal, m.sal
# MAGIC from emp e join emp m
# MAGIC on m.empno = e.mgr
# MAGIC group by m.empno, m.ename, m.sal
# MAGIC having m.sal > avg(e.sal)
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC ####  13.	List	the	name,salary,comm.	For	those	employees	whose	net	pay	is greater	than	or	equal	to	any	other	employee	salary	of	the	company.

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC -- CTE - Employees whose net pay >= ANY other employee salary
# MAGIC WITH emp_net AS (
# MAGIC   SELECT
# MAGIC     empno,
# MAGIC     ename,
# MAGIC     sal,
# MAGIC     COALESCE(comm, 0) AS comm,
# MAGIC     COALESCE(sal, 0) + COALESCE(comm, 0) AS net_pay
# MAGIC   FROM Emp
# MAGIC )
# MAGIC SELECT
# MAGIC   e.ename,
# MAGIC   e.sal,
# MAGIC   e.comm,
# MAGIC   e.net_pay
# MAGIC FROM emp_net e
# MAGIC WHERE e.net_pay >= (
# MAGIC   SELECT MIN(sal)
# MAGIC   FROM Emp
# MAGIC   WHERE empno <> e.empno
# MAGIC )
# MAGIC ORDER BY e.net_pay DESC, e.ename;
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC ####  14.	List	the	emp	whose	sal<his	manager	but	more	than	any	other	manager.

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC SELECT
# MAGIC     e.empno,
# MAGIC     e.ename,
# MAGIC     e.sal AS emp_sal,
# MAGIC     m.empno AS mgr_empno,
# MAGIC     m.ename AS mgr_name,
# MAGIC     m.sal AS mgr_sal
# MAGIC FROM Emp e
# MAGIC JOIN Emp m
# MAGIC     ON e.mgr = m.empno
# MAGIC WHERE e.sal < m.sal
# MAGIC   AND e.sal > (
# MAGIC         SELECT MIN(sal)
# MAGIC         FROM Emp
# MAGIC         WHERE empno IN (SELECT mgr FROM Emp)
# MAGIC     );

# COMMAND ----------

# MAGIC %md
# MAGIC #### 15. List	the	employee	names	and	his	average	salary	department	wise.

# COMMAND ----------

# MAGIC %sql
# MAGIC select e.ename, avg(e.sal) as avg_sal, d.dname
# MAGIC from emp e join dept d on e.deptno = d.deptno
# MAGIC group by e.ename, d.dname
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC ####  16.	Find	out	least	5	earners	of	the	company.

# COMMAND ----------

# MAGIC
# MAGIC %sql
# MAGIC SELECT empno, ename, sal
# MAGIC FROM Emp
# MAGIC ORDER BY sal ASC
# MAGIC LIMIT 5;
# MAGIC

# COMMAND ----------

# MAGIC %sql  -- based on net pay
# MAGIC select empno, ename, coalesce(sal, 0) + coalesce(comm, 0) as net_pay
# MAGIC from emp
# MAGIC order by net_pay desc

# COMMAND ----------

# MAGIC %md
# MAGIC #### 17.Find	out	emps	whose	salaries	greater	than	salaries	of	their	managers.

# COMMAND ----------

# MAGIC
# MAGIC %sql
# MAGIC SELECT
# MAGIC   e.empno        AS emp_empno,
# MAGIC   e.ename        AS emp_name,
# MAGIC   e.sal          AS emp_sal,
# MAGIC   m.empno        AS mgr_empno,
# MAGIC   m.ename        AS mgr_name,
# MAGIC   m.sal          AS mgr_sal
# MAGIC FROM Emp AS e
# MAGIC JOIN Emp AS m
# MAGIC   ON e.mgr = m.empno          -- link employee to their manager
# MAGIC WHERE e.sal > m.sal           -- employee earns more than manager
# MAGIC ORDER BY e.sal DESC, e.ename;
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC #### 18. List	the	managers	who	are	not	working	under	the	president.

# COMMAND ----------

# MAGIC %sql
# MAGIC select empno, ename, job, mgr from emp 
# MAGIC where job <> 'PRESIDENT'
# MAGIC and mgr not in (select empno from emp where job = 'PRESIDENT')

# COMMAND ----------

# MAGIC %md
# MAGIC #### 19. List	the	records	from	emp	whose	deptno	is not	in	dept.

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT * FROM EMP WHERE DEPTNO NOT IN (SELECT DEPTNO FROM DEPT)

# COMMAND ----------

# MAGIC %md
# MAGIC #### 20. List	the	Name	,	Salary,	Comm	and	Net	Pay	is	more	than	any	other employee.

# COMMAND ----------

# MAGIC
# MAGIC %sql
# MAGIC WITH emp_net AS (
# MAGIC     SELECT
# MAGIC         empno,
# MAGIC         ename,
# MAGIC         sal,
# MAGIC         COALESCE(comm, 0) AS comm,
# MAGIC         (COALESCE(sal, 0) + COALESCE(comm, 0)) AS net_pay
# MAGIC     FROM Emp
# MAGIC )
# MAGIC SELECT
# MAGIC     ename,
# MAGIC     sal,
# MAGIC     comm,
# MAGIC     net_pay
# MAGIC FROM emp_net
# MAGIC WHERE net_pay > (
# MAGIC     SELECT MAX(sal) FROM Emp
# MAGIC )
# MAGIC ORDER BY net_pay DESC;

# COMMAND ----------

# MAGIC %md
# MAGIC #### 21. List	the	Enames	who	are	retiring	after	31-Dec-89	the	max	Job	period	is 20Y.

# COMMAND ----------

# MAGIC %sql
# MAGIC select ename, hiredate, dateadd(year, 20, hiredate) from emp where dateadd(year, 20, hiredate) = '1989-12-31'

# COMMAND ----------

# MAGIC %md
# MAGIC #### 22. List	those	Emps	whose	Salary	is	odd	value.

# COMMAND ----------

# MAGIC %sql
# MAGIC select ename, sal from emp where sal%2<>0;

# COMMAND ----------

# MAGIC %md
# MAGIC #### 23. List	the	emp’s	whose	Salary	contain	3	digits.

# COMMAND ----------

# MAGIC %sql
# MAGIC select * from emp where len(sal) = 3;

# COMMAND ----------

# MAGIC %md
# MAGIC #### 24. List	the	emps	who	joined	in	the	month	of	DEC.

# COMMAND ----------

# MAGIC %sql
# MAGIC select * from emp where month(hiredate) = '12'

# COMMAND ----------

# MAGIC %sql
# MAGIC select * from emp where date_format(hiredate,'MMM') = 'DEC'

# COMMAND ----------

# MAGIC %md
# MAGIC #### 25. List	the	emps	whose	names	contains	‘A’.

# COMMAND ----------

# MAGIC %sql
# MAGIC select * from emp where ename like '%A%'

# COMMAND ----------

# MAGIC %md
# MAGIC #### 26. List	the	emps	whose	Deptno	is	available	in	his	Salary.
# MAGIC * Find employees where their deptno appears as part of their salary value (e.g., if deptno = 10 and sal = 1010, then it's a match)

# COMMAND ----------

# MAGIC
# MAGIC %sql
# MAGIC SELECT empno, ename, sal, deptno
# MAGIC FROM Emp
# MAGIC WHERE INSTR(CAST(sal AS STRING), CAST(deptno AS STRING)) > 0;
# MAGIC
# MAGIC /*
# MAGIC INSTR is a string function that returns the position (index) of the first occurrence of substring within string.
# MAGIC INSTR(string, substring)
# MAGIC string → The main text you want to search in.
# MAGIC substring → The text you want to find inside the main string.
# MAGIC Return value → An integer:
# MAGIC
# MAGIC If substring is found → returns the position (starting from 1).
# MAGIC If not found → returns 0.
# MAGIC
# MAGIC SELECT INSTR('Databricks SQL', 'SQL');  -- returns 12
# MAGIC SELECT INSTR('Databricks SQL', 'abc');  -- returns 0 (not found)
# MAGIC
# MAGIC */

# COMMAND ----------

# MAGIC %md
# MAGIC #### 27.	List	the	emps	whose	first	2	chars	from	Hiredate=last	2	characters	of Salary.

# COMMAND ----------

# MAGIC %sql
# MAGIC -- Case 1: hiredate is a DATE/TIMESTAMP column
# MAGIC
# MAGIC SELECT empno, ename, hiredate, sal
# MAGIC FROM Emp
# MAGIC WHERE DATE_FORMAT(hiredate, 'dd') = RIGHT(CAST(sal AS STRING), 2);
# MAGIC

# COMMAND ----------

# MAGIC %sql
# MAGIC -- Case 2: hiredate is stored as a STRING (e.g., '17-DEC-80')
# MAGIC
# MAGIC select * from emp where substring(hiredate, 1,2) = right(cast(sal as string), 2);
# MAGIC
# MAGIC /*
# MAGIC 1. SUBSTR (or SUBSTRING)
# MAGIC
# MAGIC SUBSTR(string, start_position, length)
# MAGIC SUBSTRING(string, start_position, length)
# MAGIC string → The text you want to extract from.
# MAGIC start_position → The starting position (1-based index).
# MAGIC length → Number of characters to extract.
# MAGIC
# MAGIC SELECT SUBSTR('Databricks', 1, 4);   -- Output: 'Data'
# MAGIC SELECT SUBSTRING('Databricks', 5, 6); -- Output: 'brick
# MAGIC
# MAGIC 2. TRIM
# MAGIC Used to remove spaces or specific characters from the beginning and/or end of a string.
# MAGIC TRIM([BOTH | LEADING | TRAILING] 'char' FROM string)
# MAGIC Default removes spaces from both ends.
# MAGIC You can specify a character to remove.
# MAGIC
# MAGIC Key Differences:
# MAGIC
# MAGIC SUBSTR / SUBSTRING → Extract part of a string by position.
# MAGIC TRIM → Remove unwanted characters (usually spaces) from ends of a string.
# MAGIC
# MAGIC LEFT(string, n)
# MAGIC
# MAGIC Purpose: Extract the first n characters from a string.
# MAGIC SELECT LEFT('Databricks', 4);  -- Output: 'Data'
# MAGIC
# MAGIC SELECT RIGHT('Databricks', 6);  -- Output: 'bricks'
# MAGIC */

# COMMAND ----------

# MAGIC %md
# MAGIC ####  28.	List	the	emps	Whose	10%	of	Salary	is	equal	to	year	of	joining.

# COMMAND ----------

# MAGIC
# MAGIC %sql
# MAGIC SELECT
# MAGIC   empno,
# MAGIC   ename,
# MAGIC   sal,
# MAGIC   hiredate,
# MAGIC   YEAR(hiredate) AS join_year
# MAGIC FROM Emp
# MAGIC WHERE sal / 10 = YEAR(hiredate)
# MAGIC ORDER BY ename;
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC ####  29.	List	first	50%	of	chars	of	Ename	in	Lower	Case	and	remaining	are	upper

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC
# MAGIC
# MAGIC SELECT
# MAGIC   empno,
# MAGIC   ename,
# MAGIC   LOWER(SUBSTRING(ename, 1, LENGTH(ename)/2)) ||
# MAGIC   UPPER(SUBSTRING(ename, LENGTH(ename)/2 + 1, LENGTH(ename))) AS ename_half_lower_half_upper
# MAGIC FROM Emp;
# MAGIC
# MAGIC /*
# MAGIC Part 1: SUBSTRING(ename, 1, LENGTH(ename)/2)
# MAGIC SUBSTRING(string, start, length) extracts a portion of the string.
# MAGIC Here:
# MAGIC
# MAGIC start = 1 → start from the first character.
# MAGIC length = LENGTH(ename)/2 → take half of the total length of ename.
# MAGIC So this gives the first half of the name.
# MAGIC
# MAGIC Part 2: SUBSTRING(ename, LENGTH(ename)/2 + 1, LENGTH(ename))
# MAGIC
# MAGIC start = LENGTH(ename)/2 + 1 → start from the character right after the first half.
# MAGIC length = LENGTH(ename) → take the remaining characters (effectively the second half).
# MAGIC So this gives the second half of the name.
# MAGIC */
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC #### 30. List	the	Dname	whose	No.	of	Emps	is equal to	number	of	chars	in	the Dname.

# COMMAND ----------

# MAGIC %sql
# MAGIC SELECT d.dname
# MAGIC FROM Dept AS d
# MAGIC LEFT JOIN Emp AS e
# MAGIC   ON e.deptno = d.deptno
# MAGIC GROUP BY d.dname, d.deptno
# MAGIC HAVING COUNT(e.empno) = LENGTH(d.dname);
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC #### 31. List	the	emps	those	who	joined	in	company	before	15th	of	the	month

# COMMAND ----------

# MAGIC %sql
# MAGIC select * from emp where day(hiredate) <15; 

# COMMAND ----------

# MAGIC %md
# MAGIC #### 32. 	List	the	Dname,	no	of	chars	of	which	is	=	no.	of	emp’s	in	any	other Dept.

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC SELECT DISTINCT d1.dname
# MAGIC FROM Dept d1
# MAGIC JOIN (
# MAGIC     SELECT deptno, COUNT(*) AS emp_count
# MAGIC     FROM Emp
# MAGIC     GROUP BY deptno
# MAGIC ) d2
# MAGIC ON LENGTH(TRIM(d1.dname)) = d2.emp_count
# MAGIC AND d1.deptno <> d2.deptno

# COMMAND ----------

# MAGIC %md
# MAGIC #### 33. List	the	emps	who	are	working	as	Managers.

# COMMAND ----------

# MAGIC %sql
# MAGIC select ename from emp where job = 'MANAGER' -- or lower(job) = 'manager'
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC #### 34. List	the	Name	of	dept	where	highest	no.of	emps	are	working.

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC SELECT d.dname
# MAGIC FROM Dept d
# MAGIC JOIN Emp e ON d.deptno = e.deptno
# MAGIC GROUP BY d.dname
# MAGIC ORDER BY COUNT(*) DESC

# COMMAND ----------

# MAGIC %md
# MAGIC #### 35.Count	the	No.of	emps	who	are	working	as	‘Managers’(using	set	option) A)select	count(*)

# COMMAND ----------

# MAGIC %sql
# MAGIC select count(*) from emp where empno in(select empno from emp where job = 'MANAGER')

# COMMAND ----------

# MAGIC %md
# MAGIC #### 36. List	the	emps	who	joined	in	the	company	on	the	same	date.

# COMMAND ----------

# MAGIC %sql
# MAGIC select * from emp where hiredate in (select hiredate from emp group by hiredate
# MAGIC having count(*)>1);

# COMMAND ----------

# MAGIC %md
# MAGIC #### 37. List	the	details	of	the	emps	whose	Grade	is	equal	to	one	tenth	of	Sales Dept.

# COMMAND ----------

# MAGIC %sql
# MAGIC select	*	from	emp	e join salgrade	s
# MAGIC on e.sal BETWEEN s.losal AND s.hisal
# MAGIC where s.grade	=	0.1*	(select	deptno	from	dept	where	dname	=	'SALES')

# COMMAND ----------

# MAGIC %md
# MAGIC #### 38. List	the	name	of	the	dept	where	more	than	average	no.	of	emps	are working.

# COMMAND ----------

# MAGIC %sql
# MAGIC
# MAGIC -- Databricks SQL
# MAGIC WITH dept_counts AS (
# MAGIC   SELECT
# MAGIC     deptno,
# MAGIC     COUNT(*) AS emp_cnt
# MAGIC   FROM Emp
# MAGIC   GROUP BY deptno
# MAGIC ),
# MAGIC avg_cnt AS (
# MAGIC   SELECT AVG(emp_cnt) AS avg_emp_cnt
# MAGIC   FROM dept_counts
# MAGIC )
# MAGIC SELECT
# MAGIC   d.dname
# MAGIC FROM dept_counts AS c
# MAGIC JOIN Dept AS d
# MAGIC   ON d.deptno = c.deptno
# MAGIC CROSS JOIN avg_cnt
# MAGIC WHERE c.emp_cnt > avg_emp_cnt
# MAGIC GROUP BY d.dname;
# MAGIC

# COMMAND ----------

# MAGIC %md
# MAGIC #### 39. List	the	Managers	name	who	is	having	max	no.of	emps	working	under him.

# COMMAND ----------

# MAGIC
# MAGIC %sql
# MAGIC WITH mgr_counts AS (
# MAGIC   SELECT
# MAGIC     m.empno        AS mgr_empno,
# MAGIC     m.ename        AS manager_name,
# MAGIC     COUNT(e.empno) AS report_count
# MAGIC   FROM Emp e
# MAGIC   JOIN Emp m
# MAGIC     ON e.mgr = m.empno
# MAGIC   GROUP BY m.empno, m.ename
# MAGIC )
# MAGIC SELECT manager_name, report_count
# MAGIC FROM mgr_counts
# MAGIC WHERE report_count = (
# MAGIC   SELECT MAX(report_count) FROM mgr_counts
# MAGIC );
# MAGIC
