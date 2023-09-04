--ex16_update.sql



/*
UPDATE
- DML
- 원하는 행의 원하는 컬럼값을 수정하는 명령어

UPDATE 구문
- UPDATE 테이블명 SET 컬럼명 = 값 [, 컬럼명=값] x N [WHERE 절]
*/

--트랜잭션 처리
COMMIT;
ROLLBACK;


SELECT * FROM tblCountry;

--대한민국: 서울 > 세종
UPDATE tblcountry SET capital = '세종';


UPDATE tblcountry SET capital = '세종' WHERE name = '대한민국'; 

UPDATE tblcountry SET capital = '세종',
					population = population +100,
					continent = 'EU'
WHERE name = '대한민국'; 

SELECT * FROM tblcountry;

