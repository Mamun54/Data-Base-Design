drop table book;
drop table students;
drop table teachers;
drop table ordinator;

create table cordinator(
   a_id number(7),
   a_name varchar(15) not null,
   a_phone number(11),
   join_date varchar(15),
   primary key(a_id)
);

create table students(
   s_id number(10),
   s_name varchar(12) not null,
   a_id number(7),
   hall varchar(10) not null,
   advisor varchar(10) not null,
   email varchar(20),
   mobile integer,
   year varchar(20),
   primary key(s_id),
   foreign key(a_id) references ordinator(a_id) on delete cascade
);

create table teachers(
   t_id number(10),
   t_name varchar(12) not null,
   email varchar(15),
   mobile integer,
   a_id number(7),
   primary key(t_id),
   foreign key(a_id) references ordinator(a_id) on delete cascade
);

create table book(
   books_id number(7),
   book_name varchar(20) not null,
   writter_name varchar(13) not null,
   category varchar(10),
   price decimal(5,2),
   time_limit number(5),
   comment_l varchar(10),
   s_id number(10),
   t_id number(10),
   a_id number(7),
   primary key(books_id),
   foreign key(s_id) references students(s_id) on delete cascade,
   foreign key(t_id) references teachers(t_id) on delete cascade,
   foreign key(a_id) references ordinator(a_id) on delete cascade
);

describe ordinator;
describe students;
describe teachers;
describe book;


CREATE OR REPLACE TRIGGER check_price BEFORE INSERT OR UPDATE ON book
FOR EACH ROW
DECLARE
   c_min constant number(8,2) := 10.0;
   c_max constant number(8,2) := 500000.0;
BEGIN
  IF :new.price > c_max OR :new.price < c_min THEN
  RAISE_APPLICATION_ERROR(-20000,'New price is too small or large');
END IF;
END;
/

insert into ordinator values(001,'Alo',01778643811,'01/01/11');
insert into ordinator values(002,'Slo',01778643853,'01/02/11');
insert into ordinator values(003,'Klo',01778543811,'05/01/11');
insert into ordinator values(004,'Blo',01778643811,'01/01/13');
insert into ordinator values(005,'Mlo',01778743811,'01/07/11');


insert into students(s_id,s_name,a_id,hall,advisor,email,mobile,year)values(1,'mamun',001,'AEH','abc','123@yahoo.com',01347673826,'3-1');
insert into students(s_id,s_name,a_id,hall,advisor,email,mobile,year)values(2,'marud',002,'BSMRH','abc','123@yahoo.com',01347673826,'3-1');
insert into students(s_id,s_name,a_id,hall,advisor,email,mobile,year)values(3,'masum',003,'FHH','abc','123@yahoo.com',01347673826,'3-1');
insert into students(s_id,s_name,a_id,hall,advisor,email,mobile,year)values(4,'peal',004,'AEH','abc','123@yahoo.com',01347673826,'3-1');
insert into students(s_id,s_name,a_id,hall,advisor,email,mobile,year)values(5,'real',005,'RH','abc','123@yahoo.com',01347673826,'3-1');


insert into teachers(t_id,t_name,email,mobile,a_id)values(101,'A','001@gmail.com',847567865,001);
insert into teachers(t_id,t_name,email,mobile,a_id)values(102,'B','004@gmail.com',8475676865,002);
insert into teachers(t_id,t_name,email,mobile,a_id)values(103,'C','005@gmail.com',847547865,002);
insert into teachers(t_id,t_name,email,mobile,a_id)values(104,'D','007@gmail.com',8477567865,001);
insert into teachers(t_id,t_name,email,mobile,a_id)values(105,'E','008@gmail.com',8478567865,005);



CREATE TRIGGER  LIMIT
BEFORE UPDATE OR INSERT ON ORDINATOR 
FOR EACH ROW 
BEGIN
IF :NEW.TIME_LIMIT>2 THEN
:NEW.COMMENT_L:='TIME OVER';

ELS :NEW.TIME_LIMIT<=2 THEN
:NEW.COMMENT_L:='OK';
END IF;
END LIMIT;
/

insert into book values(512,'C_programming','ami', 'CSE', 101.50,3,NULL,2,101,003);
insert into book values(513,'C++_programming','tumi', 'CSE', 100.50,2,NULL,1,102,004);
insert into book values(514,'C#_programming','shey', 'CSE', 110.50,5,NULL,4,102,001);
insert into book values(515,'Java_programming','amar_ami', 'CSE', 150.50,1,NULL,3,102,002);
insert into book values(516,'C_programming','ami', 'CSE', 105.50,4,NULL,1,103,003);





select * from teachers;
select * from students;
select * from ordinator;
select * from book;

select s_name,hall,year from students;

select  s_name from students where s_id=1; 


select distinct s_name from students;

select email  from teachers  order by t_name;


select s_name from students where hall='AEH';


select a_name from ordinator  order by join_date;

update teachers set email='ami@gmail.com',t_name='mamun' where t_id=101; 

select max(price) from book;

select min(price) from book;

select avg(price) from book;

select count(*), count(distinct(hall)), count(distinct (s_name))from students;

select book_name from book Order by price;



select s.s_name, s.hall, s.mobile,b.book_name,b.writter_name
	FROM students s join book b 
	ON s.s_id=b.s_id;


select students.s_name, students.hall, students.mobile,book.book_name,book.writter_name
	FROM students join book 
	using (s_id);

set serveroutput on;
Declare
max_price  book.price%type;
Begin
select max(price) into max_price
from book;

DBMS_OUTPUT.PUT_LINE('max price : '||max_price);
End;
/

SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE getname IS 
   	stu_id students.s_id%type;
    name students.s_name%type;
BEGIN
    stu_id :=1;
    SELECT s_name INTO name FROM students
    WHERE stu_id= s_id ;
    DBMS_OUTPUT.PUT_LINE('Name: '||name);
END;
/


BEGIN
getname;
END;
/


CREATE OR REPLACE PROCEDURE add_item (
  id_t teachers.t_id%TYPE,
  name_t teachers.t_name%TYPE,
  t_email teachers.email%TYPE,
  t_mobile teachers.mobile%TYPE) IS
BEGIN
  INSERT INTO teachers (t_id,t_name,email,mobile)
  VALUES (id_t,name_t,t_email,t_mobile);
  COMMIT;
END add_item;
/


BEGIN
    add_item (107,'Ta','abc@gmail.com',000876);
 END;
/

select * from teachers;

SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE UPD_ADD (id_s students.s_id%TYPE, name students.s_name%TYPE) IS
BEGIN
    update students set s_name= name where s_id=id_s;
 END UPD_ADD;
/

BEGIN
        UPD_ADD (7, 'Hlo');

    	IF SQL%NOTFOUND THEN
        RAISE_APPLICATION_ERROR(-20202, 'No name updated.');
        END IF;
END;
/

commit;














