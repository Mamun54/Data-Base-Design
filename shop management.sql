
drop table Orders;
drop table Products;
drop table Employee_Info;
drop table Employee;
drop table Client_Info;
drop table Client;

create table Client(
	Client_ID integer not null,
	Name varchar(20) not null,
	Company varchar(20) not null,
	primary key(Client_ID)
);

create table Client_Info(
	Client_Info_ID integer not null,
	Address varchar(50) not null,
	Email varchar(20) not null,
	Phone integer not null,
	primary key(Client_Info_ID),
	FOREIGN KEY (Client_Info_ID) REFERENCES Client (Client_ID) ON DELETE CASCADE
);

create table Employee(
	Employee_ID integer not null,
	Name varchar(20) not null,
	Post varchar(20) not null,
	primary key(Employee_ID)
);

create table Employee_Info(
	Employee_Info_ID integer not null,	
	Address varchar(50) not null,
	Email varchar(20) not null,
	Phone integer not null,
	Sallary integer not null,
	primary key(Employee_Info_ID),
	FOREIGN KEY (Employee_Info_ID) REFERENCES Employee (Employee_ID) ON DELETE CASCADE
);


create table Products(
	Product_ID integer not null,
	Name varchar(20) not null, 
	Price integer not null,
	primary key (Product_ID)
);


create table Orders(
	Order_ID integer not null,
	O_Client_ID integer not null,
	O_Product_ID integer not null,
	O_emp_id integer not null,
	date_in date not null,
	quantity integer not null,
	primary key (Order_ID),
	FOREIGN KEY (O_Client_ID) REFERENCES Client (Client_ID) ON DELETE CASCADE,
	FOREIGN KEY (O_Product_ID) REFERENCES Products (Product_ID) ON DELETE CASCADE,
	FOREIGN KEY (O_emp_id) REFERENCES Employee (Employee_ID) ON DELETE CASCADE
	);



insert into Client values (1,'Shuvo','Dream LTD');
insert into Client values (2,'Tawhid','Hack LTD');
insert into Client values (3,'Nayeem','Bazi LTD');
insert into Client values (4,'Ayon','Limitless LTD');
insert into Client values (5,'Badhon','Bit2byte LTD');
insert into Client values (6,'Tanzim','Maximus LTD');	


insert into Employee values	(1,'Tanmay','Salesman' );
insert into Employee values	(2,'Shuvro','Salesman' );
insert into Employee values	(3,'Moon','Salesman' );
insert into Employee values	(4,'Ali', 'Salesman' );
insert into Employee values	(5,'Charli','Salesman' );
insert into Employee values	(6,'Rianon','Salesman' );



insert into Client_Info values (4, 'Noakhali', 'nayeem@gmail.com',100000 );
insert into Client_Info values (3, 'Gazipur', 'ayon@gmail.com',110000 );
insert into Client_Info values (1, 'Narshingdi', 'shuvo@gmail.com',111000 );
insert into Client_Info values (2, 'Faridpur', 'tawhid@gmail.com',111100 );
insert into Client_Info values (5, 'Dhaka', 'badhon@gmail.com',111100 );
insert into Client_Info values (6, 'Manikganj', 'tanzim@gmail.com',111111 );

insert into Employee_Info values (4, 'Chittagong', 'ali@gmail.com', 200000,10000);	
insert into Employee_Info values (1, 'Rangpur', 'tanmay@gmail.com', 220000,10000);
insert into Employee_Info values (2, 'Nowgaon', 'shuvro@gmail.com', 222000,10000);	
insert into Employee_Info values (3, 'Sherpur', 'moon@gmail.com', 222200,20000);	
insert into Employee_Info values (5, 'Khagrachori', 'charli@gmail.com', 222220,20000);		
insert into Employee_Info values (6, 'Jessore', 'rianon@gmail.com', 222222,20000);		



insert into Products values (1, 'Shirt', 1000);
insert into Products values	(2, 'Shoe', 1500);
insert into Products values (3, 'Fruit', 2000);
insert into Products values (4, 'Pant', 1000);
insert into Products values (5, 'Camera', 15000);
insert into Products values (6, 'Computer', 30000);


insert into Orders values (1, 1, 3, 1, '1-jul-2013', 2);
insert into Orders values (2, 1, 4, 1, '1-jul-2013', 3);
insert into Orders values (3, 1, 3, 2, '2-aug-2013', 2);
insert into Orders values (4, 2, 1, 2, '2-aug-2013', 2);
insert into Orders values (5, 2, 2, 3, '2-aug-2013', 4);
insert into Orders values (6, 3, 5, 3, '3-aug-2013', 1);
insert into Orders values (7, 4, 6, 3, '3-aug-2013', 4);
insert into Orders values (8, 4, 2, 4, '4-aug-2013', 1);
insert into Orders values (9, 5, 6, 5, '5-aug-2013', 2);
insert into Orders values (10, 5, 5, 6, '6-aug-2013', 3);


select * from Client;
select Client_ID, Name, Company from Client;
select Client_ID, Name from Client;

select * from Client_Info;
select Client_Info_ID, Address, Email, Phone from Client_Info;
select Client_Info_ID, Address from Client_Info;

select * from Orders;
select distinct O_Client_ID from Orders;
select O_Client_ID, count(O_Product_ID ) from orders group by O_Client_ID ;
select O_Client_ID, count(O_Product_ID ) from orders group by O_Client_ID having count(O_Product_ID)>1;


select * from Products;
select Product_ID, Name from Products where Price>1000;
select Product_ID, Name from Products where Price=1000 or Price=1500;
select Product_ID, Name from Products where Price>1000 and Price<2000;
select Product_ID, Name from Products where Price in (1000,3000);


select Name, Price from Products Order by Price;
select Name, Price from Products Order by Price desc;
select max(Price) from Products;
select avg(Price) from Products;
select count(*) from Products;

 
select count(Product_ID),Price from Products group by Price having Price>1500;
select count(Product_ID),Price from Products group by Price having Price>=1000;


select c.Name, ci.Address,ci.Email from 
Client c join Client_Info_ID ci
on c.Client_ID = ci.Client_Info_ID;


select c.Name, ci.Address,ci.Email from 
Client c left outer  join Client_Info ci
on c.client_id= ci.client_info_id;


select c.Name, ci.Address,ci.Email from 
Client c right outer  join Client_Info ci
on c.client_id= ci.client_info_id;

set serveroutput on;
Declare
max_s employee_info.sallary%type;
Begin
select max(sallary) into max_s
from employee_info;

DBMS_OUTPUT.PUT_LINE('max sallary : '||max_s);
End;
/



set serveroutput on;
Declare
max_s employee_info.sallary%type;
id employee_info.employee_info_id%type := 2;
Begin
select sallary into max_s
from employee_info
where employee_info_id=id;

DBMS_OUTPUT.PUT_LINE('sallary : '||max_s||' id : '||id);
End;
/

set serveroutput on;
Declare
pordered Number(2);
Begin
select count(O_Product_ID) into pordered 
from Orders
where O_Product_ID=3;
DBMS_OUTPUT.PUT_LINE(pordered);

End;
/

commit;









