--ex08_aggregation_function.sql

/*

	함수, Function
	1. 내장형 함수 (Bulit - in Function)
	2. 사용자 정의 함수 (User Function) > ANSI-SQL(X), PL/SQL(O)


	
	집계 함수, Aggregation Function
	- 아주 쉬움 > 뒤에 나오는 수업과 결합 > 꽤 어려움;;
	1. count()
	2. sum()
	3. avg()
	4. max()
	5. min()
	
	1. count()
	
	- 결과 테이블의 레코드 수를 반환한다.
	- number count (컬럼명)
		

*/

-- tblCountry. 총 나라 몇개국?

SELECT count(*) FROM tblcountry;  	 		--14(모든 레코드, 일부 컬럼에 null무관) 

SELECT count (name) FROM tblcountry; 		--14

SELECT count (population) FROM tblcountry;  --13  (null값 하나가있음)

SELECT * FROM tblcountry;    	--14
SELECT name FROM tblcountry;    	--14
SELECT population FROM tblcountry;    	--13



--모든 직원수?

SELECT count(*) FROM tblinsa; --60

-- 연락처가 있는 직원수?

SELECT tel FROM tblinsa; --57

-- 연락처가 없는 직원수?
SELECT count(*) - count(tel) FROM tblinsa; --3

SELECT count(*) FROM tblinsa WHERE tel IS NOT NULL; --57?
SELECT count(*) FROM tblinsa WHERE tel IS NULL; --3?

--tblInsa. 어떤 부서들 있나요?
SELECT DISTINCT buseo FROM tblinsa;

-- tblInsa. 부서가 총 몇 개?
SELECT count (DISTINCT nuseo) FROM tblinsa;

--tblComedian. 남자수? 여자수?
SELECT * FROM tblcomedian;

SELECT count(*) FROM tblcomedian WHERE gender = 'm';
SELECT count(*) FROM tblcomedian WHERE gender = 'f';

--남자수 + 여자수 > 1개의 테이블로 가져오시오.
SELECT 
	(CASE
		WHEN gender = 'm' THEN 1
	END) AS 남자인원수,
	(CASE
		WHEN gender = 'f' THEN 1
	END) AS 여자인원수
FROM tblcomedian;


--tblInsa. 기획부 몇명? 총무부 몇명? 개발부 몇명? 총인원? 나머지 부서사람들 몇명?

SELECT count(*) FROM tblinsa WHERE buseo = '기획부';   --7
SELECT count(*) FROM tblinsa WHERE buseo = '총무부';   --7
SELECT count(*) FROM tblinsa WHERE buseo = '개발부';   --14

SELECT
   count(CASE
      WHEN buseo = '기획부' THEN 'O'
   END) AS 기획부인원수,
   count(CASE
      WHEN buseo = '총무부' THEN 'O'
   END) AS 총무부인원수,
   count(CASE
      WHEN buseo = '개발부' THEN 'O'
   END) AS 개발부인원수,
   count(*) AS 전체인원수,
   count(
      CASE
         WHEN buseo NOT IN ('기획부', '총무부', '개발부') THEN 'O'
      END
   ) AS 나머지
FROM tblinsa;



/*
 	2. sum()
 	- 해당 칼럼의 합을 구한다.
 	- number sum(컬럼명)
 	- 해당 컬럼은 숫자형만 가능하다.
 	
 */

SELECT * FROM tblcomedian;
SELECT sum(height), sum(weight) FROM tblcomedian;
SELECT sum(FIRST)FROM tblcomedian;


SELECT
*	sum(basicpay) AS 지출급여합,
	sum(sudang) AS 지출수당합,
	sum(basicpay)+sum(sudang) AS 총지출,
 	sum(basicpay+sudang) AS 총지출
	FROM tblinsa;



/*
 	3. avg()
 	- 해당 컬럼의 평균값을 구한다.
 	- number avg(컬럼명)
 	- 숫자형만 적용 가능
 	- 
 */


--tblinsa. 평균급여?
SELECT sum(basicpay) / 60 FROM tblinsa; --1556526.66666666666666666666666666666667
SELECT sum(basicpay) / count(*) FROM tblinsa; 
SELECT avg(basicpay) FROM tblinsa;


--tblCountry 평균 인구수?
SELECT avg(population) FROM tblcountry; --15588
SELECT sum(population)/count(*)FROM tblcountry --14475 위랑 결과가 다르게 나옴 이방법은 틀림
SELECT sum(population)/count(population)FROM tblcountry --15588 평균을 구할때는 이렇게 해야함
SELECT count(population),count(*)FROM tblcountry  --13,14 NULL 값 때문에

-- 1팀 공로로 회사 성과급 지급 
-- 1. 균등 지급: 총지급액 / 모든 직원수 = sum/count(*) 
-- 2. 차등 지급: 총지급액 / 1팀 직원수 = sum/coumt(1팀)   = avg()

SELECT avg(name) FROM tblinsa;
SELECT avg(ibsadate) FROM tblinsa;

/*
 
 4.max()
 - object max(컬럼명)
 - 최댓값 반환
 
 5.min()
 - object min(컬럼명
 - 최솟값 반환
 
 - 숫자형, 문자형, 날짜형 모두 적용 가능
 
 
 */


SELECT max(Sudang),min(sudang) FROM tblinsa; 	 --숫자형
SELECT max(name), min(name) FROM tblinsa; 		 --문자형
SELECT max(ibsadate),min(ibsadate) FROM tblinsa; -- 날짜형



SELECT
	count(*) AS 직원수,
	sum(basicpay) AS 총급여합,
	avg(basicpay) AS 평균급여,
	max(basicpay) AS 최고급여,
	min(basicpay) AS 최저급여
FROM tblinsa;

--집계 함수 사용 주의점!!

--ORA-00937: not a single-group group function
--컬럼 리스트에서는 집계함수와 일반컬럼을 동시에 사용할 수 없다.

SELECT count(*) FROM tblinsa; --직원수
SELECT name FROM tblinsa; 	  --직원명

--요구사항] 직원들 이름과 총직원수를 동시에 가져오시오. 불가능!!
SELECT count(*), name FROM tblinsa; --불가능!


--2.ORA-00934: group function is not allowed here¶
--WHERE절에는 집계 함수를 사용할 수 없다.
-- WHERE 절은 개개인 레코드의 데이터를 접근해서 조건을 검색하고 집합값을 호출하는 것이 불가능하다

-- 요구사항] 평균 급여 보다 더 많이 받는 직원들?
SELECT avg(basicpay)FROM tblinsa; --1556526

SELECT * FROM tblinsa WHERE basicpay >= 1556526;
SELECT * FROM tblinsa WHERE basicpay >= avg(basicpay); 










SELECT
   first_name
FROM employees
   WHERE first_name LIKE '%an%' OR first_name LIKE '%AN%'
         OR first_name LIKE '%An%' OR first_name LIKE '%aN%'; --ANNA