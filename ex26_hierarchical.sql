-- ex26_hierarchical.sql


/*
 rownum
 - 오라클 전용
 - MS-SQL (top n)
 - MySQL(limit n, m)
 
 
 계층형 쿼리, Hierarchical Query
 - 오라클 전용 쿼리
 - 레코드의 관계가 서로간에 상하 수직 구조인 경우에 사용
 - 자기 참조를 하는 테이블에서 사용 > 셀프 조인
 - 자바의 트리 구조
 
 tblself
 홍사장
 	- 김부장
 		- 박과장
 			- 최대리
 				- 정사원

- 이부장
	- 하과장
	
	
	
	
	
	
		컴퓨터
        - 본체
            - 메인보드
            - 그래픽카드
            - 랜카드
            - 메모리
            - CPU
        - 모니터
            - 보호필름
            - 모니터암
        - 프린터
            - A4용지
            - 잉크카트리지
    
		카테고리
        - 컴퓨터용품
            - 하드웨어
            - 소프트웨어
            - 소모품
        - 운동용품
            - 테니스
            - 골프
            - 달리기
        - 먹거리
            - 밀키트
            - 베이커리
            - 도시락





 */
SELECT * FROM tblself;


create table tblComputer (
    seq number primary key,                         --식별자(PK)
    name varchar2(50) not null,                     --부품명
    qty number not null,                            --수량
    pseq number null references tblComputer(seq)    --부모부품(FK)
);


insert into tblComputer values (1, '컴퓨터', 1, null);
insert into tblComputer values (2, '본체', 1, 1);
insert into tblComputer values (3, '메인보드', 1, 2);
insert into tblComputer values (4, '그래픽카드', 1, 2);
insert into tblComputer values (5, '랜카드', 1, 2);
insert into tblComputer values (6, 'CPU', 1, 2);
insert into tblComputer values (7, '메모리', 2, 2);
insert into tblComputer values (8, '모니터', 1, 1);
insert into tblComputer values (9, '보호필름', 1, 8);
insert into tblComputer values (10, '모니터암', 1, 8);
insert into tblComputer values (11, '프린터', 1, 1);
insert into tblComputer values (12, 'A4용지', 100, 11);
insert into tblComputer values (13, '잉크카트리지', 3, 11);

SELECT * FROM tblComputer;

-- 부품 가져오기 + 부모 부품의 정보
SELECT
	 c1.name AS "부품명",
	 c2.name AS "부모부품명"
FROM tblComputer c1				--부품(자식)
	INNER JOIN tblcomputer c2	--부품(부모)
		ON c1.pseq = c2.seq;
	
	
-- 계층형 쿼리
-- 1. start with절 + connect by 절
-- 2. 계층형 쿼리에서만 사용 가능한 의사 컬럼들
--		a. prior: 자기와 연관된 부모 레코드를 참조
--		b. level: 세대수(depth, generation)

	SELECT
		seq AS 번호,
		lpad(' ', (LEVEL - 1) * 10) || name AS 부품명,
		PRIOR name AS 부모부품명,
		LEVEL -- 세대수 
	FROM tblcomputer
		START WITH seq = 1	-- 루트 레코드 지정
			CONNECT BY pseq = PRIOR seq;	-- 현재 레코드와 부모 레코드를 연결하는 조건  PRIOR seq = 부모 테이블의 레코드
			

SELECT
	lpad(' ', (LEVEL - 1) * 10) || name,
	PRIOR name 
FROM tblself
	START WITH seq = 1
		CONNECT BY super = PRIOR seq;

-- prior : 부모 레코드 참조 > 직속 상사
-- connect_by_root: 최상위 레코드 참조 > 홍사장
-- connect_by_isleaf: 말단 노드

SELECT
	lpad(' ', (LEVEL - 1) * 10) || name,
	PRIOR name,
	CONNECT_by_root name,
	connect_by_isleaf,
	sys_connect_by_path(name, '▷')
FROM tblself
	START WITH seq = 1
		CONNECT BY super = PRIOR seq;
	
	SELECT
		seq AS 번호,
		lpad(' ', (LEVEL - 1) * 10) || name AS 부품명,
		PRIOR name AS 부모부품명,
		LEVEL
	FROM tblcomputer
		START WITH seq = 1
			CONNECT BY pseq = PRIOR seq
				ORDER siblings BY name asc;	-- siblings
			

				
				
				
create table tblCategoryBig (
    seq number primary key,                 --식별자(PK)
    name varchar2(100) not null             --카테고리명
);

create table tblCategoryMedium (
    seq number primary key,                             --식별자(PK)
    name varchar2(100) not null,                        --카테고리명
    pseq number not null references tblCategoryBig(seq) --부모카테고리(FK)
);

create table tblCategorySmall (
    seq number primary key,                                 --식별자(PK)
    name varchar2(100) not null,                            --카테고리명
    pseq number not null references tblCategoryMedium(seq)  --부모카테고리(FK)
);


insert into tblCategoryBig values (1, '카테고리');

insert into tblCategoryMedium values (1, '컴퓨터용품', 1);
insert into tblCategoryMedium values (2, '운동용품', 1);
insert into tblCategoryMedium values (3, '먹거리', 1);

insert into tblCategorySmall values (1, '하드웨어', 1);
insert into tblCategorySmall values (2, '소프트웨어', 1);
insert into tblCategorySmall values (3, '소모품', 1);
insert into tblCategorySmall values (4, '테니스', 2);
insert into tblCategorySmall values (5, '골프', 2);
insert into tblCategorySmall values (6, '달리기', 2);
insert into tblCategorySmall values (7, '밀키트', 3);
insert into tblCategorySmall values (8, '베이커리', 3);
insert into tblCategorySmall values (9, '도시락', 3);
	
SELECT * FROM tblcategorybig;
SELECT * FROM tblcategorymedium;		
SELECT * FROM tblcategorysmall;

SELECT 
	b.name AS "상",
	m.name AS "중",
	s.name AS "하"
FROM tblcategorybig b
	INNER JOIN tblcategorymedium m
		ON b.seq = m.pseq
			INNER JOIN tblcategorysmall s
				ON m.seq = s.pseq;
	
	


