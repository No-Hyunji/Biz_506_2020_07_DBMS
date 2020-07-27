-- 여기는 user2의 화면입니다

create table tbl_성적(
    
    학번 char(5),
    과목명 NVARCHAR2(20),
    점수 number

);

select * from tbl_성적;

-- 표준 SQL을 이용한 PIVOT
-- 1. 어떤 칼럼을 기준칼럼으로 할 것인가 : 학번칼럼을 기준으로 삼는다.
-- 기준 칼럼에 대해서 GROUP BY를 설정
-- 2. 어떤 칼럼을 GROUP BY로 설정을 하게 되면 나머지 칼럼은
-- 통계함수로 감싸거나, 아니면 GROUP BY에 칼럼을 포함해주어야 한다.

-- 점수를 SUM 함수로 묶어주는 이유와 결과
-- 학번을 GROUP BY로 묶어서 여러개 저장된 학번을 1개만 보이도록 하기위해 
-- 계산되는 각 과목의 점수를 SUM()으로 묶어준다.
-- 현재 테이블 구조에서 학번+과목의 점수는 데이터에서 1개의 레코드만 존재한다.
-- 따라서 SUM()함수는 무언가 합산을 하는 용도가 아니라, 단순히 GROUP BY를 사용할 수 있도록 하는 용도일 뿐이다.
select 학번,
    SUM(case when 과목명 = '국어' then 점수 else 0 end) as 국어,
    SUM(case when 과목명 = '영어' then 점수 else 0 end) as 영어,    
    SUM(case when 과목명 = '수학' then 점수 else 0 end) as 수학
from tbl_성적
GROUP BY 학번 ;

-- 오라클의 DECODE() 함수를 이용해서 
SELECT 학번,
    SUM(DECODE(과목명,'국어',점수,0)) AS 국어,
    SUM(DECODE(과목명,'영어',점수,0)) AS 영어,
    SUM(DECODE(과목명,'수학',점수,0)) AS 수학
FROM tbl_성적
GROUP BY 학번;

-- 오라클 11g부터 지원하는 PIVOT기능을 사용하는 방법
-- PIVOT() : 특정한 칼럼을 기준으로 데이터를 PIVOT View 나타내는 내장 함수
-- PIVOT(SUM(칼럼값들) : PIVOT으로 나열할 데이터값이 들어있는 칼럼을 SUM()으로 묶어서 표시
-- FOR 칼럼(칼럼값들) : '칼럼'에 '칼럼값'으로 가로(COLUMN)방향나열하여 가상칼럼으로 만들기
SELECT 학번,국어,영어,수학
FROM tbl_성적
PIVOT (
    SUM(점수)
    FOR 과목명 IN('국어'as 국어,'영어'as 영어,'수학'as 수학)
) 성적;

CREATE TABLE tbl_학생정보 (
    학번 CHAR(5) PRIMARY KEY,
    학생이름	nVARCHAR2(30) NOT NULL,
    전화번호	VARCHAR2(20),
    주소	NVARCHAR2(125),
    학년 NUMBER,
    학과 CHAR(3)
);

SELECT * FROM tbl_학생정보;

-- 학번이라는 칼럼명을 사용했는데
-- 이 칼럼이 어떤 테이블에 있는 칼럼인지 모르겠다.
-- JOIN을 수행하여 다수의 Table이 Relation되었을 때
-- 다수의 table에 같은 이름의 칼럼이 있을 때 발생하는 오류
-- 영문으로 작성할때는 칼럼에 prefix를 붙여서 이런 오류를 막지만
-- 실제 테이블에서 여러테이블에 DOMAIN 설정(같은 정보를 담는 칼럼)을 만들 경우
-- prefix를 통일하는 경우도 많다
-- 이 때는 아래 오류를 매우 자주 접하게 된다.
-- ORA-00918: column ambiguously(애매하게) defined
-- 00918. 00000 -  "column ambiguously defined"

-- 이 오류를 방지하기 위해 2개 이상의 table을 JOIN할 때 는 TABLE에 Alias를 설정하고
-- AS.칼럼 형식으로 어떤 Table의 칼럼인지 명확히 지정을 해주는 것이 좋다.
-- JOIN, SUBQUERY를 만들 때 한 개의 테이블을 여러번 사용할 경우 반드시 Alias를 설정하고
-- 명확히 칼럼을 지정 해 주어야 한다.

SELECT SC.학번,ST.학생이름,ST.전화번호,
    SUM(DECODE(SC.과목명,'국어',SC.점수,0)) AS 국어,
    SUM(DECODE(SC.과목명,'영어',SC.점수,0)) AS 영어,
    SUM(DECODE(SC.과목명,'수학',SC.점수,0)) AS 수학
FROM tbl_성적 SC
    LEFT JOIN tbl_학생정보 ST
        ON ST.학번 = sc.학번
GROUP BY SC.학번,ST.학생이름,ST.전화번호;

CREATE view view_성적PIVOT
AS
(
    SELECT 학번,국어,영어,수학
    FROM tbl_성적 
        
PIVOT (
    SUM(SC.점수)
    FOR 과목명 IN('국어'as 국어,'영어'as 영어,'수학'as 수학)
    )
) ;

select * from view_성적PIVOT;

select sc.학번, st.학번이름,sc.국어, sc.영어 ,sc.수학
for view_성적PIVOT Sc
    Left join tbl_학생정보 st
        on st.학번 = sc.학번;
        
select sc.학번, st.학생이름,sc.국어 sc.영어 sc.수학
from(
select 학번,국어,영어,수학
from tbl_성적
pivot(
sum(점수)
for 과목명 in ('국어' as 국어,'영어'as 영어,'수학'as 수학)
)
) sc
    left join tbl_학생정보 ST
        on st.학번 = sc.학번
order by sc.학번;























