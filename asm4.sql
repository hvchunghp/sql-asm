--CREATE DATABASE AGM4
USE AGM4

CREATE TABLE Type_Product(
	Mlsp VARCHAR(20) PRIMARY KEY,
	Name NVARCHAR(255) NOT  NULL 
)
CREATE TABLE Manager_Product(
	Id INT PRIMARY KEY,
	Name NVARCHAR(255)
)
CREATE TABLE Product(
	Id VARCHAR(50) PRIMARY KEY,
	PF_Date DATE ,
	Mlsp_TP VARCHAR(20) FOREIGN KEY REFERENCES Type_Product(Mlsp),
	Manager_ID INT FOREIGN KEY REFERENCES Manager_Product(Id)
)

-- INSERT Type_Product
INSERT INTO Type_Product VALUES
('G789',N'Máy tính sách tay G789'),
('Z37E',N'Máy tính sách tay Z37'),
('A111',N'Điện thoại A111'),
('B222',N'Máy ảnh B222'),
('C333',N'Máy tính sách tay C333'),
('D444',N'Đồ chơi nè D444')
	
-- INSERT Manager_Product
INSERT INTO Manager_Product VALUES
(99999,N'Nguyễn Văn A'),
(33333,N'Nguyễn Văn B'),
(66666,N'Nguyễn Văn C')

-- INSERT Product
INSERT INTO Product VALUES
('G789 465456','2012/05/12','G789',66666),
('Z37 111111','2009/10/22','Z37E',99999),
('Z37 222222','2010/12/02','Z37E',99999),
('Z37 333333','2009/03/12','Z37E',33333),
('Z37 444444','2008/12/22','Z37E',99999),
('Z37 555555','2009/10/22','Z37E',66666),
('A111 666666','2009/08/22','A111',99999),
('A111 111111','2009/04/22','A111',99999),
('B222 111111','2015/10/22','B222',33333),
('B222 333333','2009/10/22','B222',33333),
('B222 444444','2009/12/22','B222',99999),
('C333 111111','2004/11/22','C333',33333),
('C333 555555','2009/10/22','C333',66666),
('C333 444444','2005/12/22','C333',99999),
('C333 333333','2009/10/22','C333',99999),
('D444 111111','2009/10/22','D444',66666)

/*Viết các câu lênh truy vấn để*/

--a) Liệt kê danh sách loại sản phẩm của công ty.
	SELECT * FROM Type_Product
--b) Liệt kê danh sách sản phẩm của công ty.
	SELECT * FROM Product
--c) Liệt kê danh sách người chịu trách nhiệm của công ty.
	SELECT * FROM Manager_Product
/*5. Viết các câu lệnh truy vấn để lấy*/
--a) Liệt kê danh sách loại sản phẩm của công ty theo thứ tự tăng dần của tên
	SELECT * FROM Type_Product ORDER BY Name asc
--b) Liệt kê danh sách người chịu trách nhiệm của công ty theo thứ tự tăng dần của tên.
	SELECT * FROM Manager_Product ORDER BY Name desc
--c) Liệt kê các sản phẩm của loại sản phẩm có mã số là Z37E.
	SELECT * FROM Product where Product.Mlsp_TP = 'Z37E'
--d) Liệt kê các sản phẩm Nguyễn Văn An chịu trách nhiệm theo thứ tự giảm đần của mã.
	SELECT * FROM Product where Product.Manager_ID in (select Id from Manager_Product where Name like N'Nguyễn Văn A' )
	ORDER BY Id DESC
/*6. Viết các câu lệnh truy vấn để*/
--a) Số lượng sản phẩm của từng loại sản phẩm.
	SELECT COUNT(*) AS SL_SanPham,Mlsp_TP FROM  Product GROUP BY Product.Mlsp_TP
--b) Số lượng sản phẩm trung bình theo loại sản phẩm.
		SELECT (CAST(COUNT(Id) AS float) /(SELECT count( DISTINCT Mlsp_TP )FROM  Product)) FROM  Product
		-- CHIA 2 SO NGUYEN SE TRA VE 1 SO NGUYEN
		SELECT (COUNT(Id)*1.0 /(SELECT count( DISTINCT Mlsp_TP )FROM  Product)) FROM  Product
		-- decimal OR DEC tương tự như nhau
		SELECT CAST(COUNT(Id)*1.0 /(SELECT count( DISTINCT Mlsp_TP )FROM  Product) AS decimal (10,2) ) FROM  Product
	--c) Hiển thị toàn bộ thông tin về sản phẩm và loại sản phẩm.
	SELECT * FROM Product JOIN Type_Product ON Product.Mlsp_TP= Type_Product.Mlsp
--d) Hiển thị toàn bộ thông tin về người chịu trách nhiêm, loại sản phẩm và sản phẩm
	SELECT * FROM Manager_Product JOIN Product ON Manager_ID=Manager_Product.Id JOIN Type_Product ON Mlsp=Mlsp_TP
/*7. Thay đổi những thư sau từ cơ sở dữ liệu*/
--a) Viết câu lệnh để thay đổi trường ngày sản xuất là trước hoặc bằng ngày hiện tại.
	/*KHI BẢNG ĐÃ CÓ DỮ LIỆU MÀ ĐK CHECK KO THỎA MÃN THÌ SẼ KO THÊM constraint ĐC :(XÓA DATA TRONG BẢNG THÌ MỚI CÓ THỂ ADD)*/
	ALTER TABLE Product ADD constraint CHECKDate CHECK (Product.PF_Date >= GETDATE()) ;
	--ALTER TABLE Product DROP constraint CHECKDate 

--b) Viết câu lệnh để xác định các trường khóa chính và khóa ngoại của các bảng.
	CREATE TABLE TETS (ID INT NOT NULL)
	--KHI THEM KHÓA CHÍNH CHO 1 CỘT THÌ CỘT ĐÓ PHỈA CÓ RÀNG BUỘC NOT NULL 
	ALTER TABLE TETS ADD  PRIMARY KEY (ID)
	ALTER TABLE TETS ADD FR_KEY INT 
	ALTER TABLE TETS ADD  FOREIGN KEY (ID) REFERENCES Manager_Product(ID)
--c) Viết câu lệnh để thêm trường phiên bản của sản phẩm.
	ALTER TABLE Product
	ADD Version nvarchar(50) default N'A123'
/*8. Thực hiện các yêu cầu sau*/
--a) Đặt chỉ mục (index) cho cột tên người chịu trách nhiệm
	CREATE INDEX MNG_NAME ON Manager_Product (Name);
/*b) Viết các View sau:*/
--◦ View_SanPham: Hiển thị các thông tin Mã sản phẩm, Ngày sản xuất, Loại sản phẩm
	CREATE VIEW View_SanPham AS 
	SELECT ID as MaSanPham,PF_Date as NgaySX,Mlsp ,Name  FROM Product JOIN Type_Product ON Type_Product.Mlsp=Mlsp_TP;
	-- VIEW
	SELECT * FROM View_SanPham;
--◦ View_SanPham_NCTN: Hiển thị Mã sản phẩm, Ngày sản xuất, Người chịu trách nhiệm
	CREATE VIEW View_SanPham_NCTN AS 
	SELECT Product.Id as MaSP,PF_Date AS NgaySX,Name AS NgCTN FROM Product JOIN Manager_Product ON Manager_Product.Id = Manager_ID
	-- VIEW
	SELECT * FROM View_SanPham_NCTN;
--◦ View_Top_SanPham: Hiển thị 5 sản phẩm mới nhất (mã sản phẩm, loại sản phẩm, ngàysản xuất)
	SELECT TOP 5 * FROM Product WHERE PF_Date 
/*c) Viết các Store Procedure sau:*/
--◦ SP_Them_LoaiSP: Thêm mới một loại sản phẩm
	CREATE PROCEDURE SP_Them_LoaiSP @Mlsp VARCHAR(20) ,@Name NVARCHAR(255) AS
	INSERT INTO Type_Product values (@Mlsp,@Name)

	EXEC SP_Them_LoaiSP @Mlsp='G456' , @Name='Loại SP MỚI 1'
--◦ SP_Them_NCTN: Thêm mới người chịu trách nhiệm
	CREATE PROCEDURE SP_Them_NCTN @Id INT ,@Name NVARCHAR(255) AS
	INSERT INTO Manager_Product VALUES (@Id,@Name)

	EXEC SP_Them_NCTN @Id=22222 , @Name=N'Người mới 2'
--◦ SP_Them_SanPham: Thêm mới một sản phẩm
	 
	CREATE PROCEDURE SP_Them_SanPham @MaSP VARCHAR(20) ,@DATE DATE, @MaLoai VARCHAR(20) , @ngQL INT AS
	INSERT INTO Product VALUES (@MaSP,@DATE,@MaLoai,@ngQL)
	--('D444 111111','2009/10/22','D444',66666)
	EXEC SP_Them_SanPham @MaSP='G444 111111',@DATE='2010/10/30',@MaLoai='D444',@ngQL=66666
--◦ SP_Xoa_SanPham: Xóa một sản phẩm theo mã sản phẩm
	CREATE PROCEDURE SP_Xoa_SanPham @MaSP varchar(50) AS
	DELETE FROM Product WHERE Product.Id LIKE @MaSP

	EXEC SP_Xoa_SanPham @MaSP = 'D444 333333'
--◦ SP_Xoa_SanPham_TheoLoai: Xóa các sản phẩm của một loại nào đó
	CREATE PROCEDURE SP_Xoa_SanPham_TheoLoai @MALOAISP VARCHAR(20) AS
	DELETE FROM Product WHERE @MALOAISP = Product.Mlsp_TP 

	EXEC SP_Xoa_SanPham_TheoLoai @MALOAISP='Z37E'

