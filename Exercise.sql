-- Employees ���̺�
--[ employee_id = ��ȣ ] [ first_name = �̸� ] 
--[ last_name = �� ] [ email = �̸��� ] 
--[ phone_number = ��ȭ��ȣ ] [ hire_date = ����� ]
--[ job_id = �����ڵ� ] [ salary = �޿�]
--[ commission_pct = Ŀ�̼Ǻ��� ] [ manager_id = ���ID]
--[ department_id = �μ��ڵ�]

desc employees;
desc DEPARTMENTS;
desc LOCATIONS;
desc jobs;

DROP VIEW EMP;
DROP VIEW JOB;
DROP VIEW DEP;
DROP VIEW LOC;


CREATE VIEW EMP AS 
SELECT 
EMPLOYEE_ID EID,
FIRST_NAME FNAME,
LAST_NAME LNAME,
PHONE_NUMBER PHONE,
HIRE_DATE HDATE,
JOB_ID JID,
SALARY SAL,
COMMISSION_PCT COMM,
MANAGER_ID MANID,
DEPARTMENT_ID DID
FROM EMPLOYEES;

CREATE VIEW JOB AS 
SELECT JOB_ID JID,
JOB_TITLE TITLE,
MIN_SALARY MINSAL,
MAX_SALARY MAXSAL
FROM JOBS;

CREATE VIEW DEP AS 
SELECT DEPARTMENT_ID DID,
DEPARTMENT_NAME DNAME,
MANAGER_ID MANID,
LOCATION_ID LID
FROM DEPARTMENTS;

CREATE VIEW LOC AS 
SELECT 
LOCATION_ID LID,
STREET_ADDRESS ADDR,
POSTAL_CODE ZIP,
CITY,
STATE_PROVINCE PROV,
COUNTRY_ID CID
FROM LOCATIONS;

DESC JOB_HISTORY; 

CREATE VIEW HIS AS
SELECT 
EMPLOYEE_ID EID,
START_DATE SDATE,
END_DATE EDATE,
JOB_ID JID,
DEPARTMENT_ID DID
FROM JOB_HISTORY;



-- *******
-- ����001. 
-- HR ��Ű�� ���̺��� ��� ���?
-- *******
SELECT * FROM tab;

-- *******
-- ����002. 
-- HR ��Ű�� ���̺� ���� �?
-- *******
SELECT COUNT(*) FROM tab;

-- *******
-- ����003. 
-- ���, ��, �̸����?
-- *******
SELECT employee_id, last_name, first_name 
FROM Employees;

-- *******
-- ����004. 
-- �̸��� s�� ������ ������ �̸� ���?
-- *******
SELECT first_name 
FROM Employees
WHERE first_name 
LIKE '%s';

-- *******
-- ����005. 
-- �̸��� s�� �����ϴ� ������ �̸� ���?
-- *******
SELECT first_name 
FROM Employees
WHERE first_name 
LIKE 'S%';

-- *******
-- ����006. 
-- �޿��� ���� ������ �̸�,�μ��ڵ�,�޿� ��ȸ 
-- *******
SELECT first_name, department_id, salary 
FROM Employees
ORDER BY salary DESC;

-- *******
-- ����007.
-- �޿��� 12000 �̻��� ���,�̸�,�μ��ڵ�, �޿� ��ȸ 
-- *******
SELECT employee_id, first_name, department_id, salary 
FROM Employees
WHERE salary > 1200;

-- *******
-- ����008.
-- �޿��� 1500�̻� 2500���ϸ� �޴� ������ ���,�̸�,�μ��ڵ�, �޿� ��ȸ 
-- *******
SELECT employee_id, first_name, department_id, salary 
FROM Employees 
WHERE salary >= 1500 AND salary <= 2500;

-- *******
-- ����009.
-- �޿��� 1500�̻� 2500���ϸ� �޴� 
-- ������ ���,�̸�,�μ��ڵ�, �޿� ��ȸ (BETWEEN ���) 
-- *******
SELECT employee_id, first_name, department_id, salary 
FROM Employees
WHERE salary 
BETWEEN 1500 AND 2500;

-- *******
-- ����010.
-- 2005�⵵�� �Ի��� ������ �̸��� �μ��ڵ�, 
-- �Ի����ڸ� ��ȸ
-- *******
SELECT first_name, department_id, hire_date 
FROM Employees
WHERE hire_date 
LIKE '05%';


-- *******
-- ����011. 
-- Ŀ�̼��� ���� ���ϴ� ������ �̸�,�����ڵ�,�޿�,Ŀ�̼Ǻ����� ��ȸ
-- *******
SELECT first_name, job_id, salary, commission_pct
FROM Employees
WHERE commission_pct is null;

-- *******
-- ����012. 
-- ����� 110,120,130�� ����� ���, ��, �̸� ��ȸ
-- *******
SELECT employee_id, first_name, last_name 
FROM Employees
WHERE employee_id IN (110, 120, 130); 

-- *******
-- ����013. 
-- �μ��ڵ�� ��������, �޿��� ������������ 
-- �μ��ڵ�, �޿�, ���, �̸�, �� ����
-- �������� 0,1,2 ... �������� 9,8,7...
-- ******
SELECT department_id, salary, employee_id, first_name, last_name
FROM Employees
ORDER BY department_id ASC, salary DESC;

-- *******
-- ����014. 
-- �̸��� am �̶� ���ڰ� ���Ե� ������ ���,�̸�, ��
-- *******
SELECT employee_id, first_name, last_name
FROM Employees
WHERE first_name
LIKE '%am%';

-- *******
-- ����015.
-- �̸��Ͽ� 'GG' �� 'KK'�δܾ� �� �ϳ��� ���ԵǾ ��ȸ
-- ��, ��ҹ��� ������
-- *******

SELECT * FROM EMPLOYEES 
WHERE email 
LIKE '%GG%' OR email LIKE '%KK%';


-- *******
-- ����016.
-- �̸����ּҰ� A �� �������� �ʴ� �̸��� ����
-- *******

SELECT COUNT(email) 
FROM EMPLOYEES 
WHERE email NOT LIKE 'A%';


-- *******
-- ����017.
-- ���� �ι�°,����° ���ڰ� ���ÿ� e �� ������ �̸�, ��
-- *******

SELECT first_name, last_name 
FROM EMPLOYEES 
WHERE last_name 
LIKE '_e%' AND last_name 
LIKE '__e%';

-- *******
-- ����018
 -- �����ӱ��� 10000�� �̻��� ������ �� ������ ǥ���Ѵ�
-- *******
select * from jobs 
where min_salary > 10000;

-- *******************
-- [����19]
-- 2002����� 2005����� 
-- ������ ������ �̸��� ���� ���ڸ� ǥ���Ѵ�.
-- *******************
SELECT FIRST_NAME, HIRE_DATE 
FROM EMPLOYEES 
WHERE TO_CHAR(HIRE_DATE, 'YYYY') 
    BETWEEN 2002 AND 2005 ORDER BY HIRE_DATE;

select first_name, hire_date
from employees 
where hire_date >= '02/01/01'
and hire_date <= '05/12/31' 
ORDER BY hire_date ASC;


-- *******************
-- [����020]
--  IT Programmer �Ǵ� Sales Man�� 
-- ������ �̸�, �Ի���, �����ڵ� ǥ��.
-- ******************* 
select 
    first_name �̸�, 
    hire_date �Ի���, 
    job_id �����ڵ�
from employees
where job_id IN('IT_PROG', 'SA_MAN');


-- *******************
-- [����021]
-- IT Programmer �Ǵ� Sales Man�� 
-- ������ �̸�, �Ի���, ������ ǥ��.
-- *******************    

select 
    E.first_name �̸�, 
    E.hire_date �Ի���, 
    J.job_title ������
from JOBS E
    inner join employees J 
    on j.job_id like e.job_id
where j.job_title in('Programmer','Sales Manager')
order by e.first_name;

select * from employees
order by first_name ;

-- *******************
-- [����022]
-- �μ��� �� �������̸� ǥ��
-- (��, �÷����� ������ [����] �̸� �� �ǵ��� ...)
-- DEPARTMENTS ���� MANAGER_ID �� ������ �ڵ�
-- *******************  
select 
    D.DNAME �μ���, 
    E.FNAME ||' '|| E.LNAME "������ �̸�" 
from DEP D
    inner join EMP E
    on D.DID like E.EID;

-- ****************��������....***
-- [����023]
-- ������(Marketing) �μ����� �ٹ��ϴ� ����� 
-- ���, ��å, �̸�, �ټӱⰣ
-- (��, �ټӱⰣ�� JOB_HISTORY ���� END_DATE-START_DATE�� ���� ��)
-- EMPLOYEE_ID ���, JOB_TITLE ��å��
-- *******************  
SELECT D.DID 
FROM DEP D
WHERE D.DNAME LIKE 'MARKETING';
-------------------------------
SELECT E.EID ���, J.TITLE ��å, E.FNAME �̸�,
        H.EDATE - H.SDATE �ټ��ϼ�
FROM HIS H
    JOIN JOB J
        ON H.JID LIKE J.JID
    JOIN EMP E
        ON E.EID LIKE H.EID
WHERE E.DID LIKE 20;

------- ���������� ��� ------
SELECT E.EID ���, J.TITLE ��å, E.FNAME �̸�,
        H.EDATE - H.SDATE �ټ��ϼ�
FROM HIS H
    JOIN JOB J
        ON H.JID LIKE J.JID
    JOIN EMP E
        ON E.EID LIKE H.EID
WHERE E.DID LIKE 20;


-- *******************
-- [����024]
--  ��å�� "Programmer"�� ����� ������ ���
-- DEPARTMENT_NAME �μ���, �̸�(FIRST_NAME + [����] + LAST_NAME)���� ���
-- �̸��� �ߺ��Ǿ ��µ�. �� �Ѹ��� �����μ����� ������ ������
-- *******************
SELECT 
    D.DNAME �μ���, 
    E.LNAME ||' '|| E.FNAME �̸�
    
from EMP E
    join DEP D
    on D.DNAME like 'IT';

select * from DEP;


-- *******************
-- [����025]
-- �μ���, ������ �̸�, �μ���ġ ���� ǥ��
-- �μ��� ��������
-- *******************

SELECT
    D.DNAME �μ���,
    E.FNAME ||''|| E.LNAME "������ �̸�",
    L.CITY "�μ���ġ ����"
FROM DEP D
    JOIN EMP E
        ON D.MANID LIKE E.MANID
    JOIN LOC L
        USING(LID)
ORDER BY DNAME;


--    ON D.LID LIKE L.LID


-- *******************
-- [����026]
-- �μ��� ��� �޿��� ���Ͻÿ�. 
-- *******************
SELECT 
    D.DNAME "�μ���",
    ROUND(AVG(E.SAL),2) "�μ��� ��� �޿�"
FROM EMP E
    JOIN DEP D
        ON E.DID LIKE D.DID
GROUP BY E.DID, D.DNAME
HAVING ROUND(AVG(E.SAL),2) >= 10000
;

-- *******************
-- [����027]
-- �μ��� ��� �޿��� 10000 �� �Ѵ�
--  �μ���, "�μ��� ��� �޿�" �� ����Ͻÿ�
-- *******************  



