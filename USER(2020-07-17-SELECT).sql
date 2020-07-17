-- 여기는 user1 화면입니다.
select * from tbl_dept ;

-- projection과 selection
-- DB 공학에서 논리적인 차원 DB 관련용서
-- 실무에서는 별로 사용하지 않는 단어이기도 하다.
-- projection
select d_code, d_name, d_prof
from tbl_dept;

-- selection 
select * 
from tbl_dept
where d_name = '관광학';


-- 현재 학과 테이블의 학과명중에 관광학 학과를 관광정보학으로 변경을 하려고 한다.
-- 1. 내가 변경 하고자 하는 조건에 맞는 데이터가 있는지 확인하는 과정
select * from tbl_dept where d_name = '관광학';
-- 2. selection 한 결과가 1개의 레코드만 나타내고 있지만 d_name은 PK가 아니다.
--    여기에서 보여주는 데이터는 리스트이다.
--    UPDATE를 할 때 d_name = '관광학' 조건으로 UPDATE를 실행하면 안됀다.
--    update tbl_dept set d_namde = '관광정보학' where d_name = '관광학' 
--    처럼 명령을 수행 하면 안됀다.
-- 3. 조회된 결과에서 PK값이 무엇인지를 파악해야 한다.
-- 4. PK를 조건으로 데이터를 update 수행해야 한다.
update tbl_dept
set d_name = '관광정보학'
where d_code = 'D001';

select * from tbl_dept;

insert into tbl_dept ( d_code, d_name, d_prof)
values ('D006','무역학','장길산');

-- delete
-- dbms 스키마에 포함된 Table 중에 여러 업무를 수행하는데 필요한 Table을 
-- 보통 master data table이라고 한다.
-- (학생정보, 학과정보)
-- master data는 초기에 insert가 수행된 후에 업무가 진행동안
-- 가급적 데이터를 변경하거나 삭제하는 일이 최소화 되어야 하는 데이터
-- master data와 relation을 하여 생성되는 여러 데이터들의 무결성을 위해서 
-- master data는 변경을 최소화 하면서 유지해야 한다.

-- dbms의 스키마에 포함된 table중에 수시로 데이터가 추가, 변경, 삭제가 필요한 table을
-- 보통 Work Data Table이라고 한다.
-- (성적정보)
-- work data는 수시로 데이터가 추가되고, 여러가지 연산을 수행하여 
-- 통계, 집계 등 보고서를 작성하는 기본 데이터가 된다.
-- 통계, 집계 등 보고서를 작성 한 후 데이터를 검증 하였을 때 이상이 있으면, 
-- 데이터를 수정, 삭제를 수행햐여 정정하는 과정이 이루어진다.
-- work data는 master table과 relation을 잘 연동하여 데이터를 insert하는
-- 단계부터 잘못된 데이터가 추가 되는것을 막아줄 필요가 있다.
-- 이 때 설정하는 조건중에 외래키, 연관 조건이 있다.

select * from tbl_score;
insert into tbl_score(sc_num) value(100);
commit;

update tbl_score  -- 변경할 테이블
set sc_kor = 90     -- 변경할 대상 = 값
where sc_num = '20015'; -- 조건(update에서 where는 선택사항이나, 실무에서는 필수사항으로 인식)

update tbl_score
set sc_kor = 90, sc_math = 90  --  다수의 칼럼 값을 변경하고 할 때 칼럼 = 값, 칼럼 = 값 형식으로
where sc_num = '20015';

select * from tbl_score;
select * from tbl_score where sc_num = '20015';

update tbl_score
set sc_kor = 100;

select * from tbl_score;

-- 보통 SQL문으로 CUD(Insert, Update, Delete)를 수행하고 난 직후에는
-- table의 변경 된 데이터가 물리적(스토리지)에 반영이 아직 안된상태이다.
-- 스토리지에 데이터 변경이 반영되기 전에
-- rollback 명령을 수행하면 변경내용이 모두 제거(취소)된다.
-- rollback명령을 잘못 수행하면, 정상적으로 변경(CUD) 필요한 데이터 마저
-- 변경이 취소되어 문제를 일으킬 수 있다.

-- insert를 수행하고 난 직후에는 데이터의 변경이 물리적으로 반영될 수 있도록
-- commit명령을 수행해주는 것이 좋다.
-- update나 delete는 수행한 직후 반드시 select를 수행하여
-- 원하는 결과가 잘 수행되었는지 확인 하는 것이 좋다.

rollback;
select * from tbl_score;


-- 20020학번의 학생이 시험날 결석을 하여 시험 응시를 하지 못했는데
-- 성적이 입력되었다, 
-- 이 학생의 성적데이터는 삭제되어야 한다.
-- 20020 학생이 정말 시험날 결석한 학생인지 확인하는 절차가 필요하다.
-- 20020 학생의 학생정보를 확인하고, 만약 이 학생의 정보가 등록되어있다면
-- 삭제를 수행하자.
select * from tbl_student where st_num = '20020';

-- 아래 쿼리문을 실행했을 때
-- 학생정보는 보이는데, 성적정보 칼럼 값들이 모두 (null)로 나타나면
-- 이 학생의 성적정보는 등록되지 않은 것이다.
-- 따라서 삭제하는 과정이 필요하지 않다.
-- 학생정보와 함께 성적정보칼럼의 값들이 1개라도 (null)이 아닌 것으로 나타나면
-- 이 학생의 성적정보는 등록된것이다.
-- 따라서 이 학생의 성적정보를 삭제해야 한다.
select *
from tbl_student ST
    left join tbl_score SC
        on ST.st_num = SC.sc_num
where ST.st_num = '20020';        

-- sc_num 데이터에 없는 조건을 부여하면
-- delete를 수행하지 않을 뿐 오류가 나거나 하지는 않는다.
delete from tbl_score
where sc_num = '20020';
-- 잘못하면 롤백하고 다시
rollback;

-- 성적 데이터의 국어 점수가 가장 높은 값과 가장 낮은 값은 무엇인가?????????
select max(sc_kor), min(sc_kor)
from tbl_score;

-- 최고 점수는 100점, 최저점수는 50점이 나왔는데
-- 이 점수를 받은 학생은 누구일까
select SC.sc_num, ST.st_name, SC.sc_kor 
from tbl_score SC
left join tbl_student ST
on ST.st_num = SC.sc_num
where SC.sc_kor = 100  or  SC.sc_kor = 50 ;

-- 최고,최저점이 바뀌면? 
-- 서브쿼리
select SC.sc_num, ST.st_name, SC.sc_kor
from tbl_score SC
left join tbl_student ST
on ST.st_num = SC.sc_num
where SC.sc_kor = 
(
    select max(sc_kor) from tbl_score
)

or  SC.sc_kor = 
(
    select min(sc_kor) from tbl_score
    );

