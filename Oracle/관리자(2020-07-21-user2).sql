-- 여기는 관리자 화면입니다.
-- 새로운 TableSpace와 사용자를 등록하기
-- TableSpace : user2Ts,
-- user : user2, password user2
-- C:\bizwork\workspace\oracle_data

create tablespace user2Ts
datafile 'C:/bizwork/workspace/oracle_data/user2.dbf'    -- 역슬래시를 슬래시로 바꾸기
size 1m autoextend on next 10k;                          -- [1]생성하기

create user user2 identified by user2
DEFAULT tablespace user2ts;             -- 유저를 만들면서 반드시 사용할 테이블스페이스를 설정해줘야한다. 안그러면 시스템 테이블스페이스에 저장된다
                                        --[2]

grant dba to user2;  --[3]