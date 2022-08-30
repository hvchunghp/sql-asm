create table Department(
	DepartId int primary key,
	DepartName varchar(50) not null,
	Description varchar(255) not null,
);

create table Employee(
	EmpCode char(6) primary key,
	FirstName varchar(30) not null,
	LastName varchar(30) not null,
	Birthday smalldatetime not null,
	Gender bit default 1,
	Address varchar(100),
	DepartID int not null,
	FOREIGN KEY (DepartID) REFERENCES Department(DepartId),
	Salary Money,
);
--1
insert into Department (DepartId, DepartName, Description)
values (1, 'Marketing', 'In the era of technology 4.0, the role of the Marketing department is enhanced...'),
(2, 'Human resource', 'Manage the organization''s human resources in a reasonable and effective manner...'),
(3, 'Management', 'The management board is the place to issue strategic, long-term and short-term decisions affecting the existence and development of the organization...')

insert into Employee (EmpCode, FirstName, LastName, Birthday, Gender, Address, DepartID, Salary)
values ('MKT001', 'John', 'Doe', '1980-06-08', 1, 'USA', 1, 8000),
('HMR001', 'Marry', 'Rose', '1982-01-04', 0, 'USA', 2, 7000),
('MAN001', 'Carmine', 'Falcon', '1962-08-03', 1, 'USA', 3, 10000)
--2
UPDATE Employee 
SET Salary = Salary + (Salary * 10/100);
--3
ALTER TABLE Employee
ADD CHECK (Salary>0);
--5
create index IX_DepartmentName on Department(DepartName);
--6
CREATE VIEW emp_all as
select Employee.EmpCode, Employee.FirstName, Employee.LastName, Department.DepartName  from Employee left join Department
on Employee.DepartID = Department.DepartID
--7
create procedure sp_getAllEmp @departmentId int as
select * from Employee where DepartId = @departmentId;
--8
create procedure sp_delDept @ID char(6) as 
delete from Employee where EmpCode = @ID

exec sp_delDept @ID = 'MKT001'
