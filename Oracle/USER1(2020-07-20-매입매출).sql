-- 여기는 user1 화면입니다..
-----------------------------------------------------------
-- 매입 매출 관리 프로젝트
-----------------------------------------------------------
-- 00 회사의 매입매출 관리 프로젝트를 수행하고 있다.
-- 이 회사는 기존에 엑셀을 이용하여 거래처별 매입매출 관리를 수행해 왔는데
-- 최근 App을 개발하여 데이터베이스화 하고 관리를 수행하려 한다.
-- 엑셀데이터를 받아서 DB로 보내기 위해 변환 작업을 수행하고 있다.

-- 엑셀 매입매출원장을 DB로 만들기 위해 매입, 매출을 분리하고, 날짜를 문자열화 했다.
-- 이 데이타를 DB에 저장하려고 봤더니, 이 데이터에 PK칼럼으로 지정할 만한 칼럼을 찾을 수가 없다.
-- 이러한 경우(Work DB인 경우)에는 실제 데이터와 별도로 임의의 PK칼럼을 생성해서
-- 관리 해 주는 것이 좋다.

----------------------------------------------------------
-- 매입매출 원장 Table
----------------------------------------------------------
create table tbl_iolist(

         io_seq	NUMBER	       PRIMARY KEY 	,
         io_date	VARCHAR2(10)	NOT NULL,	
        io_pname	nVARCHAR2(125)	NOT NULL,	
        io_dname	nVARCHAR2(125)	NOT NULL,	
        io_dceo	nVARCHAR2(125)	NOT NULL	,
         io_inout	 nVARCHAR2(2)	NOT NULL,	
        io_qty	 NUMBER	  DEFAULT 0,
         io_price	NUMBER	      DEFAULT 0, 
        io_amt	NUMBER	      DEFAULT	0
);
-- 전체 데이터 개수
select count(*) from tbl_iolist;

-- 매입과 매출로 구분하여 개수 세기
select io_inout, count(*) from tbl_iolist
group by io_inout;

-- 매입 데이터만 보고 싶을 때
select * from tbl_iolist
where io_inout = '매입';

select * from tbl_iolist
where io_inout = '매출';

-- 거래 수량이 90개 이상인 데이터만 보고싶을 때
select * from tbl_iolist
where io_qty >= 90;

-- 데이터를 확인하다 봤더니 단가와 금액이 0인 데이터가 보인다.
select * from tbl_iolist
where io_price = 0 or io_amt = 0;

-- 투니스, 7+8칫솔, 레종블루
-- 이 3가지 데이터가 거래된 5, 10, 28 seq 데이터가 칼럼값이 0이다.
-- 이 데이터의 단가, 금액을 수저하기 위해 동일한 데이터가 있는지 확인작업
select * from tbl_iolist
where io_pname in ('투니스', '7+8칫솔', '레종블루');
-- 검색을 해 봤더니 이 3가지 상품의 거래 내열이 다른 것이 없다.
-- 다른 곳에서 찾아서 값을 입력해야 할 것이다.
-- 투니스 : 1000, 칫솔 : 2500, 레종블루 : 4500 으로 변경하자

-- 투니스 거래 내용의 단가, 금액을 변경할텐데
-- where io_pname = '투니스' 와 같이 지정하면
-- 혹시 다른 매입, 매출 데이터가 있을 경우 막대한 문제를 일으킬 수 있다.
-- 반드시 PK 칼럼값을 조회하고 PK칼럼으로 where절을 사용하자.
update tbl_iolist
set io_price = 1000, -- 단가
    io_amt = io_qty * 1000  -- 금액(수랭 + 단가)
where io_seq = 5;

-- 7 + 8 칫솔
update tbl_iolist
set io_price = 2500, -- 단가
    io_amt = io_qty * 2500  -- 금액(수랭 + 단가)
where io_seq = 10;

-- 레종 블루
update tbl_iolist
set io_price = 4500, -- 단가
    io_amt = io_qty * 4500  -- 금액(수랭 + 단가)
where io_seq = 28;

select * from tbl_iolist
where io_qty = 0;

-- 원본 데이터
--      단가, 매입단가, 매출단가, 매입금액, 매출금액 으로 칼럼을 분리하여 사용해 왔다.
--      이러한 형태의 데이터는 각 칼럼에 NULL값이 존재하여, 다양한 연산을 수행 할 때 
--      문제를 일으킬 수 있다.

-- 변환된 데이터
--      단가, 금액 형식으로 칼럼을 통합작업을 수행했다.
--      칼럼으로 분리된 값들을 공통 칼럼을 선정하고 데이터를 통합하는 것을 보푠적으로 제3정규화가 되었다.

-- 변환된 데이터를 참조하여 
--      매입과 매출을 구분하여 보고 싶다 할 때,
--      (거래처, 수량, 매입단가, 매입금액, 매출단가, 매출듬액 형식으로 보고싶을 때)
--      이 데이터는 PIVOT 형태로 변환을 해야 한다.

select * from tbl_iolist
-- where (io_seq > 0 and io_seq < 20) or (io_seq >= 300 and io_seq <= 310)
order by io_dname ;

select io_dname, io_inout, io_qty, io_price, io_amt  from tbl_iolist
-- where (io_seq > 0 and io_seq < 20) or (io_seq >= 300 and io_seq <= 310)
order by io_dname ;

-- PIVOT으로 데이터 살펴보기
-- 매입 매출 단가가 단가(io_price)칼럼에 같이 저장되어있다.
-- 이 값은 io_inout 칼럼의 값을 모르면 매입인지 매출인지 구별이 어렵다.
-- 따라서  매번 io_inout 칼럼의 값을 표시해야만 매입인지 매출인지 구별이 된다.
-- 그러한 불편을 막기 위해 io_inout칼럼의 값을 조건으로 하는 decode 함수를 사용하여
-- 단가 부분을 매입단가, 매출단가로 분리하여 보여주도록 query를 작성하였다.

-- 이제 io_inout 값을 몰라도 현재 데이터가 매입데이터인지, 매출데이터인지 알기 쉽게 되었다.
select io_dname, io_qty,

        -- 매입단가(보기위한 가상칼럼) 칼럼의 데이터를 보여준데
        -- 만약 io_inout 칼럼의 값이 '매입'이면, io_price칼럼의 값을 표시하고
        -- 그렇지 않으면 0을 표시하라
        decode(io_inout, '매입', io_price,0) as 매입단가,
        decode(io_inout, '매입', io_amt,0) as 매입합계,
        decode(io_inout,'매출',io_price,0) as 매출단가,
        decode(io_inout,'매출',io_amt  ,0) as 매출합계

from tbl_iolist
where (io_seq > 0 and io_seq <= 10) or (io_seq >= 300 and io_seq <= 310)
order by io_dname ;

-- 거래처별로 매입과 매출을 구분하여 볼 수 있는 쿼리를 완성했다.
-- 거래처 별로 매입과 매출의 합계를 계산해 보고 싶다.
-- 이 데이터(일년간 거래내역)에서 거래별로 총 매입금액, 총 매출금액을 계산 해 보고 싶다.

-- 1. 거래처 별로 거래내역이 여러번 반복이루어 졌으므로 거래처명이 여러번 나타날 것이다.
-- 이 데이터를 거래 별로 묶어주어야 한다,
-- group by io_name
-- 2. 전체 매출금액과 매입금액을 표시하는 가상칼럼(매출금액, 매입금액을 계산한) 을 통계함수로 묶어준다.
select io_dname,

        SUM(DECODE(io_inout,'매입',io_amt,0)) AS 매입합계,
        SUM(DECODE(io_inout,'매출',io_amt,0)) AS 매출합계

FROM tbl_iolist
-- WHERE (io_seq > 0 AND io_seq <= 10) OR (io_seq >= 300 AND io_seq <= 310)
GROUP BY io_dname
ORDER BY io_dname ;

-- 이제 거래처별로 매입합계와 매출합계를 보았으니
-- 각 거래처별로 얼마만큼의 이익을 주었는지 살펴 보고 싶어진다.
-- 이익금 : 매출합계 - 매입합계 로 연산을 하면 된다.
SELECT io_dname, 

        SUM(DECODE(io_inout,'매입',io_amt,0)) AS 매입합계,
        SUM(DECODE(io_inout,'매출',io_amt,0)) AS 매출합계,
        SUM(DECODE(io_inout,'매출',io_amt,0)) - SUM(DECODE(io_inout,'매입',io_amt,0)) AS 이익금

FROM tbl_iolist
-- WHERE (io_seq > 0 AND io_seq <= 10) OR (io_seq >= 300 AND io_seq <= 310)
GROUP BY io_dname
ORDER BY io_dname ;

-- 00 회사에서 2019년 1년동안 총 매입, 총매출, 총 이익이 얼마나 발생했는지 알고싶다
SELECT SUM(DECODE(io_inout,'매입',io_amt,0)) AS 매입합계,
        SUM(DECODE(io_inout,'매출',io_amt,0)) AS 매출합계,
        SUM(DECODE(io_inout,'매출',io_amt,0)) - SUM(DECODE(io_inout,'매입',io_amt,0)) AS 이익금

FROM tbl_iolist
-- WHERE (io_seq > 0 AND io_seq <= 10) OR (io_seq >= 300 AND io_seq <= 310)
ORDER BY io_dname ;