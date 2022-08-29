-- CREATE DATABASE Assignment9

USE Assignment9 


CREATE TABLE NHACUNGCAP
(
	MaNhaCC varchar(10) primary key not null,
	TenNhaCC nvarchar(255) not null unique default 'chua ro!!' ,
	DiaChi nvarchar(50) not null default 'chua ro!!' ,
	SoDT varchar(20) unique constraint CHECK_SDT check(SoDT like '05%[0-9]' AND LEN(SoDT)>10) default 0  ,
	MaSoThue int not null unique default 0,
) 


--DROP TABLE NHACUNGCAP

CREATE TABLE LOAIDICHVU
(
	MaLoaiDV varchar(10) primary key not null,
	TenLoaiDV nvarchar(255) not null unique ,
)

CREATE TABLE MUCPHI
(
	MaMP varchar(10) primary key not null,
	DonGia decimal(16,0) not null ,
	MoTa ntext 
)

CREATE TABLE DONGXE
(
	DongXe varchar(50) primary key  not null ,
	HangXe varchar(50) not null  ,
	SoChoNguoi int not null check(SoChoNguoi > 0 and SoChoNguoi < 100)
)

CREATE TABLE DANGKYCUNGCAP 
(
	MaDKCC varchar(10) primary key ,
	MaNhaCC varchar(10) constraint CHECK_MaNhaCC  foreign key ( MaNhaCC) references NHACUNGCAP(MaNhaCC) DEFAULT 0,
	MaLoaiDV varchar(10) constraint CHECK_MaLoaiDV  foreign key ( MaLoaiDV) references LOAIDICHVU(MaLoaiDV) DEFAULT 0,
	DongXe varchar(50) constraint CHECK_DongXe  foreign key (DongXe) references DONGXE(DongXe) DEFAULT 0,
	MaMP varchar(10) constraint CHECK_MaMP  foreign key ( MaMP) references MUCPHI(MaMP) DEFAULT 0,
	NgayBatDauCungCap  date not null default getdate(),
	NgayKetThucCungCap date not null default getdate()+3,
	SoLuongXeDangKy int not null default 1,
)
--DROP TABLE DANGKYCUNGCAP
--drop table DANGKYCUNGCAP,DONGXE,LOAIDICHVU,MUCPHI,NHACUNGCAP
-- INSERT DATA NHACUNGCAP
INSERT INTO NHACUNGCAP
VALUES 
('NCC001',N'Cty TNHH Toàn Pháp',N'Hai Chau','05113999888','568941'),
('NCC002',N'Cty Cổ phần Đông Du ',N'Liên Chiểu','05113999889','456789'),
('NCC003',N'Ong Nguyen Van A',N'Hoa Thuan','05113999890','321456'),
('NCC004',N'Cty Cổ phần Toàn Cầu Xanh',N'Hai Chau','051138589451','513364'),
('NCC005',N'Cty TNHH AVA',N'Thanh Khê','05113875468 ','546546'),
('NCC006',N'Bà Trần Thị Bích Vân',N'Liên Chiểu','05113587469','524545'),
('NCC007',N'Cty TNHH Phan Thành',N'Thanh Khê','05113987456','113021'),
('NCC008',N' Ông Phan Đình Nam',N'Hoa Thuan','05113532456 ','121230'),
('NCC009',N'Tập đoàn Đông Nam Á',N'Liên Chiểu','05113937121','533654'),
('NCC010',N'Cty Cổ phần Rạng đông',N'Liên Chiểu','05113569654','187864')
--SELECT * FROM NHACUNGCAP
UPDATE NHACUNGCAP
SET MaNhaCC = 'NCC010'
WHERE MaSoThue='187864'

 -- INSERT DATA LOAIDICHVU

 INSERT INTO LOAIDICHVU
VALUES 
('DV01',N'Dịch vụ xe taxi'),
('DV02',N'Dịch vụ xe  bus công cộng theo tuyến cố định'),
('DV03',N'Dịch vụ xe  cho thuê theo hợp đồng')
SELECT * FROM  MUCPHI

 -- INSERT DATA MUCPHI
INSERT INTO MUCPHI 
VALUES 
('MP01',10000,N'Áp dụng từ ngày 1/2015'),
('MP02',15000,N'Áp dụng từ ngày 2/2015'),
('MP03',20000,N'Áp dụng từ ngày 1/2010'),
('MP04',10000,N'Áp dụng từ ngày 2/2011')

 -- INSERT DATA DONGXE
INSERT INTO DONGXE
VALUES 
('Hiace','Toyota','16'),
('Vios','Toyota','5'),
('Escape','Ford','5'),
('Cerato','Toyota','7'),
('Forte','Ford','5'),
('Starex','Ford','7'),
('Grand-i10','Huyndai','7')

INSERT INTO DANGKYCUNGCAP
VALUES 
('DK001','NCC001','DV01','Hiace','MP01','2015/11/20','2016/11/20','4'),
('DK002','NCC002','DV02','Vios','MP03','2015/01/12','2017/11/20','1'),
('DK003','NCC008','DV01','Escape','MP01','2015/11/20','2018/11/20','8'),
('DK004','NCC004','DV03','Forte','MP02','2015/11/27','2017/05/30','12'),
('DK005','NCC001','DV02','Starex','MP01','2015/11/20','2016/11/20','5'),
('DK006','NCC006','DV01','Cerato','MP02','2017/10/22','2018/11/20','1'),
('DK007','NCC007','DV01','Vios','MP01','2015/01/12','2016/11/20','4'),
('DK008','NCC001','DV03','Grand-i10','MP01','2015/10/22','2016/11/20','7'),
('DK009','NCC009','DV02','Forte','MP04','2018/03/08','2019/10/12','1'),
('DK010','NCC006','DV02','Escape','MP01','2015/10/11','2019/11/20','2')

UPDATE DANGKYCUNGCAP
SET MaDKCC='DK010'
WHERE MaNhaCC='NCC006'

DELETE FROM DANGKYCUNGCAP
--drop table MUCPHI
--select * from DANGKYCUNGCAP
--Câu 3: Liệt kê những dòng xe có số chỗ ngồi trên 5 chỗ
select * from DONGXE 
where SoChoNguoi > 5
/*
Câu 4: Liệt kê thông tin của các nhà cung cấp -- đã từng đăng ký cung cấp những dòng xe
thuộc hãng xe “Toyota”-- với mức phí có đơn giá là 15.000 VNĐ/km hoặc những dòng xe
thuộc hãng xe “KIA” với mức phí có đơn giá là 20.000 VNĐ/km */
--select * from NHACUNGCAP as NPC
SELECT * FROM NHACUNGCAP AS NCC
WHERE MaNhaCC IN 
(SELECT MaNhaCC FROM DANGKYCUNGCAP AS DKCC WHERE DongXe = 
(SELECT DongXe FROM DONGXE WHERE HangXe LIKE 'Toyota'

SELECT * FROM NHACUNGCAP AS NCC
JOIN DANGKYCUNGCAP AS DKCC ON NCC.MaNhaCC = DKCC.MaNhaCC
WHERE DKCC.DongXe IN (SELECT DONGXE.DongXe FROM DONGXE WHERE DONGXE.HangXe='Toyota') 
AND DKCC.MaMP IN (SELECT MUCPHI.MaMP FROM MUCPHI WHERE MUCPHI.DonGia=15000)

SELECT * FROM NHACUNGCAP AS NCC
JOIN DANGKYCUNGCAP AS DKCC ON NCC.MaNhaCC = DKCC.MaNhaCC
WHERE DKCC.DongXe IN (SELECT DONGXE.DongXe FROM DONGXE WHERE DONGXE.HangXe='Toyota') 
AND DKCC.MaMP IN (SELECT MUCPHI.MaMP FROM MUCPHI WHERE MUCPHI.DonGia=15000)

-- Câu 5: Liệt kê thông tin toàn bộ nhà cung cấp được sắp xếp tăng dần theo tên nhà cung cấp và giảm dần theo mã số thuế

select * from NHACUNGCAP AS NCC
ORDER BY TenNhaCC ASC , MaSoThue DESC

/* Câu 6: Đếm số lần đăng ký cung cấp phương tiện tương ứng cho từng nhà cung cấp 
với yêu cầu chỉ đếm cho những nhà cung cấp thực hiện đăng ký cung cấp có ngày  bắt đầu cung cấp là “20/11/2015” */

SELECT COUNT(NCC.MaNhaCC) AS SLDK, NCC.MaNhaCC  FROM NHACUNGCAP AS NCC JOIN DANGKYCUNGCAP AS DKCC 
ON NCC.MaNhaCC = DKCC.MaNhaCC AND DKCC.NgayBatDauCungCap ='2015/11/20'
GROUP BY NCC.MaNhaCC
HAVING COUNT (DKCC.MaNhaCC) >=0

SELECT NCC.MaNhaCC,  NCC.MaNhaCC  FROM NHACUNGCAP AS NCC ,DANGKYCUNGCAP AS DKCC
WHERE NCC.MaNhaCC = DKCC.MaNhaCC  AND DKCC.NgayBatDauCungCap ='2015/11/20'
GROUP BY NCC.MaNhaCC
HAVING COUNT (DKCC.MaNhaCC) >=0

/*Câu 7: Liệt kê tên của toàn bộ các hãng xe có trong cơ sở dữ liệu với yêu cầu mỗi hãng xe
chỉ được liệt kê một lần*/
select * FROM DANGKYCUNGCAP,NHACUNGCAP

/*Câu 8: Liệt kê MaDKCC, MaNhaCC, TenNhaCC, DiaChi, MaSoThue, TenLoaiDV, DonGia,
HangXe, NgayBatDauCC, NgayKetThucCC của tất cả các lần đăng ký cung cấp phương
tiện với yêu cầu những nhà cung cấp nào chưa từng thực hiện đăng ký cung cấp phương
tiện thì cũng liệt kê thông tin những nhà cung cấp đó ra*/

SELECT MaDKCC,DKCC.MaNhaCC,MaLoaiDV,DongXe,MaMP,NgayBatDauCungCap,NgayKetThucCungCap,SoLuongXeDangKy
FROM DANGKYCUNGCAP  AS DKCC 
FULL OUTER JOIN NHACUNGCAP AS NCC
ON DKCC.MaNhaCC = NCC.MaNhaCC 

SELECT * FROM DANGKYCUNGCAP AS DKCC JOIN NHACUNGCAP AS NCC
ON DKCC.MaNhaCC = NCC.MaNhaCC 

/*Câu 9: Liệt kê thông tin của các nhà cung cấp đã từng đăng ký cung cấp phương tiện
thuộc dòng xe “Hiace” hoặc từng đăng ký cung cấp phương tiện thuộc dòng xe “Cerato”*/

SELECT * FROM NHACUNGCAP AS NCC
RIGHT JOIN DANGKYCUNGCAP AS DKCC ON NCC.MaNhaCC = DKCC.MaNhaCC
WHERE DKCC.DongXe like 'Hiace' or DKCC.DongXe like 'Cerato'

SELECT * FROM NHACUNGCAP AS NCC
WHERE NCC.MaNhaCC IN 
(SELECT MaNhaCC FROM DANGKYCUNGCAP WHERE DongXe like 'Hiace' or DongXe like 'Cerato')

/*Câu 10: Liệt kê thông tin của các nhà cung cấp chưa từng thực hiện đăng ký cung cấp
phương tiện lần nào cả.*/

SELECT * FROM NHACUNGCAP AS NCC
WHERE NCC.MaNhaCC NOT IN (SELECT MaNhaCC FROM DANGKYCUNGCAP)


