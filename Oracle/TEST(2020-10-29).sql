-- test1 사용자 
-- 거의 대부분의 DBMS에서 공통으로 사용되는 명령어들 

-- 데이터를 저장할 Table,Entity 생성 
-- t_num..등등으로 칼럼을 만들겠다
create table tbl_test(
    t_num CHAR(5), -- 문자열 5자
    t_name nVARCHAR2(20), -- 한글포함 문자열 20자
    t_tel VARCHAR2(20) -- 영문, 숫자 전용 문자열 20자 
    
);
-- 데이터를 저장하기
-- 엑셀에 있는 표 , t_num t_name t_tel 이렇게 표를 만들어라 
--                S0001   홍길동  010-111-1111 추가하라 
insert into tbl_test(t_num, t_name, t_tel)values('S0001','홍길동','010-111-1112');
insert into tbl_test(t_num, t_name, t_tel)values('S0002','이몽룡','010-111-1113');
insert into tbl_test(t_num, t_name, t_tel)values('S0003','성춘향','010-111-1114');
insert into tbl_test(t_num, t_name, t_tel)values('S0004','장보고','010-111-1115');
insert into tbl_test(t_num, t_name, t_tel)values('S0005','장영실','010-111-1116');

-- 데이터가 모두 잘 저장되었나 확인 
select * from tbl_test;

-- insert한 데이터중에 이름이 이몽룡인 데이터가 있는가 확인하기
-- 조건 검색 이라고 한다. 
select * from tbl_test where t_name = '이몽룡';

-- 번호가 S0004인 사람이 누구인가 알아보고 싶을 때
select * from tbl_test where t_num = 'S0004';

-- 이름이 성춘향인 사람의 전화번호가 010-222-2222으로 변경이 되었다.
-- 저장된 데이터를 수정하고 싶다. 이럴 때 update
update tbl_test set t_tel = '010-222-2222' where t_name = '성춘향'; -- 좋지 않은 방법
select * from tbl_test;

-- 만약 아래 명령문을 실행했을 때 2개 이상이면 위의 방법으로 업데이트 하면 안된다 
-- 성춘향의 전화번호를 바꾸려고 할 때 혹시 데이터중에 성춘향의 데이터가 두개 이상있으면 
-- 이름으로 업데이트를 하면 문제가 발생한다.
-- 바꾸고자 하는 성춘향의 데이터를 조건검색하여 
-- 번호를 확인하고 바꾸는 것이 좋다.
select * from tbl_test where t_name = '성춘향';
update tbl_test set t_tel = '010-333-3333' where t_num='S0003';

-- 데이터 삭제 
-- 필요없는 데이터를 삭제를 수행하는데
-- 장영실 삭제할것, 이름으로 하지 말자 
-- java개발자로서 최소한 여기까지는 해야한다. CRUD구현 위해서 
select * from tbl_test where t_name ='장영실';
-- 이렇게 삭제하는게 좋은 방법
delete from tbl_test where t_num = 'S0005';





















