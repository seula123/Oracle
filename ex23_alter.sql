--ex23_alter.sql


/*

	DDL   객체 조작
	- 객체 생성 : CREATE
	- 객체 수정 : ALTER
	- 객체 삭제 : DROP


	DML   데이터 조작
	- 데이터 생성: INSERT
	- 데이터 수정: UPDATE
	- 데이터 삭제: DELETE

	
	
	테이블 수정하기
	- 테이블 정의 수정 > 스키마 수정 > 컬럼 수정 = 컬럼명 or 자료형(길이) or 제약사항 등을 수정하는 것이다
	- 되도록 테이블 수정하는 상황을 발생시키면 안된다 !! > 설계를 반드시 완벽하게하기

	
	테이블 수정해야하는 상황 발생!
	1. 테이블 삭제 (DROP) > 테이블 DDL(CREATE) 수정 > 수정된 DDL로 새롭게 테이블 생성
		a. 기존 테이블에 데이터가 없었을 경우 > 아무 문제 없음
		b. 기존 테이블에 데이터가 있었을 경우  미리 데이터 백업 > 테이블 삭제 > 수정된 테이블 다시 생성 > 데이터 복구 
			- 개발 중에 사용 가능
			- 공부할 때 사용 가능 
			- 서비스 운영 중에는 거의 불가능한 방법
			
	
	2. ALTER 명령어 사용 > 기존 테이블의 구조 변경
		a. 기존 테이블에 데이터가 없었을 경우 > 아무 문제 없음
		b. 기존 테이블에 데이터가 있었을 경우 > 경우에 따라 비용차이
			- 개발 중에 사용 가능
			- 공부할 때 사용 가능
			- 서비스 운영 중에는 경우에 따라 가능
			
		
**/



DROP TABLE tblEdit;

CREATE TABLE tblEdit (
	seq NUMBER PRIMARY KEY,
	DATA varchar2(20) NOT NULL
);



INSERT INTO tblEdit VALUES (1, '마우스');
INSERT INTO tblEdit VALUES (2, '키보드');
INSERT INTO tblEdit VALUES (3, '모니터');

SELECT * FROM tbledit;



--Case 1. 새로운 컬럼을 추가하기
ALTER TABLE tblEdit --edit 테이블을 수정하겠다
	ADD ( price number);


SELECT * FROM tblEdit;

--[42000]: ORA-01758: table must be empty to add mandatory (NOT NULL) column¶
ALTER TABLE tblEdit 
	ADD (qty number NOT NULL);


DELETE FROM tblEdit;


INSERT INTO tblEdit VALUES (1, '마우스', 1000, 1);
INSERT INTO tblEdit VALUES (2, '키보드', 2000, 1);
INSERT INTO tblEdit VALUES (3, '모니터', 3000, 2);






ALTER TABLE tblEdit 
	ADD (color varchar2(30) DEFAULT 'white' NOT NULL);

SELECT *FROM tbledit;


--case2 컬럼 삭제하기
ALTER TABLE tblEdit 
	DROP COLUMN color;

ALTER TABLE tblEdit 
	DROP COLUMN qty;

ALTER TABLE tblEdit 
	DROP COLUMN seq; -- pk 삭제 > 절대 금지!!!!
	
	
	
--case3. 컬럼 수정하기
SELECT * FROM tblEdit;


INSERT INTO tblEdit values (4, '애플 M2 맥북 프로 2023'); --길어서 안들어가니까 밑에 길이 수정해주기


--Case 3.1 컬러 길이 수정하기 (확장/축소)
--확장은 용이하지만 축소는 그안에 들어있는데이터를 보고해야한다
ALTER TABLE tbledit
	MODIFY (DATA varchar2(100));

--축소하면 ORA-01441: cannot decrease column length because some value is too big 에러가 난당! 데이터를 고치고 줄여야함
ALTER TABLE tbledit
	MODIFY (DATA varchar2(20));



--Case3.2 컬럼의 제약사항 수정하기
ALTER TABLE tblEdit 
	MODIFY (DATA varchar2(100) NULL); -- NOTNULL에서NULL로 수정

INSERT INTO tblEdit values (5, NULL);  -- NULL값이 들어감

ALTER TABLE tblEdit 
	MODIFY (DATA varchar2(100) NOT NULL); -- NULL에서 NOT NULL로 수정


	
--Case3.3 컬럼의 자료형 바꾸기  > 테이블 비우고 작업
ALTER TABLE tblEdit	
	MODIFY (DATA NUMBER);  --이미 데이터가 차있어서 바꿀수없다
	
--이거확실하게 적은지 모르겠으니까 확인하깅!!
--ALTER TABLE tblEdit	
--	MODIFY (DATA varchar2(100));	
	
DESC tbledit; -- SOL*Plus > SQL Develoer 전용 명렁어	

DELETE FROM tbledit;

SELECT * FROM tblEdit;
	

	