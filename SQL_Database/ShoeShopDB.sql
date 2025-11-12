USE master;
GO
ALTER DATABASE ShoeShopDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE IF EXISTS ShoeShopDB;
GO

CREATE DATABASE ShoeShopDB;
GO
USE ShoeShopDB;
GO

-- 5 Account
CREATE TABLE Account (
    AccountID INT IDENTITY(1,1) PRIMARY KEY,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    Password NVARCHAR(50) NOT NULL,
    Role INT NOT NULL,
	-- không xóa tài khoản nên cần status quản lý cấp quyền truy cập
	-- 0: Chặn đăng nhập; 1: cho phép đăng nhập
	Status int default 1 not null
);
GO

-- 6 Customer
CREATE TABLE Customer (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName NVARCHAR(100) NOT NULL,
    PhoneNumber NVARCHAR(15) NOT NULL,
    AccountID INT FOREIGN KEY REFERENCES Account(AccountID) not null, 
    Address NVARCHAR(200) NOT NULL
);
GO

-- 1 Size
CREATE TABLE Size (
    SizeID INT IDENTITY(1,1) PRIMARY KEY,
    SizeValue INT NOT NULL
);
GO

-- 2 Color
CREATE TABLE Color (
    ColorID INT IDENTITY(1,1) PRIMARY KEY,
    ColorName NVARCHAR(30) NOT NULL,
    Status INT DEFAULT 1
);
GO

-- 3 Product
CREATE TABLE Product (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
	-- Image không cần not null tránh lỗi
    Image NVARCHAR(255) ,
    Price DECIMAL(10,2) NOT NULL,
    Category NVARCHAR(255) NOT NULL,
    Brand NVARCHAR(255) NOT NULL,
    Status INT DEFAULT 1
);
GO

-- 4 ProductDetail
CREATE TABLE ProductDetail (
    ProductDetailID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT FOREIGN KEY REFERENCES Product(ProductID) not null,
    ColorID INT FOREIGN KEY REFERENCES Color(ColorID) not null,
    SizeID INT FOREIGN KEY REFERENCES Size(SizeID) not null,
    Quantity INT CHECK (Quantity >= 0) NOT NULL,
    Status INT DEFAULT 1 not null,
    CONSTRAINT UQ_Product_Color_Size UNIQUE(ProductID, ColorID, SizeID)
);
GO

-- 7 Order + OrderDetail
CREATE TABLE [Order] (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    OrderDate DATETIME DEFAULT GETDATE() NOT NULL,
    CustomerID INT FOREIGN KEY REFERENCES Customer(CustomerID),
    Status INT DEFAULT 0
);
GO

CREATE TABLE OrderDetail (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES [Order](OrderID),
    ProductDetailID INT FOREIGN KEY REFERENCES ProductDetail(ProductDetailID),
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL
);
GO

-- Câu lệnh select toàn bộ DB
-- EXEC sp_MSforeachtable 'SELECT * FROM ?'; 