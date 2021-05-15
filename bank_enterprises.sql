create database BANKING_ENTERPRISES;
use BANKING_ENTERPRISES;

create table Branch(
Branchname varchar(255),
Branchcity varchar(255),
Assets float,
primary key(Branchname));

create table BankAccount(
Accno varchar(10),
Branchname varchar(255),
Balance float,
primary key(Accno),
foreign key(Branchname) references Branch(Branchname));

create table BankCustomer(
Customername varchar(255),
Customerstreet varchar(250),
City varchar(255),
primary key(Customername));

create table Loan(
loannumber int,
Branchname varchar(255),
amount float,
primary key(loannumber),
foreign key(Branchname) references Branch(Branchname));

create table Depositor(
Customername varchar(255),
Accno varchar(10),
foreign key(Customername) references BankCustomer(Customername),
foreign key(Accno) references BankAccount(Accno));

insert into Branch values('SBI_Chamrajpet','Bangalore','50000');
insert into Branch values('SBI_ResidencyRoad','Bangalore',10000),('SBI_ShivajiRoad','Bombay',20000),('SBI_ParliamentRoad','Delhi',10000),('SBI_Jantarmantar','Delhi',20000);

select * from Branch;

insert into BankAccount values('1','SBI_Chamrajpet',2000),('2','SBI_ResidencyRoad',5000),('3','SBI_ShivajiRoad',6000),('4','SBI_ParliamentRoad',9000),('5','SBI_Jantarmantar',8000),('6','SBI_ShivajiRoad',4000),('8','SBI_ResidencyRoad',4000),('9','SBI_ParliamentRoad',3000),
('10','SBI_ResidencyRoad',5000),('11','SBI_Jantarmantar',2000);

insert into BankCustomer values
('Avinash','Bull_Temple_Raod','Bangalore'),
('Dinesh','Bannergatta_Road','Bangalore'),
('Mohan','NationalCollege_Road','Bangalore'),
('Nikil','Akbar_Road','Delhi'),
('Ravi','Prithviraj_Road','Delhi');

insert into Loan values
(1,'SBI_Chamrajpet',1000),
(2,'SBI_ResidencyRoad',2000),
(3,'SBI_ShivajiRoad',3000),
(4,'SBI_ParliamentRoad',4000),
(5,'SBI_Jantarmantar',5000);



insert into Depositor values
('Avinash','1'),
('Dinesh','2'),
('Nikil','4'),
('Ravi','5'),
('Avinash','8'),
('Nikil','9'),
('Dinesh','10'),
('Nikil','11');

select d.Customername from Depositor d,BankAccount b where d.Accno=b.Accno and b.Branchname='SBI_ParliamentRoad' group by d.Customername having count(*)>=2;

select distinct CustomerName 
        from Depositor
        where Accno in (select Accno
						from BankAccount 
                        where BranchName in (select  BranchName 
												from Branch
                                                where BranchCity ='Bangalore'))
		group by CustomerName having count(distinct Accno)>=(select count(*) from Branch
															where BranchCity ='Bangalore');
		
                                              
