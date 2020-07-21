-- 여기는 user1 화면입니다.

select * from tbl_student;
--------------------------------------------------------------------------------
-- SELECTION 연산---------------------------------------------------------------
-- 전체 데이터에서 필요한 record만 추출하기-------------------------------------
--------------------------------------------------------------------------------
-- pk 칼럼에 한 개의 조건을 부여하여 조회 하기
-- 반드시 한 개의 결과값(record)만 나타난다.
select * from tbl_student
where st_num = '20010';

-- (일반)칼럼에 1개의 조건을 부여하여 조회하기
-- (일반)칼럼에 조건을 부여하여 조회한 결과는 
-- 지금 1개의 record만 보일 지라도 이 결과는 리스트형으로 출력된다.
select * from tbl_student
where st_name = '남동예';

-- pk칼럼에 2개 이상의 조건을 부여하여 조회하기
-- 만약 결과가 1개의 record만 보일지라도 결과는 리스트형으로 출력된다(취급한다). 
select * from tbl_student
where st_num = '20010' or st_num = '20020' or st_num = '20030';

-- 1개의 칼럼에 다수의 or조건을 부여하여 selection을 할 때는
-- in 연산자를 사용 할 수 있다.
select * from tbl_student
where st_num in('20010','20020','20030');

-- 한 개의 칼럼 값을 범위로 제한하는 selection을 할 때
-- 부등호연산 숫자 칼럼에만 적용되는 것이 원칙
-- 문자열일 경우에도 저장된 데이터의 길이가 모두 같고
-- 패턴이 같으면 문자열도 부등호 연산이 가능하다
select * from tbl_student
where st_num >= '20010' and st_num <= '20030';

-- 범위를 지정 할 대 시작값과 종료값이 포함되는 연산을 수행 할 때는
-- between 연산자를 사용 할 수 있다.
select * from tbl_student
where st_num between '20010' and '20020';

--------------------------------------------------------------------------------
-- PROJECTION-------------------------------------------------------------------
-- table에 있는 칼럼 중에서 내가 보고자 하는 칼럼만 나타나도록 제한하는것-------
--------------------------------------------------------------------------------
select st_num, st_name, st_dept
from tbl_student;

-- projection
-- projection 연산
select * from tbl_score;

select sc_num, sc_kor, sc_eng, sc_math, sc_music, sc_art,
        ( sc_kor+ sc_eng+ sc_math+ sc_music+ sc_art) as 총점,
        -- round : 실수(float) 값을 반올림 하는 함수
        -- round(값) : 소수점 이하 반올림하고 정수로 표현
        -- round(값, 자릿수) : 자릿수+1에서 반올림하여 자릿수자리까지 소수점 표현 
        round(( sc_kor+ sc_eng+ sc_math+ sc_music+ sc_art)/5, 3)as 평균,
        
        -- 무조건 자르기(절사)
        -- trunc(값) : 소수점 이하 모두 버리기
        -- trunc(값, 자릿수) : 자릿수 +1 이하 모두 버리기
        trunc(( sc_kor+ sc_eng+ sc_math+ sc_music+ sc_art)/5 )as 평균1
from tbl_score;

select sum(sc_kor) as 국어총점,
       sum(sc_eng) as 영어총점,
       sum(sc_math) as 수학총점,
       sum(sc_music) as 음악총점,
       sum(sc_art) as 미술총점,
       sum( sc_kor+ sc_eng+ sc_math+ sc_music+ sc_art) as 총점,
       AVG(round(( sc_kor+ sc_eng+ sc_math+ sc_music+ sc_art)/5, 3))as 평균
from tbl_score;       

-- sc_kor 칼럼의 값을 기준으로 전체 리스트를 오름차순 정렬
select*
from tbl_score
where sc_num between '20001' and '20010'
order by sc_kor;

select sc_num, sc_kor, sc_eng, sc_math, sc_music, sc_art,
    ( sc_kor+ sc_eng+ sc_math+ sc_music+ sc_art) as 총점
from tbl_score
where sc_num between '20001' and '20010'
order by 총점;

-- 계산을 위한 '총점'칼럼을 projection에서 선언하고
-- '총점' 칼럼을 기준으로 오름차순 정렬
select sc_num, sc_kor, sc_eng, sc_math, sc_music, sc_art,
    ( sc_kor+ sc_eng+ sc_math+ sc_music+ sc_art) as 총점
from tbl_score
where sc_num between '20001' and '20010'
order by 총점;

-- DESCENDING : 내림차순 정렬
select sc_num, sc_kor, sc_eng, sc_math, sc_music, sc_art,
    ( sc_kor+ sc_eng+ sc_math+ sc_music+ sc_art) as 총점
from tbl_score
where sc_num between '20001' and '20010'
order by 총점 desc;

-- 학생의 이름의 오름차순으로 전체리스트를 정렬하여 보여달라
select *
from tbl_student
where st_num between '20001' and '20010'
order by st_name;

-- 2개 이상의 칼럼을 정렬수행
-- st_dept 칼럼으로 정렬을 수행하고
-- st_dept 칼럼 값이 같으면, 그 범위(그룹, 파티션)내에서 
-- st_name을 기준으로 내림차순 정렬하라
select *
from tbl_student
where st_num between '20001' and '20010'
order by st_dept, st_name desc;

-- st_dept 칼럼값은 같은 레코드끼리 묶고
-- 묶인 레코드의 개수를 세어라
-- 부분합 연산
select st_dept, count(st_dept)
from tbl_student
group by st_dept;

-- 그룹 count를 수행하고
-- st_dept칼럼을 기준으로 오름차순 정렬
select st_dept, count(st_dept)
from tbl_student
group by st_dept
order by st_dept;

-- substr : 오라클에서만 사용하는 문자열 함수
-- sc_num칼럼에 담긴 문자열을 1번째부터 4번째 글자까지 잘라서 보여라
select substr(sc_num, 1, 4)
from tbl_score;

select substr(sc_num, 1, 4)
from tbl_score
group by substr(sc_num, 1, 4);

-- 학번을 다음과 같이 구성
-- 20001 ~ 20100
-- 어떤 칼럼에 값을 정할 때 규칙을 만들고 해당 칼럼을 pk로 삼아서
-- 레코드의 유일함을 보증하는 용도로 사용하는 값들

-- (학과) 코드
-- 학과 D001 - D010
-- 규칙을 정해서 만들고 학과 레코드에 유일함을 보증하는 용도로 사용한다.

select substr(sc_num,1,4) as 반,
        sum(sc_kor) as 국어총점,
        sum(sc_eng) as 영어총점
            
from tbl_score 
where 1 = 1 or sc_num = '20001' -- where는 from 다음에 나타나야 한다.
group by substr(sc_num,1,4)
order by 반 -- order by는 select명령문의 절들 중에 가장 끝에 나타나야 한다.
