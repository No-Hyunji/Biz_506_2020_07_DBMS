-- 여기는 user2 화면입니다.


--주문번호,             고객번호,                        상품코드,상품명, 판매가격,수량,합계
-- O00001		C0032	003		C0026	남종숙	010-2767-0420	P00069,P00026,P00083	P00069	P00026	P00083	
select * from tbl_주문서원장;

create table tbl_order(

        O_SEQ	NUMBER	PRIMARY KEY	,
        O_NUM	CHAR(6)	NOT NULL	,
        O_DATE CHAR(10) NOT NULL ,
        O_CNUM	CHAR(6)	NOT NULL	,
        O_PCODE	CHAR(6)	NOT NULL	,
        O_PNAME	 nVARCHAR2(125)		,
        O_PRICE	NUMBER		,
        O_QTY	NUMBER		,
        O_TOTAL	NUMBER		
);

-- tbl_order Table을 만들면서 여기에 추가될 데이터들 중에 1개의 칼럼으로는 PK를 만들 수 없어서
-- 임의의 일련번호 칼럼을 하나 추가하고 이 칼럼을 PK선언했다.
-- 이 상황이 되면 데이터를 추가할 때 일일히 Q_SEQ 칼럼에 저장된 데이터들을 살펴보고
-- 등록되지 않은 숫자를 만든 다음 그 값으로 SEQ값을 정하고 INSERT를 수행해야 한다.
-- 이런 방식은 코드를 매우 불편하게 만드는 결과를 낳게된다.

create sequence seq_order
start with 1 increment by 1;

-- 표준 SQL에서 간단한 계산을 할 때 
-- SELECT 3+4 ; 라고 코딩을 하면 3+4의 결과를 확인 할 수 있다.
-- 그런데 오라클에서는 SELECT 명령문에 FROM [table]절이 없으면 문법오류가 난다.
-- 이러한 코드가 필요할 때 시스템에 이미 준비되어 있는 DUAL 이라는 DUMMY 테이블을 사용해서 코딩을 한다.
select 3+4 from dual;

-- seq_order 객체의 nextval 이라는 모듈(함수역할)을 호출하여
-- 변화되는 일련번호를 보여달라 라는코드
select seq_order.nextval from dual;

-- 이 seq_order의 nextval 모듈을 사용하여 insert를 수행할 때 일련번호를 자동으로 부여할 수 있다.


--주문번호, 고객번호, 상품코드
-- 000001   C0032       P00001
-- 000002   C0032       P00002
-- 000003   C0032       P00003
insert into tbl_order(o_seq, o_date, o_num, o_cnum, o_pcode) values (seq_order.nextval,'2020-07-22','000001','C0032','P00001');
insert into tbl_order(o_seq, o_date, o_num, o_cnum, o_pcode) values (seq_order.nextval,'2020-07-22','000001','C0032','P00002');
insert into tbl_order(o_seq, o_date, o_num, o_cnum, o_pcode) values (seq_order.nextval,'2020-07-22','000001','C0032','P00003');

select o_num, o_cnum, o_pcode from tbl_order;

-- 지금 tbl_order 테이블에 위와 같은 데이터가 있을 때
-- 000001 C000031   P00001 이러한 데이터를 추가한다면 아무런 제약없이 값이 추가가 되버릴 것이다.

-- 주문번호, 고객번호, 상품코드 이 3개의 칼럼 묶음의 값이 중복되면 insert가 되지 않도록 제약조건을 설정해야 한다.
-- UNIQUE : 칼럼에 값이 중복되어서 INSERT가 되는 것을 방지하는 제약조건
-- 주문테이블에 UNIQUE 제약조건을 추가하자
alter table tbl_order 
        add constraint uq_order     
        unique (o_num, o_cnum, o_pcode) ; 
        
-- unique를 추가 하는데 이미 unique 조건에 위배되는 값이 있으면 제약조건이 추가되지 않는다
-- duplicate keys found : PK, UNIQUE로 설정된 칼럼에 값을 추가하거나, 
-- 이미 중복된 값이 있는데 PK, unique를 설정하려 할 때 발생되는 오류
-- unique 제약 조건을 추가하기 위해 마지막에 추가된 데이터를 제거하려고 다음과 같은 SQL을 실행한다.
-- 이 SQL을 실행하면, 삭제되어서는 안되는 중요한 주문정보 1건이 같이 삭제 되어 버릴것이다.
-- 이 Table의 데이터는 무결성을 잃게 된다. => 삭제이상
delete from tbl_order
    where o_num = '000001' and    -- 모든 데이터 사라짐
    o_cnum = 'C0032' and o_pcode = 'P00001';
    
    -- 다행히 일련번호 칼럼이 안만들어져있기 때문에 PK를 기준으로 값을 삭제할 수 있다.
    select * from tbl_order;
    
delete from tbl_order
where O_seq = 9;

alter table tbl_order
add constraint uq_order
unique (o_num, o_cnum, o_pcode);

-- 후보키중에 단일칼럼으로 PK를 설정할 수 없는 상황이 발생을 하면
-- 복수의 칼럼으로 PK를 설정하는데
-- update, delete수행 할 때 where칼럼1 = 값 and 칼럼2 = 2 and 칼럼3 = 값....과 같은 조건을 부여해야 한다,
-- 이것은 데이터 무결성을 유지하는데 매우 좋지 않은 환경이다
-- 이럴 때 데이터와 상관없는 SEQ칼럼을 만들어 PK로 설정하자









