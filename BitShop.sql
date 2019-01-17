--테이블 생성~
create table member(
 id varchar2(10) primary key,
 name varchar2(10),
 pass varchar2(10),
 ssn varchar2(14)
);

--테이블 갯수세기~
select count(*) from tab;

--테이블 삭제~~
drop table member;

--테이블 다 보여줘~~
select * from tab;

--test에 test2 칼럼명 추가
alter table Test 
add test2 varchar2(10);

select *from Test;

--칼럼명 삭제
alter table test
drop column test2;

select * from article;

drop table account;

--제약조건 .. constraints

CREATE TABLE account(
   account_num VARCHAR2(9) primary key,
   created_date date default sysdate, 
   money NUMBER default 0,
   id varchar2(10) not null, 
   constraint account_fk_member foreign key(id)
        references member(id)
  ); 
    
create table admin (
admin_num varchar2(10) primary key,
name varchar2(10) not null,
pass varchar2(10) not null,
auth varchar2(10) default '사원'
);

-- 아티클 생성 전 시퀀스 시작 번호 설정
create sequence art_seq
start with 1000
increment by 1;

create table article(
art_seq number primary key,
title varchar2(20) default '제목없음',
content varchar2(50),
regdate date default sysdate,
id varchar2(10)not null,
constraint article_fk_member foreign key(id)
    references member(id)
);

--인스턴스 생성
--DB에서 한 row 를 추가하는 것
INSERT INTO article(art_seq, title, content, regdate)
VALUES('hong', '홍길동', '1', '900101-1234567');

    