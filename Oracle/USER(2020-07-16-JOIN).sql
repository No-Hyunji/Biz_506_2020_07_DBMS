-- 여기는 user1 화면입니다.


-- 이상현상
-- 추가이상, 변경(수정)이상, 삭제이상
-- DBMS를 저장하는 저장된 데이터를 관리할 때(select 외의 CUD에서)
-- 문제가 발생하여 원 본 데이터가 무결성을 잃는 상황

-- 추가 이상 방지 : PK(primary key), UNUQUE, NOT NULL 이러한 제약조건을 설정하여
-- 잘못된 데이터가 insert되는 현상을 막기
-- PK로 설정된 칼럼은 정말 천재지변으로 문제가 발생하지 않는 한 저장된 값은 
-- 변경, 삭제를 금해야 한다.
-- 필요없는 데이터가 발생하는 경우 데이터를 삭제하는 대신
-- 특정한 칼럼을 하나 마련하고, 그 칼럼에 데이터의 사용유무를 등록하여
-- 관리하는 것이 실무상 원칙이다.


-- 변경 삭제 이상을 방지 : 특별한 경우가 아니면 두 개 이상의 레코드에 변화가 
-- 발생하지 않도록 코드나 관리를 설계해야한다.

-- 어떤 테이블에 변경된 가능성이 1이라도 존재하는 칼럼이 있는데
-- 여기에 동일한 값들이 중복되어서 저장되어 있을 때 
-- 이 칼럼의 값은 여러 레코드가 변경, 삭제 되는 일이 생길 수 있다.
-- 더불어 이러한 변경, 삭제를 수행하는 동안 데이터에 문제가 발생 할 수 있다.

-- 데이터 베이스의 정규화 :  설계차원에서 변경, 삭제 이상을 막기 위한 조치


--------------------------------------------------------------------------------
---------------------------------학과정보---------------------------------------
--------------------------------------------------------------------------------
drop table tbl_dept;
create table tbl_dept(
         d_code	 CHAR(4)	PRIMARY KEY,	
         d_name	 nVARCHAR2(20)	NOT NULL,	
         d_prof	 nVARCHAR2(20)		,
         d_assist	 nVARCHAR2(20)	,	
         d_tel 	 VARCHAR2(20)		,
         d_addr	 nVARCHAR2(125)		
);

select * from tbl_dept;

-- 학생 정보를 조회 하면서 학과 테이블과 연결하여 조회

-- 기본 select * 를 시작
-- from 절에 보고자 하는 주 table(master)를 작성
-- left join 절에 보조 정보가 담긴 table을 작성
-- on 두 테이블의 연관관계를 설정하는 키를 지정
-- select 에 필요한 칼럼들을 나열
select st_num, st_name, st_dept, d_name, tbl_dept.d_prof, d_tel, st_grade, st_tel, st_addr
from tbl_student
    left join tbl_dept
        on st_dept = d_code ;       
        
-- join이 된 후에 보조 테이브르이 칼럼을 where조건설정을 하여 selection을 수행 할 수 있다.        
select st_num, st_name, st_dept, d_name, tbl_dept.d_prof, d_tel, st_grade, st_tel, st_addr
from tbl_student
    left join tbl_dept
        on st_dept = d_code 
where d_name = '법학';                
--------------------------------------------------------------------------------
-- select table에 alias 설정하기------------------------------------------------
--------------------------------------------------------------------------------
-- 다수의 table을 join으로 설정하다 보면
-- 다른 table의 같은 칼럼이름이 존재할 수 있다.
-- 보통은 칼럼에 prefix를 붙여 그 구분을 명확하게 하지만
-- table이 많아지다 보면 같은 이름의 칼럼이 존재할 수 있다.
-- 이러한 상황에서 join을 수행하면, 칼럼을 제대로 인식하지 못하여
-- 오류가 발생하는 경우가 있다.(실제로 많다!!!)
-- 이런 경우 테이블에 alias를 설정하여 주면 오류를 막을 수 있다.
-- [table] AS [alias] 형식으로 작성
-- 단, 오라클에서는 AS 키워드를 사용하지 않는다.
select ST.st_num, ST.st_name, ST.st_dept,
    DT.d_name, DT.d_prof, DT.d_tel,
    ST.st_grade, ST.st_tel, ST.st_addr
from tbl_student ST
    left join tbl_dept DT
        on ST.st_dept = d_code 
where d_name = '법학';        

--------------------------------------------------------------------------------
--------------------------------view 생성---------------------------------------
--------------------------------------------------------------------------------

-- select 명령문을 사용하여 복잡한 Query를 작성하고
-- 작성된 query를 자주 사용하게 될 것으로 예상이 되면
-- 이 Query를 View에 생성해 보관 할 수 있다.

-- view는 실제 table과 똑같이 select 명령을 통해 데이터를 조회 할 수 있다,
-- 하지만 view는 실제 데이터를 가지고 있지 않다.
-- 원본 table로 부터 query 를 실행햐여 (보통 임시저장소에 저장해두고)
-- 결과를 보여주는 역할을 한다.
create view view_score
as
(select SC.sc_num, ST.st_name, ST.st_tel,
    ST.st_dept, DT.d_name, DT.d_prof, DT.d_Tel,
    SC.sc_kor,
    SC.sc_eng,
    SC.sc_math,
    SC.sc_music,
    sc.sc_art
from tbl_score SC
    left join tbl_student ST
        on ST.st_num = SC.sc_num
        
    left join tbl_dept DT
        on ST.st_dept = DT.d_code
);

select *
from view_score;

select * 
from view_score
where st_num between '20001' and '20010'
order by sc_num;

Select substr(sc_num,1,4) as NUM,
    sum(sc_kor),sum(sc_eng),sum(sc_math)
from view_score
group by substr(sc_num,1,4);

select *
from tbl_student;

drop view view_sim_student;

-- 중요 정보를 봐서는 안돼는 사용자가 있을 때
-- 보여줘도 문제 없는 칼럼만 projection한 쿼리를 만들고
-- 이 쿼리를 view로 생성해두면
-- 권한이 제한된 사용자는 꼭 필요한 정보만을 보게 되어
-- 보안, 개인정보 보호 등의 용도로 사용 할 수 있다.
create VIEW view_sim_student
as
(
select ST.st_num, ST.st_name, ST.st_dept, DT.d_name
from tbl_student ST
    left join tbl_dept DT
       on ST.st_dept = DT.d_code 
);

select * from view_sim_student
order by st_num;











