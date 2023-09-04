/*

  ex24_pseudo.SQL

의사 컬럼, pseudo COLUMN
- 실제 컬럼이 아닌데 컬럼처럼 행동하는 객체


	rownum
	-행번호
	-시퀀스 객체 상관X
	-현재 테이블의 행번호를 가져오는 역할
	-테이블에 지정된 값이 아니ㅏㄹ, SELECT 실행시 동적으로 계산되어 만들어진다(***)
	- FROM 절이 실행될때 각 레포트에 ROWNUM을 할당한다.(*************)
	-WHERE 절이 실행될 때 상황에 따라 ROWNUM이 재계산된다(****) > from 절에서 만들어진 rownum은 where절이 실행될 때 변경될 수 있다.
	
***/

SELECT
	name, buseo, --컬럼(속성) >output(읽기전용) >객체(레코드)의 특성에 따라 다른 값을 가진다.
	100,			--상수 > OUTPUT > 모든 레코드가 동일한 값을 가진다.
	substr(name, 2), --함수 > INPUT + OUTPUT >객체 특성에 따라 다른값을 가진다.
	rownum 			-- 의사 컬럼 + OUTPUT
FROM tblinsa;
--등수를 매겨서 부분추출하는 모든행동을 rownum을 사용하면 된다

--게시판 > 페이지
--1페이지 > rownum between 1 and 20
--2페이지 > rownum between 21 and 40
--3페이지 > rownum between 41 and 60


SELECT name, buseo, rownum FROM tblinsa WHERE rownum =1; --첫번째에 있는애를 가져와랑
SELECT name, buseo, rownum FROM tblinsa WHERE rownum <=5; 

SELECT name, buseo, rownum FROM tblinsa WHERE rownum =5; --안가져와짐
SELECT name, buseo, rownum FROM tblinsa WHERE rownum >5 AND rownum <=10 ; --안가져와짐
 
SELECT name, buseo, rownum --2.소비 > 1에서 만든 rownum을 가져온다. (여기서 생성x)
FROM tblinsa; 		--1. 생성 > from절이 실행되는 순간 모든 레코드의 rownum이 할당됨


SELECT name, buseo, rownum  --3.소비	
FROM tblinsa				--1.생성
WHERE rownum =1;			--2.조건

SELECT name, buseo, rownum  --3.소비	
FROM tblinsa				--1.생성
WHERE rownum =3;			--2.조건


SELECT name, buseo, rownum  --3.소비	
FROM tblinsa				--1.생성
WHERE rownum =3;			--2.조건





SELECT name, buseo, basicpay,rownum
FROM tblinsa						--1. rownum 할당
ORDER BY basicpay DESC;				--2. 정렬


--가지런하게 변경 내가 원하는 순서대로 정렬후 rownum을 할당하는 방법 > 서브쿼리 사용 (***)
SELECT name, buseo, basicpay, rownum,rnum 
FROM (SELECT name, buseo, basicpay,rownum AS rnum  --내가 원하는순서대로 가지런하게 정렬
FROM tblinsa						
ORDER BY basicpay DESC)WHERE rownum <=3; -- 원하는 값 추출		


--급여 5~10등까지 
-- 원하는 범위 추출 (1이 포함x) > rownum 사용 불가능 
--1. 내가 원하는 순서대로 정렬
--2. 1을 서브쿼리로 묶는다 + rownum(rnum)
--3. 2를 서브쿼리로 묶는다. + rownum(불필요)+rnum(사용***)
SELECT name, buseo, basicpay, rnum, rownum 
FROM (SELECT name, buseo, basicpay, rownum AS rnum  --2
               FROM (SELECT name, buseo, basicpay
                  FROM tblinsa                  
                     ORDER BY BASICPAY DESC))  --1
                     	WHERE rnum BETWEEN 5 AND 10;
                     	
                     
-- 페이징 > 이름순으로 한번에 20명씩 보기(나눠서 보기)
SELECT * FROM tbladdressbook;   --2000건                     

--1.내가 원하는 대로 정렬을 한다
SELECT * FROM tbladdressbook ORDER BY name asc;                  

--2. 서브쿼리로 묶는다. 이 때의 rownum이 필요하다.
SELECT a.*, rownum FROM (SELECT * FROM tbladdressbook ORDER BY name ASC) a;

--3. rownum을 조건으로 사용하고 싶으면 한번 더 서브쿼리를 묶어야 함
SELECT * FROM (SELECT a.*, rownum AS rnum FROM (SELECT * FROM tbladdressbook ORDER BY name ASC) a) WHERE rnum BETWEEN 1 AND 20;

SELECT * FROM (SELECT a.*, rownum AS rnum FROM (SELECT * FROM tbladdressbook ORDER BY name ASC) a) WHERE rnum BETWEEN 21 AND 40;

SELECT * FROM (SELECT a.*, rownum AS rnum FROM (SELECT * FROM tbladdressbook ORDER BY name ASC) a) WHERE rnum BETWEEN 1981 AND 2000;



SELECT * FROM (SELECT a.*, rownum AS rnum FROM (SELECT * FROM tbladdressbook ORDER BY name ASC) a) WHERE rnum BETWEEN 1981 AND 2000;


CREATE OR REPLACE VIEW vwAddressBook
AS
SELECT a.*, rownum AS rnum FROM (SELECT * FROM tbladdressbook ORDER BY name ASC) a;


SELECT * FROM vwaddressbook;

SELECT * FROM vwaddressbook WHERE rnum BETWEEN 1 AND 20;

