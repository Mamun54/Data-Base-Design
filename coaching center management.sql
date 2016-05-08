drop table student;
drop table teacher;
drop table batch;
drop table co_ordinator;


create table co_ordinator(
   c_id number(7),
   c_name varchar(11) not null,
   c_phone number(11),
   join_date varchar(10),
   salary number(13),
   p_limit varchar(15),
   primary key(c_id)
);


create table batch(
   b_no number(7),
   batch_name varchar(20) not null,
   category varchar(10),
   payments number(12),
   time decimal(5,2),
   c_id number(7),
   primary key(b_no),
   foreign key(c_id) references co_ordinator(c_id) on delete cascade
);


create table teacher(
   ts_id number(7),
   ts_name varchar(12) not null,
   email varchar(15),
   mobile number(11),
   t_salary number(20),
   b_no number(7),
   c_id number(7),
   primary key(ts_id),
   foreign key(b_no) references batch(b_no) on delete cascade,
   foreign key(c_id) references co_ordinator(c_id) on delete cascade
);

create table student(
   st_id number(7),
   st_name varchar(12) not null,
   email varchar(20),
   mobile number(11),
   year varchar(10),
   b_no number(7),
   c_id number(7),
   primary key(st_id),
   foreign key(b_no) references batch(b_no) on delete cascade,
   foreign key(c_id) references co_ordinator(c_id) on delete cascade
);

describe co_ordinator;
describe batch;
describe teacher;
describe student;

CREATE TRIGGER  PARMIT
BEFORE UPDATE OR INSERT ON ORDINATOR 
FOR EACH ROW 
BEGIN
IF :NEW.SALARY>5000 THEN
:NEW.P_LIMIT:='PARMANENT';

ELS :NEW.SALARY<=2 THEN
:NEW.P_LIMIT:='NOT PARMANENT';
END IF;
END PARMIT;
/



insert into co_ordinator values(1,'real',01778643811,'01/01/11',5000,NULL);
insert into co_ordinator values(2,'peal',01778643811,'01/01/13',6000,NULL);
insert into co_ordinator values(3,'seal',01778643811,'01/01/12',4500,NULL);
insert into co_ordinator values(4,'meal',01778643811,'01/01/11',3000,NULL);


insert into batch(b_no,batch_name,category,payments,time,c_id)values(01,'tukhord','Science',2500,5.30,1);
insert into batch(b_no,batch_name,category,payments,time,c_id)values(02,'probate','Science',1500,5.30,1);
insert into batch(b_no,batch_name,category,payments,time,c_id)values(03,'tukhord','Business',2000,5.30,2);
insert into batch(b_no,batch_name,category,payments,time,c_id)values(04,'tukhord','HUM',1000,5.30,3);




insert into teacher(ts_id,ts_name,email,mobile,t_salary,b_no,c_id) values (001,'Maruf','123@gmail.com',1234,10000,01,1);
insert into teacher(ts_id,ts_name,email,mobile,t_salary,b_no,c_id) values (002,'Mahmud','43@gmail.com',1234,12000,01,1);
insert into teacher(ts_id,ts_name,email,mobile,t_salary,b_no,c_id) values (003,'M.real','003@gmail.com',1234,15000,02,3);
insert into teacher(ts_id,ts_name,email,mobile,t_salary,b_no,c_id) values (004,'M.peal','123@gmail.com',1234,3500,01,1);



insert into student values(101,'rana','boo@gamil.com',0456,'1st',01,001);
insert into student values(102,'jaml','coo@gamil.com',2345,'2nd',02,004);
insert into student values(103,'lemon','aoo@gamil.com',1234,'1st',03,001);
insert into student values(104,'asad','doo@gamil.com',6543,'add',01,004);
select * from co_ordinator;

select * from  batch;

select * from teacher;

select * from  student;



select  batch_name from batch where b_no=01; 


select distinct category from batch;


select email  from teacher  order by ts_name;


select st_name from student where year='1st';


select c_name from co_ordinator order by join_date;

update batch set time=4.30,batch_name='Gudoli' where b_no=03; 

select max(salary) from co_ordinator;

select min(salary) from co_ordinator;


select count(*), count(distinct(category)), count(distinct (batch_name))from batch;

select ts_name from teacher Order by t_salary;


select s.st_name,s.mobile,b.batch_name,b.category
	FROM student s,batch b 
	WHERE s.b_no=b.b_no;

select student.st_name, student.mobile,student.year,batch.batch_name,batch.time,batch.payments
	FROM batch join student
	using (b_no);



set serveroutput on;
Declare
max_salary  co_ordinator.salary%type;
name   co_ordinator.c_name%type;  
Begin
select max(salary) into max_salary
from co_ordinator;
select c_name into name from co_ordinator where salary=5000; 

DBMS_OUTPUT.PUT_LINE('max salary : '||max_salary ||'  name :'||name);
End;
/

CREATE OR REPLACE PROCEDURE adding_test (
  id_t teacher.ts_id%TYPE,
  name_t teachers.ts_name%TYPE,
  t_email teachers.email%TYPE,
  t_mobile teachers.mobile%TYPE) IS
BEGIN
  INSERT INTO teachers (ts_id,ts_name,email,mobile)
  VALUES (id_t,name_t,t_email,t_mobile);
  COMMIT;
END adding_test;
/
SHOW ERRORS


BEGIN
    adding_test (006,'Tall','abc@gmail.com',00087);
 END;
/


select * from teacher;

commit;
