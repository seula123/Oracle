

--ex22_union.sql

/*

	관계 대수 연산
	1. 셀렉션 > select where
	2. 프로젝션 > select column
	3. 조인
	4. 합집합(union), 차집합(minus), 교집합(intersect) --해당수업
	
	
	유니온, union
	- 스키마가 동일한 결과셋(***)끼리 가능
	
	
	
	
*/

--10+10 = 20RO
SELECT * FROM tblmen
UNION
SELECT * FROM tblwomen;

SELECT name,address,salary From tblstaff
union
SELECT name,city,basicpay FROM tblinsa;  --컬럼 이름이 달라도 상관없다


-- 어떤 회사 > 부서별 게시판 
SELECT * FROM 영업부게시판;
SELECT * FROM 총무부게시판;
SELECT * FROM 개발부게시판;

-- 회장님: 각 부서에 근황을 알고싶다 모든 부서에 게시판 글을 한번에 열람해서 보고싶음

SELECT * FROM 영업부게시판
union
SELECT * FROM 총무부게시판
union
SELECT * FROM 개발부게시판;



--야구선수 > 공격수, 수비수
SELECT * FROM 공격수;
SELECT * FROM 수비수;

SELECT * FROM 공격수
UNION
SELECT FROM 수비수;


--sns 하나의 테이블+ 다량의 데이터 > 기간별 테이블 분할

SELECT * FROM 게시판2020;
SELECT * FROM 게시판2021;
SELECT * FROM 게시판2022;
SELECT * FROM 게시판2023;

SELECT * FROM 게시판2020
UNION
SELECT * FROM 게시판2021
UNION
SELECT * FROM 게시판2022
UNION
SELECT * FROM 게시판2023;

--



CREATE TABLE tblAAA (
	name varchar2(30) NOT NULL
 );

CREATE TABLE tblBBB (
	name varchar2(30) NOT NULL
);


INSERT INTO tblAAA VALUES ('강아지');
INSERT INTO tblAAA VALUES ('고양이');
INSERT INTO tblAAA VALUES ('토끼');
INSERT INTO tblAAA VALUES ('거북이');
INSERT INTO tblAAA VALUES ('병아리');


INSERT INTO tblBBB VALUES ('강아지');
INSERT INTO tblBBB VALUES ('고양이');
INSERT INTO tblBBB VALUES ('호랑이');
INSERT INTO tblBBB V검ALUES ('사자');
INSERT INTO tblBBB VALUES ('코끼리');

SELECT * FROM tblaaa;
SELECT * FROM tblbbb;


--union > 수학의 집합 > 중복 제거 
SELECT * FROM tblaaa
UNION 
SELECT * FROM tblbbb;


--union all > 중복값 허용
SELECT * FROM tblaaa
UNION ALL
SELECT * FROM tblbbb;



-- intersect > 교집합 > 중복값만 출력
SELECT * FROM tblaaa
INTERSECT 
SELECT * FROM tblbbb;


-- minus > 차집합 (A - B) :거북이 병아리 토끼
SELECT * FROM tblaaa
MINUS
SELECT * FROM tblbbb;

--B-A : 사자 코끼리 호랑이
SELECT * FROM tblbbb
MINUS
SELECT * FROM tblaaa;








