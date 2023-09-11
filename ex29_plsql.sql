--ex29_plsql.sql


/*

    - PL/SQL
    - Oracles's Procedural Language extension to SQL
    - 기존의 ANSI-SQL + 절차 지향 언어 기능 추가
    - ANSI-SQL + 확장팩(변수, 제어 흐름(제어문), 객체(메소드) 정의)

    프로시저, Procedure
    - 메서드, 함수 등..
    - 순서가 있는 명령어들의 집합
    - 모든 PL/SQL 구문은 프로시저내에서만 작성/동작이 가능하다.
    - 프로시저가 아닌 영역 > ANSI-SQL 영역
    
    
    1. 익명 프로시저
        - 1회용 코드 작성용
        
    
    2. 실명 프로시저
        - 데이터베이스 객체
        - 저장용
        - 재호출
    
    
    PL/SQL 프로시저 구조
    1. 4개의 블럭(키워드)으로 구성
        - DECLARE
        - REGIN
        - EXCEPTION
        - END
    
    2. DECLARE
        - 선언부
        - 프로시저내에서 사용할 변수, 객체 등을 선언하는 영역
        - 생략 가능
    3. BEGIN - END (둘이 한 쌍이다)  --자바에서 () 바디괄호같은 거다!
        - 실행문, 구현부
        - 구현된 코드를 가지는 영역(메서드의 body 영역)
        - 생략 불가능
        - 구현된 코드 > ANSI-SQL +PL/SQL(연산, 제어 등)
    4. EXCEPTION
        - 예외처리부
        - catch 역할, 3번 영역 try 역할
        - 생략 가능 
    
    
    자료형 + 변수 
    
    PL/SQL 자료형
    - ANSI-SQL과 동일
    
    
    변수 선언하기
    - 변수명 자료형 [not null] [default 값];
    
    PL/SQL 연산자
    - ANSI-SQL과 동일
    
    대입 연산자
    - ANSI-SQL 대입 연산자
        ex) update table setl column = '값';
        
    - PL/SQL 대입 연산자
        ex) 변수 := '값';
        
    
    
*/

set SERVEROUTPUT on;  --이걸 실행해야함 현재 세션에서만 유효 (접속 해제> 초기화)

set SERVEROUTPUT off;

set SERVEROUTPUT on;

-- 익명 프로시저
declare
    num number;
    name VARCHAR2(30);
    today date;
begin

    num := 10;
    dbms_output.put_line(num); --=syso
    
    name := '홍길동';
    dbms_output.put_line(name);
    
    today := sysdate;
    dbms_output.put_line(today);
    dbms_output.put_line();
    end;
    
    
--위아래 / 적으면 블럭 안 잡고 해도 실행됨   
/    
declare
    num1 number;
    num2 number;
    num3 number := 30;
    num4 number default 40;        --기본값
    num5 number not null := 50;   --not null은 declare 블럭에서 초기화를해야함
begin

    dbms_output.put_line(num1); --생성 후 초기화 안했으니 null상태
    
    num2 := 20;
    dbms_output.put_line(num2);

    dbms_output.put_line(num3);
    
    dbms_output.put_line(num4);
    num4 := 400;
    
    dbms_output.put_line(num4);
    
    dbms_output.put_line(num5);
end;
/   
--위아래 / 적으면 블럭 안 잡고 해도 실행됨


/*

    변수 > 어떤 용도로 사용?
    - select 결과를 담는 용도(************)
    - select into 절 (PL/SQL)

*/


declare 
    vbuseo varchar2(15);
begin

    --vbuseo:= (select buseo from tblInsa where name = '홍길동');
    
    select buseo into vbuseo from tblInsa where name = '홍길동';
    dbms_output.put_line(vbuseo);
    
    select buseo from tblInsa where name = '홍길동';  -- 이렇게 하면 안 됨 PL/SQL은 ANSI-SQL을 자동으로 인식하지 못해서 오류가 남
    dbms_output.put_line(vbuseo);                    -- 이렇게 하면 안 됨 PL/SQL은 ANSI-SQL을 자동으로 인식하지 못해서 오류가 남
    end;

/
    begin
        --PL/SQL 프로시저 안에서는 순수한 select문은 올 수 없다.
        --PL/SQL 프로시저 안에서는 select into문만 사용한다.
        select buseo from tblInsa where name = '홍길동';
    end;
/


--성과급 받는 직원명 
create table tblName2(
    name varchar2(15)
);

--1. 개발부 + 부장 > select > name?
--2. tblName > name > insert

insert into tblName2 (name)
    values ((select name from tblinsa where buseo = '개발부' and jikwi = '부장'));
    
declare
    vname varchar2(15);
begin
    --1. select into 로 변수에 데이터 저장
    select name into vname from tblinsa where buseo = '개발부' and jikwi = '부장';
    
    --2. 테이블에 insert
    insert into tblName2 (name) values (vname);
end;
/

select * from tblName2;


declare
    vname varchar2(15);
    vbuseo varchar2(15);
    vjikwi varchar2(15);
    vbasicpay number;
begin
    --select name, buseo, jikwi, basicpay from tblinsa where num = 1001;
    
    --into 사용시
    --1. 컬럼의 개수와 변수의 개수 일치
    --2. 컬럼의 순서와 변수의 순서 일치
    --3. 컬럼과 변수의 자료형 일치
    select name, buseo, jikwi, basicpay into vname, vbuseo, vjikwi, vbasicpay
    from tblinsa where num=1001;
    
    dbms_output.put_line(vname);
    dbms_output.put_line(vbuseo);
    dbms_output.put_line(vjikwi);
    dbms_output.put_line(vbasicpay);
end;


desc tblInsa

/*
    타입 참조
    
    %type
    - 사용하는 테이블의 특정 컬럼값의 스키마를 알아내서 변수에 적용
    - 복사되는 정보
        a. 자료형
        b. 길이
    
*/

declare
--    vbuseo varchara2(15);
    vbuseo tblInsa.buseo%type;
begin
    select buseo into vbuseo from tblInsa where name = '홍길동';
    dbms_output.put_line(vbuseo);
end;





declare
    vname tblInsa.name%type;
    vbuseo tblInsa.buseo%type;
    vjikwi tblInsa.jikwi%type;
    vbasicpay tblInsa.basicpay%type;
begin
    --select name, buseo, jikwi, basicpay from tblinsa where num = 1001;
    
    --into 사용시
    --1. 컬럼의 개수와 변수의 개수 일치
    --2. 컬럼의 순서와 변수의 순서 일치
    --3. 컬럼과 변수의 자료형 일치
    select name, buseo, jikwi, basicpay into vname, vbuseo, vjikwi, vbasicpay
    from tblinsa where num=1001;
    
    dbms_output.put_line(vname);
    dbms_output.put_line(vbuseo);
    dbms_output.put_line(vjikwi);
    dbms_output.put_line(vbasicpay);
end;



-- 직원 중 일부에게 보너스(급여*1.5) 지급
create table tblBonus (
    seq number primary key,
    num number(5) not null references tblInsa(num),
    bonus number not null
);

declare
    vnum tblInsa.num%type;
    vbasicpay tblInsa.basicpay%type;
begin

    select num, basicpay into vnum, vbasicpay
        from tblInsa where city = '서울' and jikwi = '부장' and buseo = '영업부';

    insert into tblBonus (seq, num, bonus)
        values ((select nvl(max(seq),0)+1 from tblBonus), vnum, vbasicpay * 1.5);
end;

select * from tblBonus;


select * from tblBonus b
        inner join tblInsa i
            on i.num = b.num;
            
            
select * from tblMen;
select * from tblWomen;

--무명씨 성전환수술 하셨으니 남자테이블에서 여자테이블로 옮겨보세용
--1. 무명씨 > tblMen > select
--2. tblWomen > insert 
--3. tblMen > delete



declare
--    vname tblWomen.name%type;
--    vage tblWomen.age%type;
--    vheight tblWomen.height%type;
--    vweight tblWomen.weight%type;
--    vcouple tblWomen.couple%type;
--    
declare
    vrow tblMen%rowtype; --vrow : tblMen의 레코드 1개(모든 컬럼값)를 저장할 수 있는 변수
begin

    --1.
    select 
        * into vrow      
    from tblMen where name = '정형돈';
    
    dbms_output.put_line(vrow.name);
    dbms_output.put_line(vrow.age);
    dbms_output.put_line(vrow.height);
    dbms_output.put_line(vrow.weight);
    dbms_output.put_line(vrow.couple);
    
    --2.
    insert into tblWomen (name, age, height, weight, couple)
        values (vrow.name, vrow.age, vrow.height, vrow.weight, vrow.couple);

    --3.
    delete from tblMen where name = vrow.name;

end;



/*
    타입 참조
    %type
    - 사용하는 테이블의 특정 컬럼값의 스키마를 알아내서 변수에 적용
    - 복사되는 정보
        a. 자료형
        b. 길이
    %rowtype
    - 행 전체 참조(여러개의 컬럼을 한번에 참조)
    - %type의 집합형
    - 레코드 전체(여러개 컬럼)을 하나의 변수에 저장 가능
    
*/



/*
    
    제어문
    1. 조건문
    2. 반복문
    3. 분기문
    
*/

declare
    vnum number :=-10;
begin
    
    if vnum >0 then 
        dbms_output.put_line('양수');
    else
        dbms_output.put_line('음수');
    end if;    
end;







declare
    vnum number := 10;
begin
    if vnum > 0 then
    dbms_output.put_line('양수');
     elsif vnum < 0 then
    dbms_output.put_line('음수');
      else
    dbms_output.put_line('0');
    end if;
    
end;



-- tblInsa 남자 직원/여자 직원 > 다른 업무

declare
    vgender char(1);
begin
    
    select substr (ssn, 8, 1) into vgender from tblinsa where num = 1035; 
    
    if vgender = '1' then
     dbms_output.put_line('남자 직원');
    elsif vgender = '2' then
     dbms_output.put_line('여자 직원');
    end if;
    
end;

--직원 1명 선택 
--차등 지급
--a. 과장/부장 > basicpay * 1.5
--b. 대리/사원 > basicpay * 2

declare
    vnum tblInsa.num%type;
    vbasicpay tblInsa.basicpay%type;
    vjikwi tblInsa.jikwi%type;
    vbonus number;
begin

    select num, basicpay, jikwi into vnum, vbasicpay, vjikwi 
        from tblInsa where num = 1040;

    if vjikwi = '과장' or vjikwi = '부장' then
        vbonus := vbasicpay * 1.5;
    elsif vjikwi in ('사원', '대리') then
        vbonus := vbasicpay * 2;
    end if;

    insert into tblBonus (seq, num, bonus)
        values ((select nvl(max(seq), 0) + 1 from tblBonus), vnum, vbonus);

end;


/*
    case 문
    - ANSI-SQL의 case문과 거의 유사
    - 자바의 switch문, 다중 if문
    

*/


declare
    vcontinent tblCountry.continent%type;
    vresult varchar2(30);
begin
    select continent into vcontinent from tblCountry where name = '영국';
    
    if vcontinent = 'AS' then
        vresult := '아시아';
    elsif vcontinent = 'EU' then
        vresult := '유럽';
    elsif vcontinent = 'AF' then
        vresult := '아프리카';
    else
        vresult := '기타';
    end if;
    
    dbms_output.put_line(vresult);
    
    
    case
        when vcontinent = 'AS' then vresult := '아시아';
        when vcontinent = 'EU' then vresult := '유럽';
        when vcontinent = 'AF' then vresult := '아프리카';
        else vresult := '기타';
    end case;
    
        dbms_output.put_line(vresult);
end;



case vcontinent
    when "AS" then vresult := '아시아';
    when "EU" then vresult := '유럽';
    when "AF" then vresult := '아프리카';
end case;

dbms_output.put_line(vresult);

end;


/*

    반복문
    1. loop
        - 단순 반복
    2. for loop
        - 횟수 반복 (자바 for)
        - loop 기반
        
    3. while loop
        - 조건 반복 (자바 while)
        - loop 기반
        
*/
--이 글을 발견한 당신! 오늘은 행운이 따르겠군요!
--이 글은 영국에서 시작되어.. 이 글을 다른 사람 3명에게 보내세요.
declare
    vnum number :=1;
begin
    loop
        dbms_output.put_line(vnum);
        vnum := vnum +1;
        
        exit when vnum > 10;      --조건부 break
    end loop;
end;


create table tblLoop (

    seq number primary key,
    data varchar2(100) not null

);


create sequence seqLoop;

-- 데이터 x 1000건 추가
-- data > '항목2', '항목2'..'항목1000'

DECLARE

    vnum number := 1;

    begin
    loop
        insert into tblLoop values (seqLoop.nextval, '항목' || vnum);
        vnum := vnum + 1;
        exit when vnum > 1000;
    end loop;


end;

select * FROM  tblLoop;



/*
--2. for loop
-- 향상된 for 문
    - for each문
    - for in

*/
begin 

    for i in 1..10 loop
    dbms_output.put_line(i);  
    end loop;

end;


create table tblGugudan (
    dan number not null,
    num number not null,
    result number not null,
    constraint tblgugudan_dan_num_pk primary key (dan, num)  --복합키 (composite key) 제약사항
);

drop table tblGugudan;

create table tblGugudan (
    dan number not null,
    num number not null,
    result number not null
);

alter table tblGugudan
    add constraint tblgugudan_dan_num_pk primary key(dan, num)  --제약사항 깔끔한 방법


begin

    for dan in 2..9 loop
        for num in 1..9 loop
            insert into tblGugudan (dan, num, result)
                values (dan, num, dan * num);
        end loop;
    end loop;
end;

select * from tblGugudan;



begin 

    for i in reverse 1..10 loop
    dbms_output.put_line(i);  
    end loop;

end;


--3. while loop

declare
    vnum number :=1;
begin 
    loop
        dbms_output.put_line(vnum);
        vnum := vnum +1;
        exit when vnum > 10;
    end loop;
end;


declare
    vnum number :=1;
begin 
    while vnum<=10 loop
        dbms_output.put_line(vnum);
        vnum := vnum +1;
    end loop;
end;




/*


    select > 결과셋 > PL/SQL 변수 대입
    
    1. select into
        - 결과셋의 레코드가 1개일 때만 사용이 가능하다.
    
    2. cursor
        - 결과셋의 레코드가 N개일 때 사용한다.
        - 루프 사용

    declare
        변수 선언;
        커서 선언; --결과셋을 참조하는 객체
    begin
        커서 열기;
            loop
                데이터 접근 (루프 1회전 > 레코드 1개 <- 커서 사용)
            end loop;
        커서 닫기;
    end

*/

--ORA-01422: exact fetch returns more than requested number of rows
declare 
    vname tblInsa.name%type;
begin 
    select name into vname from tblInsa;
    dbms_output.put_line(vname);
end;


create view vview
as
select문

cursor vcursor 
is
select문;




declare
    cursor vcursor
    is
    select name from tblinsa;
    vname tblinsa.name%type;
begin
    open vcursor; --커서 열기 > select실행 > 결과셋을 커서가 참조
--        fetch vcursor into vname; --select into 역할
--        dbms_output.put_line(vname);
--        fetch vcursor into vname; --select into 역할
--        dbms_output.put_line(vname);
    
--    for i in 1..60 loop
--    fetch vcursor into vname;
--    dbms_output.put_line(vname);
--    end loop;

--루프횟수를 짐작할수없으면 무한루프
    loop
        fetch vcursor into vname;
        exit when vcursor%notfound;  --bool값
        
        dbms_output.put_line(vname);
    end loop;
    
    close vcursor;
    
end;


--'기획부' > 이름, 직위, 급여 > 출력

declare
    cursor vcursor
        is select name, jikwi, basicpay from tblInsa where buseo = '기획부';

    vname tblInsa.name%type;
    vjikwi tblInsa.jikwi%type;
    vbasicpay tblInsa.basicpay%type;
    
begin
    
    open vcursor;
    
    loop
        fetch vcursor into vname, vjikwi, vbasicpay;
        exit when vcursor%notfound;
        
        -- 업무 > 기획부 직원 한 사람씩 접근
        dbms_output.put_line(vname || ',' || vjikwi || ',' || vbasicpay);
        
    end loop;
    
    close vcursor;
    
end;


--문제 tblBonus
-- 모든 직원에게 보너스 지급. 60명 전원 > 단 조건은 과장과 부장한테는 1.5배 사원과 대리한테는 2배 
select * from tblBonus;


declare

    cursor vcursor
    is select num , BASICPAY , JIKWI from TBLINSA;
    vnum TBLINSA.num%type;
    vbasicpay tblinsa.basicpay%type;
    vjikwi tblinsa.jikwi%type;
    vbonus number;

    begin

    open vcursor;
    loop
        fetch vcursor into vnum , vbasicpay , vjikwi;
        exit when vcursor%notfound;

        if vjikwi in ('과장','부장') then
            vbonus := vbasicpay * 1.5;
        elsif vjikwi in ('사원','대리') then
            vbonus := vbasicpay * 2;
        end if;

        insert into tblBonus( seq, num, bonus) values ((select nvl(max(seq),0) +1 from tblBonus) , vnum , vbonus);
    end loop;
close vcursor;
end;


select i.name, b.bonus from tblBonus b
    inner join tblInsa i
    on i.num = b.num;
    
    
--커서 탐색
-- 1. 커서 + loop > 정석
-- 2. 커서 + for loop >간결

--1번 방법
declare
    cursor vcursor
    is select * from tblInsa;
    vrow tblInsa%rowtype;
begin
    open vcursor;
    loop
        fetch vcursor into vrow;
        exit when vcursor%notfound;
        
        dbms_output.put_line(vrow.name);
        
    end loop;
    close vcursor;
end;



--2번 방법
declare
    cursor vcursor
    is select * from tblInsa;
    --vrow tblInsa%rowtype;
begin
   -- open vcursor;
   -- loop
        for vrow in vcursor loop --fetch into를 대신
--        fetch vcursor into vrow;
--        exit when vcursor%notfound;
        
        dbms_output.put_line(vrow.name);
        
    end loop;
  --  close vcursor;
end;





-- 예외처리
-- : 실행부에서(begin-end) 발생하는 예외를 처리하는 블럭 > exception 블럭

declare
    vname varchar2(5);
begin 
    dbms_output.put_line('하나');
    select name into vname from tblinsa where num = 1001;
    dbms_output.put_line('둘');
    
    dbms_output.put_line(vname);
exception

    when others then
        dbms_output.put_line('예외 처리');

end;


-- 예외 발생 > DB 저장
create table tblLog (
    seq number primary key,         --pk
    code varchar2 (7) not null check (code in ('A001','B001','B002','C001')), --에러 상태 코드
    message varchar2(1000) not null,      --에러 메시지
    regdate date default sysdate not null --에러 발생 시각
);


create sequence seqLog;

declare
    vcnt number;
    vname tblInsa.name%type;
begin
    select count(*) into vcnt from tblCountry --where name = '태국';
    
    dbms_output.put_line(100/vcnt);

    select name into vname from tblInsa where num = 1001;
    dbms_output.put_line(vname);

--exception 
    
    when zero_divide then
    dbms_output.put_line('0으로 나누기');
    
end;






create sequence seqLog;

declare
    vcnt number;
    vname tblinsa.name%type;
begin 

select count(*) into vcnt from tblcountry; --where name = '태국';
dbms_output.put_line(100 / vcnt);

select name into vname from tblinsa where num = 1000;
dbms_output.put_line(vname);

exception
    
    when zero_divide then
        dbms_output.put_line('0으로 나누기');
        insert into tblLog 
            values (seqLog.nextVal, 'B001', '가져온 레코드가 없습니다.',default);
        
    when no_data_found then
        dbms_output.put_line('데이터 없음');
        insert into tblLog 
            values (seqLog.nextVal, 'A001', '직원이 존재하지 않습니다.',default);
    
    
    when others then
        dbms_output.put_line('나머지 예외');
        insert into tblLog 
            values (seqLog.nextVal, 'C001', '기타 예외가 발생했습니다.',default);


end;


select * from tblLog;

-- ~ 익명 프로시저

-- 실명 프로시저 ~

/*


명령어 실행 > 처리 과정

1. ANSI-SQL

2. 익명 프로시저

	a. 클라이언트 > 구문 작성 (select)
	b. 실행 (Ctrl + Enter)
	c. 명령어를 오라클 서버에 전달
	d. 서버가 명령어를 수신
	e. 구문 분석 (파싱) + 문법 검사
	f. 컴파일
	g. 실행(select)
	h. 결과셋 도출
	i. 결과셋을 클라이언트에게 반환
	j. 결과셋을 화면에 출력
	
2-1 다시 실행
	a~z 다시 반복
	- 한 번 실행했던 명령어를 다시 실행 했을 때 위의 모든 과정을 처음부터 끝까지 다시실행한다.
	- 첫번째 실행 비용 = 다시 실행 비용
	b.
	c.
	
	
3. 실명 프로시저
    --메서드 생성
    a. 클라이언트 > 구문 작성 > 필수 
	b. 실행 (Ctrl + Enter)
	c. 명령어를 오라클 서버에 전달
	d. 서버가 명령어를 수신
	e. 구문 분석 (파싱) + 문법 검사
	f. 컴파일
    g. 실행
    h. 오라클 서버 > 프로시저 생성 > 저장
    i. 저장

    --실행
    a. 클라이언트 > 구문 작성 (호출)
    b. 실행 (Ctrl + Enter)
	c. 명령어를 오라클 서버에 전달
	d. 서버가 명령어를 수신
	e. 구문 분석 (파싱) + 문법 검사
	f. 컴파일
    g. 실행 >프로시저 실행
    
    
    4. 다시 실행
    a. 클라이언트 > 구문 작성 (호출)
    b. 실행 (Ctrl + Enter)
	c. 명령어를 오라클 서버에 전달
	d. 서버가 명령어를 수신
	e. 구문 분석 (파싱) + 문법 검사
	f. 컴파일
    g. 실행 >프로시저 실행
    
    
    
    
    
    
    
    
*/

SELECT * FROM tblinsa;




/*
  프로시저
  1. 익명 프로시저
  	- 1회용
  
  2. 실명 프로시저
  	- 재사용
  	- 오라클에 저장
  	
  	
  실명 프로시저
  	- 저장 프로시저(Stroed Procedure)
	1. 저장 프로시저, Stroed Procedure
		- 매개변수 / 반환값 구성 > 자유
	2. 저장 함수, Stroed Function
		- 매개변수 / 반환값 구성 > 필수
		

	익명 프로시저 선언
	[declare
		변수 선언;
		커서 선언;]
	begin
		구현부;
	[exception
		예외처리;]
	end;
	
	
	
	저장 프로시저 선언
	
	
	create [or replace] procedure 프로시저명
	is(as) --이건 생략 불가능
		[변수 선언;
		커서 선언;]
	begin
		구현부;
	[exception
		예외처리;]
	end;
		
		  
 */

--즉시 실행
DECLARE
	vnum NUMBER;
BEGIN
	vnum :=100;
	dbms_output.put_line(vnum);
END;




--저장 프로시저
create or replace procedure procTest
is
	vnum NUMBER;
BEGIN
	vnum :=100;
	dbms_output.put_line(vnum);
END;


-- 저장 프로시저를 호출하는 방법
begin
    procTest;   --프로시저 호출
end;


--저장 프로시저 = 메서드
-- 매개변수 + 반환값

--1. 매개변수가 있는 프로시저
create or replace procedure procTest(pnum number)  --매개변수
is
    vresult number; --일반변수
begin
    vresult := pnum *2;
    dbms_output.put_line(vresult);
end procTest;


set serveroutput on;

begin
    -- pl/sql 영역
    procTest(100);
    procTest(200);
    procTest(300);
end;


--  무슨 영역?
--  ANSI-SQL  영역
select * from tblInsa;

execute procTest(400);
exec procTest(500);
call procTest(600);



create or replace procedure procTest(width number, height number)
is
    vresult number;
begin 
    vresult := width * height;
    dbms_output.put_line(vresult);
end procTest;


begin
    procTest(10,20);
end;


CREATE OR REPLACE procedure procTest(
    name varchar2--(30) > *** 프로시저 매개변수는 길이와 not null 표현은 불가능하다.
) 
is --변수 선언이 없어도 반드시 기재
begin
    dbms_output.put_line('안녕하세요.' || name || '님');
end procTest;
/



begin
    procTest('홍길동');
end;
/






create or replace procedure procTest(
    width number, 
    height number default 10)
is
    vresult number;
begin 
    vresult := width * height;
    dbms_output.put_line(vresult);
end procTest;


begin
    --procTest(10,20);  --width(10), height(10)
    procTest(10);     -- width(10), height(10-default)
end;


/* 

    매개변수 모드
    - 매개변수가 값을 전달하는 방식
    - CALL BY Value
    - Call by Reference
    - Call by Reference > 매개변수 > 참조값(주소)를 넘기는 방식( 참조형 인자)    
    
    
    1. in 모드 > 기본
    2. out 모드
    3. in out 모드(x)


*/


create or replace procedure procTest(
    pnum1 in number,       --in parameter//인자값
    pnum2 in number,       
    presult out number, --out parameter//반환값 역할
    presult2 out number,
    presult3 out number 
)
is 
begin
    presult := pnum1 + pnum2;
    presult2 := pnum1 - pnum2;
    presult3 := pnum1 * pnum2;
end procTest;


declare
    vnum number;
    vnum2 number;
    vnum3 number;
begin
    procTest(10,20,vnum,vnum2,vnum3);
    dbms_output.put_line(vnum);
    dbms_output.put_line(vnum2);
    dbms_output.put_line(vnum3);
end;


--문제
-- 1. 부서 전달(인자값으로) > 해당 부서의 직원중 급여를 가장 많이 받는 사람의 번호를 반환(out)하세요 >출력
--      in 1개 + out 1개

-- 2. 직원 번호 전달(인자) > 직원과 같은 지역에 사는 직원의 수? , 같은 직위의 직원수? 해당 직원보다 급여를 더 많이 받는 직원수? 반환
--  in 1개 + out 3개
create or replace procedure procTest1(
    pbuseo in varchar2,
    pnum out number
)
is
begin
    select num into pnum from tblinsa
        where basicpay = (select max(basicpay) from tblinsa where buseo = pbuseo)
            and buseo = pbuseo;
end procTest1;
/

declare
    vnum number; -- out에게 넘길 변수
begin
    procTest1('기획부', vnum);
    dbms_output.put_line(vnum);
end;
/




create or replace procedure procTest2(
    pnum in number, --직원 번호
    pcnt1 out number,
    pcnt2 out number,
    pcnt3 out number
)
is
begin
    -- 2. 직원번호를 전달(인자) 후 같은 지역에 사는 직원수?, 같은 직위의 직원수?, 해당 직원보다 급여를 더 많이 받는 직원수? 반환
    select count(*) into pcnt1 from tblinsa 
        where city = (select city from tblinsa where num = pnum);
    select count(*) into pcnt2 from tblinsa 
        where jikwi = (select jikwi from tblinsa where num = pnum);
    select count(*) into pcnt3 from tblinsa 
        where basicpay > (select basicpay from tblinsa where num = pnum);
end procTest2;
/
/
declare
    vnum number;
    vcnt1 number;
    vcnt2 number;
    vcnt3 number;
begin
    --개발부에서 가장 많은 급여를 받는 사람과 같은 지역에 사는 직원수?, 같은 직위의 직원수?, 해당 직원보다 급여를 더 많이 받는 직원수?
    procTest1('개발부', vnum);
    
    procTest2(vnum, vcnt1, vcnt2, vcnt3);
    dbms_output.put_line(vcnt1);
    dbms_output.put_line(vcnt2);
    dbms_output.put_line(vcnt3);
end;
/


CREATE TABLE tblStaff(            
   seq NUMBER PRIMARY KEY,         --직원번호(PK)
   name varchar2(30) NOT NULL,      --직원명
   salary NUMBER NOT NULL,         --급여
   address varchar2(300) NOT NULL,   --거주지
   project varchar2(300)         --담당프로젝트
);


CREATE TABLE tblProject(
   seq NUMBER PRIMARY KEY,         --프로젝트 번호(PK)
   project varchar2(100) NOT NULL,   --프로젝트명
   --staff_seq NUMBER NOT NULL      --담당 직원 번호(위 테이블과 참조하는 코드)
   staff_seq NUMBER NOT NULL REFERENCES tblStaff(seq)   --담당 직원 번호(FK)
); --자식 테이블


select * from tblstaff;
select * from tblproject;

delete from tblstaff;
delete from tblProject;



INSERT INTO tblStaff (seq, name, salary, address) VALUES (1, '홍길동', 300, '서울시');
INSERT INTO tblStaff (seq, name, salary, address) VALUES (2, '아무개', 250, '인천시');
INSERT INTO tblStaff (seq, name, salary, address) VALUES (3, '하하하', 250, '부산시');

INSERT INTO tblProject (seq, project, staff_seq) VALUES (1, '홍콩 수출', 1); --홍길동
INSERT INTO tblProject (seq, project, staff_seq) VALUES (2, 'TV 광고', 2); --아무개
INSERT INTO tblProject (seq, project, staff_seq) VALUES (3, '매출 분석', 3); --하하하
INSERT INTO tblProject (seq, project, staff_seq) VALUES (4, '노조 협상', 1); --홍길동
INSERT INTO tblProject (seq, project, staff_seq) VALUES (5, '대리점 분양', 2); --아무개

commit;

CREATE OR REPLACE PROCEDURE procDeleteStaff(
   pseq NUMBER,         -- 퇴사 할 직원 번호
   pstaff NUMBER,         -- 위임받을 직원번호
   presult OUT NUMBER      -- 성공(1) OR 실패(0) > 피드백
)
IS
   vcnt NUMBER; -- 퇴사 직원의 담당 프로젝트 개수
BEGIN
   
   --1. 퇴사 직원이 담당 프로젝트가 있는지?
   SELECT count(*) INTO vcnt FROM tblproject WHERE staff_seq = pseq;

   --2. 조건 > 위임 유무 결정
   IF vcnt > 0 THEN
      --3. 위임
      UPDATE tblproject SET staff_seq = pstaff WHERE staff_seq = pseq;
   ELSE 
      --3. 아무것도 안 함
      NULL; -- 이 조건의 else절에는 아무것도 하지 마시오!! > 개발자의 의도 표현
   END IF;

   --4. 퇴사
   DELETE FROM tblstaff WHERE seq = pseq;

   --5. 피드백 > 성공
   presult := 1;

EXCEPTION
   WHEN OTHERS THEN 
      presult := 0;
      
   
   
END procDeleteStaff;



declare 
   vresult NUMBER;
begin
   procDeleteStaff(1, 2, vresult);
   IF vresult = 1 THEN
   dbms_output.put_line('퇴사 성공');
   else
   dbms_output.put_line('퇴사 실패');
   END IF;
END ;


select * from tblStaff;

select * from tblProject;


insert into tblStaff values (4, '호호호', 200, '서울시');






--위임받을 직원 > 현재 프로젝트를 가장 적게 담당 직원에게 자동으로 위임
-- 동률 > rownum = 1

CREATE OR REPLACE PROCEDURE procDeleteStaff(
   pseq NUMBER,         -- 퇴사 할 직원 번호
   presult OUT NUMBER      -- 성공(1) OR 실패(0) > 피드백
)
IS
   vcnt NUMBER; -- 퇴사 직원의 담당 프로젝트 개수
   vstaff_seq number; --담당 프로젝트가 가장 적은 직원 번호
BEGIN
   
   --1. 퇴사 직원이 담당 프로젝트가 있는지?
   SELECT count(*) INTO vcnt FROM tblproject WHERE staff_seq = pseq;

   --2. 조건 > 위임 유무 결정
   IF vcnt > 0 THEN
   
      --2.5 적게 맡고 있는 직원 번호?
       select seq from (
            select 
                s.seq
            from tblStaff s
                left outer join tblProject p
                    on s.seq = p.staff_seq
                        group by s.seq
                            having count(p.staff_seq) = (select                                                             
                                                                min(count(p.staff_seq))
                                                            from tblStaff s
                                                                left outer join tblProject p
                                                                    on s.seq = p.staff_seq
                                                                        group by s.seq))
                                                                             where rownum = 1
      
      
      --3. 위임
      UPDATE tblproject SET staff_seq = pstaff WHERE staff_seq = pseq;
   ELSE 
      --3. 아무것도 안 함
      NULL; -- 이 조건의 else절에는 아무것도 하지 마시오!! > 개발자의 의도 표현
   END IF;

   --4. 퇴사
   DELETE FROM tblstaff WHERE seq = pseq;

   --5. 피드백 > 성공
   presult := 1;

EXCEPTION
   WHEN OTHERS THEN 
      presult := 0;
      
   
   
END procDeleteStaff;



/*

    저장 프로시저 
    1. 저장 프로시저
    2. 저장 함수 --오늘 할 거임
    
    저장 함수, Stored Function > 함수
    - 저장 프로시저와 동일
    - 반환값이 반드시 존재 > out 파라미터를 말하는게 아니라 > return문을 사용한다
    - out 파라미터를 사용 금지하고 대신 return 문을 사용한다 => in 파라미터는 사용한다. 이게 저장프로시저와 저장 함수의 차이점
    - 이런 특성 때문에 호출하는 구문이 조금 다르다(*****)

*/

--num1 + num2 > 합

-- 프로시저
create or replace procedure procSum(
    num1 in number,   --in 생략 가능
    num2 in number,
    presult out number
)
is 
begin
    presult := num1 + num2;
end procSum;

-- 함수
create or replace function fnSum(
    num1 in number,
    num2 in number
    --presult out number -- out을 사용하면 함수의 고유 특성이사라지고 프로시저와 동일해진다. 함수를 만드는의미가 없어짐 out을 쓸거면 그냥 프로시저를써~
) return number
is
begin
--    presult := num1 + num2;
    
    return num1 + num2;
    
end fnSum;


set serverout on;

declare
    vresult number;
begin

    procSum(10, 20, vresult);
    dbms_output.put_line(vresult);

   vresult := fnSum(10,20);  --return 
     dbms_output.put_line(vresult);
end;

-- 프로시저: PL/SQL 전용 > 업무 절차 모듈화
-- 함수 : ANSI-SQL 보조


select name, basicpay, sudang,
        --procSum(basicpay, sudang,변수)
        fnSum(basicpay, sudang)
from tblInsa;


--이름, 부서, 직원, 성별(남자/여자)

select
    name, buseo, jikwi,
    case
        when substr(ssn, 8, 1) = '1' then '남자'
        when substr(ssn, 8, 1) = '2' then '여자'  
    end as gender,
    fnGender(ssn) as gender2
from tblInsa;



create or replace function fnGender(pssn varchar2) return varchar2
is
begin
    return case
            when substr(pssn, 8, 1) = '1' then '남자'
            when substr(pssn, 8, 1) = '2' then '여자'
            end;
end fnGender;

/*
    프로시저
    1. 프로시저
    2. 함수
    3. 트리거


    트리거, trigger
    - 프로시즈의 한 종류
    - 개발자의 호출이 아닌, 미리 지정한 특정 사건이 발생하면 시스템이 자동으로 실행하는 프로시저
    - 예약(사건) > 사건 발생 > 프로시저 호출
    - 특정 테이블 지정 > 지정 테이블 오라클 감시 >
        > insert or update or delete > 미리 준비해놓은 프로시저 호출
        
        
    트리거 구문
    create or replace trigger 트리거 명
        before|after
        insert|update|delete
        on 테이블명
        [for each row]
    declare 
        선언부;
    begin
        구현부;
    exception
        예외처리부;
    end;
        
*/

--tblInsa > 직원 삭제
create or replace trigger trgInsa
    before      -- 3. 삭제가 발생하기 직전에 아래의 구현부를 먼저 실행해라!!
    delete      -- 2. 삭제가 발생하는지 감시?
    on tblInsa  -- 1. tblInsa 테이블에서(감시)
begin
    dbms_output.put_line(to_char(sysdate, 'hh24:mi:ss') || ' 트리거가 실행되었습니다.');
    -- 월요일에는 퇴사가 불가능
    if to_char(sysdate, 'dy') = '월' then
        -- 강제로 에러 발생
        -- 자바 : throw new Exception()
        -- -20000 ~ -29999
        raise_application_error(-20001, '월요일에는 퇴사가 불가능합니다.');
    end if;
end trgInsa; -- 주의! 만들자마자 감시중임 

select * from tblInsa;

--1010	김종서	751010-1122233	97/08/08	부산	011-3214-5555	영업부	부장	2540000	130000 삭제

select * from tblInsa;

delete from tblInsa where num = 1004;

delete from tblBonus;
commit;

rollback;


select * from tabs;
select * from tblDiary;


--로그 기록
create table tblLogDiary(
    seq number primary key,
    message varchar2(1000) not null,
    regdate date default sysdate not null
    );
    
    create sequence seqLogDiary;
    
create or replace trigger trgDiary
    after
    insert or update or delete
    on TBLDIARY

declare
    vmessage varchar2(1000);
begin
    -- DBMS_OUTPUT.PUT_LINE(to_char(sysdate , 'hh24:mi:ss')||'트리거가 실행되었습니다.');
    if inserting then
        -- DBMS_OUTPUT.PUT_LINE('추가');
        vmessage := '새로운 항목이 추가되었습니다.';
    elsif updating then
        --    DBMS_OUTPUT.PUT_LINE('수정');
        vmessage := '기존 항목이 수정되었습니다.';
    elsif deleting then
        -- DBMS_OUTPUT.PUT_LINE('삭제');
        vmessage := '기존 항목이 삭제되었습니다.';


    end if;
    insert into tblLogDiary values (seqLogDiary.nextval , vmessage , default);
end trgDiary;




insert into TBLDIARY values (11,'프로시저를 공부했다.' , '흐림' , sysdate);

update TBLDIARY set SUBJECT = '프로시저를 복습했다.' where seq = 11;

delete from TBLDIARY where seq = 11;

select *
from tblLogDiary;
 
 rollback;

/*
    [for each row]
    
    1. 생략
        - 문장(Query) 단위 트리거 . Table level trigger
        - 사건에 적용된 행의 개수 무관> 트리거 딱 1회 호출
        - 적용된 레코드의 정보는 중요하지 않은 경우 - 사건 자체가 중요한 경우
        
    2. 사용
        - 행(Record) 단위 트리거
        - 사건에 적용된 행의 개수만큼 트리거가 호출   
        - 적용된 레코드의 정보가 중요한 경우 + 사건 자체보다..
        - 상관 관계를 사용한다. = 일종의 가상 레코드 > old,new
        
        insert
        - :new > 방금 추가된 행
        
        update
        - :old > 수정되기 전 행
        - :new > 수정된   후 행
        
        delete
        - :old > > 삭제되기 전 행
*/

select * from tblMen;

create or replace trigger trgMen
    after
    delete
    on tblMen
    for each row
begin
dbms_output.put_line('레코드를 삭제했습니다.'||:old.name);
end trgMen;

select * from tblMen;

delete from tblMen where name = '홍길동'; --1명 삭제 > 트리거 1회 실행

set SERVEROUTPUT on;

delete from tblMen where age <25;  --3명 사제 > 트리거 1회실행

rollback;

INSERT INTO tblmen VALUES ('홍길동', 25, 180, 70, '장도연');
INSERT INTO tblmen VALUES ('아무개', 22, 175, NULL, '이세영');
INSERT INTO tblmen VALUES ('하하하', 27, NULL, 80, NULL);
INSERT INTO tblmen VALUES ('무명씨', 21, 177, 72, NULL);
INSERT INTO tblmen VALUES ('정형돈', 28, NULL, 92, NULL);
INSERT INTO tblmen VALUES ('양세형', 22, 166, 55, '김민경');
INSERT INTO tblmen VALUES ('조세호', 24, 165, 58, '오나미');


create or replace trigger tblMen
    after
    update
    on tblMen
    for each row
begin
    
    dbms_output.put_line('레코드를 수정했습니다.'||:old.name);
    dbms_output.put_line('수정하기 전 나이: '|| :old.age);
    dbms_output.put_line('수정하기 후 나이'|| :new.age);
end trgMen;

update tblMen set age = age + 1 where name = '홍길동';



--퇴사 > 프로젝트 위임
select * from tblStaff;
select * from tblProject;

--직원을 퇴사 > 퇴사 바로 직전에 담당프로젝트를 체크해서 위임을 시켜야함
create or replace trigger trgDeleteStaff
    before          --3. 전에
    delete          --2. 퇴사
    on tblStaff     --1.직원테이블에서 
    for each row    --4. 해당 직원 정보
begin

    --5. 위임 진행
    update tblProject set
        staff_seq = 3
            where staff_seq = :old.seq; --퇴사하는 직원 번호
    
end trgDeleteStaff;

select * from tblStaff;
select * from tblProject;

delete from tblStaff where seq =1;

--회원 테이블, 게시판 테이블
-- 포인트 제도
--1. 글 작성 > 포인트+ 100
--2. 글 삭제 > 포인트 -50

create table tblUser (
    id varchar2(30) primary key,
    point number default 1000 not null
);

create table tblBoard(
    seq number primary key,
    subject varchar2(1000) not null,
    id varchar2(30) not null references tblUser(id)
);

create sequence seqBoard;

insert into tblUser values ('hong', default);

select * from tblUser;

-- A. 글을 쓴다(삭제한다)
-- B. 포인트를 누적/차감한다..


-- Case 1. Hard
-- 개발자가 직접 제어.
-- 실수 > 일부 업무 누락;;;


--1.1 글쓰기
insert into tblBoard values (seqBoard.nextVal, '게시판입니다.', 'hong');

--1.2 포인트 누적하기
update tblUser set point = point + 100 where id = 'hong';

--1.3 글 삭제
delete from tblBoard where seq = 1;

--1.4 포인트 차감하기
update tblUser set point = point - 50 where id = 'hong';

select * from tblUser;


-- Case 2. 프로시저
create or replace procedure procAddBoard (
    pid varchar2,
    psubject varchar2

)
is
begin

    --2.1 글쓰기
    insert into tblBoard values (seqBoard.nextVal, psubject, pid);
    
    --2.2 포인트 누적하기
    update tblUser set point = point + 100 where id = pid;
    
    
    
end procAddBoard;









create or replace procedure procDeleteBoard(
    pseq number
)
is
    vid varchar2(30); --삭제글의 작성자를 저장할 변수
begin

    -- 2.1 삭제글의 작성자?
    select id into vid from tblBoard where seq = pseq;
    
    -- 2.2 글 삭제
    delete from tblBoard where seq = pseq;

    -- 2.3 포인트 차감하기
    update tblUser set point = point -50 where id = vid;
end procDeleteBoard;



begin 
   -- procAddBoard ('hong','글을 작성합니다.');
    procDeleteBoard(2);
end;

select * from tblBoard;
select * from tblUser ; --1050



--3.트리거

create or replace trigger trgBoard
    after
    insert or delete
    on tblBoard
    for each row
    
begin
    
    if inserting then
        update tblUser set point = point + 100 where id = :new.id; 
    elsif deleting then
        update tblUser set point = point - 50 wher id = :new.id;
    end if;
    
end trgBoard;


insert into tblBoard values (seqBoard.nextVal, '또 다시 글을 씁니다.','hong');

delete from tblBoard where seq = 5;



select * from tblUser;
select * from tblBoard;










