-- 여기는 user1 화면입니다.

-- 빛나리 쇼핑몰 기본정보 테이블
-- 상품정보 테이블
create table tbl_product(
    P_CODE	CHAR(6)	PRIMARY KEY	,
    P_NAME	nVARCHAR2(30)	NOT NULL	,
    P_DCODE	CHAR(4)		,
    P_STD	nVARCHAR2(20),		
    P_IPRICE	NUMBER	,	
    P_OPRICE	NUMBER	,	
    P_IMAGE	nVARCHAR2(125)		  
);

-- 거래처 정보 테이블
create table tbl_dept(
    P_CODE	CHAR(4)	PRIMARY KEY	,
    D_NAME	nVARCHAR2(50)	NOT NULL	,
    D_DEO	NVARCHAR2(30)	NOT NULL	,
    D_TEL	VARCHAR(20)		,
    D_ADDRESS	nVARCHAR2(255),		
    D_MANAGER	nVARCHAR2(50),		
    D_MN_TEL	VARCHAR(20)		
);