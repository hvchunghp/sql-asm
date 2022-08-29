
create database Assignment_06
use Assignment_06

create table TypesBookAGM6(
	Id int primary key  identity(1,1), 
	Name nvarchar(255) not null unique
)

create table AuthorsAGM6(
	Id int primary key identity(1,1),
	Name nvarchar(225) not null, 
)

create table PublishionsAGM6 (
	Id int primary key identity(1,1),
	Name nvarchar(225) not null unique, 
	Address nvarchar(225) ,
);


create table BooksAGM6(

	Id varchar(25) primary key ,
	N_Books nvarchar(255) not null,
	Content ntext,
	Year_publication int not null default year(getdate()),
	Price decimal(16,0) not null check(price >= 0) default 0,
	Quantity int not null check(Quantity >=0) default 0,
	NumberPublish int not null check(NumberPublish>0) default 0, 
	TypeID int not null foreign key(TypeID) references TypesBookAGM6(ID),
	AuthorsID int not null  foreign key(AuthorsID) references AuthorsAGM6(ID),
	PublishionID int not null  foreign key(PublishionID) references PublishionsAGM6(ID),
)
--drop table Books,Publishions,Authors,TypesBook
-- TypesBook,Authors,Publishions,Books
-- insert into TypesBook 
	insert into TypesBookAGM6(Name) values
	(N'Văn học nghệ thuật'),(N'Khoa Học Xã Hội'),
	(N'Công Nghệ Thông Tin'),(N'Tiểu Thuyết'),
	(N'Sách thiếu nhi'),(N'Chính trị – pháp luật'),
	(N'Tâm lý học'),(N'Ngon lu`');
		
-- insert into Authors 
	insert into AuthorsAGM6(Name) values 
	('Eran Katz'),(N'Văn Tèo'),(N'Nguyễn Văn A'),
	(N'Nguyễn Thị B'),(N'ĐÀO Văn Vàng'),
	(N'Nguyễn Văn Mario'),(N'Thị nở'),
	(N'Chí Phèo'),(N'CHị Dậu');
-- insert into Publishions 
	insert into PublishionsAGM6(Name,Address) values 
	(N'Tri Thức',N'53 Nguyễn Du, Hai Bà Trưng, Hà Nội'),
	(N'Dân Trí',N'Tầng 2, nhà D, 347, Đội Cấn, P. Liễu Giai, Q. Ba Đình, Tp. Hà Nội'),
	(N'Kim Đồng',N'22, Hàng Chuối, P. Phạm Đình Hổ, Q. Hai Bà Trưng, Tp. Hà Nội'),
	(N'Hà Nội',N'4, Tống Duy Tân, P. Hàng Bông, Q. Hoàn Kiếm, Tp. Hà Nội'),
	(N'Lao động',N'175, Giảng Võ, P. Cát Linh, Q. Đống Đa, Tp. Hà Nội'),
	(N'Phụ Nữ',N'39, Hàng Chuối, P. Phạm Đình Hổ, Q. Hai Bà Trưng, Tp. Hà Nội');
-- insert into Books 

	insert into BooksAGM6 VALUES
	('B011',N'Tin học - 3000 bài code thiếu nhi',N'Bạn có muốn biết:123...',2021,79000,99,1,3,6,3),
	('B001',N'Trí tuệ Do Thái',N'Bạn có muốn biết:123...',2010,79000,100,1,2,1,6),
	('B002',N'Bao giờ bán được 1 tỷ gói mè',N'đọc hết thì biết...',2022,100000,99,5,1,2,4),
	('B004',N'Cách để có Lương 1 tỷ/tháng',N'Dạy chế biến',2022,150000,200,2,4,8,1),
	('B005',N'Con gà có trước hay Trứng có trước',N'Không biết... hỏi chị google',2000,50000,500,3,2,7,4),
	('B006',N'Lòng xào dưa',N'...truyên hay đọc đi',2021,100000,25,6,1,6,5),
	('B007',N'Cuộc chiến công nghệ số',N'sách công nghệ nên công nghệ..',2010,15000,60,1,3,4,2),
	('B008',N'Trạng Quỳnh',N'.....Quỳnh',2005,60000,800,3,5,2,2),
	('B009',N'Luật nhận quả',N'Nói về những quả bên trong có nhân',2015,80000,20,2,6,8,3),
	('B010',N'Tiểu thuyết',N'có chú Tiểu thuyết trình về Lòng xào dưa',1999,5000,60,7,4,6,2),
	('B013',N'Tiểu thuyết 1',N'có chú Tiểu thuyết trình về Lòng xào bo`',2000,10000,0,7,4,6,2),
	('B012',N'Tiểu thuyết 2',N'có chú Tiểu thuyết trình về Lòng xào thi lon',2001,15000,0,7,4,6,2),
	('B017',N'Ngon lu` 1',N'Ngon nhung lun` 1',2020,100000,0,1,10,6,6),
	('B015',N'Ngon lu` 2',N'Ngon nhung lun` 2',2022,20000,0,2,10,6,6),
	('B016',N'Ngon lu` 3',N'Ngon nhung lun` 3',2035,0,0,1,10,6,6);
	select * from PublishionsAGM6
	--update BooksAGM6 set PublishionID=6 where Id ='B001'
--3. Liệt kê các cuốn sách có năm xuất bản từ 2008 đến nay
	select * from BooksAGM6 where Year_publication >= 2008
--4. Liệt kê 10 cuốn sách có giá bán cao nhất
	SELECT TOP 10 * FROM BooksAGM6 ORDER BY Price desc
--5. Tìm những cuốn sách có tiêu đề chứa từ “tin học”
	select * from BooksAGM6 where N_Books like N'%Tin học%'
--6. Liệt kê các cuốn sách có tên bắt đầu với chữ “T” theo thứ tự giá giảm dần
	select * from BooksAGM6 where N_Books like 'T%' order by N_Books desc
--7. Liệt kê các cuốn sách của nhà xuất bản Tri thức
	select * from BooksAGM6 where PublishionID in (select Id from PublishionsAGM6 where Name like N'Tri thức')
--8. Lấy thông tin chi tiết về nhà xuất bản xuất bản cuốn sách “Trí tuệ Do Thái”
select * from PublishionsAGM6

--9. Hiển thị các thông tin sau về các cuốn sách: Mã sách, Tên sách, Năm xuất bản, Nhà xuất bản,Loại sách
	select B.Id,B.N_Books,B.Year_publication,P.Name,T.Name from BooksAGM6 as B join PublishionsAGM6 as P  on B.PublishionID = P.Id
	JOIN TypesBookAGM6 AS T ON B.TypeID=T.Id

--10. Tìm cuốn sách có giá bán đắt nhất
	SELECT * FROM BooksAGM6 WHERE Price = (select max(Price) from BooksAGM6)
--11. Tìm cuốn sách có số lượng lớn nhất trong kho
	SELECT * FROM BooksAGM6 WHERE Quantity = (select max(Quantity) from BooksAGM6)
--12. Tìm các cuốn sách của tác giả “Eran Katz”
	SELECT * FROM BooksAGM6 as B WHERE b.AuthorsID = (select Id from AuthorsAGM6 where Name like 'Eran Katz')
--13. Giảm giá bán 10% các cuốn sách xuất bản từ năm 2008 trở về trước
	update BooksAGM6 set Price = Price-(10*Price/100)
	where Year_publication <= 2008
--14. Thống kê số lượng sách của mỗi nhà xuất bản
	select SUM(Quantity)AS SL_SACH,PublishionID AS PublishionID from BooksAGM6 as B join PublishionsAGM6 as P on B.TypeID = P.Id GROUP BY B.PublishionID 
	SELECT * FROM PublishionsAGM6
	SELECT * FROM BooksAGM6
--15. Thống kê số lượng sách của mỗi loại sách
	select count(*) AS SL_SACH,T.Name from BooksAGM6 as B join TypesBookAGM6 as T on B.TypeID = T.Id GROUP BY T.Name
--16. Đặt chỉ mục (Index) cho trường tên sách
	create index IDX_BOOK_N
	ON BooksAGM6(N_Books)
--17. Viết view lấy thông tin gồm: Mã sách, tên sách, tác giả, nhà xb và giá bán
	create view V_BOOK_ATH AS
	SELECT B.Id AS MaSach, B.N_Books AS TenSach,ATH.Name AS TenTG,P.Name AS NhaXB,B.Price AS GiaBan FROM BooksAGM6 AS B JOIN AuthorsAGM6 AS ATH ON B.AuthorsID=ATH.Id
	JOIN PublishionsAGM6 AS P ON B.PublishionID = P.Id

	SELECT * FROM V_BOOK_ATH;
--18. Viết Store Procedure:
--◦ SP_Them_Sach: thêm mới một cuốn sách
	CREATE PROCEDURE SP_Them_Sach @Id varchar(25),@N_Books nvarchar(255),@Content ntext,@Y_PLS int,@Price decimal(16,0),@Quantity int,@Num_PLS int,@TypeID int,@AuthorsID int,@PublishionID int AS
	INSERT INTO BooksAGM6 values (@Id,@N_Books,@Content,@Y_PLS,@Price,@Quantity,@Num_PLS,@TypeID,@AuthorsID,@PublishionID)

	EXEC SP_Them_Sach @Id='B1234',@N_Books=N'THÊM SACH 1',@Content=N'NỘI DUNG ',@Y_PLS=2022,@Price=99999,@Quantity=12,@Num_PLS=1,@TypeID=3,@AuthorsID=9,@PublishionID=1;
--◦ SP_Tim_Sach: Tìm các cuốn sách theo từ khóa
	CREATE PROCEDURE SP_Tim_Sach @TimSach nvarchar(255) as
	select * from BooksAGM6 where N_Books like N'%'+@TimSach +'%';

	exec SP_Tim_Sach @TimSach=N'Tin học';
--◦ SP_Sach_ChuyenMuc: Liệt kê các cuốn sách theo mã chuyên mục
	create procedure SP_Sach_Loai @MaLoaiSach int as
	select * from BooksAGM6 where TypeID in (@MaLoaiSach)

	exec SP_Sach_Loai @MaLoaiSach = 10
--19. Viết trigger không cho phép xóa các cuốn sách vẫn còn trong kho (số lượng > 0)
	create trigger TG_KDXS 
	ON BooksAGM6 for delete as
	begin 
		if exists (select * from deleted where deleted.Quantity >0)
		begin 
			print N'Không được xóa' 
			rollback tran
		end
	end
	select * from BooksAGM6

	delete from BooksAGM6 where Id = 'B012'

--20. Viết trigger chỉ cho phép xóa một danh mục sách khi không còn cuốn sách nào thuộc chuyên mục này
	CREATE trigger TG_XOA_TypeB
	ON TypesBookAGM6 for delete as
	begin
	-- nếu loại sách có số lượng <= 0 hoặc sách chưa từng tồn tại trong kho thì được xóa
		if exists (select * from deleted where Id in (select TypeID FROM BooksAGM6 where 0 = (select sum(Quantity) from BooksAGM6 where TypeID = deleted.Id))) 
		or exists (select * from deleted where Id in (select TypeID FROM BooksAGM6 ))
			begin 
				print N'Không được xóa' 
				rollback tran
			end
	end
		delete from TypesBookAGM6 where Id = 7
		--update BooksAGM6 set TypeID =10 where Id IN ('B015','B016','B017')

