--ex03_select.sql


/*

    SQL, Query(질의)
    
    SELECT문
    - DML, DQL
    - SQL은 SELECT로 시작해서 SELECT로 끝난다.

    - CRUD
    
    
    
    [WITH <Sub Query>] 
    SELECT column_list
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING search_condition]
    [ORDER BY order_expresstion [ASC|DESC]]
    
    SELECT column_list -- 원하는 칼럼을 지정만 가져와라.
    FROM table_name -- 데이터 소스. 즉 어떤 테이블로부터 데이터를 가져와라라는 뜻
    
    각 절의 순서
    2. SELECT 
    1. FROM
    
*/

select * 
from tblType; 

--테이블 구조?? > 스키마(Scheme) > 명세서 
desc employees;

select * from employees;

select first_name from employees;

select * from tblAddressBook;
select * from tblComedian;
select * from tblCountry;
select * from tblDiary
select * from tblHouseKeeping;
select * from tblInsa;
select * from tblMen;
select * from tblWomen;
select * from tblSalary;
select * from tblTodo;
--select * from tblName;
select * from tblZoo;
select * from tblcode;


-- select 절
-- from 절

--select 컬럼리스트

--단일 컬럼
select first from tblComedian;
select nick from tblComedian;

select * from tblComedian;
--다중 컬럼
select first, last, gender, height, weight, nick from tblComedian;

--컬럼 순서 > 자유 
select last, first from tblComedian;

--동일 컬럼 반복 
select last, last from tblComedian;


--쓰는 방법
--1
select last, first from tblComedian;

--2
select last,first
from tblComedian;

--3
select last,first
    from tblComedian;

--4
select
    last,first
from
    tblComedian;

--ORA-00904: "FIRS": invalid identifier
--ORA-00942: table or view does not exist
