-- 1번 가.
create tablespace scoreTS
datafile 'scoreTS.dbf'
size 1m autoextend on next 1k;
-- 1번 나.
create user score
identified by score
default tablespace scoreTS;
grant dba to score;
