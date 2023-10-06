
--ex31.spl

-- 근태 상황(출석)
create table tblDate (
    seq number primary key,
    state varchar2(30) not null,
    regdate date not null
);
/

insert into tblDate (seq, state, regdate) values (1, '정상', '2023-09-01');
-- 09-02 : 토요일
-- 09-03 : 일요일

insert into tblDate (seq, state, regdate) values (2, '정상', '2023-09-04');
insert into tblDate (seq, state, regdate) values (3, '지각', '2023-09-05');
-- 09-06 : 결석
insert into tblDate (seq, state, regdate) values (4, '정상', '2023-09-07');
insert into tblDate (seq, state, regdate) values (5, '정상', '2023-09-08');

-- 09-09 : 토요일
-- 09-10 : 일요일
insert into tblDate (seq, state, regdate) values (6, '조퇴', '2023-09-11');
insert into tblDate (seq, state, regdate) values (7, '정상', '2023-09-12');
insert into tblDate (seq, state, regdate) values (8, '정상', '2023-09-13');
insert into tblDate (seq, state, regdate) values (9, '지각', '2023-09-14');
insert into tblDate (seq, state, regdate) values (10, '정상', '2023-09-15');

-- 09-16 : 토요일
-- 09-17 : 일요일
insert into tblDate (seq, state, regdate) values (11, '정상', '2023-09-18');
insert into tblDate (seq, state, regdate) values (12, '정상', '2023-09-19');
insert into tblDate (seq, state, regdate) values (13, '지각', '2023-09-20');
-- 09-21 : 결석
insert into tblDate (seq, state, regdate) values (14, '조퇴', '2023-09-22');

-- 09-23 : 토요일
-- 09-24 : 일요일
insert into tblDate (seq, state, regdate) values (15, '정상', '2023-09-25');
insert into tblDate (seq, state, regdate) values (16, '정상', '2023-09-26');
insert into tblDate (seq, state, regdate) values (17, '정상', '2023-09-27');
-- 09-28 : 추석
-- 09-29 : 추석
-- 09-30 : 토요일

-- 근태 조회 > 9월 근태 기록 열람 > 결석한 날짜 + 공휴일 포함
-- 1. ANSI-SQL
-- 2. PL/SQL
-- 3. Java
set serveroutput on;

declare
    vdate date;
    vstate varchar2(30);
    vcnt number;
begin
    vdate := to_date('2023-09-01', 'yyyy-mm-dd'); 
    
    for i in 1..30 loop
        dbms_output.put_line(vdate);
        
        select count(*) into vcnt from tblDate
            where to_char(regdate, 'yyyy-mm-dd') = to_char(vdate, 'yyyy-mm-dd');
        
        if vcnt > 0 then
        select state into vstate from tblDate 
            where to_char(regdate, 'yyyy-mm-dd') = to_char(vdate, 'yyyy-mm-dd');
        end if;
        
        dbms_output.put_line(vstate);
        
        vdate := vdate + 1; --하루씩 증가
    end loop;
end;
/

-- ANSI-SQL
-- 계층형 쿼리 사용
select * from tblComputer;

SELECT
	lpad(' ',LEVEL*3) ||name
FROM tblcomputer
	START WITH seq = 1
		CONNECT BY pseq = PRIOR seq;
	
--계층형 쿼리 = for문 효과 > 일련번호 생성 /일련번호 만드는 방법
	
SELECT * FROM dual;	

SELECT LEVEL FROM dual
	CONNECT BY LEVEL <= 5;

SELECT sysdate + LEVEL FROM dual
	CONNECT BY LEVEL <=5;


--기억!! date 자료형으로 원하는 기간의 데이터 생성하는 방법!

CREATE OR REPLACE VIEW vwDate
as
SELECT
	TO_Date ('20230901','yyyymmdd')+ LEVEL -1 AS regdate
FROM dual
	CONNECT BY LEVEL <= (to_date('20230930','yyyymmdd') - to_date('20230901','yyyymmdd')+1);

SELECT * FROM vwdate;
	
SELECT * FROM vwdate; --9월 한달 날짜
SELECT * FROM tbldate; -- 9월 근태 기록


SELECT
*
FROM vwdate v
	LEFT outer JOIN tbldate t
		ON v.regdate = t.regdate
			ORDER BY v.regdate asc;
			
		
		
		
--휴일처리 (토,일)		
SELECT
	v.regdate,
	CASE
		WHEN to_char(v.regdate, 'd')IN ('1')THEN '일요일'
		WHEN to_char(v.regdate, 'd')IN ('7')THEN '토요일'
		ELSE t.state
	END AS state
FROM vwdate v
	LEFT outer JOIN tbldate t
		ON v.regdate = t.regdate
			ORDER BY v.regdate asc;
			
		

		
--공휴일 처리
CREATE TABLE tblHoliday (
	seq NUMBER PRIMARY KEY,
	regdate DATE NOT NULL,
	name varchar2(30) NOT null
);

INSERT INTO tblholiday VALUES (1, '2023-09-28', '추석');
INSERT INTO tblholiday VALUES (2, '2023-09-29', '추석');


-- 평일 + 휴일 처리(토,일) + 공휴일 + 결석
select
    v.regdate,
    case
        when to_char(v.regdate, 'd') in ('1') then '일요일'
        when to_char(v.regdate, 'd') in ('7') then '토요일'
        when t.state is null and h.name is not null then h.name
        when t.state is null and h.name is null then '결석'
        else t.state
    end as state
from vwDate v
    left outer join tblDate t
        on v.regdate = t.regdate
            left outer join tblHoliday h
                on v.regdate = h.regdate
                    order by v.regdate asc;
			
                   
                   1., 1/1/1
                   2//1/2/1
                   1스터디에 5번 6789
                   1 1 6 5\
                   2
                   3
	