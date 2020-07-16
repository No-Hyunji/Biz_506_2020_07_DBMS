-- 여기는 grade 화면

-- DEFAUT
-- 해당하는 칼럼에 데이터를 지정하지 않고 INSERT 수행하면
-- DEFAULT로 설정된 값을 지정한 것으로 이해하고 INSERT를 수행하라
create table tbl_score(
        sc_num	CHAR(5)	PRIMARY KEY	,
        sc_kor	NUMBER(3)	DEFAULT 0	,
        sc_eng	NUMBER(3)	DEFAULT 0	,
        sc_math	NUMBER(3)	DEFAULT 0	,
        sc_music	NUMBER(3)	DEFAULT 0,	
        sc_art	NUMBER(3)	DEFAULT 0	
);

DROp table tbl_score;

insert into tbl_score (sc_num) values ('20001');
select * from tbl_score;

select * from tbl_score;
select count(*) from tbl_score;

--------------------------------------------------------------------------------
---------------------성적정보 table을 활용한 select-----------------------------                 
--------------------------------------------------------------------------------

-- 학생별 성적의 총점과 평균계산하여 리스트로 확인하기
-- AS(Alias) :  Table의 칼럼명, 연산수식 등에 별명을 부여하여 사용하는 방법
select sc_num, sc_kor, sc_eng, sc_math, sc_music, sc_art,
    (sc_kor+ sc_eng+ sc_math+ sc_music+ sc_art) as 총점,
    (sc_kor+ sc_eng+ sc_math+ sc_music+ sc_art)/5 as 총점
from tbl_score;

-- 각 과목별 총점을 계산하기 = 집계, 통계를 수행한다.
select sum(sc_kor) as 국어총점,
       sum(sc_eng) as 영어총점,
       sum(sc_math) as 수학총점,
       sum(sc_music) as 음악총점,
       sum(sc_art) as 미술총점
from tbl_score;

select avg(sc_kor) as 국어평균,
       avg(sc_eng) as 영어평균,
       avg(sc_math) as 수학평균,
       avg(sc_music) as 음악평균,
       avg(sc_art) as 미술평균
from tbl_score;

-- selection을 적용하여 구현
-- 학번이 20001부터 20010까지 학생의 리스트만 보고싶을 때
select * from tbl_score
where sc_num between '20001' and '20010';

-- 학번이 20001부터 20010인 학생들만 추출하여 과목별 총점을 계산하라.
select 
       sum(sc_kor) as 국어총점,
       sum(sc_eng) as 영어총점,
       sum(sc_math) as 수학총점,
       sum(sc_music) as 음악총점,
       sum(sc_art) as 미술총점
from tbl_score
where sc_num between '20001' and '20010';

--------------------------------------------------
select sc_num as 학번,
       (sc_kor) as 국어,
       (sc_eng) as 영어,
       (sc_math) as 수학,
       (sc_music) as 음악,
       (sc_art) as 미술
from tbl_score
where sc_num between '20001' and '20010'
-- sum() 함수를 이용하여 각 과목별 총점을 계산하면서
-- 의미없는 (dumy)칼럼을 '==과목총점==' 이라는 값으로 만들었다.
-- 통계, 집계 함수를 사용할 때 통계, 집계함수로 묶이지 않은 칼럼은
-- 무조건 group by 절에 칼럼을 나열해 주어야 한다.
union all 
-- 학번이 20001~20010인 학생들만 추출하여 과목별 총점을 계산하라
select 
       '==과목총점==',
       sum(sc_kor) as 국어,
       sum(sc_eng) as 영어,
       sum(sc_math) as 수학,
       sum(sc_music) as 음악,
       sum(sc_art) as 미술
from tbl_score
where sc_num between '20001' and '20010'
group by '==과목총점=='

union all

select '==과목평균==',
       avg(sc_kor) as 국어,
       avg(sc_eng) as 영어,
       avg(sc_math) as 수학,
       avg(sc_music) as 음악,
       avg(sc_art) as 미술
from tbl_score
where sc_num between '20001' and '20010'
group by '==과목평균==';

