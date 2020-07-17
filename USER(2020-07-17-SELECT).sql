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
--------------------------------------------------------------------------------
------------------------------sub query-----------------------------------------
--------------------------------------------------------------------------------
-- 두 번 이상 select 수행해서 결과를 만들어야 하는 경우
-- 첫번째 select 결과르 두번째 select에 주입하여 
-- 동시에 두 번 이상의 select를 수행하는 방법
-- subquery는 join로 모두 구현 가능하다.
-- 하지만 간단한 동작을 요구할때는 서브쿼리를 사용하는 것이 
-- 쉬운 방법 이기도 하다
-- 또한 오라클 관련정보들(구글링)중에 join보다는 서브쿼리를 
-- 사용한 예제들이 많아서 코딩에 다소 유리한 면도 있다.

-- 서브쿼리를 사용하게 되면 select문이 여러번 실행되기때문에
-- 약간만 코딩이 변경 되어도 상당히 느린 실행결과를 낳게 된다. 

-- [첫번째 방법]where절에서 서브쿼리(subquery) 사용하기
-- where 처음에 칼럼 명이 오고 (<=>) 
-- 괄호를 포함 한 select 쿼리가 나와야 한다.
-- subquery로 작동되는 select문은 기본적으로 1개의 결과만 나와야 한다.
-- subquery의해 연산된 결과의 값을 기준으로 칼럼에 조건문을 부여하는 방식
-- subquery는 method, 함수를 호출하는 것과 같이 subquery가 return해주는 값을
-- 칼럼과 비교하여 최종 결과물을 낸다.

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

-- 국어점수의 평균을 구하고
-- 평균 점수보다 높은 점수를 얻은 학생들의 리스트를 구하고 싶다.

-- 서브쿼리가 들어갈 쿼리문을 미리 실행해보기
select AVG(sc_kor)
from tbl_score;

select * 
from tbl_score
where sc_kor >= 75 ;

-- 위의 두개 쿼리를 하나로 묶기
select * 
from tbl_score
where sc_kor >=
(
select avg(sc_kor) from tbl_score
);

-- 각 학생의 점수 평균을 구하고
-- 전체 학생의 평균을 구하여 
-- 각 학생의 평균점수가  전체 학생의 평균 점수보다 높은 리스트를 조회하시오.

select avg(sc_kor + sc_eng + sc_math + sc_music + sc_art)
from tbl_score; -- 전체평균 371.39

-- 각 학생평균
select sc_num, ((sc_kor + sc_eng + sc_math + sc_music + sc_art)/5)
from tbl_score;


--------------나
select sc_num,
((sc_kor+sc_eng+sc_math+sc_music+sc_art)/5)
from tbl_score
where ((sc_kor + sc_eng + sc_math + sc_music + sc_art)/5) > 
(select (avg(sc_kor + sc_eng + sc_math + sc_music + sc_art)/5)from tbl_score);
-- select query문이 실행되는 순서
-- 1. from 절이 실행되어 tbl_score 테이블의 정보(칼럼)를 가져오기
-- 2. where이 실행되어서 실제로 가져올 데이터를 선별
-- group by절이 있다면, 실행되어 중복된 데이터를 묶어서 하나로 만든다.
-- 3. select에 나열된 칼럼에 값을 채워넣고,
-- 4. select에 정의된 수식을 연산, 결과를 보일준비
-- 5. order by는 모든 쿼리가 실행되고 가장 마지막에 연산수행되어 정렬을 한다.

-- where절과 group by절에서는 alias로 설정 된 칼럼 이름을 사용 할 수 없다.
-- order by에서는 alias로 설정된 칼럼 이름을 사용 할 수 있다.

-- 위의 쿼리를 활용하여 
-- 평균을 구하는 조건은 그대로 유지하고,
-- 학번이 20020 이전의 학생들만 추출하기
select sc_num,
((sc_kor+sc_eng+sc_math+sc_music+sc_art)/5)
from tbl_score
where ((sc_kor + sc_eng + sc_math + sc_music + sc_art)/5) >= 
(select (avg(sc_kor + sc_eng + sc_math + sc_music + sc_art)/5)from tbl_score)
and sc_num < '20020';

-- 성적 테이블에서 학번의 문자열을 자르기 수행하여
-- 반 명칭만 추출하기 
select substr(sc_num,1,4) as 반
from tbl_score
group by substr(sc_num,1,4)
order by 반;

-- 추출된 반 명칭이 '2006' 보다 작은 값을 갖는 반만 추출
-- having : 성질이 where와 매우 비슷하다.
-- 하는 일 : group by로 묶이거나, 통계함수로 생성된 값을 대상으로
-- where 연산을 수행하는 키워드
select substr(sc_num,1,4) as 반
from tbl_score
group by substr(sc_num,1,4)
having substr(sc_num,1,4) < '2006'
order by 반;

-- 각 반의 평균을 구하는 코드
select substr(sc_num,1,4) as 반, round(avg(sc_kor+sc_eng+sc_math)/3) 반평균
from tbl_score
group by substr(sc_num,1,4)
having round(avg(sc_kor+sc_eng+sc_math)/3) > 75
order by 반;

-- 각반의 평균 서브쿼리 사용
select substr(sc_num,1,4) as 반, round(avg(sc_kor+sc_eng+sc_math)/3) 반평균
from tbl_score
group by substr(sc_num,1,4)
having round(avg(sc_kor+sc_eng+sc_math)/3) >= (
 select round(avg(sc_kor+sc_eng+sc_math)/3) from tbl_score
)
order by 반;

-- 2000~2005까지는 A Group, 2006~2010까지는 B Group 일 때 
-- 반 명이 '2005' 이하, A 그룹의 반들 평균 구하기

-- 비 효율적인 코드
select substr(sc_num,1,4) as 반, round(avg(sc_kor+sc_eng+sc_math)/3) 반평균
from tbl_score
group by substr(sc_num,1,4)
having substr(sc_num,1,4) <= '2005'
order by 반;

-- Having과 where
-- 두 가지 모두 결과를 selection하는 조건문을 설정하는 방식이다
-- having은 그룹으로 묶이거나 통계함수로 연산된 결과를 조건으로 설정하는 방식이고,
-- where 아무런 연산이 수행되기 전에 원본 데이터를 조건으로 제한하는 방식이다,
-- 어쩔 수 없이 통계 결과를 제한 할 때는 having을 써야한다.
-- where절에 조건을 설정하여 데이터를 제한 한 후 연산을 수행 할 수 있다면
-- 항상 그 방법을 우선 조건으로 설정하자
-- having where 조건이 없으면 전체데이터를 상대로 상당한 연산을 수행 한 후 
-- 조건을 설정하므로 상대적으로 where조건을 설정하는 것보다 느리다.
select substr(sc_num,1,4) as 반, round(avg(sc_kor+sc_eng+sc_math)/3) 반평균
from tbl_score
where substr(sc_num,1,4) <= '2005'
group by substr(sc_num,1,4)
order by 반;

 










