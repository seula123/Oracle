-- 문제02.sql


-- distinct



--요구사항.001.employees
--직업이 어떤것들이 있는지 가져오시오. > job_id


SELECT job_id
FROM employees;

--요구사항.002.employees
--고용일이 2002~2004년 사이인 직원들은 어느 부서에 근무합니까? > hire_date + department_id


SELECT hire_date, department_id 
FROM employees;
WHERE hire_date>=2002 AND hire_date<=2004

--요구사항.003.employees
--급여가 5000불 이상인 직원들은 담당 매니저가 누구? > manager_id

SELECT *
FROM employees;

SELECT manager_id
FROM employees
WHERE salary>=5000

--요구사항.004.tblInsa
--남자 직원 + 80년대생들의 직급은 뭡니까? > ssn + jikwi

SELECT jikwi
FROM tblinsa
	WHERE ssn LIKE '8%';

--요구사항.005.tblInsa
--수당 20만원 넘는 직원들은 어디 삽니까? > sudang + city   

SELECT *
FROM tblinsa;


SELECT city,sudang
FROM tblinsa
	WHERE sudang>=200000
    
--요구사항.006.tblInsa
--연락처가 아직 없는 직원은 어느 부서입니까? > null + buseo

SELECT
*
FROM tblinsa;

SELECT buseo, tel
FROM tblinsa
	WHERE tel IS null







--요구사항.001.employees > 19행

--요구사항.002.employees > 10행

--요구사항.003.employees > 13행

--요구사항.004.tblInsa > 4행

--요구사항.005.tblInsa > 3행
    
--요구사항.006.tblInsa > 2행
	
	
	
-- 문제03.sql



-- 집계함수 > count()



-- 1. tblCountry. 아시아(AS)와 유럽(EU)에 속한 나라의 개수?? -> 7개
	
	SELECT *
	FROM tblcountry
	
	SELECT count(*)
	FROM tblcountry
	WHERE continent = 'EU' OR continent = 'AS'
        

-- 2. 인구수가 7000 ~ 20000 사이인 나라의 개수?? -> 2개
    
	
	SELECT COUNT(*)
	FROM tblcountry
	WHERE population >=7000 AND population <=20000

-- 3. hr.employees. job_id > 'IT_PROG' 중에서 급여가 5000불이 넘는 직원이 몇명? -> 2명
    

	SELECT *
	FROM employees

	SELECT count(*)
	FROM employees
	WHERE job_id = 'IT_PROG' AND salary >=5000;
	
-- 4. tblInsa. tel. 010을 안쓰는 사람은 몇명?(연락처가 없는 사람은 제외) -> 42명

SELECT
   count(tel)
FROM tblinsa 
  WHERE tel IS NOT NULL AND tel NOT LIKE '010%';
    
    

-- 5. city. 서울, 경기, 인천 -> 그 외의 지역 인원수? -> 18명

SELECT *
FROM tblinsa;

SELECT count(*)
FROM tblinsa
WHERE CITY NOT IN('서울','경기','인천');
    

-- 6. 여름태생(7~9월) + 여자 직원 총 몇명? -> 7명
SELECT *
FROM tblinsa;

SELECT count(*)
FROM tblinsa
WHERE (SSN LIKE '__07%' OR SSN LIKE '__08%' OR SSN LIKE'__09%') AND ssn LIKE '%-2';

-- 7. 개발부 + 직위별 인원수? -> 부장 ?명, 과장 ?명, 대리 ?명, 사원 ?명

SELECT 
   count(CASE
      WHEN JIKWI = '부장' THEN 4
   END) AS 부장,
   count(CASE 
      WHEN JIKWI = '과장' THEN 3
   END) AS 과장,
   count(CASE 
      WHEN JIKWI = '대리' THEN 2
   END) AS 대리,
   count(CASE 
      WHEN JIKWI = '사원' THEN 1
   END) AS 사원 
   FROM tblinsa WHERE buseo = '개발부'; 

SELECT * FROM tblinsa WHERE buseo = '개발부';




-- 문제04.sql


-- 집계함수 > sum(), avg(), max(), min()


--sum()
--1. 유럽과 아프리카에 속한 나라의 인구 수 합? tblCountry > 14,198

SELECT *
FROM tblcountry;

SELECT sum(population)
FROM tblcountry
WHERE continent IN ('EU','AF');

--2. 매니저(108)이 관리하고 있는 직원들의 급여 총합? hr.employees > 39,600

SELECT *
FROM employees;

SELECT sum(salary)
FROM employees
WHERE manager_id = 108

--3. 직업(ST_CLERK, SH_CLERK)을 가지는 직원들의 급여 합? hr.employees > 120,000

SELECT *
FROM employees;

SELECT sum(salary)
FROM employees
WHERE JOB_ID = 'ST_CLERK' OR JOB_ID = 'SH_CLERK'

--4. 서울에 있는 직원들의 급여 합(급여 + 수당)? tblInsa > 33,812,400

SELECT *
FROM tblinsa;

SELECT SUM(basicpay+SUDANG)
FROM TBLINSA
WHERE CITY = '서울';


--5. 장급(부장+과장)들의 급여 합? tblInsa > 36,289,000

SELECT *
FROM tblinsa;

SELECT sum(BASICPAY)
FROM tblinsa
WHERE jikwi = '부장' OR jikwi = '과장';

--avg()
--1. 아시아에 속한 국가의 평균 인구수? tblCountry > 39,165
SELECT
*
FROM tblcountry


SELECT avg(population)
FROM tblcountry
WHERE continent = 'AS'

--2. 이름(first_name)에 'AN'이 포함된 직원들의 평균 급여?(대소문자 구분없이) hr.employees > 6,270.4

SELECT *
FROM employees

SELECT AVG(SALARY)
FROM employees
WHERE lower(first_name) LIKE '%an%';

   WHERE first_name LIKE '%an%' OR first_name LIKE '%AN%'
         OR first_name LIKE '%An%' OR first_name LIKE '%aN%'; --ANNA

--3. 장급(부장+과장)의 평균 급여? tblInsa > 2,419,266.66
         
SELECT
*
FROM tblinsa;

SELECT
avg(basicpay)
FROM tblinsa
WHERE jikwi ='부장' OR jikwi = '과장';


--4. 사원급(대리+사원)의 평균 급여? tblInsa > 1,268,946.66

SELECT
*
FROM tblinsa;

SELECT
avg(basicpay)
FROM tblinsa
WHERE jikwi ='대리' OR jikwi = '사원';

--5. 장급(부장,과장)의 평균 급여와 사원급(대리,사원)의 평균 급여의 차액? tblInsa > 1,150,320

SELECT
avg 
--max(),min()
--1. 면적이 가장 넓은 나라의 면적은? tblCountry > 959


SELECT*
FROM tblcountry;


SELECT max(area)
FROM tblcountry;

--2. 급여(급여+수당)가 가장 적은 직원은 총 얼마를 받고 있는가? tblInsa > 988,000

SELECT min(basicpay+sudang)
FROM tblinsa;











