-- SCORE 화면 

-- 2.
create table tbl_score(
    학번 CHAR(10),
    학과 CHAR(5),
    국어 number(5),
    영어 number(5),
    수학 number(5)
);

--3.
insert into tbl_score(학번,학과,국어,영어,수학)values('20001','001','64','79','54');
insert into tbl_score(학번,학과,국어,영어,수학)values('20002','003','70','99','54');
insert into tbl_score(학번,학과,국어,영어,수학)values('20003','002','56','52','55');
insert into tbl_score(학번,학과,국어,영어,수학)values('20004','001','67','55','55');
insert into tbl_score(학번,학과,국어,영어,수학)values('20005','003','75','74','59');
insert into tbl_score(학번,학과,국어,영어,수학)values('20006','004','52','78','74');
insert into tbl_score(학번,학과,국어,영어,수학)values('20007','005','85','92','36');
insert into tbl_score(학번,학과,국어,영어,수학)values('20008','002','62','62','41');
insert into tbl_score(학번,학과,국어,영어,수학)values('20009','003','81','86','85');
insert into tbl_score(학번,학과,국어,영어,수학)values('20010','004','93','79','13');
commit;
-- 4.
select * from tbl_score;
select 학번, 학과, 국어, 영어, 수학,
        (국어 + 영어 + 수학) AS 총점,
        (국어 + 영어 + 수학)/3 AS 평균
from tbl_score;






