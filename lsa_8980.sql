DROP table reservation;
DROP table director;
DROP table schedule_movie;
DROP table member;

DROP SEQUENCE seq_res_num;
DROP SEQUENCE seq_movie_code;
DROP SEQUENCE seq_dr_code;


create table member(
    id varchar2(30) primary key,
    pass varchar2(100) ,
    name varchar2(50) ,
    gender char(10) ,
    tel varchar2(13) ,
    regdate date default sysdate
);



create table schedule_movie(
    movie_code number primary key,
    mv_title varchar2(100) ,
    mv_story varchar2(4000) ,
    mv_runtime number,
    mv_regdate date default sysdate
);


create table director (
    dr_code NUMBER primary key,
    dr_name varchar2(50),
    dr_regdate date DEFAULT sysdate,
    movie_code NUMBER not null REFERENCES schedule_movie(movie_code)
);


create table reservation (
    res_num number primary key,
    id varchar2(30),
    movie_code NUMBER,
    regdate date default sysdate,
    CONSTRAINT fk_reservation_id FOREIGN KEY (id) REFERENCES member(id),
    CONSTRAINT fk_reservation_movie_code FOREIGN KEY (movie_code) REFERENCES schedule_movie(movie_code)
);



create sequence seq_res_num;
create sequence seq_movie_code;
create sequence seq_dr_code;


delete from member;

-- 회원 테이블 데이터
INSERT INTO member (id, pass, name, gender, tel) VALUES ('son', '1234', '손재옥', '남', '010-7361-9876');
INSERT INTO member (id, pass, name, gender, tel) VALUES ('kim', '1234', '김영주', '남', '010-6712-7652');
INSERT INTO member (id, pass, name, gender, tel) VALUES ('jung', '1234', '정헌석', '남', '010-7731-1471');

select * from member;

-- 영화 테이블 데이터
INSERT INTO schedule_movie (movie_code, mv_title, mv_Story, mv_runtime)
VALUES (seq_movie_code.nextVal, '007 노 타임 투 다이(No time to Die)', '가장 강력한 운명의 적과 마주하게된 제임스 본드의 마지막 미션이 시작된다.', 163);
INSERT INTO schedule_movie (movie_code, mv_title, mv_Story, mv_runtime)
VALUES (seq_movie_code.nextVal, '보이스(On the Line)', '단 한 통의 전화!걸려오는 순간 걸려들었다!', 109);
INSERT INTO schedule_movie (movie_code, mv_title, mv_Story, mv_runtime)
VALUES (seq_movie_code.nextVal, '수색자(The Recon)', '억울하게 죽은 영혼들의 무덤 DMZ', 111);
INSERT INTO schedule_movie (movie_code, mv_title, mv_Story, mv_runtime)
VALUES (seq_movie_code.nextVal, '기적(Mircle)', '오갈 수 있는 길은 기찻길밖에 없지만 정작 기차역은 없는 마을.', 117);

select * from schedule_movie;

-- 감독 테이블
INSERT INTO director (dr_code, dr_name, movie_code) VALUES (seq_dr_code.nextVal, '캐리 후쿠나가', 1);
INSERT INTO director (dr_code, dr_name, movie_code) VALUES (seq_dr_code.nextVal, '김선' , 2);
INSERT INTO director (dr_code, dr_name, movie_code) VALUES (seq_dr_code.nextVal, '김곡', 2);
INSERT INTO director (dr_code, dr_name, movie_code) VALUES (seq_dr_code.nextVal, '김민섭', 3);
INSERT INTO director (dr_code, dr_name, movie_code) VALUES (seq_dr_code.nextVal, '이창훈', 4);

select * from director;

-- 예약 테이블
INSERT INTO reservation (res_num, id, movie_code) VALUES (seq_res_num.nextVal, 'son', 2);
INSERT INTO reservation (res_num, id, movie_code) VALUES (seq_res_num.nextVal, 'son', 3);
INSERT INTO reservation (res_num, id, movie_code) VALUES (seq_res_num.nextVal, 'kim', 1);
INSERT INTO reservation (res_num, id, movie_code) VALUES (seq_res_num.nextVal, 'jung', 2);

select * from reservation;




--검색
select * from member;
select * from reservation;
select * from director;



--영화제목, 스토리, 러닝타임, 감독명
select 
s.mv_title as 영화제목,
s.mv_story as 스토리,
s.mv_runtime as 러닝타임,
d.dr_name as 감독명
from schedule_movie s 
    inner join director d
    on d.movie_code=s.movie_code
    
    
    

--보이스 라는 영화의 예약자명, 성별, 전화번호, 예매번호, 예매일을 조회한다. 단, 예매일이 마지막에 예매된 순서대로 조회하세요.

select 
    m.name as 예약자명,
    m.gender as 성별,
    m.tel as  전화번호,
    r.res_num as 예매번호,
    r.regdate as 예매일
from reservation r
    inner join member m
    on r.id = m.id
    inner join schedule_movie s
    on r.movie_code = s.movie_code
    where s.mv_title = '보이스(On the Line)'
    order by r.regdate desc;
    