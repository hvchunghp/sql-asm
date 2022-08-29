
create database Assignment_05
use Assignment_05


create table Custemers
(
	Id int primary key identity(1,1),
	Ten nvarchar(50) not null ,
	DiaChi nvarchar(255) not null ,
	NgaySinh date  default getdate(),
)
create table Phone_Number
(
	Phone_NB varchar(20) primary key CONSTRAINT CK_PNB check(Phone_NB LIKE '[0-9]%[0-9]'),
	Ctm_Id int foreign key references Custemers(Id)
)

-- insert data Custemers

insert into Custemers(Ten,DiaChi,NgaySinh) values
(N'Văn Tèo',N'Bốn bể là nhà','1999/08/22'),
(N'Nguyễn Văn A',N'13 Nguyễn Trãi, Thanh Xuân, Hà Nội','1987/11/18'),
(N'Nguyễn Thị B',N'13 Nguyễn Trãi, Thanh Xuân, Hà Nội','1987/11/18'),
(N'ĐÀO Văn Vàng',N'22n Nguyễn , Phòng Hải, Hải Phòng','2009/12/12'),
(N'Nguyễn Văn Mario',N'111 Nguyễn Trãi, Thanh Xuân, Đà Nẵng','2009/12/12'),
(N'Thị nở',N'Làng Vũ Đại','1963/10/22'),
(N'Chí Phèo',N'Làng Vũ Đại','1960/05/13'),
(N'CHị Dậu',N'Tức Nước - Vỡ Bờ - Ninh Bình ','2000/06/23');

-- insert data Phone_Number
insert into Phone_Number values
('123456789',1 ),
('111111111',2 ),
('222222222',1 ),
('333333333',3 ),
('444444444',1 ),
('555555555',1 ),
('666666666',5 ),
('777777777',4 ),
('888888888',3 ),
('999999999',6 ),
('987654321',6 ),
('789654123',7 );

/*4. Viết các câu lênh truy vấn để*/
--a) Liệt kê danh sách những người trong danh bạ
	select * from Custemers
--b) Liệt kê danh sách số điện thoại có trong danh bạ
	select * from Phone_Number
/*5. Viết các câu lệnh truy vấn để lấy*/
--a) Liệt kê danh sách người trong danh bạ theo thứ thự alphabet.
	select * from Custemers order by Ten asc
--b) Liệt kê các số điện thoại của người có tên là Nguyễn Văn An.
	select * from Phone_Number as pn where pn.Ctm_Id = 
	(select Id from Custemers where Ten like N'Nguyễn Văn A' )
--c) Liệt kê những người có ngày sinh là 12/12/09
	select * from Custemers where NgaySinh = '2009/12/12'
/*6. Viết các câu lệnh truy vấn để*/
--a) Tìm số lượng số điện thoại của mỗi người trong danh bạ.
	select count(*) as SL_Phone_Num_Of_CTM  from Phone_Number group by Ctm_Id
--b) Tìm tổng số người trong danh bạ sinh vào thang 12.
	select count(*) as CTM_m_12 from Custemers WHERE (select Month(NgaySinh) as Month) like 12
	-- or
	select count(*) as CTM_m_12 from Custemers WHERE (SELECT DATEPART(month, NgaySinh) AS DatePartInt) like 12
--c) Hiển thị toàn bộ thông tin về người, của từng số điện thoại.
	select * from Custemers join Phone_Number on Id = Ctm_Id
--d) Hiển thị toàn bộ thông tin về người, của số điện thoại 123456789.
	select * from Custemers where Id = (select Ctm_Id from Phone_Number where Phone_NB='123456789')
/*7. Thay đổi những thư sau từ cơ sở dữ liệu*/
--a) Viết câu lệnh để thay đổi trường ngày sinh là trước ngày hiện tại.
	alter table Custemers 
	alter column NgaySinh getdate(1);
--b) Viết câu lệnh để xác định các trường khóa chính và khóa ngoại của các bảng.

--c) Viết câu lệnh để thêm trường ngày bắt đầu liên lạc.
	alter table Custemers 
	add contact_d date default getdate();
/*8. Thực hiện các yêu cầu sau*/
--a) Thực hiện các chỉ mục sau(Index)1
--◦ IX_HoTen : đặt chỉ mục cho cột Họ và tên
	create index IX_HoTen on Custemers(Ten,NgaySinh)
--◦ IX_SoDienThoai: đặt chỉ mục cho cột Số điện thoại
	create index IX_SoDienThoai on Phone_Number(Phone_NB)
/*b) Viết các View sau:*/
--◦ View_SoDienThoai: hiển thị các thông tin gồm Họ tên, Số điện thoại
	CREATE VIEW View_SoDienThoai as 
	select Custemers.Ten,Phone_Number.Phone_NB FROM Custemers JOIN Phone_Number ON  Id = Ctm_Id
	select * from View_SoDienThoai
--◦ View_SinhNhat: Hiển thị những người có sinh nhật trong tháng hiện tại (Họ tên, Ngàysinh, Số điện thoại)
	create view View_SinhNhat as
	select * from Custemers where Month(NgaySinh) = Month(getdate());

	select * from View_SinhNhat;
/*c) Viết các Store Procedure sau:*/
--◦ SP_Them_DanhBa: Thêm một người mới vào danh bạn Ten,DiaChi,NgaySinh
	create procedure SP_Them_DanhBa @Ten nvarchar(50),@DiaChi nvarchar(255),@NgaySinh date as
	insert into Custemers values (@Ten,@DiaChi,@NgaySinh)

	EXEC SP_Them_DanhBa @Ten=N'Cu Tis',@DiaChi=N'Nguyện đi theo Tèo',@NgaySinh='2000/02/22'
--◦ SP_Tim_DanhBa: Tìm thông tin liên hệ của một người theo tên (gần đúng)
	alter procedure SP_Tim_DanhBa @Timten nvarchar(50) as
	select * from Custemers where  Ten like '%'+@Timten+'%'

	exec SP_Tim_DanhBa @Timten='Tis'
