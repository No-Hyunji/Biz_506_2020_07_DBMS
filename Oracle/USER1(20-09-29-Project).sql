-- 여기는 user1 화면입니다 --
create table tbl_iolist(
    seq number primary key,
    io_date varchar2(10),
    io_time varchar2(10),
    io_input char(1),
    io_pname nvarchar2(30),
    ip_price number,
    io_quan number,
    io_total NUMBER
);