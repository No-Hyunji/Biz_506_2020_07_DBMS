
create tablespace grade2TS
datafile 'C:/bizwork/workspace/oracle_data/grade2TS'
size 1M AUTOEXTEND ON NEXT 500K ;

create user grade1 IDENTIFIED by grade1
default tablespace grade2TS;
GRANT DBA to grade1;


create table tbl_student(
  st_num char(5) primary key,
  st_name varchar2(20) not null,
  st_tel varchar2(20) not null,
  st_addr varchar2(125),
  st_grade number(5) not null,
  st_dcode char(5) not null,
  st_dept char(20) ,
  st_prof nvarchar2(20)
);
drop table tbl_student;

insert into tbl_student(st_num, st_name, st_tel,st_addr, st_grade, st_dcode, st_dept, st_prof)
values('20001','갈한수','010-2217-7851','경남 김해시 어방동 1088-7', 3, 008, '미술학', '필리스');
insert into tbl_student(st_num, st_name, st_tel,st_addr, st_grade, st_dcode, st_dept, st_prof)
values('20002','강이찬','010-4311-1533','강원도 속초시 대포동 956-5', 1, 006, '영어영문', '권오순');
insert into tbl_student(st_num, st_name, st_tel,st_addr, st_grade, st_dcode, st_dept, st_prof)
values('20003','개원훈','010-6262-7441','경북 영천시 문외동 38-3번', 1, 009, '고전음악학', '파파로티');
insert into tbl_student(st_num, st_name, st_tel,st_addr, st_grade, st_dcode, st_dept, st_prof)
values('20004','경시현','010-9794-9856','서울시 구로구 구로동 3-35번지', 1, 006, '영어영문', '권오순');
insert into tbl_student(st_num, st_name, st_tel,st_addr, st_grade, st_dcode, st_dept, st_prof)
values('20005','공동영','010-8811-7761','강원도 동해시 천곡동 1077-3', 2, 010, '정보통신공학', '최양록');

select * from tbl_student;

create table tbl_dept(
    dt_dcode NUMBER(3) primary key,
    dt_dept char(20) not null  ,
    dt_prof char(20)UNIQUE);
insert into tbl_dept(dt_dcode, dt_dept, dt_prof) values(001,'컴퓨터공학','토발즈');
insert into tbl_dept(dt_dcode, dt_dept, dt_prof) values(002,'전자공학','이철기');
insert into tbl_dept(dt_dcode, dt_dept, dt_prof) values(003,'법학','킹스필드');

drop table tbl_score;
select * from tbl_score;

create table tbl_score(
    sc_num char(10) ,
    sc_dept char(20) ,
    sc_score number(5) 

);
insert into tbl_score(sc_num, sc_dept, sc_score) values('20001','데이터베이스',71);
insert into tbl_score(sc_num, sc_dept, sc_score) values('20001','수학',63);
insert into tbl_score(sc_num, sc_dept, sc_score) values('20001','미술',50);

insert into tbl_score(sc_num, sc_dept, sc_score) values('20002','데이터베이스',84);
insert into tbl_score(sc_num, sc_dept, sc_score) values('20002','음악',75);
insert into tbl_score(sc_num, sc_dept, sc_score) values('20002','국어',52);

insert into tbl_score(sc_num, sc_dept, sc_score) values('20003','수학',89);
insert into tbl_score(sc_num, sc_dept, sc_score) values('20003','영어',63);
insert into tbl_score(sc_num, sc_dept, sc_score) values('20003','국어',70);


SELECT sc_num, sc_score 
FROM tbl_score
where sc_score < 60;

update tbl_student 
set st_addr = '광주광역시 북구 중흥동 경양로 170번'
where st_name = '공동영';



select * from tbl_student;

delete from tbl_student
where st_name = '개원훈';
delete from tbl_score
rollback;

drop table tbl_student;
drop table tbl_score;
drop table tbl_dept;

create table tbl_student(
    st_num  CHAR(5) primary key,
    st_name nVARCHAR2(20) not null,
    st_tel nVARCHAR2(20),
    st_addr nVARCHAR2(125),
    st_grade NUMBER(1)
    );
create table tbl_dept(
d_num char(5) primary key,
d_name	 nVARCHAR2(20)	NOT NULL,
 d_prof	 nVARCHAR2(20)	
);

drop table tbl_dept;
SELECT st_num, st_name, st_tel, st_addr, st_grade ,tbl_dept.d_num, d_name, d_prof
FROM tbl_student
    LEFT JOIN tbl_dept
        ON st_num = d_num ;
        
drop table tbl_student;
drop table tbl_dept;







