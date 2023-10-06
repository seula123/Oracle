    --ex30_accout.sql

/*


	사용자 권한
	- DCL
	- 계정 생성, 삭제 등 제어
	- 리소스 제어 권한
	
	현재 사용 계정
	- system
	- hr


	프로젝트 > 계정 생성
	

*/

SELECT * FROM tabs; --현재 스키마(계정-hr)에서 소유하고 있는 테이블 목록

SELECT * FROM tblinsa;

--회원 > tblMember


/*

	-사용자 계정 생성하기
	- 시스템 권한을 가지고 있는 계쩡만 가능하다 > 관리자급 > system
	- 계정 생성 권한을 가지고 있는 일반 계정도 가능하다.

*/