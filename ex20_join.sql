--ex20_join.sql

/*

	관계형 데이터베이스 시스템이 지양하는 것들
	 -테이블 다시 수정해야 고쳐지는 것들 > 구조적인 문제!!
	1. 테이블에 기본키가 없는 상태 > 데이터 조작 곤란
	2. null이 많은 상태의 테이블 > 공간 낭비
	3. 데이터가 중복되는 상태	   > 공간 낭비 + 데이터 조작 곤란
	4. 하나의 속성값이 원자값이 아닌 상태 > 더이상 쪼개지지 않는 값을 넣어야 한다.
	
	
*/

--1.
CREATE TABLE tblTest(
	name varchar2(30) NOT NULL,
	age NUMBER (3) NOT NULL,
	nick varchar2(30) NOT NULL
);


-- 홍길동, 20, 강아지
-- 아무개, 22, 바보
-- 테스트, 20, 반장
-- 홍길동, 20, 강아지 > 발생(X), 조작(?)


INSERT INTO tblTest VALUES ('홍길동', 20, '강아지');
INSERT INTO tblTest VALUES ('아무개', 22, '바보');
INSERT INTO tblTest VALUES ('테스트', 20, '반장');
INSERT INTO tblTest VALUES ('홍길동', 20, '강아지');

--홍길동 별명 수정
UPDATE tblTest SET nick ='고양이' WHERE name='강아지';  --> 식별 불가능

--홍길동 탈퇴
DELETE FROM tblTest WHERE name='홍길동'; -->식별 불가능

DROP TABLE tblTest;




--2. null이 많은 상태의 테이블 > 공간 낭비

CREATE TABLE tblTest
(
	name varchar(30) PRIMARY KEY;
	age number(3) NOT NULL;
	nick varchar2(30) NOT NULL,
	hobby1 varchar2(100) NULL,
	hobby2 varchar2(100) NULL,
	hobby3 varchar2(100) NULL,
	..
	hobby8 varchar2(100) NULL
	
);


INSERT INTO tblTest VALUES ('홍길동', 20, '강아지', null);
INSERT INTO tblTest VALUES ('아무개', 22, '고양이', '게임');
INSERT INTO tblTest VALUES ('이순신', 24, '거북이', '수영', '활쏘기');



-- 홍길동, 20, 강아지, null, null, null, null, null, null, null, null
-- 아무개, 22, 고양이, 게임, null, null, null, null, null, null, null
-- 이순신, 24, 거북이, 수영, 활쏘기, null, null, null, null, null, null
-- 테스트, 25, 닭, 수영, 독서, 낮잠, 여행, 맛집, 공부, 코딩, 영화

-- 직원 정보
-- 직원 (번호, 직원명, 급여, 거주지, 담당프로젝트)
CREATE TABLE tblStaff (
	seq NUMBER PRIMARY KEY,		 	 --직원번호(pk)
	name varchar2(30) NOT NULL,		 --직원명
	salary NUMBER NOT NULL,			 --급여
	address varchar2(300) NOT NULL,	 --거주지
	project varchar2(300)			 --담당프로젝트
);

INSERT INTO tblstaff(seq, name, salary, address, project) VALUES (1, '홍길동', 300, '서울시', '홍콩 수출');
INSERT INTO tblstaff(seq, name, salary, address, project) VALUES (2, '아무개', 250, '인천시', 'TV 광고');
INSERT INTO tblstaff(seq, name, salary, address, project) VALUES (3, '하하하', 350, '의정부시', '매출 분석');

SELECT * FROM tblstaff;

--'홍길동'에게 담당 프로젝트 1건('고객 관리')이 추가되었다. 
UPDATE tblstaff SET project = project + '고객 관리' WHERE seq=1;   --> 절대 금지.  --> 실행하면 '홍콩 수출, 고객 관리' 이렇게 됨.

--밑에 이런 방식으로만 가능.
INSERT INTO tblstaff(seq, name, salary, address, project) VALUES (4, '홍길동', 300, '서울시', '고객관리');

--
INSERT INTO tblstaff(seq, name, salary, address, project) VALUES (5, '호호호', 250, '서울시', '게시판 관리, 회원 응대');

--'TV 광고'를 맡은 담당자 불러!
SELECT * FROM tblStaff WHERE project='TV 광고';

--'회원 응대'를 맡은 담당자 불러!
SELECT * FROM tblStaff WHERE project LIKE;

INSERT INTO tblstaff(seq, name, salary, address, project) VALUES (6, '후후후', 250, '부산시', '불량 회원 응대');
SELECT * FROM tblStaff;

--'회원 응대' 에서 '멤버 조치'라고 수정을 원함.
UPDATE tblstaff SET project ='멤버 조치' WHERE project LIKE '%회원 응대%';




--해결 > 테이블 재구성
DROP TABLE tblStaff;
DROP TABLE tblproject;


-- 직원 정보
-- 직원(번호(PK)), 직원명, 급여, 거주지, 답당프로젝트)
CREATE TABLE tblStaff(
	seq NUMBER primary KEY,				--직원번호(PK)
	name varchar2(30) NOT NULL,			--직원명
	salary NUMBER NOT NULL,				--급여
	address varchar2(300) NOT NULL	--거주지
	--project varchar2(300)			--담당프로젝트  --> 문제가 되는 컬럼은 아예 제거. -> 따로 만들기

);

--프로젝트 정보
CREATE TABLE tblProject(
	seq NUMBER PRIMARY KEY,				--프로젝트 번호(PK)
	project varchar2(100) NOT NULL,   	--프로젝트명
	staff_seq NUMBER NOT NULL		   	--담당 직원 번호

);

INSERT INTO tblStaff (seq, name, salary, address) VALUES (1, '홍길동', 300, '서울시');
INSERT INTO tblStaff (seq, name, salary, address) VALUES (2, '아무개', 250, '인천시');
INSERT INTO tblStaff (seq, name, salary, address) VALUES (3, '하하하', 250, '부산시');

INSERT INTO tblProject (seq, project, staff_seq) VALUES (1, '홍콩 수출', 1);  --홍길동
INSERT INTO tblProject (seq, project, staff_seq) VALUES (2, 'TV 광고', 2);  --아무개
INSERT INTO tblProject (seq, project, staff_seq) VALUES (3, '매출 분석', 3);  --하하하
INSERT INTO tblProject (seq, project, staff_seq) VALUES (4, '노조 협상', 1);  --홍길동
INSERT INTO tblProject (seq, project, staff_seq) VALUES (5, '대리점 분양', 2);  --아무개

SELECT * FROM tblStaff;
SELECT * FROM tblproject;


--'TV 광고' 담당자 불러!
SELECT staff_seq FROM tblproject WHERE project ='TV 광고';
SELECT * FROM tblstaff WHERE seq=(SELECT staff_seq FROM tblproject WHERE project ='홍콩 수출');


--A. 신입 사원이 입사하고 신규 프로젝트를 담당했다.
--A-1) 신입 사원 추가
INSERT INTO tblStaff (seq, name, salary, address) VALUES (4, '호호호', 250, '성남시');
--A-2) 신규 프로젝트 추가
INSERT INTO tblProject (seq, project, staff_seq) VALUES (6, '자재 매입', 4);

--A-3) 또 신규 프로젝트가 추가
INSERT INTO tblProject (seq, project, staff_seq) VALUES (7, '고객 유치', 5);
--실행이 되는데, 되면 안된다 -> 담당자가 없는 사람이니까. -> 논리 오류.

SELECT * FROM tblstaff WHERE seq=(SELECT staff_seq FROM tblproject WHERE project ='고객 유치');



--B. '홍길동' 퇴사
--B-1) '홍길동' 삭제
DELETE FROM tblstaff WHERE seq=1;
--얘도 문제 있다. 홍길동이 담당하고 있는 프로젝트가 2개나 있으니까 나가면 문제가 생김..

--B-2) '홍길동' 삭제 -> 퇴사전에 인수인계 하고 가야함.
UPDATE tblproject SET staff_seq =2 WHERE staff_seq=1;

--B-3) '홍길동' 삭제 -> 인수인계 마무리했으니 안전하게 퇴사시키기.
DELETE FROM tblstaff WHERE seq=1;


--references 하고 상황 다시보기.
--참조는 무조건 primary key를 참조해야한다.
--테이블 초기화하기-----------------------------------------------------------------------------------------------------------------------
DROP TABLE tblstaff;
DROP TABLE tblproject;

CREATE TABLE tblProject(
	seq NUMBER PRIMARY KEY,														--프로젝트 번호(PK)
	project varchar2(100) NOT NULL,   											--프로젝트명
	staff_seq NUMBER NOT NULL REFERENCES tblstaff(seq)		   	--담당 직원 번호
	--참조하는 순간부터 테이블을 만드는 순서가 생겨버림.
);  --FOREIGN KEY를 가지고 있는 테이블이 자식 테이블.

CREATE TABLE tblStaff(
	seq NUMBER primary KEY,				--직원번호(PK)
	name varchar2(30) NOT NULL,			--직원명
	salary NUMBER NOT NULL,				--급여
	address varchar2(300) NOT NULL	--거주지

);	--부모 테이블

--만들 때는 부모부터 만들고 이후에 자식만들기 / 지울때는 자식먼저 지우고 이후에 부모지우기.

--A. 신입 사원이 입사하고 신규 프로젝트를 담당했다.
--A-1) 신입 사원 추가
INSERT INTO tblStaff (seq, name, salary, address) VALUES (4, '호호호', 250, '성남시');
--A-2) 신규 프로젝트 추가
INSERT INTO tblProject (seq, project, staff_seq) VALUES (6, '자재 매입', 4);

--A-3) 또 신규 프로젝트가 추가
INSERT INTO tblProject (seq, project, staff_seq) VALUES (7, '고객 유치', 5);
--에러.  parent key not found : 부모키의 primary key를 잘못적었다는 뜻.


--B. '홍길동' 퇴사
--B-1) '홍길동' 삭제
DELETE FROM tblstaff WHERE seq=1;
--에러. child record found : 자식 레코드가 있기 때문에 삭제가 안된다는 뜻.

--B-2) '홍길동' 삭제 -> 퇴사전에 인수인계 하고 가야함.
UPDATE tblproject SET staff_seq =2 WHERE staff_seq=1;

--B-3) '홍길동' 삭제 -> 인수인계 마무리했으니 안전하게 퇴사시키기.
DELETE FROM tblstaff WHERE seq=1;

SELECT * FROM tblstaff;
SELECT * FROM tblproject;


------------------------------------------------------------------------------------------------------------------------------------------


--** 자식 테이블보다 부모 테이블이 먼저 발생한다(테이블 생성, 레코드 생성)
-- 고객 테이블
create table tblCustomer (
    seq number primary key,         --고객번호(PK)
    name varchar2(30) not null,     --고객명
    tel varchar2(15) not null,      --연락처
    address varchar2(100) not null  --주소
);  --부모테이블

-- 판매내역 테이블
create table tblSales (
    seq number primary key,                             --판매번호(PK)
    item varchar2(50) not null,                         --제품명
    qty number not null,                                --판매수량
    regdate date default sysdate not null,              --판매날짜
    cseq number not null references tblCustomer(seq)    --판매한 고객번호(FK)
);  --자식테이블

--자식테이블보다 부모테이블이 먼저 발생한다.(테이블 생성, 레코드 생성)  --> 고객이 있어야 판매 내역도 생기니까.

CREATE SEQUENCE genreSeq;
CREATE SEQUENCE videoSeq;
CREATE SEQUENCE memberSeq;
CREATE SEQUENCE rentSeq;




-- [비디오 대여점]

-- 장르 테이블
create table tblGenre (
    seq number primary key,         --장르 번호(PK)
    name varchar2(30) not null,     --장르명
    price number not null,          --대여가격
    period number not null          --대여기간(일)
);

-- 비디오 테이블
create table tblVideo (
    seq number primary key,                         --비디오 번호(PK)
    name varchar2(100) not null,                    --비디오 제목
    qty number not null,                            --보유 수량
    company varchar2(50) null,                      --제작사
    director varchar2(50) null,                     --감독
    major varchar2(50) null,                        --주연배우
    genre number not null references tblGenre(seq)  --장르 번호(FK)
);

-- 고객 테이블
create table tblMember (
    seq number primary key,         --고객번호(PK)
    name varchar2(30) not null,     --고객명
    grade number(1) not null,       --고객등급(1,2,3)
    byear number(4) not null,       --생년
    tel varchar2(15) not null,      --연락처
    address varchar2(300) null,     --주소
    money number not null           --예치금
);

-- 대여 테이블
create table tblRent (
    seq number primary key,                             --대여번호(PK)
    member number not null references tblMember(seq),   --회원번호(FK)
    video number not null references tblVideo(seq),     --비디오번호(FK)
    rentdate date default sysdate not null,             --대여시각
    retdate date null,                                  --반납시각
    remark varchar2(500) null                           --비고
);

DROP TABLE tblrent;



SELECT * FROM tblCustomer;
SELECT * FROM tblSales;
SELECT * FROM tblGenre;
SELECT * FROM tblVideo;
SELECT * FROM tblMember;
SELECT * FROM tblRent;


/*
	조인, Join
	- (서로 관계를 맺은)2개(1개) 이상의 테이블을 1개의 결과셋으로 만드는 기술
	
	조인의 종류
	1. 단순 조인(Cross Join)
	
	2. 내부 조인(Inner Join)*****
	
	3. 외부 조인(Outer Join)*****
	
	4. 셀프 조인(Self Join)
	
	5. 전체 외부 조인(Full Outer Join)
	
*/


/*
	1. 단순 조인(Cross Join, 카티션곱(데카르트곱))
	- A 테이블 X B테이블
	- 가치있는 행과 가치없는 행이 뒤섞여 있어서 쓸모없다.
	- 유효성과 무관한 더미 데이터를 생성할 때, 유용하게 생성 가능.
	
	구문 : select 컬럼리스트 from 테이블A cross join 테이블B;
	
*/

SELECT * FROM tblcustomer;  --3명
SELECT * FROM tblSales;  --9건

SELECT * FROM tblcustomer CROSS JOIN tblsales;   --> CROSS JOIN == X     --> 3x9 =27개     --> ANSI-SQL방식
--SELECT * FROM tblcustomer, tblsales;   --> 위 문장과 결과가 같다. but Oracle에서만 이런 표현방식으로 사용 가능.


/*
 	2. 내부 조인, INNER JOIN 
  	- 단순 조인에서 유효한 레코드만 추출한 조인
  	
	select 컬럼리스트 from 테이블A cross join 테이블B;
	
	select 컬럼리스트 from 테이블A inner join 테이블B on 테이블A.PK = 테이블B.FK;
	
  	
 */

COMMIT;

--직원 테이블, 프로젝트 테이블
SELECT
*
FROM tblstaff
	CROSS JOIN tblProject;


SELECT
	tblstaff.seq,
	tblstaff.name,
	tblProject.seq,
	tblProject.project
FROM tblstaff
	INNER JOIN tblProject
		ON tblstaff.seq = tblproject.staff_seq
			ORDER BY tblProject.seq;
			
	
		
--조인에서 테이블 병칭을 자주 사용한다.		
SELECT				--2
	s.seq,
	s.name,
	p.seq,
	p.project
FROM tblstaff s  
	INNER JOIN tblProject p 
		ON tblstaff.seq = tblproject.staff_seq  --1  
			ORDER BY tblProject.seq;   --3



-- 고객 테이블, 판매 테이블

SELECT
	c.name AS 고객명,
	s.item AS 제품명,
	S.qty AS 개수
FROM tblcustomer c
	INNER JOIN tblsales s
		ON c.seq = s.cseq
		
		
SELECT * FROM tblmen;
SELECT * FROM tblwomen;


SELECT * FROM tblcustomer;
SELECT * FROM tblsales;
SELECT * FROM tblGenre;
SELECT * FROM tblVideo;
SELECT * FROM tblMember;
SELECT * FROM tblRent;


SELECT 
	*
FROM tblmen M
	INNER JOIN tblwomen w
		ON m.name = w.couple;
	
	
SELECT
*
FROM tblstaff st
	INNER JOIN tblSales sa
		ON st.seq = sa.cseq;
	
	
-- 고객명(tblCustomer)+ 판매물품명(tblSales) > 가져오시오.
-- 1. 조인
SELECT
	c.name AS 고객명,
	s.item AS 물품명
FROM tblcustomer c
	INNER JOIN tblsales s
		ON c.seq = s.seq;
	
-- 2. 서브 쿼리 > 상관 서브 쿼리
-- 메인 쿼리 > 자식 테이블
-- 상관 서브 쿼리 > 부모 테이블

SELECT
	item AS 물품명,
	(SELECT name FROM tblcustomer WHERE seq = tblsales.cseq) AS 고객명
FROM tblsales;















--비디오 + 장르 > 조인
SELECT
	v.name,
	g.name,
	g.price
FROM tblgenre g
	INNER JOIN tblvideo v
		ON g.seq = v.genre ;
	
	
	
--비디오 + 장르 + 대여
SELECT
	v.name,
	g.name,
	g.price
	r.MEMBER
	r.rentdate
	r.retdate
FROM tblgenre g
	INNER JOIN tblvideo v
		ON g.seq = v.genre
			INNER JOIN tblrent r
				ON v.seq = r.video;
	
			
			
--장르 + 비디오 + 대여 + 회원	
SELECT
*
FROM tblgenre g
	INNER JOIN tblvideo v
		ON g.seq = v.genre
			INNER JOIN tblrent r
				ON v.seq = r.video
					INNER JOIN tblmemer m
						ON m.seq = r.member;
			
			
			
			
			
--hr 샘플데이터 조인
SELECT 
	e.first_name || ' ' || e.last_name AS "직원명",
	d.department_name AS "부서명",
	l.city AS "도시명",
	c.country_name AS "국가명",
	r.region_name AS "대륙명",
	j.job_title AS "직업"
FROM employees e
   INNER JOIN departments d
      ON d.department_id = e.department_id --PK키와 FK를 동일하게 생성해서 덜 헷갈림
         INNER JOIN locations l
            ON l.location_id = d.location_id
               INNER JOIN countries c
                  ON c.country_id = l.country_id
                     INNER JOIN regions r
                        ON r.region_id = c.region_id
                           INNER JOIN jobs j
                              ON j.job_id = e.job_id; --jobs 와 employees 연결, 순서 상관없음
			
SELECT * FROM departments;
SELECT * FROM locations;
SELECT * FROM countries
SELECT * FROM regions;
			


/*
   3. 외부 조인, OUTER JOIN
   - 내부 조인의 반댓말(X)
   - 내부 조인 결과 + 내부 조인에서 포함되지 않았던 부모테이블의 나머지 레코드를 합하는 조인
   
   <내부조인>
    select
       컬럼리스트
    from 테이블A
       inner join 테이블B
          on 테이블A.컬럼 = 테이블B.컬럼; 
          
   <외부조인>
    select
       컬럼리스트
    from 테이블A
       (left|right)outer join 테이블B
          on 테이블A.컬럼 = 테이블B.컬럼; 
          
    select
       컬럼리스트
    from 테이블A left outer join 테이블B >> A테이블을 가리킴
          on 테이블A.컬럼 = 테이블B.컬럼; 
*/
   
SELECT * FROM tblcustomer; --3명
SELECT * FROM tblsales; --9건

INSERT INTO tblcustomer VALUES (4, '호호호', '010-1234-1234', '서울시');
INSERT INTO tblcustomer VALUES (5, '이순신', '010-1234-1234', '서울시');


--내부조인
--!물건을 한번이라도 구매한 이력이 있는! 고객의 정보와 그 고객이 사간 구매내역을 가져오시오
SELECT *
FROM tblcustomer c
   INNER JOIN tblsales s
      ON s.cseq = c.seq;   --9
   
--외부조인
SELECT *
FROM tblcustomer c
   LEFT OUTER JOIN tblsales s
      ON s.cseq = c.seq;   --11


SELECT *
FROM tblcustomer c
   RIGHT OUTER JOIN tblsales s
      ON s.cseq = c.seq;   --9 내부조인과 동일한 결과

      
      
INSERT INTO tblstaff VALUES (4, '호호호', 250, '성남시');
INSERT INTO tblproject VALUES (6, '자재 매입', 4);
      
SELECT * FROM tblstaff; --3명
SELECT * FROM tblproject; --6건


UPDATE tblproject SET staff_seq = 4 WHERE staff_seq = 3;

--프로젝트를 1건 이상 담당하고 있는 직원을 가져오시오.
SELECT 
   * 
FROM tblstaff s
   INNER JOIN tblproject p
      ON s.seq = p.staff_seq;   --6건

--담당 프로젝트의 유무와 상관없이 모든 직원을 가져오시오.
SELECT 
   * 
FROM tblstaff s
   LEFT OUTER JOIN tblproject p
      ON s.seq = p.staff_seq;   --7건


--대여가 한번이라도 발생한 비디오와 대여기록   
SELECT 
   * 
FROM tblvideo v
   INNER JOIN tblrent r
      ON v.seq = r.video;

--아무도 빌려가지 않은 악성재고 확인
SELECT 
   * 
FROM tblvideo v
   LEFT OUTER JOIN tblrent r
      ON v.seq = r.video;
      

--대여를 최소 1회 이상 했던 회원과 대여내역 
SELECT 
   * 
FROM tblmember m
   INNER JOIN tblrent r
      ON m.seq = r.MEMBER;

--대여를 한번도 안한 회원 확인
SELECT 
   * 
FROM tblmember m
   LEFT OUTER JOIN tblrent r
      ON m.seq = r.MEMBER;
   
--대여를 한번도 안한 회원 명단
SELECT 
   * 
FROM tblmember m
   LEFT OUTER JOIN tblrent r
      ON m.seq = r.MEMBER
         WHERE r.seq IS null;
   
--대여 기록이 있는 회원의 이름
SELECT 
   DISTINCT(m.name)
FROM tblmember m
   INNER JOIN tblrent r
      ON m.seq = r.MEMBER;
   
--대여 기록이 있는 회원의 이름 + 대여 횟수(우수고객 확인)
SELECT 
   m.name,
   count(*)
FROM tblmember m
   INNER JOIN tblrent r
      ON m.seq = r.MEMBER
         GROUP BY m.name;
   
--대여 기록의 유무에 상관없이 대여횟수 출력
SELECT
   m.name,
   count(r.seq)
FROM tblmember m
   LEFT  JOIN tblrent r
      ON m.seq = r.MEMBER
         GROUP BY m.name
            ORDER BY count(r.seq) desc;
   
/*
    4. 셀프 조인, SELF JOIN
    - 1개의 테이블을 사용하는 조인
    - 테이블이 자기 스스로와 관계를 맺는 경우
    
    <기존>
    - 다중 조인(2개) + 내부조인
    - 다중 조인(2개) + 외부조인
    
    <셀프>
    - 셀프 조인(1개) + 내부조인
    - 셀프 조인(1개) + 외부조인

*/

	
	
--직원 테이블
CREATE TABLE tblSelf(
	seq NUMBER PRIMARY KEY,
	name varchar2(30) NOT NULL,
	department varchar2(30) NOT NULL,
	super NUMBER NULL REFERENCES tblSelf(seq)
);

INSERT INTO tblself VALUES (1,'홍사장','사장',null);
INSERT INTO tblself VALUES (2,'김부장','영업부',1);
INSERT INTO tblself VALUES (3,'박과장','영업부',2);
INSERT INTO tblself VALUES (4,'최대리','영업부',3);
INSERT INTO tblself VALUES (5,'정사원','영업부',4);
INSERT INTO tblself VALUES (6,'이부장','개발부',1);
INSERT INTO tblself VALUES (7,'하과장','개발부',6);
INSERT INTO tblself VALUES (8,'신과장','개발부',6);
INSERT INTO tblself VALUES (9,'황대리','개발부',7);
INSERT INTO tblself VALUES (10,'허사원','개발부',9);
	
COMMIT;

--직원 명단을 가져오시오 단, 상사의 이름까지
-- 1. join
--2. sub qurery
--3. 계층형 쿼리

--1. Join 
--   a. INNER JOIN 사장님은 상사가 없어서 명단 빠짐
SELECT 
   b.name AS 직원명,
   b.department AS 부서명,
   a.name AS 상사이름
FROM tblself a            --역할: 부모테이블 > 상사
   INNER JOIN tblself b    --역할: 자식테이블 > 직원
      ON a.seq = b.super;

--   b. OUTER JOIN 사장님 보이게 하려면 직원테이블을 가리켜야 함(RIGHT)
SELECT 
   b.name AS 직원명,
   b.department AS 부서명,
   a.name AS 상사이름
FROM tblself a               --역할: 부모테이블 > 상사
   RIGHT outer JOIN tblself b    --역할: 자식테이블 > 직원
      ON a.seq = b.super;
   
   
--2. Sub Query
SELECT
   name AS 직원명,
   department AS 부서명,
   (SELECT name FROM tblSelf WHERE seq = a.super) AS 상사이름
FROM tblSelf a;





/*
 * 5. 전체 외부조인,full outer join
 * - 서로 참조하고 있는 관계에서 사용
 */

SELECT * FROM tblmen; --부모, 자식
SELECT * FROM tblwomen; -- 자식, 부모



--커플인 남자와 여자를 가져오세요
--inner
SELECT
	m.name,
	w.name
FROM tblmen m
	INNER JOIN tblwomen w
		ON m.name = w.couple; --남자가 부모 여자가 자식

		
--left		
SELECT
	m.name,
	w.name
FROM tblmen m
	left JOIN tblwomen w
		ON m.name = w.couple; --남자가 부모 여자가 자식

--right
SELECT
	m.name,
	w.name
FROM tblmen m
	right JOIN tblwomen w
		ON m.name = w.couple; --남자가 부모 여자가 자식
		

--full outer (LEFT+RIGHT 합친거)	
SELECT
	m.name,
	w.name
FROM tblmen m
	FULL OUTER JOIN tblwomen w
		ON m.name = w.couple; --남자가 부모 여자가 자식
		
		
		


	
SELECT*FROM tblrent;
SELECT*FROM tblmember;
SELECT*FROM tblvideo;
SELECT*FROM tblgenre;
SELECT*FROM tblrent;

	


CREATE SEQUENCE genreSeq;
CREATE SEQUENCE videoSeq;
CREATE SEQUENCE memberSeq;
CREATE SEQUENCE rentSeq;			

DROP SEQUENCE videoSeq; 
DROP SEQUENCE genreSeq;
DROP SEQUENCE memberSeq;
DROP SEQUENCE rentSeq;

DROP TABLE tblrent;
DROP TABLE tblmember;
DROP TABLE tblvideo;
DROP TABLE tblgenre;


-- 장르 데이터
INSERT INTO tblGenre VALUES (genreSeq.NEXTVAL, '액션',1500,2);
INSERT INTO tblGenre VALUES (genreSeq.NEXTVAL, '에로',1000,1);
INSERT INTO tblGenre VALUES (genreSeq.NEXTVAL, '어린이',1000,3);
INSERT INTO tblGenre VALUES (genreSeq.NEXTVAL, '코미디',2000,2);
INSERT INTO tblGenre VALUES (genreSeq.NEXTVAL, '멜로',2000,1);
INSERT INTO tblGenre VALUES (genreSeq.NEXTVAL, '기타',1800,2);




-- 비디오 데이터
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (videoSeq.NEXTVAL, '영구와 땡칠이',5,'영구필름','심영래','땡칠이',3);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (videoSeq.NEXTVAL, '어쭈구리',5,'에로 프로덕션','김감독','박에로',2);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (videoSeq.NEXTVAL, '털미네이터',3,'파라마운트','James','John',1);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (videoSeq.NEXTVAL, '육복성',3,'대만영화사','홍군보','생룡',4);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (videoSeq.NEXTVAL, '뽀뽀할까요',6,'뽀뽀사','박감독','최지후',5);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (videoSeq.NEXTVAL, '우정과 영혼',2,'파라마운트','James','Mike',5);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (videoSeq.NEXTVAL, '주라기 유원지',1,NULL,NULL,NULL,1);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (videoSeq.NEXTVAL, '타이거 킹',4,'Walt','Kebin','Tiger',3);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (videoSeq.NEXTVAL, '텔미 에브리 딩',10,'영구필름','강감독','심으나',5);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (videoSeq.NEXTVAL, '동무',7,'부산필름','박감독','장동근',1);
INSERT INTO tblVideo (seq, Name, qty, Company, Director, Major, Genre) VALUES (videoSeq.NEXTVAL, '공동경쟁구역',2,'뽀뽀사','박감독','이병흔',1);

commit;


-- 회원 데이터
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (memberSeq.NEXTVAL, '김유신',1,1970,'123-4567','12-3번지 301호',10000);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (memberSeq.NEXTVAL, '강감찬',1,1978,'111-1111','777-2번지 101호',0);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (memberSeq.NEXTVAL, '유관순',1,1978,'222-2222','86-9번지',20000);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (memberSeq.NEXTVAL, '이율곡',1,1982,'333-3333',NULL,15000);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (memberSeq.NEXTVAL, '신숙주',1,1988,'444-4444','조선 APT 1012호',0);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (memberSeq.NEXTVAL, '안중근',1,1981,'555-5555','대한빌라 102호',1000);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (memberSeq.NEXTVAL, '윤봉길',1,1981,'666-6666','12-1번지',0);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (memberSeq.NEXTVAL, '이순신',1,1981,'777-7777',NULL,1500);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (memberSeq.NEXTVAL, '김부식',1,1981,'888-8888','73-6번지',-1000);
INSERT INTO tblMember (seq, Name,Grade,Byear,Tel,address,Money) VALUES (memberSeq.NEXTVAL, '박지원',1,1981,'999-9999','조선 APT 902호',1200);



-- 대여 데이터

INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (rentSeq.NEXTVAL, 1,1,'2007-01-01',NULL);
INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (rentSeq.NEXTVAL, 2,2,'2007-02-02','2001-02-03');
INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (rentSeq.NEXTVAL, 3,3,'2007-02-03',NULL);
INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (rentSeq.NEXTVAL, 4,3,'2007-02-04','2001-02-08');
INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (rentSeq.NEXTVAL, 5,5,'2007-02-05',NULL);
INSERT INTO tblRent (seq, member, video, Rentdate, Retdate) VALUES (rentSeq.NEXTVAL, 1,2,'2007-02-10',NULL);





commit;



