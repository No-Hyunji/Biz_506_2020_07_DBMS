-- 여기는 user1 화면
create table tbl_address(
     ad_seq	 CHAR(5)	PRIMARY KEY	,
     ad_name	 nVARCHAR2(20)	NOT NULL,	
     ad_tel	 VARCHAR2(20)		,
     ad_addr	 nVARCHAR2(125)		
);

create table tbl_hobby(
     ad_seq	 CHAR(5)	NOT NULL,
     ho_name	 nVARCHAR2(20)	 NOT NULL
);
