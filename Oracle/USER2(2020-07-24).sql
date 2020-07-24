delete tbl_order;
commit;
select * from tbl_order;

INSERT INTO tbl_order(o_seq, o_date,o_num, o_cnum, o_pcode) 
        VALUES (seq_order.NEXTVAL,'2020-07-22','O00001','C0032','P00001') ;
INSERT INTO tbl_order(o_seq, o_date,o_num, o_cnum, o_pcode) 
        VALUES (seq_order.NEXTVAL,'2020-07-22','O00001','C0032','P00002') ;
INSERT INTO tbl_order(o_seq, o_date,o_num, o_cnum, o_pcode) 
        VALUES (seq_order.NEXTVAL,'2020-07-22','O00001','C0032','P00003') ;
INSERT INTO tbl_order(o_seq, o_date,o_num, o_cnum, o_pcode) 
        VALUES (seq_order.NEXTVAL,'2020-07-22','O00001','C0032','P00001') ;        
INSERT INTO tbl_order(o_seq, o_date,o_num, o_cnum, o_pcode) 
        VALUES (seq_order.NEXTVAL,'2020-07-22','O00022','C0055','P00067') ;
        