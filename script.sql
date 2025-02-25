USE [master]
GO
/****** Object:  Database [CKDBMS]    Script Date: 1/26/2021 1:39:01 AM ******/
CREATE DATABASE [CKDBMS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CKDBMS', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CKDBMS.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CKDBMS_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\CKDBMS_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [CKDBMS] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CKDBMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CKDBMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CKDBMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CKDBMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CKDBMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CKDBMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [CKDBMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CKDBMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CKDBMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CKDBMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CKDBMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CKDBMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CKDBMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CKDBMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CKDBMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CKDBMS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CKDBMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CKDBMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CKDBMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CKDBMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CKDBMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CKDBMS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CKDBMS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CKDBMS] SET RECOVERY FULL 
GO
ALTER DATABASE [CKDBMS] SET  MULTI_USER 
GO
ALTER DATABASE [CKDBMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CKDBMS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CKDBMS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CKDBMS] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CKDBMS] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CKDBMS] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'CKDBMS', N'ON'
GO
ALTER DATABASE [CKDBMS] SET QUERY_STORE = OFF
GO
USE [CKDBMS]
GO
/****** Object:  User [thungan]    Script Date: 1/26/2021 1:39:02 AM ******/
CREATE USER [thungan] FOR LOGIN [thungan] WITH DEFAULT_SCHEMA=[thungan]
GO
/****** Object:  User [admin]    Script Date: 1/26/2021 1:39:02 AM ******/
CREATE USER [admin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[admin]
GO
/****** Object:  DatabaseRole [RoleThuNgan]    Script Date: 1/26/2021 1:39:02 AM ******/
CREATE ROLE [RoleThuNgan]
GO
ALTER ROLE [RoleThuNgan] ADD MEMBER [thungan]
GO
/****** Object:  Schema [admin]    Script Date: 1/26/2021 1:39:02 AM ******/
CREATE SCHEMA [admin]
GO
/****** Object:  Schema [RoleThuNgan]    Script Date: 1/26/2021 1:39:02 AM ******/
CREATE SCHEMA [RoleThuNgan]
GO
/****** Object:  Schema [thungan]    Script Date: 1/26/2021 1:39:02 AM ******/
CREATE SCHEMA [thungan]
GO
/****** Object:  UserDefinedFunction [dbo].[f_dangnhap]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   function [dbo].[f_dangnhap](@taikhoan int,@matkhau nvarchar(50),@loaitk nvarchar(50))
returns int
as
begin
	if @loaitk = N'admin'
		begin 
			if (select count(*) from Taikhoan where tentk = @taikhoan and matkhau = @matkhau and loaitk = @loaitk) =1
			return 1
		end
	else if @loaitk = N'TN'
		begin
			if (select count(*) from Taikhoan where tentk = @taikhoan and matkhau = @matkhau and loaitk = @loaitk) = 1
			return 1
		end

	return 0
end
GO
/****** Object:  UserDefinedFunction [dbo].[f_kiemtratrangthai]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   function [dbo].[f_kiemtratrangthai](@maphong char(5))
returns int
as
	begin 
		declare @trangthai char(1),
				@kq int

		select @trangthai = tinhtrang from Phong where @maphong = maphong

		if @trangthai = 'N'
			begin
				set @kq = 1
				return @kq
			end
		else if @trangthai = 'Y'
			begin
				set @kq = 0
				return @kq
			end
		return -1
	end
GO
/****** Object:  Table [dbo].[Taikhoan]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Taikhoan](
	[tentk] [int] NOT NULL,
	[matkhau] [nvarchar](50) NOT NULL,
	[loaitk] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__Taikhoan__7A217E16EA826D97] PRIMARY KEY CLUSTERED 
(
	[tentk] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Taikhoan_view]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [dbo].[Taikhoan_view] as
select tentk as N'Tên tài khoản', loaitk as N'Loại tài khoản'
from Taikhoan
GO
/****** Object:  Table [dbo].[Khachhang]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Khachhang](
	[maKh] [int] NOT NULL,
	[ho] [nvarchar](50) NOT NULL,
	[tenlot] [nvarchar](50) NOT NULL,
	[tenKh] [nvarchar](50) NOT NULL,
	[sdt] [varchar](50) NULL,
	[ngaysinh] [date] NULL,
	[loaiKh] [nvarchar](20) NOT NULL,
	[nguoiCapnhat] [int] NOT NULL,
 CONSTRAINT [PK__Khanghan__7A3ECF04A6B228D3] PRIMARY KEY CLUSTERED 
(
	[maKh] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Khachhang_View]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [dbo].[Khachhang_View] as
select maKh , ho , tenlot ,tenKh , ngaysinh , loaiKh 
from Khachhang
GO
/****** Object:  Table [dbo].[Thue]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Thue](
	[maThue] [int] NOT NULL,
	[maphong] [char](5) NOT NULL,
	[maKh] [int] NOT NULL,
	[ngaythue] [datetime] NOT NULL,
	[ngaytra] [datetime] NULL,
	[tinhtrang] [char](1) NULL,
	[tongiten] [money] NULL,
	[nguoiCapnhat] [int] NULL,
 CONSTRAINT [PK_Thue] PRIMARY KEY CLUSTERED 
(
	[maThue] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ThueTN_view]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   view [dbo].[ThueTN_view] as
select t.maphong , kh.ho+ ' '+ kh.tenlot +' ' +  kh.tenKh as HotenKH
			, t.ngaythue , t.ngaytra , t.tinhtrang , t.tongiten , t.maThue
from Thue t, Khachhang kh
where t.maKh = kh.maKh
GO
/****** Object:  Table [dbo].[Nhanvien]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Nhanvien](
	[manv] [int] NOT NULL,
	[ho] [nvarchar](50) NOT NULL,
	[tenlot] [nvarchar](50) NULL,
	[tennv] [nvarchar](50) NOT NULL,
	[ngaysinh] [date] NULL,
	[sdt] [varchar](50) NULL,
	[chucvu] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__Nhanvien__7A21B37D0E46FDBE] PRIMARY KEY CLUSTERED 
(
	[manv] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[ThueAd_view]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create   view [dbo].[ThueAd_view] as
select t.maphong , kh.ho+ ' '+ kh.tenlot +' ' +  kh.tenKh as HotenKH
			, t.ngaythue , t.ngaytra , t.tinhtrang , t.tongiten , nv.manv , nv.ho + ' ' + nv.tenlot +' '+nv.tennv as HotenNV, t.maThue
from Thue t, Khachhang kh, Nhanvien nv
where t.maKh = kh.maKh and nv.manv = t.nguoiCapnhat
GO
/****** Object:  Table [dbo].[Phong]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Phong](
	[stt] [int] NOT NULL,
	[maphong] [char](5) NOT NULL,
	[loaiphong] [nvarchar](20) NOT NULL,
	[capdo] [nvarchar](50) NOT NULL,
	[giaphong] [money] NOT NULL,
	[tinhtrang] [char](1) NULL,
 CONSTRAINT [PK__Phong__BBA25480C88249A5] PRIMARY KEY CLUSTERED 
(
	[maphong] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Khachhang] ([maKh], [ho], [tenlot], [tenKh], [sdt], [ngaysinh], [loaiKh], [nguoiCapnhat]) VALUES (1, N'Huỳnh', N'Phước', N'Thiện', N'0939203990', CAST(N'2000-01-01' AS Date), N'Thường', 1)
INSERT [dbo].[Khachhang] ([maKh], [ho], [tenlot], [tenKh], [sdt], [ngaysinh], [loaiKh], [nguoiCapnhat]) VALUES (2, N'Nguyễn', N'Thị Như', N'Ngọc', N'0903204900', CAST(N'2000-02-02' AS Date), N'Thường', 1)
INSERT [dbo].[Khachhang] ([maKh], [ho], [tenlot], [tenKh], [sdt], [ngaysinh], [loaiKh], [nguoiCapnhat]) VALUES (3, N'Vương', N'Hoàng', N'Hải', N'0940299999', CAST(N'2000-03-03' AS Date), N'VIP', 1)
INSERT [dbo].[Khachhang] ([maKh], [ho], [tenlot], [tenKh], [sdt], [ngaysinh], [loaiKh], [nguoiCapnhat]) VALUES (4, N'Đoàn', N'Nhật', N'Phong', N'092039029', CAST(N'2000-04-04' AS Date), N'Thường', 1)
INSERT [dbo].[Khachhang] ([maKh], [ho], [tenlot], [tenKh], [sdt], [ngaysinh], [loaiKh], [nguoiCapnhat]) VALUES (5, N'Nguyễn', N'Hoàng Gia', N'Bảo', N'0923992399', CAST(N'2000-05-05' AS Date), N'VIP', 1)
INSERT [dbo].[Khachhang] ([maKh], [ho], [tenlot], [tenKh], [sdt], [ngaysinh], [loaiKh], [nguoiCapnhat]) VALUES (7, N'Đỗ', N'Phạm Trúc', N'Quỳnh', N'0978978787', CAST(N'2000-02-28' AS Date), N'Thường', 1)
GO
INSERT [dbo].[Nhanvien] ([manv], [ho], [tenlot], [tennv], [ngaysinh], [sdt], [chucvu]) VALUES (1, N'Lê', N'Ngọc', N'Hải', CAST(N'2000-12-13' AS Date), N'0939209300', N'Quản lý')
INSERT [dbo].[Nhanvien] ([manv], [ho], [tenlot], [tennv], [ngaysinh], [sdt], [chucvu]) VALUES (2, N'Nguyễn', N'Ngọc Minh', N'Thư', CAST(N'2000-05-06' AS Date), N'0930299300', N'Thu ngân')
INSERT [dbo].[Nhanvien] ([manv], [ho], [tenlot], [tennv], [ngaysinh], [sdt], [chucvu]) VALUES (3, N'Cao', N'Thị Thùy', N'Linh', CAST(N'2000-04-07' AS Date), N'0930923990', N'Thu ngân')
GO
INSERT [dbo].[Phong] ([stt], [maphong], [loaiphong], [capdo], [giaphong], [tinhtrang]) VALUES (1, N'A101 ', N'Đơn', N'Thường', 400000.0000, N'N')
INSERT [dbo].[Phong] ([stt], [maphong], [loaiphong], [capdo], [giaphong], [tinhtrang]) VALUES (2, N'A102 ', N'Đơn', N'Thường', 400000.0000, N'N')
INSERT [dbo].[Phong] ([stt], [maphong], [loaiphong], [capdo], [giaphong], [tinhtrang]) VALUES (3, N'A103 ', N'Đơn', N'Thường', 400000.0000, N'Y')
INSERT [dbo].[Phong] ([stt], [maphong], [loaiphong], [capdo], [giaphong], [tinhtrang]) VALUES (4, N'A104 ', N'Đơn', N'Thường', 400000.0000, N'Y')
INSERT [dbo].[Phong] ([stt], [maphong], [loaiphong], [capdo], [giaphong], [tinhtrang]) VALUES (5, N'A105 ', N'Đơn', N'Thường', 400000.0000, N'Y')
INSERT [dbo].[Phong] ([stt], [maphong], [loaiphong], [capdo], [giaphong], [tinhtrang]) VALUES (6, N'A106 ', N'Đôi', N'Thường', 600000.0000, N'Y')
INSERT [dbo].[Phong] ([stt], [maphong], [loaiphong], [capdo], [giaphong], [tinhtrang]) VALUES (7, N'A107 ', N'Đôi', N'Thường', 600000.0000, N'Y')
INSERT [dbo].[Phong] ([stt], [maphong], [loaiphong], [capdo], [giaphong], [tinhtrang]) VALUES (8, N'A108 ', N'Đôi', N'Thường', 600000.0000, N'Y')
INSERT [dbo].[Phong] ([stt], [maphong], [loaiphong], [capdo], [giaphong], [tinhtrang]) VALUES (9, N'A109 ', N'Đôi', N'Thường', 600000.0000, N'Y')
INSERT [dbo].[Phong] ([stt], [maphong], [loaiphong], [capdo], [giaphong], [tinhtrang]) VALUES (10, N'A110 ', N'Đôi', N'Thường', 600000.0000, N'Y')
INSERT [dbo].[Phong] ([stt], [maphong], [loaiphong], [capdo], [giaphong], [tinhtrang]) VALUES (11, N'A201 ', N'Đôi', N'VIP', 800000.0000, N'N')
INSERT [dbo].[Phong] ([stt], [maphong], [loaiphong], [capdo], [giaphong], [tinhtrang]) VALUES (12, N'A202 ', N'Đôi', N'VIP', 800000.0000, N'Y')
INSERT [dbo].[Phong] ([stt], [maphong], [loaiphong], [capdo], [giaphong], [tinhtrang]) VALUES (13, N'A203 ', N'Đôi', N'VIP', 800000.0000, N'Y')
INSERT [dbo].[Phong] ([stt], [maphong], [loaiphong], [capdo], [giaphong], [tinhtrang]) VALUES (14, N'A204 ', N'Đôi', N'VIP', 800000.0000, N'Y')
INSERT [dbo].[Phong] ([stt], [maphong], [loaiphong], [capdo], [giaphong], [tinhtrang]) VALUES (15, N'A205 ', N'Đôi', N'VIP', 800000.0000, N'Y')
INSERT [dbo].[Phong] ([stt], [maphong], [loaiphong], [capdo], [giaphong], [tinhtrang]) VALUES (16, N'A206 ', N'Đơn', N'VIP', 600000.0000, N'N')
INSERT [dbo].[Phong] ([stt], [maphong], [loaiphong], [capdo], [giaphong], [tinhtrang]) VALUES (17, N'A207 ', N'Đơn', N'VIP', 600000.0000, N'Y')
INSERT [dbo].[Phong] ([stt], [maphong], [loaiphong], [capdo], [giaphong], [tinhtrang]) VALUES (18, N'A208 ', N'Đơn', N'VIP', 600000.0000, N'Y')
INSERT [dbo].[Phong] ([stt], [maphong], [loaiphong], [capdo], [giaphong], [tinhtrang]) VALUES (19, N'A209 ', N'Đơn', N'VIP', 600000.0000, N'Y')
INSERT [dbo].[Phong] ([stt], [maphong], [loaiphong], [capdo], [giaphong], [tinhtrang]) VALUES (20, N'A210 ', N'Đơn', N'VIP', 600000.0000, N'Y')
GO
INSERT [dbo].[Taikhoan] ([tentk], [matkhau], [loaitk]) VALUES (1, N'0000', N'admin')
INSERT [dbo].[Taikhoan] ([tentk], [matkhau], [loaitk]) VALUES (2, N'1111', N'TN')
INSERT [dbo].[Taikhoan] ([tentk], [matkhau], [loaitk]) VALUES (3, N'1111', N'TN')
GO
INSERT [dbo].[Thue] ([maThue], [maphong], [maKh], [ngaythue], [ngaytra], [tinhtrang], [tongiten], [nguoiCapnhat]) VALUES (1, N'A101 ', 1, CAST(N'2021-01-09T00:00:00.000' AS DateTime), NULL, N'N', NULL, 1)
INSERT [dbo].[Thue] ([maThue], [maphong], [maKh], [ngaythue], [ngaytra], [tinhtrang], [tongiten], [nguoiCapnhat]) VALUES (2, N'A102 ', 2, CAST(N'2021-01-15T00:00:00.000' AS DateTime), NULL, N'N', NULL, 2)
INSERT [dbo].[Thue] ([maThue], [maphong], [maKh], [ngaythue], [ngaytra], [tinhtrang], [tongiten], [nguoiCapnhat]) VALUES (3, N'A206 ', 4, CAST(N'2021-01-07T00:00:00.000' AS DateTime), NULL, N'N', NULL, 3)
INSERT [dbo].[Thue] ([maThue], [maphong], [maKh], [ngaythue], [ngaytra], [tinhtrang], [tongiten], [nguoiCapnhat]) VALUES (4, N'A201 ', 3, CAST(N'2021-01-05T00:00:00.000' AS DateTime), NULL, N'N', NULL, 1)
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [index_phong_tinhtrang]    Script Date: 1/26/2021 1:39:02 AM ******/
CREATE NONCLUSTERED INDEX [index_phong_tinhtrang] ON [dbo].[Phong]
(
	[tinhtrang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [index_thue_tinhtrang]    Script Date: 1/26/2021 1:39:02 AM ******/
CREATE NONCLUSTERED INDEX [index_thue_tinhtrang] ON [dbo].[Thue]
(
	[tinhtrang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Khachhang]  WITH CHECK ADD  CONSTRAINT [FK_Khachhang_Nhanvien] FOREIGN KEY([nguoiCapnhat])
REFERENCES [dbo].[Nhanvien] ([manv])
GO
ALTER TABLE [dbo].[Khachhang] CHECK CONSTRAINT [FK_Khachhang_Nhanvien]
GO
ALTER TABLE [dbo].[Taikhoan]  WITH CHECK ADD  CONSTRAINT [FK_Taikhoan_Nhanvien] FOREIGN KEY([tentk])
REFERENCES [dbo].[Nhanvien] ([manv])
GO
ALTER TABLE [dbo].[Taikhoan] CHECK CONSTRAINT [FK_Taikhoan_Nhanvien]
GO
ALTER TABLE [dbo].[Thue]  WITH CHECK ADD  CONSTRAINT [FK_Thue_Khanghang] FOREIGN KEY([maKh])
REFERENCES [dbo].[Khachhang] ([maKh])
GO
ALTER TABLE [dbo].[Thue] CHECK CONSTRAINT [FK_Thue_Khanghang]
GO
ALTER TABLE [dbo].[Thue]  WITH CHECK ADD  CONSTRAINT [FK_Thue_Nhanvien] FOREIGN KEY([nguoiCapnhat])
REFERENCES [dbo].[Nhanvien] ([manv])
GO
ALTER TABLE [dbo].[Thue] CHECK CONSTRAINT [FK_Thue_Nhanvien]
GO
ALTER TABLE [dbo].[Thue]  WITH CHECK ADD  CONSTRAINT [FK_Thue_Phong] FOREIGN KEY([maphong])
REFERENCES [dbo].[Phong] ([maphong])
GO
ALTER TABLE [dbo].[Thue] CHECK CONSTRAINT [FK_Thue_Phong]
GO
/****** Object:  StoredProcedure [dbo].[sp_chonKh]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[sp_chonKh]
	@makh int
as
begin tran
	select * from Khachhang where maKh = @makh
commit tran
GO
/****** Object:  StoredProcedure [dbo].[sp_chonnv]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[sp_chonnv]
	@manv int
as
begin
	select * from Nhanvien where @manv = manv
end	
GO
/****** Object:  StoredProcedure [dbo].[sp_chonphong]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[sp_chonphong]
	@maphong char(5)
as
begin
	select * from Phong where maphong = @maphong
end
GO
/****** Object:  StoredProcedure [dbo].[sp_datphong]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[sp_datphong]
	@maphong char(10),
	@makh int,
	@mancc int
as
begin tran
	begin try
		if @maphong = '' or @makh = '' or @mancc = '' 
			begin
				rollback tran
				return
			end
	end try
	begin catch
		begin
			rollback tran
			return
		end
	end catch
	declare @mathue int
	set @mathue = 1
	while exists(select * from Thue where maThue = @mathue)
	set @mathue = @mathue + 1

	insert into Thue values (@mathue,@maphong, @makh, getdate(),null,'N','',@maNcc)

commit tran
GO
/****** Object:  StoredProcedure [dbo].[sp_loadDSKH]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[sp_loadDSKH]
@tukhoa nvarchar(50),
@loaitk nvarchar(50)
as
begin tran
	begin try
		if not exists (select * from Khachhang)
		begin 
			rollback tran
			return
		end
	end try

	begin catch
		rollback tran
		return
	end catch
	if @loaitk = 'Admin'
		select maKh as N'Mã khách hàng', ho +' '+ tenlot +' '+ tenKh as N'Họ và tên', ngaysinh as N'Ngày sinh', loaiKh as N'Cấp độ', nguoiCapnhat as N'Mã người cập nhật'
		from Khachhang 
		where lower(ho) like '%'+lower(@tukhoa)+'%'
		or lower(tenlot) like '%' + lower(@tukhoa) + '%'
		or lower(tenKh) like '%' + lower(@tukhoa) + '%'
		or lower(loaiKh) like '%' + lower(@tukhoa) + '%'
	else if @loaitk = 'TN'
		select *
		from Khachhang_view
		where lower(ho) like '%'+lower(@tukhoa)+'%'
		or lower(tenlot) like '%' + lower(@tukhoa) + '%'
		or lower(tenKh) like '%' + lower(@tukhoa) + '%'
		or lower(loaiKh) like '%' + lower(@tukhoa) + '%'
commit tran
GO
/****** Object:  StoredProcedure [dbo].[sp_loadDSP]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[sp_loadDSP]
	@tinhtrang char(1)
as
begin
	if @tinhtrang = 'A'
	select stt as N'Số thứ tự', maphong as N'Mã phòng', loaiphong as N'Loại phòng',
				capdo as N'Cấp độ', giaphong as N'Giá phòng (VNĐ)', tinhtrang as N'Tình trạng'
	from Phong order by stt
	else
	select stt as N'Số thứ tự', maphong as N'Mã phòng', loaiphong as N'Loại phòng',
				capdo as N'Cấp độ', giaphong as N'Giá phòng (VNĐ)', tinhtrang as N'Tình trạng' 
	from Phong
	where tinhtrang like '%' + @tinhtrang  + '%' order by stt
end
GO
/****** Object:  StoredProcedure [dbo].[sp_loadDSTP]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[sp_loadDSTP]
	@tukhoa nvarchar(50),
	@loaitk nvarchar(50),
	@trangthai char(1)
as
begin 
	if @loaitk = 'TN'
		begin
			if @trangthai = 'A'
				select maphong as N'Mã phòng', HotenKH as N'Họ tên KH', ngaythue as N'Ngày thuê', ngaytra as N'Ngày trả',
								tinhtrang as N'Trạng thái', tongiten as N'Tổng tiền', maThue as N'Mã số thuê'
				from ThueTN_view where lower(HotenKH) like '%'+lower(@tukhoa)+'%'
			else if @trangthai = 'N'
				select maphong as N'Mã phòng', HotenKH as N'Họ tên KH', ngaythue as N'Ngày thuê', ngaytra as N'Ngày trả',
								tinhtrang as N'Trạng thái', tongiten as N'Tổng tiền' , maThue as N'Mã số thuê'
				from ThueTN_view where lower(HotenKH) like '%'+lower(@tukhoa)+'%'
												and tinhtrang = 'N'
			else if @trangthai = 'Y'
				select maphong as N'Mã phòng', HotenKH as N'Họ tên KH', ngaythue as N'Ngày thuê', ngaytra as N'Ngày trả',
								tinhtrang as N'Trạng thái', tongiten as N'Tổng tiền' , maThue as N'Mã số thuê'
				from ThueTN_view where lower(HotenKH) like '%'+lower(@tukhoa)+'%' and tinhtrang = 'Y'
		end
	else if @loaitk = 'admin'
		begin
			if @trangthai = 'A'
				select maphong as N'Mã phòng', HotenKH as N'Họ tên KH', ngaythue as N'Ngày thuê', ngaytra as N'Ngày trả',
								tinhtrang as N'Trạng thái', tongiten as N'Tổng tiền', manv as N'Mã nhân viên', HotenNV as N'Họ tên NV', maThue as N'Mã số thuê'
				from ThueAd_view where lower(HotenKH) like '%'+lower(@tukhoa)+'%'
												or lower(HotenNV) like '%' + lower(@tukhoa) + '%'
			else if @trangthai = 'N'
				select maphong as N'Mã phòng', HotenKH as N'Họ tên KH', ngaythue as N'Ngày thuê', ngaytra as N'Ngày trả',
								tinhtrang as N'Trạng thái', tongiten as N'Tổng tiền', manv as N'Mã nhân viên', HotenNV as N'Họ tên NV', maThue as N'Mã số thuê'
				from ThueAd_view where tinhtrang = 'N' and (lower(HotenKH) like '%'+lower(@tukhoa)+'%'
												or lower(HotenNV) like '%' + lower(@tukhoa) + '%')
												
			else if @trangthai = 'Y'
				select maphong as N'Mã phòng', HotenKH as N'Họ tên KH', ngaythue as N'Ngày thuê', ngaytra as N'Ngày trả',
								tinhtrang as N'Trạng thái', tongiten as N'Tổng tiền', manv as N'Mã nhân viên', HotenNV as N'Họ tên NV', maThue as N'Mã số thuê'
				from ThueAd_view where tinhtrang = 'Y'  and (lower(HotenKH) like '%'+lower(@tukhoa)+'%'
												or lower(HotenNV) like '%' + lower(@tukhoa) + '%')
		end
end
GO
/****** Object:  StoredProcedure [dbo].[sp_loadnv]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[sp_loadnv]
	@tukhoa nvarchar(50)
as
begin tran
	begin try
		if not exists (select * from Nhanvien)
		begin 
			print N'Không tồn tại nhân viên'
			rollback tran
			return
		end
	end try

	begin catch
		rollback tran
		return
	end catch

	select manv as N'Mã nhân viên', ho +' '+ tenlot +' '+ tennv as N'Họ và tên',ngaysinh as N'Ngày sinh' , sdt as N'Số điện thoại', chucvu as N'Chức vụ'
	from Nhanvien
	where lower(ho) like '%'+lower(@tukhoa)+'%'
	or lower(tenlot) like '%' + lower(@tukhoa) + '%'
	or lower(tennv) like '%' + lower(@tukhoa) + '%'
	or lower(chucvu) like '%' + lower(@tukhoa) + '%'
commit tran
GO
/****** Object:  StoredProcedure [dbo].[sp_loainv]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[sp_loainv]
as
begin
	select distinct chucvu from Nhanvien
end
GO
/****** Object:  StoredProcedure [dbo].[sp_selectLoaikh]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[sp_selectLoaikh]
as
begin tran
	select distinct loaiKh from Khachhang
commit tran
GO
/****** Object:  StoredProcedure [dbo].[sp_suakh]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[sp_suakh]
	@makh int,
	@ho nvarchar(50),
	@tenlot nvarchar(50),
	@tenkh nvarchar(50),
	@sdt varchar(50),
	@ngaysinh date,
	@loaiKh nvarchar(20),
	@mancn int
as
begin tran
	update Khachhang
	set ho = @ho, tenlot = @tenlot, tenKh = @tenkh, @sdt =sdt , ngaysinh = @ngaysinh, loaiKh = @loaiKh, nguoiCapnhat = @mancn
	where @makh = maKh
commit tran
GO
/****** Object:  StoredProcedure [dbo].[sp_suanv]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[sp_suanv]
	@manv int,
	@ho nvarchar(50),
	@tenlot nvarchar(50),
	@ten nvarchar(50),
	@ngaysinh date,
	@sdt varchar(50),
	@chucvu nvarchar(50)
as
begin tran
	begin try
		if @ho = '' or @tenlot = '' or @ten = '' or @sdt = '' or (@chucvu != N'Thu ngân' and @chucvu != N'Quản lý')
		begin
			rollback tran
			return
		end
	end try
	begin catch
		rollback tran
		return
	end catch

	update Nhanvien 
	set ho = @ho, tenlot = @tenlot, tennv = @ten, sdt = @sdt, ngaysinh = @ngaysinh, chucvu = @chucvu
	where manv = @manv
commit tran
GO
/****** Object:  StoredProcedure [dbo].[sp_suaphong]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[sp_suaphong]
	@maphong char(5),
	@loaiphong nvarchar(20),	
	@capdo nvarchar(50),
	@giaphong money,
	@tinhtrang char(1)
as
begin tran
	begin try
		if @maphong = '' or @loaiphong = '' or @giaphong = '' or @capdo = '' or (@tinhtrang != 'Y' and @tinhtrang != 'N' )
		begin 
			rollback tran
			return
		end
	end try

	begin catch
		rollback tran
			return
	end catch
	
	update Phong
	set capdo = @capdo, loaiphong = @loaiphong, giaphong = @giaphong,tinhtrang= @tinhtrang
	where maphong = @maphong

commit tran
GO
/****** Object:  StoredProcedure [dbo].[sp_themkh]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[sp_themkh]
	@ho nvarchar(50),
	@tenlot nvarchar(50),
	@tenkh nvarchar(50),
	@sdt varchar(50),
	@ngaysinh date,
	@mancn int
as
begin tran
	begin try
		if @ho = '' or @tenkh = '' or @tenlot = '' or @sdt = ''
		begin
			print N'Không được bỏ trống'
			rollback tran
			return
		end
	end try
	begin catch
		print N'Lỗi nha'
		return
	end catch
	declare @makh int

	set @makh = 1
	while exists (select * from Khachhang where maKh = @makh)
	set @makh = @makh + 1

	insert into Khachhang values (@makh, @ho, @tenlot,@tenkh,@sdt,@ngaysinh,N'Thường',@mancn)
commit tran
GO
/****** Object:  StoredProcedure [dbo].[sp_themnv]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[sp_themnv]
	@ho nvarchar(50),
	@tenlot nvarchar(50),
	@ten nvarchar(50),
	@ngaysinh date,
	@sdt varchar(50),
	@chucvu nvarchar(50)
as
begin tran
	begin try
		if @ho = '' or @tenlot = '' or @ten = '' or @sdt = '' or (@chucvu != N'Thu ngân' and @chucvu != N'Quản lý')
		begin
			rollback tran
			return
		end
	end try
	begin catch
		rollback tran
		return
	end catch

	declare @manv int

	set @manv = 1
	while exists(select * from Nhanvien where @manv = manv)
	set @manv = @manv + 1

	insert into Nhanvien values (@manv,@ho,@tenlot,@ten,@ngaysinh,@sdt,@chucvu)
commit tran
GO
/****** Object:  StoredProcedure [dbo].[sp_themphong]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[sp_themphong]
	@maphong char(5),
	@loaiphong nvarchar(20),	
	@capdo nvarchar(50),
	@giaphong money,
	@tinhtrang char(1)
as
begin tran
	begin try
		if @maphong = '' or @loaiphong = '' or @giaphong = '' or @capdo = '' or (@tinhtrang != 'Y' and @tinhtrang != 'N' )
		begin 
			rollback tran
			return
		end
	end try

	begin catch
		rollback tran
			return
	end catch
	
	declare @stt int
	set @stt = 1
	while exists (select * from Phong where @stt = stt)
		set @stt = @stt + 1

	insert into Phong values(@stt,@maphong,@loaiphong,@capdo,@giaphong,@tinhtrang)
commit tran
GO
/****** Object:  StoredProcedure [dbo].[sp_thongtincn]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[sp_thongtincn]
	@tentk int
as
begin tran
	select nv.ho + ' '+nv.tenlot+' '+ nv.tennv as N'hovaten' , nv.ngaysinh,nv.sdt,nv.chucvu  
	from Nhanvien nv where @tentk = nv.manv
commit tran
GO
/****** Object:  StoredProcedure [dbo].[sp_traphong]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[sp_traphong]
	@maphong char(5),
	@maThue int,
	@mancc int
as
begin tran
	
	declare @songay int,
		@tien money,
		@ngaythue date

	select @tien = giaphong from Phong where maphong =@maphong
	select @ngaythue = ngaythue from Thue where @maThue = maThue
	set @songay = datediff(day,@ngaythue,getdate())

	update Thue
	set tinhtrang = 'Y', ngaytra = getdate(), tongiten = @songay * @tien, nguoiCapnhat =@mancc
	where @maThue = maThue

	update Phong
	set tinhtrang = 'Y'
	where @maphong = maphong
	
commit tran
GO
/****** Object:  StoredProcedure [dbo].[sp_xoakh]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[sp_xoakh]
	@makh int
as
begin tran
	delete from Khachhang where @makh = maKh
commit tran
GO
/****** Object:  StoredProcedure [dbo].[sp_xoanv]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[sp_xoanv]
	@manv int
as
begin tran
	delete from Taikhoan where tentk = @manv
	delete from Nhanvien where @manv = manv
commit tran
GO
/****** Object:  StoredProcedure [dbo].[sp_xoaphong]    Script Date: 1/26/2021 1:39:02 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   proc [dbo].[sp_xoaphong]
	@maphong char(5)
as 
begin tran
	delete from Phong where maphong = @maphong
commit tran
GO
USE [master]
GO
ALTER DATABASE [CKDBMS] SET  READ_WRITE 
GO
