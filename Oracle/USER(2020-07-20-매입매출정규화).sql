-- 여기는 user1 화면입니다.
-- tbl_iolist에는 상품명, 거래처명, 거래처CEO 칼럼의 데이터가 일반 문자열 형태로 저장되어 있다.
-- 이 데이터는 같은 칼럼에 중복된 데이터가 있어서 데이터관리 측면에서 상당히 불편한 상황이다.
-- 만약 어떤 상품의 상품명이 변경이 필요 한 경우
-- 상품명을 update하여야 하는데, 2개 이상의 레코드를 대상으로 update과정이 필요하다.
-- 두 개 이상의 레코드를 update를 수행하는 것은 데이터의 무결성을 해칠 수 있는 수행이 된다.
-- 이러한 문제를 방지하기 위해 다음과 같은 정규화를 실행한다.

-- 상품명 정보를 별도의 테이블로 분리하고, 상품정보에 상품코드를 부여한 후
-- tbl_iolist와 연동하는 방식으로 정규화를 실행한다.

-- tbl_iolist로 부터 상품명 리스트를 추출하자
-- 상품명 칼럼을 group by하여 중복되지 않은 상품명 리스트만 추출한다.
select io_pname,
    min(decode(io_inout, '매입', io_price, 0)) as 매입단가,
    max(decode(io_inout, '매출', io_price, 0)) as 매출단가
from tbl_iolist
group by io_pname
order by io_pname;
---------------------------------------------
-- 상품 정보 TABLE
---------------------------------------------
create table tbl_product(               -- 생성시키기
p_code	CHAR(5)		PRIMARY KEY,	
p_name	nVARCHAR2(125)		NOT NULL,	
p_iprice	NUMBER			,
p_oprice	NUMBER			,
p_vat	CHAR(5)		DEFAULT'1'
);

select * from tbl_product;           -- 임포트 잘 다됐나 확인, 전체불러오기

/*
매입매출 테이블에서 상품정보(이름, 단가) 부분을 추출하여 상품정보 테이블을 생성했다.

매입매출 테이블에서 상품이름 칼럼을 제거하고
상품정보 테이블과 join할 수 있도록 설정해야 한다.

현재 매입매출테이블에는 상품이름이 들어있고
상품정보 테이블에는 상품코드, 상품이름, 매입 매출단가 가 들어 있다.

매입매출 테이블의 상품이름에 해당하는 상품코드를 매입매출 테이블에 업데이트 하고
매입매출 테이블의 상품이름 칼럼을 제거한 후 join을 수행하여 데이터를 확인해야 한다.
*/

-- 1. 매입매출 테이블의 상품명과 상품정보 테이블의 상품명을 join해서
-- 매입매출 테이블의 상품명이 상품정보에 모두 있는지 확인 하기
select IO.io_pname, P.p_name 
from tbl_iolist IO
    left join tbl_product P
    on IO.io_pname = P.p_name;    -- 실행시켜서 P인 항목의 null이 있는지 확인하기 

-- 위 코드를 실행하여 P.p_name 항목에 (null)값이 있다면 상품정보 테이블이 잘못 만들어진것이다.
-- 상품정보 테이블을 삭제하고 과정을 다시 수행해야 한다
    
-- 쿼리 결과중에 P.p_name 항목의 값이 null인 리스트만 보여라
-- 쿼리 결과가 정상적이라면 리스트는 한 개도 없어야 한다. -- 깨끗^^
select IO.io_pname, P.p_name 
from tbl_iolist IO
    left join tbl_product P
    on IO.io_pname = P.p_name
where p.p_name is null;         --해당 칼럼의 값이 NULL이 아니냐??? : IS NOT NULL         

-- 이제 상품데이터가 이상 없음을 알았으니 매입매출 테이블에 상품코드를 저장 할 "칼럼을 추가" 테이블을 새로 만드는게 아님.
-- ALTER TABLE : 테이블의 구조(칼럼 추가 삭제) 구조 변경, 칼럼의 타입변경 등을 수행 하는 명령
-- 상품 테이블의 p_code 칼럼과 같은 type으로 io_pcode 칼럼을 추가
alter table tbl_iolist add io_pcode char(5);               -- 누름 io pcode라는 칼럼이 하나 들어갔을것, 상품코드 널 나와버림 널 나오면 안될것같은데??

 
 
alter table tbl_iolist drop column io_pcode ;-- 칼럼이 삭제가 됨.

-- alter tble을 할 때
-- 이미 많은 데이터가 insert되어 있는 상태에서 칼럼을 추가하면
-- 추가하는 칼럼은 당연히 초기값이 null이 된다.
-- 이 방식으로  칼럼을 추가하면 절대 칼럼추가가 안됀다
-- 이 방식은 아직 데이터가 1개도 없을 대는 가능
alter table tbl_iolist add(io_pocode char(5) not null);

-- not null 조건을 추가하기
-- 1. p_code 칼럼을 추가, 기본적으로 문자열이므로 빈칸을 추가(숫자 칼럼이면 0을 추가')
alter table tbl_iolist add (io_pcode char(5) default ' '); 

-- 2. p_code 칼럼의 제약조건을 not null설정
alter table tbl_iolist modify (io_pcode constraint io_pcode not null);

-- 칼럼 추가하기
alter table tbl_iolist add (io_pcode char(5) default ' ');
-- 칼럼 삭제하기
alter table tbl_iolist drop column io_pcode;
-- 칼럼의 not null 조건 추가하기
alter table tbl_iolist modify (io_pcode constraint io_pcode not null);

-- 칼럼의 타입 변경하기
alter table tbl_iolist modify (io_pcode char(10));
-- 칼럼의 type변경하기 주의사항
-- 칼럼의 타입을 변경 할 때
-- 문자열 <==> 숫자 처럼 타입이 완전히 다른 경우는 오류가 발생하거나 데이터를 모두 잃을 수 있다.
-- CHAR <==> nVARCHAR2
-- 문자열의 길이가 같으면 데이터 변환이 이루어진다.
-- char <==> nVARCHAR2 는 저장된 문자열이 유니코드(한글 등)이면 매우 주의를 해야한다
-- 보통 길이가 다르면 오류가 나지만, 정상적으로 명령이 수행 되더라도
-- 데이터가 잘리거나. 문자열이 알 수 없는 값으로 변형되는 경우가 발생 할 수 있다.

-- 칼럼의 이름변경하기
alter table tbl_iolist rename column io_pcode to io_pcode1; -- io.pcode이름을 io_pcode1로 변경

-- 상품정보에서 매입매출장 각 레코드의 상품명과 일치하는 상품코드를 찾아서
-- 매입매출장의 상품코드(io_pcode)칼럼에 저장해주기

/*select * 
from tbl_iolist IO
where io_pname = (
select p_code
from tbl_product P
where p_name = IO.io_pname
);*/
    
-- 업데이트 명령이 서브쿼리를 만나면
-- 1. 서브쿼리에서 iolist에 io_pname  칼럼의 값을 요구하고 있다.
-- 2. tbl_iolist의 레코드를 전체 셀렉트를 수행한다
-- 3. 셀렉트된 리스트에서 io_pname칼럼 값을 서브쿼리로 전달한다
-- 4. 이때 서브쿼리는  전달받은 io_pname 값을  tbl_product테이블에서 조회를 한다.
-- 이 때 서브쿼리는 반드시 1개의 칼럼, 1개의 VO만 추출해야 한다,
-- 5. 그 결과를 현재 iolist의 레코드의 io_pcode칼럼에 업데이트를 수행한다.

update tbl_iolist IO
set io_pcode = 
( 
select p_code
from tbl_product P
where p_name = IO.io_pname
);

select io_pcode from tbl_iolist;

-- iolist에 pcode가 정상적으로 업데이트 되었는지 검증
select io_pcode, io_pname, p.p_name
from tbl_iolist IO
    left join tbl_product P
        on IO.io_pcode = p.p_code
where p.p_name is null;
    
------------------------------------------------
-- 거래처 데이터 정규화
------------------------------------------------
-- 거래처명, CEO 칼럼이 테이블에 들어있다.
-- 이 칼럼을 추출하여 거래처 정보를 생성
-- 추출된 데이터 중 거래처명은 같고 ceo가 다르면, 다른회사로 보고
-- 거래처명과 ceo가 같으면 같은 회사로 보고 데이터를 만듦
select io_dname, io_dceo
from tbl_iolist
group by io_dname, io_dceo
order by io_dname;

create table tbl_buyer(
b_code	CHAR(4)	PRIMARY KEY,
b_name	nVARCHAR2(125)	NOT NULL,
b_ceo	nVARCHAR2(50)	NOT NULL,
b_tel	VARCHAR2(20)	
); 

-- b_tel 칼럼의 값이 중복된(두 개 이상)인 레코드가 있냐.
select * from tbl_buyer;
select b_tel, count(*) from tbl_buyer
group by b_tel
having count(*) > 1;

-- iolist에 저장된 dname, dceo 칼럼으로 거래처 정보에서 데이터를 조회하고
-- iolist에 거래처코드칼럼으로 업데이트

alter table tbl_iolist add (io_bcode CHAR(4) default ' ');
alter table tbl_iolist modify (io_bcode constraint io_bcode not null); 

desc tbl_iolist;

-- iolist와 buyer 테이블간의 거래처명, 대표자명 칼럼으로 join을 수행하여 데이터 검증
-- 데이터가 한 개 도 출력되지 않아야 한다.
select *
from tbl_iolist IO
    left join tbl_buyer B
        on IO.io_dname = B.b_name
where B.b_name is null;
--------------------------------------------------------------------------------
-- iolist에 거래처 코드 update
-- 지금 생성 한 tbl_buyer테이블에는 거래처명은 같고 대표자가 다른 데이터가 있다.
-- 이 데이터에서 거래처명으로 조회를 하면 출력되는 레코드(row)값이 2개 이상인 경우가 발생한다.
-- 따라서 이 쿼리를 실행하면, ORA-01427: single-row subquery returns more than one row 오류가 발생한다
-- 이 쿼리는 거래처명과 CEO 값을 동시에 제한하여 1개의 row값만 subquery에서 만들어 지도록 해야 한다.
update tbl_iolist IO
set io_bcode = 
(
select b_code
from tbl_buyer b
where b.b_name = io.io_dname and b.b_ceo = io.io_dceo
);

select io_bcode, io_dname, b_code, b_name
from tbl_iolist IO
    left join tbl_buyer B
        on io.io_bcode = B.b_code
where b_code is null or b_name is null;

-- 데이터를 tbl_product, tbl_buyer테이블로 분리 했으니
-- table_iolist에서 io_pname, io_dname, io_dceo 칼럼은 필요가 없었으므로 제거한다.
alter table tbl_iolist drop column io_pname;
alter table tbl_iolist drop column io_dname;
alter table tbl_iolist drop column io_dceo;

select * from tbl_iolist;

create view view_iolist
as
(
select io_seq, io_date, io_bcode, b_name, b_ceo, b_tel,
io_pcode, p_name, p_iprice, p_oprice,
DECODE(io_inout,'매입',io_price,0) as 매입단가,
DECODE(io_inout,'매입',io_amt,0) as 매입금액,
DECODE(io_inout,'매출',io_price,0) as 매출단가,
DECODE(io_inout,'매출',io_amt,0) as 매출금액

from tbl_iolist IO
    left join tbl_product P
        on io.io_pcode = P.p_code
    left join tbl_buyer B
        on io.io_bcode = b.b_code
        );
        
select * from view_iolist
where io_date between '2019-01-01' and '2019-01-31'
order by io_date;



















    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    