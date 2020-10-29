-- 관리자 화면 

-- TableSpace, User 생성
-- User 권한 생성

-- TABLESPACE는 실제 데이터를 저장할 파일을 지정하는 곳 testTS라는 이름으로 testTS.dbf라는 파일에 저장을 하겠다. 
-- 오라클에서 DB 작업을 할 떄 가장 먼저 수행해야 할 작업 (데이터를 저장할 공간을 생성하는것 제일 먼저 해야할것)
CREATE TABLESPACE testTS -- 사용할 Tablespace의 이름
DATAFILE 'testTS.dbf' -- 실제 데이터가 저장될 파일 이름
SIZE 1M  -- 데이터가 없더라도 공간을 1M Byte만큼 확보하라 (성능때문에 )
AUTOEXTEND on next 1K; -- 데이터를 저장하는 과정에서 공간이 부족하면, 1kbyte만큼 자동으로  증가하라  

-- 사용자 생성(등록 ) 공간먼저 생성한뒤 유저 연결..?
CREATE USER test1  -- 사용자의 ID
IDENTIFIED BY test1     -- 비밀번호
DEFAULT TABLESPACE testTS;  -- CRUD를 수행했을 때 데이터를 저장할 곳

-- 사용자에게 권한 부여하기
grant dba to test1; -- test1사용자에게 dba권한을 부여하겠다. 

