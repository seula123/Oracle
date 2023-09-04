--ex10_string_function.sql



/*

	문자열 함수
	
	대소문자 변환
	- upper(), lower(), initcap()
	- varchar2 upper(컬럼)
	- varchar2 lower(컬럼)
	- varchar2 initcap (컬럼)
	
*/

SELECT
	first_name,
	upper(first_name),
	lower(First_name)
FROM employees;


SELECT
	'abc',
	initcap('abc'), -- 첫문자를 대문자로
	initcap('abc')  -- 나머지 문자는 소문자로
FROM dual;


--이름(first_name) 에 'an' 포함된 직원 > 대소문자 구분없이

SELECT
	first_name
FROM employees
	WHERE first_name LIKE '%an%' OR first_name LIKE '%AN%'
			OR first_name LIKE '%An%' OR first_name LIKE '%aN%'; --ANNA
			
			
			
SELECT
	first_name
FROM employees
	WHERE lower(first_name) LIKE '%an%';
	

/*
 	문자열 추출 함수
 	- substr() > substring()
 	- varchar2 substr(컬럼, 시작위치, 가져올 문자 갯수)
 	- varchar2 substr(컬럼, 시작위치)  --숫자안넣어주면 끝까지 가져옴
 */
*/