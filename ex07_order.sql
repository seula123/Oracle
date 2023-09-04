-- ex07_order.sql

/*

	    [WITH <Sub Query>] 
    SELECT column_list
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING search_condition]
    [ORDER BY order_expression [ASC|DESC]];
    
    select 컬럼리스트       4. 컬럼 지정 (보고 싶은 컬럼만 가져오기) > Projection
    from 테이블            1. 테이블 지정
    where 조건;         	 2. 조건 지정 (보고 싶은 행만 가져오기) > Selection
    group by 기준         3. (레코드끼리) 그룹을 나눈다.
	order by 정렬기준;     5. 순서대로
	
	
	order by 절
	- 원본 테이블 정렬(x) > 오라클 저장된 데이터 > 개발자 접근(x),오라클 스스로 관리(o)
	- 결과 테이블 정렬(o)
	- order by 컬럼명 [ASC|DESC] ASC:오름차순 DESC:내림차순
	
*/

SELECT * FROM TBLINSA ORDER BY NAME DESC;

SELECT * FROM TBLINSA ORDER BY BUSEO ASC;  --1차 정렬

SELECT * FROM TBLINSA ORDER BY BUSEO ASC, JIKWI DESC; --2차 정렬

SELECT * FROM TBLINSA ORDER BY BUSEO ASC, JIKWI DESC, BASICPAY DESC; --3차 정렬


-- 비교 > 숫자, 문자, 날짜 > 정렬 가능
SELECT * FROM TBLINSA ORDER BY BASICPAY DESC;

SELECT * FROM TBLINSA ORDER BY NAME ASC;

SELECT * FROM TBLINSA ORDER BY IBSADATE DESC;

SELECT NAME, BUSEO, JIKWI FROM TBLINSA ORDER BY 3;  --컬럼리스트의 컬럼순서(비권장):유지보수의 취약


-- 가공된 값의 정렬
-- 급여(basicpay + sudang)를 가장 많이 받는 직원순으로 가져오시오
SELECT * FROM TBLINSA ORDER BY (BASICPAY+SUDANG) DESC;

SELECT * FROM tblinsa;


-- 직위순으로 정렬: 부장 > 과장 > 대리 > 사원 순으로

SELECT 
	NAME, JIKWI,
	CASE
		WHEN JIKWI = '부장' THEN 4
		WHEN JIKWI = '과장' THEN 3
		WHEN JIKWI = '대리' THEN 2
		WHEN JIKWI = '사원' THEN 1
	END
FROM TBLINSA 
	ORDER BY JIKWI DESC;

SELECT 
	NAME, JIKWI,
	CASE
		WHEN JIKWI = '부장' THEN 4
		WHEN JIKWI = '과장' THEN 3
		WHEN JIKWI = '대리' THEN 2
		WHEN JIKWI = '사원' THEN 1
	END AS JIWISEQ
FROM TBLINSA 
	ORDER BY JIWISEQ DESC;
	

SELECT 
	NAME, JIKWI
FROM TBLINSA 
ORDER BY CASE
		WHEN JIKWI = '부장' THEN 4
		WHEN JIKWI = '과장' THEN 3
		WHEN JIKWI = '대리' THEN 2
		WHEN JIKWI = '사원' THEN 1
	END DESC;
	
--직원: 남자 > 여자 순으로
SELECT 
	NAME, SSN,
	CASE
		WHEN SSN LIKE '%-1%' THEN 1
		WHEN SSN LIKE '%-2%' THEN 2
	END
FROM TBLINSA;


--직원: 남자 > 여자 순으로
SELECT 
	NAME, SSN 
FROM TBLINSA;
	ORDER BY CASE
		WHEN SSN LIKE '%-1%' THEN 1
		WHEN SSN LIKE '%-2%' THEN 2
	END ASC;

-남자 직원만 가져오기
SELECT * FROM TBLINSA 
	WHERE  CASE
		WHEN SSN LIKE '%-1%' THEN 1
		WHEN SSN LIKE '%-2%' THEN 2
	END == 1
	;

SELECT * FROM TBLINSA 
	WHERE SSN LIKE '%-1%';

--CASE END는 컬럼이 들어갈 수 있는 곳에는 항상 들어갈 수 있다.


