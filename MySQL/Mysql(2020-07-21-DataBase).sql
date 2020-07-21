-- MySQL에서 사용자는 기본적으로 root시작을 한다.
-- 오라클과 차이점
----------------------------------------------------------------------------
-- 구분                오라클                                      MySQL
-- 저장소               TableSpace                                DataBase
-- Scheme             User                                      DataBase
-- 데이터저장            User.Table형식                              Table
-- User의 개념           Scheme                                  Login하는 Account
----------------------------------------------------------------------------

-- 1. MySQL 데이터를 저장하기 위해서 최초로 DataBase를 생성 가능하다
-- 2. 생성된 DataBase를 사용가능하도록 Open 절차 필요하다.
-- 3. 사용자 login 권한과 접속하는 용도의 Account
Drop database myDB; -- [2]

-- MySQL CHARACTER SET
-- 저장하는 문자열의 코드길이(Byte)관련한 설정
-- MySQL 5.x(5.7)에서는 문자 locale설정이 기본값이 Lathin이어서 
-- 한글과 같은 UNICODE 저장에 상당히 문제가 되었던 적이 있다.
-- 최근에는 기본문자 Locale UTF8M4 라는 방식으로 거의 통일되었다.
-- 따라서 별도로 Character set을 지정하지 않아도 큰 문제가 없다
-- 오래된 MySQL 버전에서는 DataBase를 생성할 때 CHARACTER SET을
-- 명시 해 주었으니 최근 버전에서는 오히려 경고를 내고 있다.
# 이것도 주석

-- 현재 PC에 설치된 MySQL Server에 myDB라고 하는 Scheme(DataBase)를 생성
create database myDB; -- [1]

-- MySQL 칼럼 Type
-- 문자열 : CHAR(개수), VARCHAR(개수)
-- CHAR : 고정된 문자열을 저장하는 칼럼(코드 등의 데이터) 255까지 가능
-- VARCHAR : 한글을 포함한 가변형 문자열을 저장하는 칼럼 65565까지 가능
-- 정수형 숫자형 : INT(4Byte, 2의 32승),
--              BIGINT(8Byte 무제한),
--              TYNYINT(1Byte, -128 ~ 127, 0~255), 
--              SMALLINT(0~65535), 
--              MIDIUM(0~1677215)
-- 정수형의 경우 자릿수를 명시하지 않으면, 최대 지원 크기까지 저장가능 하다.
-- 실제 저장을 해보면 INT형은 정수 11자리를 넘어가면 저장이 안됀다.

-- 실수형 : FLOAT(길이, 소수점, 4Byte), DECIMAL(길이, 소수점),
--        DOUBLE(길이, 소수점, 8Byte)
-- MySQL에서는 데이터와 관련된 DDL, DML, DCL 등의 명령을 수행하기 전에
-- 사용할 Scheme를 Open 절차가 반드시 필요하다.
-- myDB DataBase Open 시키기
USE myDB; -- [3]


-- 설계를 하면서 일련번호를 채울 PK만을 위한 칼럼을 생성하는 방법
drop table tbl_student;
create table tbl_student(   -- [4] int뒤 괄호 뗌
	st_num	 CHAR(5)	PRIMARY KEY,
	st_name	VARCHAR(20)	NOT NULL,
	st_dept	VARCHAR(10)	,
	st_grade	INT	,
	st_tel	VARCHAR(20),	
	st_addr	VARCHAR(125),	
	st_age	int	
);
DESC tbl_student;    #5
select * from tbl_student;

-- auto_increment, auto increment(점진적으로,일정하게 뭔가 증가하는것)

-- 이미 사용중인 테이블에 일련번호를 채울 PK만을 위한 칼럼을 생성하는 방법
alter table tbl_score add sc_seq BIGINT auto_increment;
desc tbl_score;
select * from tbl_score;


drop table tbl_score;
create table tbl_score(
	sc_num	 CHAR(5)	NOT NULL,
	sc_scode	 CHAR(4)	NOT NULL,
	sc_sname	VARCHAR(30)	,
	sc_score	 INT	
);

-- projection
select st_num, st_name, st_tel from tbl_student;

-- selection
select st_num, st_name
from tbl_student
where st_num between '20001' and '20010';

select * from tbl_dept;

select ST.st_num, ST.st_name, ST.st_dept, D.d_name, D.d_prof
from tbl_student ST
	left join tbl_dept D
		on ST.st_dept = D.d_code;
        
select count(*) from tbl_iolist;
desc tbl_iolist;
select io_dept from tbl_iolist;

-- decode()
select 

sum(case when io_inout = '매입' then io_amt else 0  end )as '매입합계',
sum(case when io_inout = '매출' then io_amt else 0  end )as '매출합계',


sum(case when io_inout = '매출' then io_amt else 0  end )-
sum(case when io_inout = '매입' then io_amt else 0  end )as 이익금
from tbl_iolist;

-- 현재 스키마의 table 리스트
show tables;
-- 현재mySQL서버에 만들어진 스키마(DataBase)리스트
show databases;

desc tbl_score;

------------------------------------------
-- tbl_score 테이블에 데이터 추가하기
--------------------------------------------
-- 만약 학번 20001인 학생의 국어(D001), 영어(D002), 수학(D003) 점수를 입력한다 라고 하면
insert into tbl_score(sc_num, sc_scode, sc_sname, sc_score)
values('20001','D001','국어','80');
insert into tbl_score(sc_num, sc_scode, sc_sname, sc_score)
values('20001','D002','영어','70');
insert into tbl_score(sc_num, sc_scode, sc_sname, sc_score)
values('20001','D003','수학','75');

insert into tbl_score(sc_num, sc_scode, sc_sname, sc_score)
values('20002','D001','국어','75');
insert into tbl_score(sc_num, sc_scode, sc_sname, sc_score)
values('20002','D002','영어','80');
insert into tbl_score(sc_num, sc_scode, sc_sname, sc_score)
values('20002','D003','수학','50');

delete from tbl_score;
select * from tbl_score;

-- 한 개의 칼럼으로 PK를 만들때는 설계할때 고려를 하고
-- table을 생성할때 만드는 것이 편리하다.

-- 두개이상의 후보키를 묶어서 PK로 활동하는 복합키 PK
-- Table을 만들고 데이터가 추가되는 과정에서 생성되는 경우가 많다.
alter table tbl_score add primary key(sc_num, sc_scode);
alter table tbl_score drop primary key;

alter table tbl_score;

-- 어떤 table을 만들었는데, 이 테이블에 PK를 설정하려고 봤더니
-- 단일 키로 PK를 설정하기가 매우 어렵게 되었다.
-- 복합 키로 PK를 설정해야 하는데 왠지 그러기가 싫다.
-- 임의 실제 데이터와는 관계가 없이 별도의 PK만을 위한 칼럼을 만들고
-- 그 칼럼에 일련번호와 같은 값을 채워서 PK로 삼고싶다.
-- insert 보다는 update, delete의 무결을 위한 설정

drop table tbl_score;
create table tbl_score(
	
	sc_num	 CHAR(5)	NOT NULL,
	sc_	 CHAR(4)	NOT NULL,
	sc_sname	VARCHAR(30)	,
	sc_score	 INT	
);

select * from tbl_score;
insert into tbl_score(sc_num,sc_scode,sc_sname,sc_score)
values('20003','D001','국어','90');

insert into tbl_score(sc_seq,sc_num,sc_scode,sc_sname,sc_score)
values(0,'20003','D001','국어',90);
select io_bcode,sum(io_amt)
from tbl_iolist
group by io_bcode;




































