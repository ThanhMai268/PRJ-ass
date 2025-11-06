USE ShoeShopDB;
GO

INSERT INTO Account (Email, Password, Role) VALUES
('admin', 'admin123', '1'),
('a@gmail.com', '123', '2'),
('b@gmail.com', '123', '2'),
('c@gmail.com', '123', '2');
GO

INSERT INTO Customer (CustomerName, PhoneNumber, AccountID, Address) VALUES
(N'Nguyen Van A', '0901111111', 2, N'District 1, HCMC'),
(N'Tran Thi B', '0902222222', 3, N'District 3, HCMC'),
(N'Le Van C', '0903333333', 4, N'District 5, HCMC');
GO

INSERT INTO Size (SizeValue) VALUES (38),(39),(40),(41),(42),(43);
GO

INSERT INTO Color (ColorName) VALUES
(N'Black'),(N'White'),(N'Blue'),(N'Red'),(N'Gray');
GO

INSERT INTO Product (ProductName, Image, Price, Category, Brand) VALUES
(N'Adidas Ultraboost', 'adidas1.jpg', 3500000, N'Sport Shoes', N'Adidas'),
(N'Adidas Superstar', 'adidas2.jpg', 2800000, N'Sport Shoes', N'Adidas'),
(N'Nike Air Force 1', 'nike1.jpg', 3200000, N'Running Shoes', N'Nike'),
(N'Nike Air Max', 'nike2.jpg', 4000000, N'Running Shoes', N'Nike'),
(N'Converse Chuck Taylor', 'con1.jpg', 1800000, N'Sneakers', N'Converse'),
(N'Converse Run Star Hike', 'con2.jpg', 2500000, N'Sneakers', N'Converse'),
(N'Bitis Hunter X', 'bitis1.jpg', 1200000, N'Sandals', N'Bitis'),
(N'Bitis Hunter Street', 'bitis2.jpg', 1100000, N'Sandals', N'Bitis'),
(N'Puma RS-X', 'puma1.jpg', 2700000, N'Training Shoes', N'Puma'),
(N'Puma Cali', 'puma2.jpg', 2400000, N'Training Shoes', N'Puma'),
(N'Nike Jordan 1', 'nike3.jpg', 5000000, N'Running Shoes', N'Nike'),
(N'Nike Dunk Low', 'nike4.jpg', 3800000, N'Running Shoes', N'Nike'),
(N'Adidas Forum Low', 'adidas3.jpg', 3100000,N'Sport Shoes', N'Adidas'),
(N'Adidas Samba', 'adidas4.jpg', 2900000, N'Sport Shoes', N'Adidas'),
(N'Converse One Star', 'con3.jpg', 2000000, N'Sneakers', N'Converse'),
(N'Bitis Hunter Core', 'bitis3.jpg', 950000, N'Sandals', N'Bitis'),
(N'Puma Suede Classic', 'puma3.jpg', 2200000, N'Training Shoes', N'Puma'),
(N'Puma Future Rider', 'puma4.jpg', 2300000, N'Training Shoes', N'Puma'),
(N'Adidas NMD R1', 'adidas5.jpg', 3600000,N'Sport Shoes', N'Adidas'),
(N'Nike ZoomX', 'nike5.jpg', 4200000, N'Running Shoes', N'Nike');
GO

WITH AllProductIDs AS (
    SELECT ProductID FROM Product
),
AllColorIDs AS (
    SELECT ColorID FROM Color
),
AllSizeIDs AS (
    SELECT SizeID FROM Size
)
INSERT INTO ProductDetail (ProductID, ColorID, SizeID, Quantity)
SELECT
    P.ProductID,
    C.ColorID,
    S.SizeID,
    20 -- Quantity co dinh cho all san pham
FROM
    AllProductIDs P
CROSS JOIN
    AllColorIDs C
CROSS JOIN
    AllSizeIDs S;
GO

INSERT INTO [Order] (CustomerID, Status) VALUES
(1, 0),
(2, 1),
(3, 2),
(1, 1),
(2, 0),
(3, 1),
(1, 2),
(2, 0),
(3, 0),
(1, 1),
(2, 2),
(3, 1),
(1, 0),
(2, 1),
(3, 2);
GO

INSERT INTO OrderDetail (OrderID, ProductDetailID, Quantity, Price) VALUES
(4, 10, 1, 4000000),
(5, 16, 2, 2500000),
(6, 1, 1, 3500000),
(6, 3, 1, 3500000),
(7, 31, 1, 5000000),
(7, 32, 1, 5000000),
(7, 4, 1, 2800000),
(8, 19, 1, 1200000),
(9, 22, 1, 1100000),
(9, 25, 1, 2700000),
(10, 37, 1, 3100000),
(10, 40, 1, 2900000),
(10, 43, 1, 2000000),
(10, 46, 1, 950000),
(11, 55, 1, 3600000),
(12, 58, 1, 4200000),
(12, 13, 1, 1800000),
(13, 5, 1, 2800000),
(13, 49, 1, 2200000),
(14, 52, 1, 2300000),
(14, 1, 1, 3500000),
(14, 7, 2, 3200000),
(14, 11, 1, 4000000),
(14, 14, 1, 1800000),
(15, 20, 1, 1200000),
(15, 33, 1, 5000000),
(15, 38, 1, 3100000),
(15, 59, 1, 4200000);
GO