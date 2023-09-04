--ex21_view.sql


/*

	view, 뷰
	- 데이터베이스 객체 중 하나 (테이블, 제약사항, 뷰, 시퀀스)
	- 가상 테이블, 뷰 테이블 등..
	- 테이블처럼 사용한다.(***)
	- 쿼리의 양을 줄인다.
	- 정의: 쿼리(sql)을 저장하는 객체 *면접용 대답!!!!
	- 목적: 
	create [or replace] view 뷰이름
	as
	select 문;
	
*/


CREATE OR REPLACE VIEW vwInsa
AS 
SELECT * FROM tblinsa;

SELECT * FROM vwinsa; --tblInsa 테이블의 복사본

-- '영업부' 직원  -실명뷰
-- as밑 select를 영업부에 다시 저장 -익명뷰
CREATE OR REPLACE VIEW 영업부
AS 
SELECT 
	num,name,city,basicpay,substr(ssn,8) AS ssn
FROM tblinsa 
	WHERE buseo = '영업부';
	
SELECT * FROM 영업부;



--비디오 대여점 사장 > 날마다 하는 업무
CREATE OR REPLACE VIEW vwCheck
as
SELECT
   m.name AS 회원,
   v.name AS 비디오,
   r.rentdate AS 빌린날짜,
   r.retdate AS 반납날짜,
   r.rentdate + g.period AS 반납예정일,
   sysdate - (r.rentdate + g.period) AS 연체일,
   (sysdate - (r.rentdate + g.period)) * g.period * 0.1 AS 연체료
FROM tblrent r
   INNER JOIN tblvideo v
      On r.video = v.seq
         INNER JOIN tblmember m
            ON m.seq = r.MEMBER
               INNER JOIN tblgenre g
                  ON g.seq = v.genre;

			
			
SELECT * FROM tblgenre;
			
SELECT * FROM vwCheck;

			
			

-- tblInsa > 서울 직원 > view

CREATE OR REPLACE VIEW vwSeoul
as
SELECT * FROM tblinsa WHERE city = '서울';  -- 뷰를 만드는 시점에서는 20명이 있다.


SELECT * FROM vwSeoul   --20명

--서울사는 (길동,한석봉,김학년) 직원이 제주도로 이사갔음
UPDATE tblinsa SET city = '제주' WHERE num IN (1001, 1005, 1008);

SELECT * FROM tblinsa WHERE city = '서울';   --17명

--만들고 난 이후부터는 view에도 조작된게 반영이된다, 마찬가지로 view를 조작해도 테이블에 반영된다.
--
SELECT * FROM vwSeoul; -- 17aud



--신입 사원 업무: 연락처를 확인해서 문자발송  >< hr 계정 비밀번호 : java1234
SELECT * FROM tblinsa;  --신입 계정 > tblInsa 접근 권한(x)
SELECT * FROM vwTel;	--신입 계정 > vwTest 접근 읽기 권한(o)

CREATE OR REPLACE VIEW vwTel
AS
SELECT name, buseo, jikwi, tel FROM tblinsa;


--뷰 사용 주의점!!!!
--1. SELECT > 실행o > 뷰는 읽기 전용으로 사용한다 = 읽기전용 테이블
--2. insert > 실행o > 절대 사용금지
--3. update > 실행o > 절대 사용금지
--4. delete > 실행o > 절대 사용금지

CREATE OR REPLACE VIEW vwTodo  --단순뷰  뷰의 SELECT가 1개의 테이블로 구성
AS
SELECT * FROM tblTodo;


SELECT * FROM vwTodo;
INSERT INTO vwTodo


SELECT * FROM vwTodo;
INSERT INTO vwTodo VALUES ((SELECT max(seq) + 1 FROM tblTodo), '할일', sysdate, NULL);
UPDATE vwTodo SET title = '할일 완료' WHERE seq = 27;
DELETE vwTodo WHERE seq = 27;


SELECT * FROM vwTodo;
SELECT * FROM vwCheck;



