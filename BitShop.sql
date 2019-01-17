--���̺� ����~
create table member(
 id varchar2(10) primary key,
 name varchar2(10),
 pass varchar2(10),
 ssn varchar2(14)
);

--���̺� ��������~
select count(*) from tab;

--���̺� ����~~
drop table member;

--���̺� �� ������~~
select * from tab;

--test�� test2 Į���� �߰�
alter table Test 
add test2 varchar2(10);

select *from Test;

--Į���� ����
alter table test
drop column test2;

select * from article;

drop table account;

--�������� .. constraints

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
auth varchar2(10) default '���'
);

-- ��ƼŬ ���� �� ������ ���� ��ȣ ����
create sequence art_seq
start with 1000
increment by 1;

create table article(
art_seq number primary key,
title varchar2(20) default '�������',
content varchar2(50),
regdate date default sysdate,
id varchar2(10)not null,
constraint article_fk_member foreign key(id)
    references member(id)
);

--�ν��Ͻ� ����
--DB���� �� row �� �߰��ϴ� ��
INSERT INTO article(art_seq, title, content, regdate)
VALUES('hong', 'ȫ�浿', '1', '900101-1234567');

    