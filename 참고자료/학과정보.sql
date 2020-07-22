
use myDB;
-- 만약 tbl_dept가 있으면 삭제하고 다시 만들어라
drop table if exists tbl_dept;

-- 테이블이 없으면 만들어라
create table if not existstbl_dept(
 d_code Char(4) primary key,
 d_name VARCHAR(30) NOT NULL,
 d_prof VARCHAR(30)
 );
Insert into TBL_DEPT (D_CODE,D_NAME,D_PROF) values ('D001','관광학',null);
Insert into TBL_DEPT (D_CODE,D_NAME,D_PROF) values ('D002','국어국문',null);
Insert into TBL_DEPT (D_CODE,D_NAME,D_PROF) values ('D003','법학',null);
Insert into TBL_DEPT (D_CODE,D_NAME,D_PROF) values ('D004','전자공학',null);
Insert into TBL_DEPT (D_CODE,D_NAME,D_PROF) values ('D005','컴퓨터공학',null);
