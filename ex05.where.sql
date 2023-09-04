 /*

    [WITH <Sub Query>] 
    SELECT column_list
    FROM table_name
    [WHERE search_condition]
    [GROUP BY group_by_expression]
    [HAVING search_condition]
    [ORDER BY order_expresstion [ASC|DESC]];
    
    select 컬럼리스트      3. 컬럼 지정 (보고 싶은 컬럼만 가져오기) > Projection
    from 테이블         1. 테이블 지정
    where 조건;         2. 조건 지정 (보고 싶은 행만 가져오기) > Selection
    
    where절
    - 레코드 (행)을 검색한다.
    - 원하는 행만 추출하는 역할
    

 */