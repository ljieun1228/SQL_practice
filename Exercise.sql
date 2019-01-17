-- Employees 테이블
--[ employee_id = 번호 ] [ first_name = 이름 ] 
--[ last_name = 성 ] [ email = 이메일 ] 
--[ phone_number = 전화번호 ] [ hire_date = 고용일 ]
--[ job_id = 업무코드 ] [ salary = 급여]
--[ commission_pct = 커미션비율 ] [ manager_id = 상사ID]
--[ department_id = 부서코드]

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
-- 문제001. 
-- HR 스키마 테이블을 모두 출력?
-- *******
SELECT * FROM tab;

-- *******
-- 문제002. 
-- HR 스키마 테이블 수는 몇개?
-- *******
SELECT COUNT(*) FROM tab;

-- *******
-- 문제003. 
-- 사번, 성, 이름출력?
-- *******
SELECT employee_id, last_name, first_name 
FROM Employees;

-- *******
-- 문제004. 
-- 이름이 s로 끝나는 직원의 이름 출력?
-- *******
SELECT first_name 
FROM Employees
WHERE first_name 
LIKE '%s';

-- *******
-- 문제005. 
-- 이름이 s로 시작하는 직원의 이름 출력?
-- *******
SELECT first_name 
FROM Employees
WHERE first_name 
LIKE 'S%';

-- *******
-- 문제006. 
-- 급여가 많은 순으로 이름,부서코드,급여 조회 
-- *******
SELECT first_name, department_id, salary 
FROM Employees
ORDER BY salary DESC;

-- *******
-- 문제007.
-- 급여가 12000 이상인 사번,이름,부서코드, 급여 조회 
-- *******
SELECT employee_id, first_name, department_id, salary 
FROM Employees
WHERE salary > 1200;

-- *******
-- 문제008.
-- 급여가 1500이상 2500이하를 받는 직원의 사번,이름,부서코드, 급여 조회 
-- *******
SELECT employee_id, first_name, department_id, salary 
FROM Employees 
WHERE salary >= 1500 AND salary <= 2500;

-- *******
-- 문제009.
-- 급여가 1500이상 2500이하를 받는 
-- 직원의 사번,이름,부서코드, 급여 조회 (BETWEEN 사용) 
-- *******
SELECT employee_id, first_name, department_id, salary 
FROM Employees
WHERE salary 
BETWEEN 1500 AND 2500;

-- *******
-- 문제010.
-- 2005년도에 입사한 직원의 이름과 부서코드, 
-- 입사일자를 조회
-- *******
SELECT first_name, department_id, hire_date 
FROM Employees
WHERE hire_date 
LIKE '05%';


-- *******
-- 문제011. 
-- 커미션을 받지 못하는 직원의 이름,업무코드,급여,커미션비율을 조회
-- *******
SELECT first_name, job_id, salary, commission_pct
FROM Employees
WHERE commission_pct is null;

-- *******
-- 문제012. 
-- 사번이 110,120,130인 사원의 사번, 성, 이름 조회
-- *******
SELECT employee_id, first_name, last_name 
FROM Employees
WHERE employee_id IN (110, 120, 130); 

-- *******
-- 문제013. 
-- 부서코드는 오름차순, 급여는 내림차순으로 
-- 부서코드, 급여, 사번, 이름, 성 정렬
-- 오름차순 0,1,2 ... 내림차순 9,8,7...
-- ******
SELECT department_id, salary, employee_id, first_name, last_name
FROM Employees
ORDER BY department_id ASC, salary DESC;

-- *******
-- 문제014. 
-- 이름에 am 이란 글자가 포함된 직원의 사번,이름, 성
-- *******
SELECT employee_id, first_name, last_name
FROM Employees
WHERE first_name
LIKE '%am%';

-- *******
-- 문제015.
-- 이메일에 'GG' 와 'KK'두단어 중 하나만 포함되어도 조회
-- 단, 대소문자 구분함
-- *******

SELECT * FROM EMPLOYEES 
WHERE email 
LIKE '%GG%' OR email LIKE '%KK%';


-- *******
-- 문제016.
-- 이메일주소가 A 로 시작하지 않는 이메일 갯수
-- *******

SELECT COUNT(email) 
FROM EMPLOYEES 
WHERE email NOT LIKE 'A%';


-- *******
-- 문제017.
-- 성의 두번째,세번째 글자가 동시에 e 인 직원의 이름, 성
-- *******

SELECT first_name, last_name 
FROM EMPLOYEES 
WHERE last_name 
LIKE '_e%' AND last_name 
LIKE '__e%';

-- *******
-- 문제018
 -- 최저임금이 10000불 이상인 업무의 상세 내역을 표시한다
-- *******
select * from jobs 
where min_salary > 10000;

-- *******************
-- [문제19]
-- 2002년부터 2005년까지 
-- 가입한 직원의 이름과 가입 일자를 표시한다.
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
-- [문제020]
--  IT Programmer 또는 Sales Man인 
-- 직원의 이름, 입사일, 업무코드 표시.
-- ******************* 
select 
    first_name 이름, 
    hire_date 입사일, 
    job_id 업무코드
from employees
where job_id IN('IT_PROG', 'SA_MAN');


-- *******************
-- [문제021]
-- IT Programmer 또는 Sales Man인 
-- 직원의 이름, 입사일, 업무명 표시.
-- *******************    

select 
    E.first_name 이름, 
    E.hire_date 입사일, 
    J.job_title 업무명
from JOBS E
    inner join employees J 
    on j.job_id like e.job_id
where j.job_title in('Programmer','Sales Manager')
order by e.first_name;

select * from employees
order by first_name ;

-- *******************
-- [문제022]
-- 부서명 및 관리자이름 표시
-- (단, 컬럼명은 관리자 [공백] 이름 이 되도록 ...)
-- DEPARTMENTS 에서 MANAGER_ID 가 관리자 코드
-- *******************  
select 
    D.DNAME 부서명, 
    E.FNAME ||' '|| E.LNAME "관리자 이름" 
from DEP D
    inner join EMP E
    on D.DID like E.EID;

-- ****************서브쿼리....***
-- [문제023]
-- 마케팅(Marketing) 부서에서 근무하는 사원의 
-- 사번, 직책, 이름, 근속기간
-- (단, 근속기간은 JOB_HISTORY 에서 END_DATE-START_DATE로 구할 것)
-- EMPLOYEE_ID 사번, JOB_TITLE 직책임
-- *******************  
SELECT D.DID 
FROM DEP D
WHERE D.DNAME LIKE 'MARKETING';
-------------------------------
SELECT E.EID 사번, J.TITLE 직책, E.FNAME 이름,
        H.EDATE - H.SDATE 근속일수
FROM HIS H
    JOIN JOB J
        ON H.JID LIKE J.JID
    JOIN EMP E
        ON E.EID LIKE H.EID
WHERE E.DID LIKE 20;

------- 서브쿼리로 사용 ------
SELECT E.EID 사번, J.TITLE 직책, E.FNAME 이름,
        H.EDATE - H.SDATE 근속일수
FROM HIS H
    JOIN JOB J
        ON H.JID LIKE J.JID
    JOIN EMP E
        ON E.EID LIKE H.EID
WHERE E.DID LIKE 20;


-- *******************
-- [문제024]
--  직책이 "Programmer"인 사원의 정보를 출력
-- DEPARTMENT_NAME 부서명, 이름(FIRST_NAME + [공백] + LAST_NAME)까지 출력
-- 이름은 중복되어서 출력됨. 즉 한명이 여러부서에서 업무를 수행함
-- *******************
SELECT 
    D.DNAME 부서명, 
    E.LNAME ||' '|| E.FNAME 이름
    
from EMP E
    join DEP D
    on D.DNAME like 'IT';

select * from DEP;


-- *******************
-- [문제025]
-- 부서명, 관리자 이름, 부서위치 도시 표시
-- 부서명 오름차순
-- *******************

SELECT
    D.DNAME 부서명,
    E.FNAME ||''|| E.LNAME "관리자 이름",
    L.CITY "부서위치 도시"
FROM DEP D
    JOIN EMP E
        ON D.MANID LIKE E.MANID
    JOIN LOC L
        USING(LID)
ORDER BY DNAME;


--    ON D.LID LIKE L.LID


-- *******************
-- [문제026]
-- 부서별 평균 급여를 구하시오. 
-- *******************
SELECT 
    D.DNAME "부서명",
    ROUND(AVG(E.SAL),2) "부서별 평균 급여"
FROM EMP E
    JOIN DEP D
        ON E.DID LIKE D.DID
GROUP BY E.DID, D.DNAME
HAVING ROUND(AVG(E.SAL),2) >= 10000
;

-- *******************
-- [문제027]
-- 부서별 평균 급여가 10000 이 넘는
--  부서명, "부서별 평균 급여" 를 출력하시오
-- *******************  



