-- USER1 독서록 프로젝트
create table tbl_member(
    M_USERID	VARCHAR2(30)		PRIMARY KEY,
    M_PASSWORD	nVARCHAR2(255)	NOT NULL	,
    M_NAME	nVARCHAR2(30)		,
    M_TEL	VARCHAR2(30)		,
    M_ADDRESS	nVARCHAR2(125)	,	
    M_ROLL	VARCHAR2(20)		,
    -- enable칼럼에 문자열 0 또는 1 이외의 값은 저장하지 말라 
    -- check 제약사항 등록 
    ENABLE	CHAR(1)	DEFAULT '0' CONSTRAINT enable_veri check(enable = '0' or enable = '1'),
    AccountNonExpired	CHAR(1)	,	
    AccountNonLocked	CHAR(1)	,	
    CredentialsNonExpired	CHAR(1)		
);
drop table tbl_member;

create table tbl_authority(

    seq	NUMBER		PRIMARY KEY,
    M_USERID	VARCHAR2(30)	NOT NULL	,
    M_ROLE	VARCHAR2(30)	NOT NULL	

);
create SEQUENCE seq_authority
start with 1 increment by 1;