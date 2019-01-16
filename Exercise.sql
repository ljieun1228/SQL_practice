-- Employees ���̺�
--[ employee_id = ��ȣ ] [ first_name = �̸� ] 
--[ last_name = �� ] [ email = �̸��� ] 
--[ phone_number = ��ȭ��ȣ ] [ hire_date = ����� ]
--[ job_id = �����ڵ� ] [ salary = �޿�]
--[ commission_pct = Ŀ�̼Ǻ��� ] [ manager_id = ���ID]
--[ department_id = �μ��ڵ�]

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