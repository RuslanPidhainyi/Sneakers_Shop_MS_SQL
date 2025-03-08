-- Delete DB
USE master;                      
GO
IF DB_ID(N'Sneakers_shop') IS NOT NULL
    DROP DATABASE [Sneakers_shop];

-- Create DB
CREATE DATABASE [Sneakers_shop]             
COLLATE Polish_100_CI_AS; 
GO

-- Database check
IF DB_ID(N'Sneakers_shop') IS NOT NULL      
    SELECT 'DB Sneakers_shop exists' AS [DatabaseCheck];

-- Switch to created database
USE [Sneakers_shop];

-- Create tables 
CREATE TABLE [dbo].[Clients](
    [ClientID] INT PRIMARY KEY IDENTITY,
    [Surname] NVARCHAR(20) NOT NULL,
    [FirstName] NVARCHAR(20) NOT NULL,
    [Phone] NVARCHAR(24) NOT NULL,
    [Email] NVARCHAR(50) NULL,
    [Address] NVARCHAR(60) NULL,
    [City] NVARCHAR(15) NULL,
    [Region] NVARCHAR(15) NULL,
    [PostalCode] NVARCHAR(15) NULL,
    [Country] NVARCHAR(15) NULL
);

CREATE TABLE [dbo].[Earnings](
    [EarningID] INT PRIMARY KEY IDENTITY,
    [Salary] MONEY NOT NULL
);

CREATE TABLE [dbo].[Positions] (
	[PositionID] INT PRIMARY KEY IDENTITY,
	[NamePosition] NVARCHAR(100) NULL
);

CREATE TABLE [dbo].[Employees](
    [EmployeeID] INT PRIMARY KEY IDENTITY,
    [Surname] NVARCHAR(20) NOT NULL,
    [FirstName] NVARCHAR(20) NOT NULL,
    [DateOfBirth] DATE NOT NULL,
    [Pesel] CHAR(11) NULL,
    [Phone] NVARCHAR(24) NOT NULL,
    [Email] NVARCHAR(50) NULL,
    [EarningID] INT NOT NULL FOREIGN KEY REFERENCES [Earnings](EarningID) ON DELETE CASCADE,
	[PositionID] INT NOT NULL FOREIGN KEY REFERENCES [Positions](PositionID) ON DELETE CASCADE
);

CREATE TABLE [dbo].[CategoriesShoes](
    [CategoryID] INT PRIMARY KEY IDENTITY,
    [NameCategory] NVARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE [dbo].[Gender] (
	[GenderID] INT PRIMARY KEY IDENTITY,
	[NameGender] NVARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE [dbo].[SizeForWomen](
    [SizeID] INT PRIMARY KEY IDENTITY,
    [EU] DECIMAL(8, 2) NOT NULL,
    [UK] DECIMAL(8, 2) NOT NULL,
    [US] DECIMAL(8, 2) NOT NULL,
	[cm] DECIMAL(8, 2) NOT NULL
);

CREATE TABLE [dbo].[SizeForMen](
    [SizeID] INT PRIMARY KEY IDENTITY,
    [EU] DECIMAL(8, 2) NOT NULL,
    [UK] DECIMAL(8, 2) NOT NULL,
    [US] DECIMAL(8, 2) NOT NULL,
	[cm] DECIMAL(8, 2) NOT NULL
);

CREATE TABLE [dbo].[Colours](
    [ColourID] INT PRIMARY KEY IDENTITY,
    [ColourName] NVARCHAR(50) NOT NULL
);

CREATE TABLE [dbo].[Shoes](
    [ShoesID] INT PRIMARY KEY IDENTITY,
    [BrandName] NVARCHAR(100) NOT NULL,
    [Model] NVARCHAR(100) NOT NULL,
    [Collaboration] NVARCHAR(100) NULL,
	--[Gender] NVARCHAR(10) NOT NULL,
	[GenderID] INT NOT NULL FOREIGN KEY REFERENCES [Gender](GenderID) ON DELETE CASCADE,
    [CategoryID] INT NOT NULL FOREIGN KEY REFERENCES [CategoriesShoes](CategoryID) ON DELETE CASCADE,
    [ColourID] INT NOT NULL FOREIGN KEY REFERENCES [Colours](ColourID) ON DELETE CASCADE,
    [SizeWID] INT NOT NULL FOREIGN KEY REFERENCES [SizeForWomen](SizeID) ON DELETE CASCADE,
	[SizeMID] INT NOT NULL FOREIGN KEY REFERENCES [SizeForMen](SizeID) ON DELETE CASCADE,
);

CREATE TABLE [dbo].[SalesDates](
    [SalesDateID] INT PRIMARY KEY IDENTITY,
    [OrderDate] DATE NOT NULL,
    [DeliveryDate] DATE NOT NULL,
    [SaleDate] DATE NOT NULL
);

CREATE TABLE [dbo].[Solds](
    [SoldID] INT PRIMARY KEY IDENTITY,
    [EmployeeID] INT NOT NULL FOREIGN KEY REFERENCES [Employees](EmployeeID) ON DELETE CASCADE,
    [ClientID] INT NOT NULL FOREIGN KEY REFERENCES [Clients](ClientID) ON DELETE CASCADE,
    [ShoesID] INT NOT NULL FOREIGN KEY REFERENCES [Shoes](ShoesID) ON DELETE CASCADE,
    [SalesDateID] INT NOT NULL FOREIGN KEY REFERENCES [SalesDates](SalesDateID) ON DELETE CASCADE,
);

CREATE TABLE [dbo].[Prices](
    [PriceID] INT PRIMARY KEY IDENTITY,        
    [ShoesID] INT NOT NULL,                      
    [BasePrice] MONEY NOT NULL,                  
    [DiscountPrice] MONEY NULL,                  
    [StartDate] DATE NOT NULL DEFAULT GETDATE(), 
    [EndDate] DATE NULL,                         
    FOREIGN KEY (ShoesID) REFERENCES [dbo].[Shoes](ShoesID) ON DELETE CASCADE
);

-- select * from Clients
INSERT INTO [dbo].[Clients] (Surname, FirstName, Phone, Email, Address, City, Region, PostalCode, Country)
VALUES
    ('Austin', 'Brian', '934-344-6815x9740', 'santiagoryan@hotmail.com', '20143 Michael Locks', 'East Tanya', 'Wyoming', '30959', 'Singapore'),
    ('Williams', 'Marcus', '6410994240', 'uthompson@reilly.com', '6948 Johnson Knoll', 'North Kayla', 'Virginia', '51109', NULL),
    ('Fox', 'Dillon', '947.799.6811', 'thomas34@hotmail.com', '7198 Anthony Course Apt. 433', 'East Andrew', 'Oregon', '11818', 'Austria'),
    ('Nguyen', 'Jennifer', '+1-760-064-9407x47302', 'lesliewilliams@kim.net', '6908 Kimberly Hollow Apt. 192', 'Chelseyberg', 'Hawaii', '12924', 'Cyprus'),
    ('Mueller', 'Mary', '(743)540-0052x294', 'gthomas@bennett.org', '01317 Hess Locks Apt. 432', 'Alectown', 'New Jersey', '49776', 'Senegal'),
	('Pidgainyi', 'Ruslan', '+48 555 555 555', 'pidgainyi.ruslan@mail.com', NULL, NULL, NULL, NULL, NULL),
	('Anonimus', 'Anonim', '555 555 555', NULL, NULL, NULL, NULL, NULL, NULL),
	('Bohda', 'Chmelnitskyj', '+38 050 68 69 259', NULL, 'Bulukina', 'Poltava', 'Poltavska', NULL, 'Ukraine'),
	('Amina', 'Bondarenko', '+38 095 33 69 126', NULL, 'Bulukina', 'Poltava', 'Poltavska', '300-36', 'Ukraine'),
	('Violetta', 'Honcharenko', '+38 050 12 32 726', 'violetta.honcharenko@gmail.com', 'Independence Square', 'Kyiv', NULL, NULL, 'Ukraine');

--	select * from Earnings
INSERT INTO [dbo].[Earnings] (Salary)
VALUES
    (4000.00),
    (4300.00),
    (5000.85),
    (6000.90),
    (9000.15),
	(10000.99);

INSERT INTO [dbo].[Positions] (NamePosition)
VALUES 
	('Intern'),
	('Sales Assistant'),
	('Cashier'),
	('Cashier/Sales Assistant'),
	('Deputy Administrator'),
	('Administrator');

-- select * from Employees
INSERT INTO [dbo].[Employees] (Surname, FirstName, DateOfBirth, Pesel, Phone, Email, EarningID, PositionID)
VALUES
	('Tarasov', 'Ihor', '2002-03-01', '123132132', '555-5678', NULL, 1,3),
	('Borys', 'Vladyslav', '2001-03-01', NULL, '555-5678', NULL, 1,3),
	('Pushkar', 'Bohdan', '1985-06-15', '12345678901', '555-1234', 'bohdan.pusha21@example.com', 1,3),
	('Malko', 'Maxim', '1990-09-15', '1223412912', '123-1234', 'maxim.malko21@example.com', 1,3),
    ('Anderson', 'Sarah', '1985-06-15', '12345678901', '555-1234', 'sarah.anderson@example.com', 1,3),
    ('Johnson', 'Michael', '1992-03-24', '98765432101', '555-5678', 'michael.johnson@example.com', 2,4),
    ('Smith', 'Laura', '1988-12-11', '11122233344', '555-8765', 'laura.smith@example.com', 3,4),
    ('Brown', 'David', '1975-07-30', '44455566677', '555-3456', 'david.brown@example.com', 4,4),
    ('Davis', 'Emma', '1990-10-05', '88899900011', '555-6543', 'emma.davis@example.com', 5,5),
	('Chirva', 'Anton', '2000-10-05', '12399900011', '145-6543', 'chirva.boss@example.com', 6,6);

--select * from CategoriesShoes
INSERT INTO [dbo].[CategoriesShoes] (NameCategory)
VALUES
    ('Sneakers'),
    ('Running Shoes'),
    ('Casual Shoes'),
    ('Formal Shoes'),
    ('Sports Shoes');

INSERT INTO [dbo].[Gender] (NameGender)
VALUES
    ('Male'),
    ('Female');

-- select * from SizeForWomen
INSERT INTO [dbo].[SizeForWomen] (EU, UK, US, cm)
VALUES
    (34.0, 2.0, 4.5, 21.5),
    (35.0, 2.5, 5.0, 22.0),
    (35.5, 3.0, 5.5, 22.5),
    (36.0, 3.5, 6.0, 23.0),
    (37.0, 4.0, 6.5, 23.0),
	(37.5, 4.5, 7.0, 23.5),
	(38.0, 5.0, 7.5, 24.0),
	(38.5, 5.5, 8.0, 24.0),
	(39.0, 6.0, 8.5, 24.5),
	(39.5, 6.5, 9.0, 25.0),
	(40.0, 7.0, 9.5, 25.5),
	(41.0, 7.5, 10.0, 26.0),
	(42.0, 8.0, 10.5, 26.5);

-- select * from SizeForMen
INSERT INTO [dbo].[SizeForMen] (EU, UK, US, cm)
VALUES
    (38.0, 5.0, 5.5, 23.5),
    (38.5, 5.5, 6.0, 24.0),
    (39.0, 6.0, 6.5, 24.5),
    (40.0, 6.5, 7.0, 25.0),
    (40.5, 7.0, 7.5, 25.5),
	(41.0, 7.5, 8.0, 26.0),
	(42.0, 8.0, 8.5, 26.5),
	(42.5, 8.5, 9.0, 27.0),
	(43.0, 9.0, 9.5, 27.5),
	(44.0, 9.5, 10.0, 28.0),
	(44.5, 10.0, 10.5, 28.5),
	(45.0, 10.5, 11.0, 29.0),
	(46.0, 11.0, 11.5, 29.5),
	(46.5, 11.5, 12.0, 30.0),
	(47.0, 12.0, 12.5, 30.5);

-- select * from Colours
INSERT INTO [dbo].[Colours] (ColourName)
VALUES
    ('Red'),
    ('Blue'),
    ('Green'),
    ('Black'),
    ('White');

-- select * from Shoes
INSERT INTO [dbo].[Shoes] (BrandName, Model, Collaboration, GenderID, CategoryID, ColourID, SizeWID, SizeMID)
VALUES
    ('Nike', 'Air Max 90', 'Off-White', 1, 1, 1, 1, 1),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 2, 1, 1),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 3, 1, 1),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 4, 1, 1),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 5, 1, 1),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 1, 1, 1),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 2, 1, 1),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 3, 1, 1),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 4, 1, 1),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 5, 1, 1),

	('Nike', 'Air Max 90', 'Off-White', 1, 1, 1, 2, 2),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 2, 2, 2),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 3, 2, 2),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 4, 2, 2),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 5, 2, 2),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 1, 2, 2),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 2, 2, 2),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 3, 2, 2),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 4, 2, 2),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 5, 2, 2),

	('Nike', 'Air Max 90', 'Off-White', 1, 1, 1, 3, 3),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 2, 3, 3),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 3, 3, 3),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 4, 3, 3),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 5, 3, 3),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 1, 3, 3),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 2, 3, 3),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 3, 3, 3),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 4, 3, 3),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 5, 3, 3),

	('Nike', 'Air Max 90', 'Off-White', 1, 1, 1, 4, 4),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 2, 4, 4),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 3, 4, 4),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 4, 4, 4),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 5, 4, 4),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 1, 4, 4),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 2, 4, 4),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 3, 4, 4),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 4, 4, 4),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 5, 4, 4),


	('Nike', 'Air Max 90', 'Off-White', 1, 1, 1, 5, 5),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 2, 5, 5),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 3, 5, 5),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 4, 5, 5),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 5, 5, 5),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 1, 5, 5),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 2, 5, 5),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 3, 5, 5),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 4, 5, 5),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 5, 5, 5),

	('Nike', 'Air Max 90', 'Off-White', 1, 1, 1, 6, 6),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 2, 6, 6),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 3, 6, 6),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 4, 6, 6),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 5, 6, 6),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 1, 6, 6),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 2, 6, 6),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 3, 6, 6),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 4, 6, 6),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 5, 6, 6),

	('Nike', 'Air Max 90', 'Off-White', 1, 1, 1, 7, 7),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 2, 7, 7),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 3, 7, 7),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 4, 7, 7),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 5, 7, 7),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 1, 7, 7),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 2, 7, 7),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 3, 7, 7),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 4, 7, 7),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 5, 7, 7),

	('Nike', 'Air Max 90', 'Off-White', 1, 1, 1, 8, 8),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 2, 8, 8),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 3, 8, 8),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 4, 8, 8),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 5, 8, 8),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 1, 8, 8),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 2, 8, 8),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 3, 8, 8),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 4, 8, 8),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 5, 8, 8),

	('Nike', 'Air Max 90', 'Off-White', 1, 1, 1, 9, 9),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 2, 9, 9),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 3, 9, 9),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 4, 9, 9),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 5, 9, 9),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 1, 9, 9),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 2, 9, 9),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 3, 9, 9),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 4, 9, 9),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 5, 9, 9),

	('Nike', 'Air Max 90', 'Off-White', 1, 1, 1, 10, 10),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 2, 10, 10),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 3, 10, 10),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 4, 10, 10),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 5, 10, 10),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 1, 10, 10),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 2, 10, 10),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 3, 10, 10),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 4, 10, 10),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 5, 10, 10),

	('Nike', 'Air Max 90', 'Off-White', 1, 1, 1, 11, 11),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 2, 11, 11),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 3, 11, 11),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 4, 11, 11),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 5, 11, 11),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 1, 11, 11),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 2, 11, 11),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 3, 11, 11),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 4, 11, 11),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 5, 11, 11),

	('Nike', 'Air Max 90', 'Off-White', 1, 1, 1, 12, 12),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 2, 12, 12),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 3, 12, 12),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 4, 12, 12),
	('Nike', 'Air Max 90', 'Off-White', 1, 1, 5, 12, 12),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 1, 12, 12),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 2, 12, 12),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 3, 12, 12),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 4, 12, 12),
	('Nike', 'Air Max 90', 'Off-White', 2, 1, 5, 12, 12),

    ('Adidas', 'UltraBoost', NULL, 1, 1, 1, 1, 1),
	('Adidas', 'UltraBoost', NULL, 1, 1, 2, 1, 1),
	('Adidas', 'UltraBoost', NULL, 1, 1, 3, 1, 1),
	('Adidas', 'UltraBoost', NULL, 1, 1, 4, 1, 1),
	('Adidas', 'UltraBoost', NULL, 1, 1, 5, 1, 1),
    ('Adidas', 'UltraBoost', NULL, 2, 1, 1, 1, 1),
	('Adidas', 'UltraBoost', NULL, 2, 1, 2, 1, 1),
	('Adidas', 'UltraBoost', NULL, 2, 1, 3, 1, 1),
	('Adidas', 'UltraBoost', NULL, 2, 1, 4, 1, 1),
	('Adidas', 'UltraBoost', NULL, 2, 1, 5, 1, 1),

	('Adidas', 'UltraBoost', NULL, 1, 1, 1, 2, 2),
	('Adidas', 'UltraBoost', NULL, 1, 1, 2, 2, 2),
	('Adidas', 'UltraBoost', NULL, 1, 1, 3, 2, 2),
	('Adidas', 'UltraBoost', NULL, 1, 1, 4, 2, 2),
	('Adidas', 'UltraBoost', NULL, 1, 1, 5, 2, 2),
	('Adidas', 'UltraBoost', NULL, 2, 1, 1, 2, 2),
	('Adidas', 'UltraBoost', NULL, 2, 1, 2, 2, 2),
	('Adidas', 'UltraBoost', NULL, 2, 1, 3, 2, 2),
	('Adidas', 'UltraBoost', NULL, 2, 1, 4, 2, 2),
	('Adidas', 'UltraBoost', NULL, 2, 1, 5, 2, 2),

	('Adidas', 'UltraBoost', NULL, 1, 1, 1, 3, 3),
	('Adidas', 'UltraBoost', NULL, 1, 1, 2, 3, 3),
	('Adidas', 'UltraBoost', NULL, 1, 1, 3, 3, 3),
	('Adidas', 'UltraBoost', NULL, 1, 1, 4, 3, 3),
	('Adidas', 'UltraBoost', NULL, 1, 1, 5, 3, 3),
	('Adidas', 'UltraBoost', NULL, 2, 1, 1, 3, 3),
	('Adidas', 'UltraBoost', NULL, 2, 1, 2, 3, 3),
	('Adidas', 'UltraBoost', NULL, 2, 1, 3, 3, 3),
	('Adidas', 'UltraBoost', NULL, 2, 1, 4, 3, 3),
	('Adidas', 'UltraBoost', NULL, 2, 1, 5, 3, 3),

	('Adidas', 'UltraBoost', NULL, 1, 1, 1, 4, 4),
	('Adidas', 'UltraBoost', NULL, 1, 1, 2, 4, 4),
	('Adidas', 'UltraBoost', NULL, 1, 1, 3, 4, 4),
	('Adidas', 'UltraBoost', NULL, 1, 1, 4, 4, 4),
	('Adidas', 'UltraBoost', NULL, 1, 1, 5, 4, 4),
	('Adidas', 'UltraBoost', NULL, 2, 1, 1, 4, 4),
	('Adidas', 'UltraBoost', NULL, 2, 1, 2, 4, 4),
	('Adidas', 'UltraBoost', NULL, 2, 1, 3, 4, 4),
	('Adidas', 'UltraBoost', NULL, 2, 1, 4, 4, 4),
	('Adidas', 'UltraBoost', NULL, 2, 1, 5, 4, 4),

	('Adidas', 'UltraBoost', NULL, 1, 1, 1, 5, 5),
	('Adidas', 'UltraBoost', NULL, 1, 1, 2, 5, 5),
	('Adidas', 'UltraBoost', NULL, 1, 1, 3, 5, 5),
	('Adidas', 'UltraBoost', NULL, 1, 1, 4, 5, 5),
	('Adidas', 'UltraBoost', NULL, 1, 1, 5, 5, 5),
	('Adidas', 'UltraBoost', NULL, 2, 1, 1, 5, 5),
	('Adidas', 'UltraBoost', NULL, 2, 1, 2, 5, 5),
	('Adidas', 'UltraBoost', NULL, 2, 1, 3, 5, 5),
	('Adidas', 'UltraBoost', NULL, 2, 1, 4, 5, 5),
	('Adidas', 'UltraBoost', NULL, 2, 1, 5, 5, 5),

	('Adidas', 'UltraBoost', NULL, 1, 1, 1, 6, 6),
	('Adidas', 'UltraBoost', NULL, 1, 1, 2, 6, 6),
	('Adidas', 'UltraBoost', NULL, 1, 1, 3, 6, 6),
	('Adidas', 'UltraBoost', NULL, 1, 1, 4, 6, 6),
	('Adidas', 'UltraBoost', NULL, 1, 1, 5, 6, 6),
	('Adidas', 'UltraBoost', NULL, 2, 1, 1, 6, 6),
	('Adidas', 'UltraBoost', NULL, 2, 1, 2, 6, 6),
	('Adidas', 'UltraBoost', NULL, 2, 1, 3, 6, 6),
	('Adidas', 'UltraBoost', NULL, 2, 1, 4, 6, 6),
	('Adidas', 'UltraBoost', NULL, 2, 1, 5, 6, 6),

	('Adidas', 'UltraBoost', NULL, 1, 1, 1, 7, 7),
	('Adidas', 'UltraBoost', NULL, 1, 1, 2, 7, 7),
	('Adidas', 'UltraBoost', NULL, 1, 1, 3, 7, 7),
	('Adidas', 'UltraBoost', NULL, 1, 1, 4, 7, 7),
	('Adidas', 'UltraBoost', NULL, 1, 1, 5, 7, 7),
	('Adidas', 'UltraBoost', NULL, 2, 1, 1, 7, 7),
	('Adidas', 'UltraBoost', NULL, 2, 1, 2, 7, 7),
	('Adidas', 'UltraBoost', NULL, 2, 1, 3, 7, 7),
	('Adidas', 'UltraBoost', NULL, 2, 1, 4, 7, 7),
	('Adidas', 'UltraBoost', NULL, 2, 1, 5, 7, 7),

	('Adidas', 'UltraBoost', NULL, 1, 1, 1, 8, 8),
	('Adidas', 'UltraBoost', NULL, 1, 1, 2, 8, 8),
	('Adidas', 'UltraBoost', NULL, 1, 1, 3, 8, 8),
	('Adidas', 'UltraBoost', NULL, 1, 1, 4, 8, 8),
	('Adidas', 'UltraBoost', NULL, 1, 1, 5, 8, 8),
	('Adidas', 'UltraBoost', NULL, 2, 1, 1, 8, 8),
	('Adidas', 'UltraBoost', NULL, 2, 1, 2, 8, 8),
	('Adidas', 'UltraBoost', NULL, 2, 1, 3, 8, 8),
	('Adidas', 'UltraBoost', NULL, 2, 1, 4, 8, 8),
	('Adidas', 'UltraBoost', NULL, 2, 1, 5, 8, 8),

	('Adidas', 'UltraBoost', NULL, 1, 1, 1, 9, 9),
	('Adidas', 'UltraBoost', NULL, 1, 1, 2, 9, 9),
	('Adidas', 'UltraBoost', NULL, 1, 1, 3, 9, 9),
	('Adidas', 'UltraBoost', NULL, 1, 1, 4, 9, 9),
	('Adidas', 'UltraBoost', NULL, 1, 1, 5, 9, 9),
	('Adidas', 'UltraBoost', NULL, 2, 1, 1, 9, 9),
	('Adidas', 'UltraBoost', NULL, 2, 1, 2, 9, 9),
	('Adidas', 'UltraBoost', NULL, 2, 1, 3, 9, 9),
	('Adidas', 'UltraBoost', NULL, 2, 1, 4, 9, 9),
	('Adidas', 'UltraBoost', NULL, 2, 1, 5, 9, 9),

	('Adidas', 'UltraBoost', NULL, 1, 1, 1, 10, 10),
	('Adidas', 'UltraBoost', NULL, 1, 1, 2, 10, 10),
	('Adidas', 'UltraBoost', NULL, 1, 1, 3, 10, 10),
	('Adidas', 'UltraBoost', NULL, 1, 1, 4, 10, 10),
	('Adidas', 'UltraBoost', NULL, 1, 1, 5, 10, 10),
	('Adidas', 'UltraBoost', NULL, 2, 1, 1, 10, 10),
	('Adidas', 'UltraBoost', NULL, 2, 1, 2, 10, 10),
	('Adidas', 'UltraBoost', NULL, 2, 1, 3, 10, 10),
	('Adidas', 'UltraBoost', NULL, 2, 1, 4, 10, 10),
	('Adidas', 'UltraBoost', NULL, 2, 1, 5, 10, 10),

	('Adidas', 'UltraBoost', NULL, 1, 1, 1, 11, 11),
	('Adidas', 'UltraBoost', NULL, 1, 1, 2, 11, 11),
	('Adidas', 'UltraBoost', NULL, 1, 1, 3, 11, 11),
	('Adidas', 'UltraBoost', NULL, 1, 1, 4, 11, 11),
	('Adidas', 'UltraBoost', NULL, 1, 1, 5, 11, 11),
	('Adidas', 'UltraBoost', NULL, 2, 1, 1, 11, 11),
	('Adidas', 'UltraBoost', NULL, 2, 1, 2, 11, 11),
	('Adidas', 'UltraBoost', NULL, 2, 1, 3, 11, 11),
	('Adidas', 'UltraBoost', NULL, 2, 1, 4, 11, 11),
	('Adidas', 'UltraBoost', NULL, 2, 1, 5, 11, 11),

	('Adidas', 'UltraBoost', NULL, 1, 1, 1, 12, 12),
	('Adidas', 'UltraBoost', NULL, 1, 1, 2, 12, 12),
	('Adidas', 'UltraBoost', NULL, 1, 1, 3, 12, 12),
	('Adidas', 'UltraBoost', NULL, 1, 1, 4, 12, 12),
	('Adidas', 'UltraBoost', NULL, 1, 1, 5, 12, 12),
	('Adidas', 'UltraBoost', NULL, 2, 1, 1, 12, 12),
	('Adidas', 'UltraBoost', NULL, 2, 1, 2, 12, 12),
	('Adidas', 'UltraBoost', NULL, 2, 1, 3, 12, 12),
	('Adidas', 'UltraBoost', NULL, 2, 1, 4, 12, 12),
	('Adidas', 'UltraBoost', NULL, 2, 1, 5, 12, 12),


	('Puma', 'Suede Classic', NULL, 1, 1, 2, 1, 1),
	('Puma', 'Suede Classic', NULL, 1, 1, 3, 1, 1),
	('Puma', 'Suede Classic', NULL, 1, 1, 4, 1, 1),
    ('Puma', 'Suede Classic', NULL, 1, 1, 5, 1, 1),
	('Puma', 'Suede Classic', NULL, 2, 1, 2, 1, 1),
	('Puma', 'Suede Classic', NULL, 2, 1, 3, 1, 1),
	('Puma', 'Suede Classic', NULL, 2, 1, 4, 1, 1),
    ('Puma', 'Suede Classic', NULL, 2, 1, 5, 1, 1),
									
	('Puma', 'Suede Classic', NULL, 1, 1, 1, 2, 2),
	('Puma', 'Suede Classic', NULL, 1, 1, 3, 2, 2),
	('Puma', 'Suede Classic', NULL, 1, 1, 4, 2, 2),
	('Puma', 'Suede Classic', NULL, 1, 1, 5, 2, 2),
	('Puma', 'Suede Classic', NULL, 2, 1, 1, 2, 2),
	('Puma', 'Suede Classic', NULL, 2, 1, 3, 2, 2),
	('Puma', 'Suede Classic', NULL, 2, 1, 4, 2, 2),
	('Puma', 'Suede Classic', NULL, 2, 1, 5, 2, 2),

	('Puma', 'Suede Classic', NULL, 1, 1, 1, 3, 3),
	('Puma', 'Suede Classic', NULL, 1, 1, 2, 3, 3),
	('Puma', 'Suede Classic', NULL, 1, 1, 4, 3, 3),
	('Puma', 'Suede Classic', NULL, 1, 1, 5, 3, 3),
	('Puma', 'Suede Classic', NULL, 2, 1, 1, 3, 3),
	('Puma', 'Suede Classic', NULL, 2, 1, 2, 3, 3),
	('Puma', 'Suede Classic', NULL, 2, 1, 4, 3, 3),
	('Puma', 'Suede Classic', NULL, 2, 1, 5, 3, 3),

	('Puma', 'Suede Classic', NULL, 1, 1, 1, 4, 4),
	('Puma', 'Suede Classic', NULL, 1, 1, 2, 4, 4),
	('Puma', 'Suede Classic', NULL, 1, 1, 3, 4, 4),
	('Puma', 'Suede Classic', NULL, 1, 1, 5, 4, 4),
	('Puma', 'Suede Classic', NULL, 2, 1, 1, 4, 4),
	('Puma', 'Suede Classic', NULL, 2, 1, 2, 4, 4),
	('Puma', 'Suede Classic', NULL, 2, 1, 3, 4, 4),
	('Puma', 'Suede Classic', NULL, 2, 1, 5, 4, 4),

	('Puma', 'Suede Classic', NULL, 1, 1, 1, 5, 5),
	('Puma', 'Suede Classic', NULL, 1, 1, 2, 5, 5),
	('Puma', 'Suede Classic', NULL, 1, 1, 3, 5, 5),
	('Puma', 'Suede Classic', NULL, 1, 1, 4, 5, 5),
	('Puma', 'Suede Classic', NULL, 2, 1, 1, 5, 5),
	('Puma', 'Suede Classic', NULL, 2, 1, 2, 5, 5),
	('Puma', 'Suede Classic', NULL, 2, 1, 3, 5, 5),
	('Puma', 'Suede Classic', NULL, 2, 1, 4, 5, 5),

	('Puma', 'Suede Classic', NULL, 1, 1, 1, 6, 6),
	('Puma', 'Suede Classic', NULL, 1, 1, 3, 6, 6),
	('Puma', 'Suede Classic', NULL, 1, 1, 4, 6, 6),
	('Puma', 'Suede Classic', NULL, 1, 1, 5, 6, 6),
	('Puma', 'Suede Classic', NULL, 2, 1, 1, 6, 6),
	('Puma', 'Suede Classic', NULL, 2, 1, 3, 6, 6),
	('Puma', 'Suede Classic', NULL, 2, 1, 4, 6, 6),
	('Puma', 'Suede Classic', NULL, 2, 1, 5, 6, 6),

	('Puma', 'Suede Classic', NULL, 1, 1, 1, 7, 7),
	('Puma', 'Suede Classic', NULL, 1, 1, 2, 7, 7),
	('Puma', 'Suede Classic', NULL, 1, 1, 4, 7, 7),
	('Puma', 'Suede Classic', NULL, 1, 1, 5, 7, 7),
	('Puma', 'Suede Classic', NULL, 2, 1, 1, 7, 7),
	('Puma', 'Suede Classic', NULL, 2, 1, 2, 7, 7),
	('Puma', 'Suede Classic', NULL, 2, 1, 4, 7, 7),
	('Puma', 'Suede Classic', NULL, 2, 1, 5, 7, 7),

	('Puma', 'Suede Classic', NULL, 1, 1, 1, 8, 8),
	('Puma', 'Suede Classic', NULL, 1, 1, 2, 8, 8),
	('Puma', 'Suede Classic', NULL, 1, 1, 3, 8, 8),
	('Puma', 'Suede Classic', NULL, 1, 1, 5, 8, 8),
	('Puma', 'Suede Classic', NULL, 2, 1, 1, 8, 8),
	('Puma', 'Suede Classic', NULL, 2, 1, 2, 8, 8),
	('Puma', 'Suede Classic', NULL, 2, 1, 3, 8, 8),
	('Puma', 'Suede Classic', NULL, 2, 1, 5, 8, 8),

	('Puma', 'Suede Classic', NULL, 1, 1, 1, 9, 9),
	('Puma', 'Suede Classic', NULL, 1, 1, 2, 9, 9),
	('Puma', 'Suede Classic', NULL, 1, 1, 3, 9, 9),
	('Puma', 'Suede Classic', NULL, 1, 1, 4, 9, 9),
	('Puma', 'Suede Classic', NULL, 2, 1, 1, 9, 9),
	('Puma', 'Suede Classic', NULL, 2, 1, 2, 9, 9),
	('Puma', 'Suede Classic', NULL, 2, 1, 3, 9, 9),
	('Puma', 'Suede Classic', NULL, 2, 1, 4, 9, 9),



	('Reebok', 'Club C 85', 'Kendrick Lamar', 1, 1, 4, 1, 1),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 1, 1, 5, 1, 1),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 2, 1, 4, 1, 1),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 2, 1, 5, 1, 1),

	('Reebok', 'Club C 85', 'Kendrick Lamar', 1, 1, 4, 2, 2),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 1, 1, 5, 2, 2),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 2, 1, 4, 2, 2),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 2, 1, 5, 2, 2),

	('Reebok', 'Club C 85', 'Kendrick Lamar', 1, 1, 4, 3, 3),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 1, 1, 5, 3, 3),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 2, 1, 4, 3, 3),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 2, 1, 5, 3, 3),
											  
	('Reebok', 'Club C 85', 'Kendrick Lamar', 1, 1, 4, 4, 4),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 1, 1, 5, 4, 4),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 2, 1, 4, 4, 4),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 2, 1, 5, 4, 4),

	('Reebok', 'Club C 85', 'Kendrick Lamar', 1, 1, 4, 5, 5),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 1, 1, 5, 5, 5),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 2, 1, 4, 5, 5),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 2, 1, 5, 5, 5),
											  
	('Reebok', 'Club C 85', 'Kendrick Lamar', 1, 1, 4, 6, 6),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 1, 1, 5, 6, 6),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 2, 1, 4, 6, 6),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 2, 1, 5, 6, 6),
											  
	('Reebok', 'Club C 85', 'Kendrick Lamar', 1, 1, 4, 7, 7),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 1, 1, 5, 7, 7),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 2, 1, 4, 7, 7),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 2, 1, 5, 7, 7),
											  
	('Reebok', 'Club C 85', 'Kendrick Lamar', 1, 1, 4, 8, 8),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 1, 1, 5, 8, 8),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 2, 1, 4, 8, 8),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 2, 1, 5, 8, 8),

	('Reebok', 'Club C 85', 'Kendrick Lamar', 1, 1, 4, 9, 9),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 1, 1, 5, 9, 9),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 2, 1, 4, 9, 9),
	('Reebok', 'Club C 85', 'Kendrick Lamar', 2, 1, 5, 9, 9),

	('Asics', 'Gel-Kayano', NULL, 1, 1, 3, 2, 2),
    ('Asics', 'Gel-Kayano', NULL, 1, 1, 4, 2, 2),
	('Asics', 'Gel-Kayano', NULL, 1, 1, 5, 2, 2),
	('Asics', 'Gel-Kayano', NULL, 2, 1, 3, 2, 2),
    ('Asics', 'Gel-Kayano', NULL, 2, 1, 4, 2, 2),
	('Asics', 'Gel-Kayano', NULL, 2, 1, 5, 2, 2),

	('Asics', 'Gel-Kayano', NULL, 1, 1, 3, 3, 3),
    ('Asics', 'Gel-Kayano', NULL, 1, 1, 4, 3, 3),
	('Asics', 'Gel-Kayano', NULL, 1, 1, 5, 3, 3),
	('Asics', 'Gel-Kayano', NULL, 2, 1, 3, 3, 3),
    ('Asics', 'Gel-Kayano', NULL, 2, 1, 4, 3, 3),
	('Asics', 'Gel-Kayano', NULL, 2, 1, 5, 3, 3),

	('Asics', 'Gel-Kayano', NULL, 1, 1, 3, 4, 4),
    ('Asics', 'Gel-Kayano', NULL, 1, 1, 4, 4, 4),
	('Asics', 'Gel-Kayano', NULL, 1, 1, 5, 4, 4),
	('Asics', 'Gel-Kayano', NULL, 2, 1, 3, 4, 4),
    ('Asics', 'Gel-Kayano', NULL, 2, 1, 4, 4, 4),
	('Asics', 'Gel-Kayano', NULL, 2, 1, 5, 4, 4),
								  
	('Asics', 'Gel-Kayano', NULL, 1, 1, 3, 5, 5),
    ('Asics', 'Gel-Kayano', NULL, 1, 1, 4, 5, 5),
	('Asics', 'Gel-Kayano', NULL, 1, 1, 5, 5, 5),
	('Asics', 'Gel-Kayano', NULL, 2, 1, 3, 5, 5),
    ('Asics', 'Gel-Kayano', NULL, 2, 1, 4, 5, 5),
	('Asics', 'Gel-Kayano', NULL, 2, 1, 5, 5, 5),

	('Asics', 'Gel-Kayano', NULL, 1, 1, 3, 6, 6),
    ('Asics', 'Gel-Kayano', NULL, 1, 1, 4, 6, 6),
	('Asics', 'Gel-Kayano', NULL, 1, 1, 5, 6, 6),
	('Asics', 'Gel-Kayano', NULL, 2, 1, 3, 6, 6),
    ('Asics', 'Gel-Kayano', NULL, 2, 1, 4, 6, 6),
	('Asics', 'Gel-Kayano', NULL, 2, 1, 5, 6, 6),
								  
	('Asics', 'Gel-Kayano', NULL, 1, 1, 3, 7, 7),
    ('Asics', 'Gel-Kayano', NULL, 1, 1, 4, 7, 7),
	('Asics', 'Gel-Kayano', NULL, 1, 1, 5, 7, 7),
	('Asics', 'Gel-Kayano', NULL, 2, 1, 3, 7, 7),
    ('Asics', 'Gel-Kayano', NULL, 2, 1, 4, 7, 7),
	('Asics', 'Gel-Kayano', NULL, 2, 1, 5, 7, 7),
								  
	('Asics', 'Gel-Kayano', NULL, 1, 1, 3, 8, 8),
    ('Asics', 'Gel-Kayano', NULL, 1, 1, 4, 8, 8),
	('Asics', 'Gel-Kayano', NULL, 1, 1, 5, 8, 8),
	('Asics', 'Gel-Kayano', NULL, 2, 1, 3, 8, 8),
    ('Asics', 'Gel-Kayano', NULL, 2, 1, 4, 8, 8),
	('Asics', 'Gel-Kayano', NULL, 2, 1, 5, 8, 8),
								  
	('Asics', 'Gel-Kayano', NULL, 1, 1, 3, 9, 9),
    ('Asics', 'Gel-Kayano', NULL, 1, 1, 4, 9, 9),
	('Asics', 'Gel-Kayano', NULL, 1, 1, 5, 9, 9),
	('Asics', 'Gel-Kayano', NULL, 2, 1, 3, 9, 9),
    ('Asics', 'Gel-Kayano', NULL, 2, 1, 4, 9, 9),
	('Asics', 'Gel-Kayano', NULL, 2, 1, 5, 9, 9),

	('Asics', 'Gel-Kayano', NULL, 1, 1, 3, 10, 10),
    ('Asics', 'Gel-Kayano', NULL, 1, 1, 4, 10, 10),
	('Asics', 'Gel-Kayano', NULL, 1, 1, 5, 10, 10),
	('Asics', 'Gel-Kayano', NULL, 2, 1, 3, 10, 10),
    ('Asics', 'Gel-Kayano', NULL, 2, 1, 4, 10, 10),
	('Asics', 'Gel-Kayano', NULL, 2, 1, 5, 10, 10),
								  
	('Asics', 'Gel-Kayano', NULL, 1, 1, 3, 11, 11),
    ('Asics', 'Gel-Kayano', NULL, 1, 1, 4, 11, 11),
	('Asics', 'Gel-Kayano', NULL, 1, 1, 5, 11, 11),
	('Asics', 'Gel-Kayano', NULL, 2, 1, 3, 11, 11),
    ('Asics', 'Gel-Kayano', NULL, 2, 1, 4, 11, 11),
	('Asics', 'Gel-Kayano', NULL, 2, 1, 5, 11, 11);

-- select * from SalesDates
INSERT INTO [dbo].[SalesDates] (OrderDate, DeliveryDate, SaleDate)
VALUES
    ('2018-01-01', '2018-01-05', '2018-01-10'),
	('2018-01-02', '2018-01-06', '2018-01-10'),
	('2018-01-03', '2018-01-06', '2018-01-10'),
    ('2018-02-01', '2018-02-05', '2018-02-11'),
	('2018-02-02', '2018-02-06', '2018-02-12'),
	('2018-02-04', '2018-02-08', '2018-02-13'),
    ('2018-03-05', '2018-03-09', '2018-03-22'),
    ('2018-03-06', '2018-03-10', '2018-03-22'),
    ('2018-03-07', '2018-03-12', '2018-03-22'),
    ('2018-04-01', '2018-04-05', '2018-05-04'),
    ('2018-05-01', '2018-05-05', '2018-05-10'),
    ('2019-04-01', '2019-04-05', '2019-04-10'),
	('2019-04-02', '2019-04-06', '2019-04-10'),
	('2019-04-03', '2019-04-06', '2019-04-10'),
    ('2019-05-01', '2019-05-05', '2019-05-11'),
	('2019-05-02', '2019-05-06', '2019-05-12'),
	('2019-05-04', '2019-05-08', '2019-05-13'),
    ('2019-06-05', '2019-06-09', '2019-06-22'),
    ('2019-06-06', '2019-06-10', '2019-06-22'),
    ('2019-06-07', '2019-06-12', '2019-06-22'),
    ('2019-07-11', '2019-07-17', '2019-07-24'),
    ('2019-07-12', '2019-07-19', '2019-07-26'),
    ('2020-08-01', '2020-08-15', '2020-04-16'),
	('2020-08-02', '2020-08-26', '2020-04-28'),
	('2020-08-03', '2020-08-26', '2020-04-28'),
    ('2020-08-04', '2020-08-15', '2020-05-17'),
	('2020-08-05', '2020-08-16', '2020-05-18'),
	('2020-08-06', '2020-08-26', '2020-05-26'),
    ('2020-08-07', '2020-08-19', '2020-06-22'),
    ('2020-08-08', '2020-08-13', '2020-06-22'),
    ('2020-08-09', '2020-08-12', '2020-06-22'),
    ('2020-08-10', '2020-08-17', '2020-07-24'),
    ('2020-08-12', '2020-08-19', '2020-07-26'),
	('2021-01-01', '2021-01-05', '2021-01-22'),
    ('2021-01-02', '2021-01-05', '2022-01-11'),
    ('2021-02-01', '2021-02-05', '2021-02-10'),
    ('2021-02-02', '2021-02-05', '2024-02-18'),
    ('2021-03-01', '2021-03-05', '2021-03-13'),
	('2021-03-02', '2021-03-05', '2023-03-14'),
    ('2021-04-01', '2021-04-05', '2021-04-06'),
    ('2021-04-02', '2021-04-05', '2025-04-06'),
    ('2021-05-01', '2021-05-05', '2021-05-10'),
    ('2021-05-02', '2021-05-05', '2022-05-12');

-- select * from Solds
INSERT INTO [dbo].[Solds] (EmployeeID, ClientID, ShoesID, SalesDateID)
VALUES
    (1, 1,	1, 1),
	(1, 1,	1, 2),
	(1, 1,	201, 2),
	(1, 2,	2, 2),
	(1, 2,	102, 14),
	(1, 3,	3, 3),
	(1, 3,	66, 40),
	(1, 4,	4, 4),
	(1, 4,	4, 4),
	(1, 5,	5, 5),
	(1, 5,	22, 37),
	(1, 6,	6, 6),
	(1, 6,	10, 36),
	(1, 7,	7, 7),
	(1, 7,	17, 41),
	(1, 8,	8, 8),
	(1, 8,	99, 28),
	(1, 9,	9, 9),
	(1, 10,	10, 10),

	(2, 1, 91, 18),
	(2, 1, 90, 2),
	(2, 1, 89, 22),
	(2, 2, 67, 39),
	(2, 2, 51, 12),
	(2, 3, 53, 21),
	(2, 3, 41, 10),
	(2, 4,  299, 21),
	(2, 4, 168, 22),
	(2, 5,  194, 25),
	(2, 5,  294, 28),
	(2, 6,  131, 35),
	(2, 6,  123, 31),
	(2, 7,  145, 2),
	(2, 7,  198, 30),
	(2, 8,  134, 40),
	(2, 8,  145, 9),
	(2, 9,  178, 8),
	(2, 9,  215, 7),
	(2, 10,  127, 6),
	(2, 10,  105, 5),

	(3, 1, 22, 10),
	(3, 1, 33, 20),
	(3, 1, 44, 30),
	(3, 2, 55, 40),
	(3, 2, 66, 10),
	(3, 3, 77, 16),
	(3, 3, 88, 17),
	(3, 4,  99, 12),
	(3, 4, 100, 13),
	(3, 5,  111, 35),
	(3, 5,  122, 18),
	(3, 6,  133, 15),
	(3, 6,  133, 16),
	(3, 7,  144, 28),
	(3, 9,  177, 8),

    (4, 1, 191, 18),
	(4, 1, 91, 22),
	(4, 1, 21, 22),
	(4, 2, 23, 39),
	(4, 2, 18, 10),
	(4, 3, 19, 10),
	(4, 3, 200, 10),
	(4, 4,  29, 39),
	(4, 4, 18, 38),
	(4, 5,  94, 29),
	(4, 5,  64, 28),
	(4, 6,  71, 29),
	(4, 6,  83, 18),
	(4, 7,  35, 27),
	(4, 7,  88, 28),
	(4, 8,  94, 29),
	(4, 8,  45, 29),
	(4, 9,  78, 39),
	(4, 9,  15, 40),
	(4, 10, 27, 41),
	(4, 10,  185, 42),

	(5, 1, 1, 18),
	(5, 1, 2, 2),
	(5, 1, 3, 22),
	(5, 2, 4, 39),
	(5, 2, 5, 22),
	(5, 3, 66, 21),
	(5, 3, 7, 21),
	(5, 4,  8, 21),
	(5, 4, 9, 22),
	(5, 5,  11, 28),
	(5, 5,  34, 28),
	(5, 6,  25, 28),
	(5, 6,  67, 8),
	(5, 7,  78, 8),
	(5, 7,  32, 8),
	(5, 8,  32, 40),
	(5, 8,  98, 7),
	(5, 9,  65, 7),
	(5, 9,  43, 7),
	(5, 10,  227, 18),
	(5, 10,  209, 18);


-- Insert data into Prices
INSERT INTO [dbo].[Prices] (ShoesID, BasePrice, DiscountPrice, StartDate, EndDate)
VALUES
    (1, 100.00, 90.00, '2019-01-01', '2019-01-28'),
	(2, 100.00, NULL, '2019-04-01', '2019-04-28'),
	(3, 100.00, NULL, '2019-07-01', '2019-07-28'),
	(4, 100.00, 90.00, '2019-08-01', '2019-08-28'),
	(5, 120.00, 95.00, '2019-03-01', '2019-03-28'),
	(6, 120.00, 95.00, '2019-04-01', '2019-04-30'),
	(7, 120.00, NULL, '2019-05-01', '2019-05-28'),
	(8, 120.00, NULL, '2019-06-01', '2019-06-28'),
	(9, 120.00, NULL, '2019-07-01', '2019-07-28'),
	(10, 100.00, 90.00, '2019-01-02', '2019-01-31'),
	(11, 100.00, NULL, '2019-04-02', '2019-04-28'),
	(12, 100.00, NULL, '2019-07-02', '2019-07-28'),
	(13, 100.00, 90.00, '2019-08-02', '2019-08-28'),
	(14, 120.00, 95.00, '2019-03-02', '2019-03-28'),
	(15, 120.00, NULL, '2019-08-02', '2019-08-28'),
	(16, 130.00, NULL, '2019-01-03', '2019-01-28'),
	(17, 130.00, NULL, '2019-06-03', '2019-06-28'),
	(18, 150.00, 80.00, '2019-01-04', '2019-01-28'),
	(19, 150.00, 130.00, '2019-04-04', '2019-04-28'),
	(20, 150.00, 130.00, '2019-05-04', '2019-05-28'),
	(22, 150.00, 130.00, '2019-08-04', '2019-08-28'),
	(23, 200.00, 130.00, '2019-03-05', '2019-03-28'),
	(24, 200.00, 130.00, '2019-08-05', '2019-08-28'),
	(25, 200.00, 130.00, '2019-03-06', '2019-03-28'),
	(26, 200.00, 130.00, '2019-06-06', '2019-06-28'),
	(27, 200.00, 130.00, '2019-07-06', '2019-07-28'),
	(28, 150.00, 130.00, '2019-04-07', '2019-04-28'),
	(29, 150.00, 130.00, '2019-05-07', '2019-05-28'),
	(30, 150.00, 130.00, '2019-08-07', '2019-08-28'),
	(31, 200.00, 130.00, '2019-05-08', '2019-05-28'),
	(32, 200.00, 130.00, '2019-08-08', '2019-08-28'),
	(33, 200.00, 130.00, '2019-03-09', '2019-03-28'),
	(34, 200.00, 130.00, '2019-06-09', '2019-06-28'),
	(35, 100.00, 90.00, '2019-01-10', '2019-01-28'),
	(36, 100.00, NULL, '2019-04-10', '2019-04-28'),
	(37, 100.00, NULL, '2019-07-10', '2019-07-28'),
	(38, 120.00, 95.00, '2019-02-11', '2019-02-28'),
	(39, 120.00, NULL, '2019-05-11', '2019-05-28'),
	(40, 120.00, NULL, '2019-08-11', '2019-08-28'),
	(85, 130.00, NULL, '2019-03-12', '2019-03-28'),
	(86, 130.00, NULL, '2019-06-12', '2019-06-28'),
	(87, 150.00, 80.00, '2019-01-13', '2019-01-28'),
	(88, 150.00, 130.00, '2019-04-13', '2019-04-28'),
	(89, 150.00, 130.00, '2019-07-13', '2019-07-28'),
	(90, 200.00, 80.00, '2019-02-14', '2019-02-28'),
	(91, 200.00, NULL, '2019-05-14', '2019-05-28'),
	(92, 200.00, NULL, '2019-08-14', '2019-08-28'),
	(93, 200.00, NULL, '2019-03-15', '2019-03-28'),
	(94, 200.00, 130.00, '2019-06-15', '2019-06-28'),
	(95, 150.00, 80.00, '2019-01-16', '2019-01-28'),
	(96, 150.00, 130.00, '2019-04-17', '2019-04-28'),
	(97, 150.00, 130.00, '2019-05-17', '2019-05-28'),
	(98, 200.00, 80.00, '2019-02-18', '2019-02-28'),
	(99, 200.00, 130.00, '2019-05-18', '2019-05-28'),
	(100, 200.00, 130.00, '2019-08-18', '2019-08-28'),
	(101, 200.00, 130.00, '2020-03-01', '2020-03-28'),
	(102, 200.00, 130.00, '2020-06-01', '2020-06-28'),
    (103, 100.00, 90.00, '2020-01-02', '2020-01-28'),
	(104, 100.00, NULL, '2020-04-02', '2020-04-28'),
	(105, 100.00, NULL, '2020-07-02', '2020-07-28'),
	(106, 120.00, 95.00, '2020-02-03', '2020-02-28'),
	(107, 120.00, NULL, '2020-05-03', '2020-05-28'),
	(108, 120.00, NULL, '2020-08-03', '2020-08-28'),
	(109, 130.00, NULL, '2020-03-04', '2020-03-28'),
	(110, 130.00, NULL, '2020-06-04', '2020-06-28'),
	(111, 150.00, 80.00, '2020-01-05', '2020-01-28'),
	(112, 150.00, 80.00, '2020-02-05', '2020-02-28'),
	(113, 150.00, 130.00, '2020-07-05', '2020-07-28'),
	(114, 200.00, 80.00, '2020-02-06', '2020-02-28'),
	(115, 200.00, 130.00, '2020-05-06', '2020-05-28'),
	(116, 200.00, 130.00, '2020-08-06', '2020-08-28'),
	(117, 200.00, NULL, '2020-03-07', '2020-03-28'),
	(118, 200.00, NULL, '2020-06-07', '2020-06-28'),
	(119, 150.00, NULL, '2020-01-08', '2020-01-28'),
	(120, 150.00, 130.00, '2020-04-08', '2020-04-28'),
	(121, 150.00, 130.00, '2020-05-08', '2020-05-28'),
	(122, 150.00, 130.00, '2020-08-08', '2020-08-28'),
	(123, 200.00, 130.00, '2020-03-09', '2020-03-28'),
	(124, 200.00, 130.00, '2020-06-09', '2020-06-28'),
	(125, 200.00, 80.00, '2020-01-10', '2020-01-28'),
	(126, 200.00, 130.00, '2020-04-10', '2020-04-28'),
	(127, 200.00, 130.00, '2020-07-10', '2020-07-28'),
	(128, 100.00, NULL, '2020-02-11', '2020-02-28'),
	(129, 100.00, NULL, '2020-05-11', '2020-05-28'),
	(130, 100.00, NULL, '2020-07-11', '2020-07-28'),
	(132, 100.00, 90.00, '2020-08-11', '2020-08-28'),
	(133, 120.00, 95.00, '2020-03-12', '2020-03-28'),
	(134, 120.00, NULL, '2020-06-12', '2020-06-28'),
	(135, 130.00, NULL, '2020-01-13', '2020-01-28'),
	(136, 130.00, NULL, '2020-04-13', '2020-04-28'),
	(137, 130.00, NULL, '2020-07-13', '2020-07-28'),
	(138, 150.00, 80.00, '2020-02-14', '2020-02-28'),
	(139, 150.00, 130.00, '2020-05-14', '2020-05-28'),
	(140, 150.00, 130.00, '2020-08-14', '2020-08-28'),
	(141, 200.00, NULL, '2021-03-01', '2021-03-28'),
	(142, 200.00, 130.00, '2021-06-01', '2021-06-28'),
	(143, 200.00, 80.00, '2021-01-02', '2021-01-28'),
	(144, 200.00, NULL, '2021-04-02', '2021-04-28'),
	(145, 200.00, 130.00, '2021-07-02', '2021-07-28'),
	(146, 150.00, 80.00, '2021-02-03', '2021-02-28'),
	(147, 150.00, 130.00, '2021-05-03', '2021-05-28'),
	(148, 150.00, NULL, '2021-08-03', '2021-08-28'),
	(149, 200.00, NULL, '2021-03-04', '2021-03-28'),
	(152, 200.00, 130.00, '2021-06-04', '2021-06-28'),
	(153, 200.00, 80.00, '2021-01-05', '2021-01-28'),
	(154, 200.00, 130.00, '2021-04-05', '2021-04-28'),
	(155, 200.00, 130.00, '2021-07-05', '2021-07-28'),
	(156, 100.00, NULL, '2021-02-06', '2021-02-28'),
	(157, 100.00, NULL, '2021-05-06', '2021-05-28'),
	(158, 100.00, 90.00, '2021-08-06', '2021-08-28'),
	(159, 120.00, 95.00, '2021-03-07', '2021-03-28'),
	(160, 120.00, NULL, '2021-06-07', '2021-06-28'),
	(161, 130.00, NULL, '2021-01-08', '2021-01-28'),
	(162, 130.00, NULL, '2021-04-08', '2021-04-28'),
	(163, 130.00, NULL, '2021-07-08', '2021-07-28'),
	(164, 150.00, 80.00, '2021-02-09', '2021-02-28'),
	(165, 150.00, 130.00, '2021-05-09', '2021-05-28'),
	(166, 150.00, 130.00, '2021-08-09', '2021-08-28'),
	(167, 200.00, 130.00, '2021-03-10', '2021-03-28'),
	(168, 200.00, 130.00, '2021-06-10', '2021-06-28'),
	(169, 200.00, 80.00, '2021-01-11', '2021-01-28'),
	(170, 200.00, 130.00, '2021-04-11', '2021-04-28'),
	(172, 200.00, 130.00, '2021-07-11', '2021-07-28'),
	(173, 150.00, 130.00, '2021-03-12', '2021-03-28'),
	(174, 150.00, 130.00, '2021-04-12', '2021-04-28'),
	(175, 200.00, 80.00, '2021-01-13', '2021-01-28'),
	(176, 200.00, 130.00, '2021-04-13', '2021-04-28'),
	(177, 200.00, 130.00, '2021-07-13', '2021-07-28'),
	(178, 200.00, 80.00, '2021-02-14', '2021-02-28'),
	(179, 200.00, 130.00, '2021-03-14', '2021-03-28'),
	(180, 200.00, 130.00, '2021-07-14', '2021-07-28'),
	(182, 200.00, 130.00, '2021-08-14', '2021-08-28'),
	(183, 100.00, NULL, '2021-03-15', '2021-03-28'),
	(184, 100.00, NULL, '2021-06-15', '2021-06-28'),
	(185, 120.00, 95.00, '2021-01-16', '2021-01-28'),
	(186, 120.00, 95.00, '2021-04-16', '2021-04-28'),
	(187, 120.00, NULL, '2021-07-16', '2021-07-28'),
	(188, 130.00, NULL, '2021-02-17', '2021-02-28'),
	(189, 130.00, NULL, '2021-05-17', '2021-05-28'),
	(190, 130.00, NULL, '2021-08-17', '2021-08-28'),
	(191, 150.00, NULL, '2021-03-18', '2021-03-28'),
	(192, 150.00, NULL, '2021-04-18', '2021-04-28'),
	(192, 150.00, 130.00, '2021-05-18', '2021-05-28'),
	(192, 150.00, 130.00, '2021-06-18', '2021-06-28'),
	(193, 150.00, 130.00, '2021-07-18', '2021-07-28'),
	(193, 150.00, 130.00, '2021-08-18', '2021-08-28'),
	(193, 200.00, 80.00, '2021-01-19', '2021-01-28'),
	(194, 200.00, 80.00, '2021-02-19', '2021-02-28'),
	(194, 200.00, 130.00, '2021-03-19', '2021-03-28'),
	(194, 200.00, 130.00, '2021-04-19', '2021-04-28'),
	(195, 200.00, 130.00, '2021-05-19', '2021-05-28'),
	(195, 200.00, 130.00, '2021-06-19', '2021-06-28'),
	(195, 200.00, 130.00, '2021-07-19', '2021-07-28'),
	(196, 200.00, NULL, '2021-08-19', '2021-08-28'),
	(197, 200.00, NULL, '2021-05-20', '2021-05-28'),
	(198, 200.00, NULL, '2021-08-20', '2021-08-28'),
	(199, 150.00, NULL, '2021-03-21', '2021-03-28'),
	(200, 150.00, NULL, '2021-06-21', '2021-06-28');
				 
-----------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from Clients
select * from Earnings
select * from Employees
select * from CategoriesShoes
select * from Gender
select * from SizeForWomen
select * from SizeForMen
select * from Colours
select * from Shoes
select * from Solds
select * from Prices
Select * from Positions

-----------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 1  Display the table with client data and the date on which the shoes were purchased under the phone number '+1'.
Select
	C.ClientID, 
	C.Surname, 
	C.FirstName, 
	C.Phone, 
	C.Email, 
	C.Address, 
	C.City, 
	C.Region, C
	.PostalCode, 
	C.Country, 
	Sale.SaleDate 
From Clients AS C
Full join Solds AS Sold ON C.ClientID = Sold.ClientID
	Full join SalesDates AS Sale ON Sold.SalesDateID = Sale.SalesDateID
Where C.Phone like '+1%'
Order by Sale.SaleDate ASC


-- 2 Display the table of employees who have birthdays between '1992-01-01' and '1995-12-31', showing their first name, last name, and date of birth.

select FirstName, Surname, DateOfBirth  from Employees 
where DateOfBirth between '1992.01.01' and '1995.12.31' 


--3 Stowrzy kopie tablice Pracownik. Wyświetl tą tablice za pomocy UNION or UNION ALL, i pokaz dane: ID, Stanowisko, Nazwisko, Pesel. i posortuj tabele: Nazwisko i Pesel

--select ID, Stanowisko, Nazwisko, Pesel 
--into Pracownik_1 
--from Pracownik 


--select ID, Stanowisko, Nazwisko, Pesel from Pracownik  union
--select ID, Stanowisko, Nazwisko, Pesel from Pracownik_1 
--order by Nazwisko desc, Pesel asc


--select ID, Stanowisko, Nazwisko, Pesel from Pracownik  union all
--select ID, Stanowisko, Nazwisko, Pesel from Pracownik_1 
--order by Nazwisko desc, Pesel asc 



-- 4 Display the table of sellers who sold goods to customers without an email.

Select distinct 
E.EmployeeID, CONCAT(E.FirstName,' ', E.Surname) as Employee, 
C.ClientID, CONCAT(C.FirstName,' ', C.Surname) as Client, C.Email
from Employees E
Right join  Solds S ON E.EmployeeID = S.EmployeeID
	Right join Clients C ON S.ClientID = C.ClientID
Where C.Email is Null



/* 
5 Display a table that will contain information about the shoe models that were sold in the years,
and additionally provide information on how many units of each model were sold and the average price of the shoes.
*/

Select 
	YEAR(SD.SaleDate) AS SaleYear, 
	Sh.Model, 
	COUNT(Sh.Model) ModelCount,
	AVG(P.BasePrice) AS AvgPrice 
from SalesDates SD
Left join Solds So ON SD.SalesDateID = So.SalesDateID
	Left join Shoes Sh ON So.ShoesID = Sh.ShoesID
		Inner join Prices P ON Sh.ShoesID = P.PriceID
Where SD.SaleDate like '____%'
GROUP BY YEAR(SD.SaleDate), Sh.Model
ORDER BY SaleYear ASC


--6 Display a table that contains information about how much a Seller earns in a month

--Only for Cashier
Select 
	Em.EmployeeID, 
	CONCAT(Em.FirstName,' ', Em.Surname) AS Employee, 
	P.NamePosition,
	Ea.Salary AS MonthlySalary
From Employees Em
	inner join Earnings Ea ON Em.EarningID = Ea.EarningID
	inner Join Positions P ON Em.PositionID = P.PositionID
Where P.NamePosition Like 'Cashier'

--For Cashier & Sales Assistant
Select 
	Em.EmployeeID, 
	CONCAT(Em.FirstName,' ', Em.Surname) AS Employee, 
	P.NamePosition,
	Ea.Salary AS MonthlySalary
From Employees Em
	inner join Earnings Ea ON Em.EarningID = Ea.EarningID
	inner Join Positions P ON Em.PositionID = P.PositionID
Where P.NamePosition Like 'Cashier%'
Order by Ea.Salary DESC



--7 Show the first 8 shoes of the 'Sneakers' type and display information about them, such as BrandName, Model, and NameCategory.

Select Top 8  
	S.BrandName, 
	S.Model, 
	C.NameCategory 
From Shoes S
Join CategoriesShoes C ON S.CategoryID = C.CategoryID
Where C.NameCategory = 'Sneakers'


--8 Show the shoes from the Adidas brand and add the black color to them.

SELECT 
	S.BrandName, 
	S.Model,
	C.ColourName
FROM Shoes S join Colours C
ON S.ColourID = C.ColourID 
WHERE S.BrandName = 'Adidas' and C.ColourName = 'Black'



--9 Show the most expensive shoes and provide their BrandName, Model, Color, and type of shoes (Women's and Men's).

Select 
	BrandName,
	Model,
	Max(BasePrice),
	C.ColourName,
	G.NameGender
From Shoes Sh
Join Prices P ON Sh.ShoesID = P.ShoesID
Join Colours C ON Sh.ColourID = C.ColourID
Join Gender G ON Sh.GenderID = G.GenderID
Group by BrandName, Model, C.ColourName, G.NameGender
Order by BrandName ASC




--10 Show BrandName, Model, Collaboration, NameGender (Men's), ColourName, and shoe sizes in EU from 40.00 to 44.00

Select 
	Sh.BrandName,  
	Sh.Model,
	Sh.Collaboration,
	G.NameGender,
	C.ColourName,
	SM.EU
From Shoes Sh
join Gender G ON Sh.GenderID = G.GenderID
join Colours C ON Sh.ColourID = C.ColourID
join SizeForMen SM ON Sh.SizeMID = SM.SizeID
Where G.NameGender = 'male' AND SM.EU BETWEEN 40.00 AND 44.00
Order by SM.EU ASC


-- 11 Show BrandName, Model, NameGender (Women's), ColourName, and shoe sizes in EU and US starting from 6.50

Select 
	Sh.BrandName,  
	Sh.Model,
	G.NameGender,
	C.ColourName,
	SW.EU,
	SW.US
From Shoes Sh
join Gender G ON Sh.GenderID = G.GenderID
join Colours C ON Sh.ColourID = C.ColourID
join SizeForWomen SW ON Sh.SizeWID = SW.SizeID
Where G.NameGender = 'female' AND SW.US >= 6.50
Order by SW.EU ASC


--12 Show the names of 'Puma' shoes, their models, and the number of units sold.

Select
	Sh.BrandName,
	Sh.Model,
	Count(*) as 'Number of sales'
from Shoes Sh
	join Solds Sold ON Sh.ShoesID = Sold.ShoesID
	join SalesDates Sale ON Sold.SalesDateID = Sale.SalesDateID
Where Sh.BrandName = 'Puma' and Sale.SaleDate is not  NULL
Group By Sh.BrandName, Sh.Model


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                         /*widok*/


-- 1 Pokaz informacje KLienow i Spzedawcow(ich Imie i Nazwisko),  Buty (nazwe firmy 'adidas' i ich  Modele) i pokaz  do Butow ich cene


--Stworzy widok

 create view [dbo].[v_SprzedanoButy]
 as 

 select Klient.Imie + ' ' + Klient.Nazwisko as K_ImieNazwisko,
       Pracownik.Imie + ' ' + Pracownik.Nazwisko as P_ImieNazwisko,
       Buty.NazwaFirmy + ' ' + Buty.Modele as B_NazwaModele,
	   Sprzedano.Cena 
	   from Sprzedano
	                 left join Klient
	                    on Sprzedano.KlientID = klient.ID
					 left join Pracownik 
					    on Sprzedano.PracownikID = Pracownik.ID 
					 left join Buty
					    on Sprzedano.ButyID = Buty.ID
					
						

where Buty.NazwaFirmy = 'Adidas'
group by Klient.ID, Klient.Imie + ' ' + Klient.Nazwisko, Pracownik.Imie + ' ' + Pracownik.Nazwisko, Buty.NazwaFirmy + ' ' + Buty.Modele, Sprzedano.Cena 




--Pokaz widok 
select * from v_SprzedanoButy order by cena asc 

--Usun 
IF OBJECT_ID('v_SprzedanoButy') IS NOT NULL
DROP VIEW [dbo].[v_SprzedanoButy]








-- 2 Pokaz Buty (Firme i modele) rodzaj butow 'Klasyczne', ilosc butow za taka cene i ich cene za jaką byli sprzedani

--tworzymy widok 

CREATE VIEW [dbo].[v_ButyKlasyczny]
as 

select distinct Buty.NazwaFirmy + ' ' + Buty.Modele as B_NazwaModele,
       RodzajButow.Nazwa  as R_Nazwa,
	   count(Buty.NazwaFirmy) as 'ilosc butow za taka cene',
	   Sprzedano.Cena as Cena
	                           from Buty 
							            left join RodzajButow 
										          on Buty.RodzajButowID = RodzajButow.ID 
                                         left join Sprzedano 
										           on Buty.ID = Sprzedano.ButyID 

where  Sprzedano.Cena  is not null and RodzajButow.Nazwa = 'Klasyczne'
GROUP BY Buty.NazwaFirmy + ' ' + Buty.Modele,   RodzajButow.Nazwa, Sprzedano.Cena 





--wyswietl widok 

select * from v_ButyKlasyczny order by 'ilosc butow za taka cene' desc 



--Usun 
IF OBJECT_ID('v_ButyKlasyczny') IS NOT NULL
DROP VIEW [dbo].[v_ButyKlasyczny]








--3 Pokaz Buty (Firme i modele 'seria 452') i ich cene za ktorą sprzedali 



--tworzymy widok 

create view [dbo].[v_NewBalance_seria_452]
as

select B.NazwaFirmy, B.Modele, K.NazwaKoloru, R.Nazwa, S.Cena  from   Buty as B full join Kolory as K
                                                                  on B.KolorID = K.ID 
                                                                 full join RodzajButow as R
																 on B.RodzajButowID = R.ID 
																 full join Sprzedano as S
																 on  B.ID = S.ButyID 
where B.Modele =  'seria 452'
group by B.NazwaFirmy, B.Modele, K.Nazwakoloru, R.Nazwa, S.Cena 






--wyswietl  widok 

select * from v_NewBalance_seria_452 order by Cena asc


--Usun 
IF OBJECT_ID('v_NewBalance_seria_452') IS NOT NULL
DROP VIEW [dbo].[v_NewBalance_seria_452]

--lub

DROP VIEW [dbo].[v_NewBalance_seria_452]


-----------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                       /*Procedura*/

-- 1 stworzy procedure w ktorej mozna dodac klientow i informacje o nim w tabele klienci   

CREATE PROCEDURE [Proc_DodajKlienta]                                                       --piszemy parametry
                
				 @Nazwisko nvarchar(100),
				 @Imie nvarchar(100),
				 @Telefon nvarchar(25),
				 @Email nvarchar(50),
				 @Adres nvarchar(50),
				 @Miasto nvarchar(50),
				 @KodPocztowy nvarchar(50)
AS
BEGIN 
                                     --cialo pszechowywanie parametrow
INSERT Klient ( [Nazwisko], [Imie], [Telefon],[Email],[Adres],[Miasto], [KodPocztowy]) 
VALUES( @Nazwisko, @Imie, @Telefon, @Email, @Adres, @Miasto, @KodPocztowy) 

END






-- zeby wykorzystac nasze procedyre (ta procedura swozy do wpisywania dane w tabele 'Kolory' 
EXEC Proc_DodajKlienta 'Kozak', 'Wiktoria', '953-123-657', 'kozakviktoria', 'ul. Filipa 9b', 'Krakow', '312-33' 
EXEC Proc_DodajKlienta 'Kozak', 'Rafal', '932-43-33', 'rafalllhome@gmail.com', 'ul. Koszykarska 19', 'Krakow', null 

--sprzawdż zmiane
select * from Klient 


-- Usun dwa ostatnich wiersza w tabele klient
Delete from Klient where ID >= 16 

-- Zeby usunac procedure
DROP PROCEDURE [Proc_DodajKlienta]






-- 2 Stworz procedure i pokaz w tabele Nazwafirmy butow 'New balance' i ich modele 'seria 452', rodzaj butow, Kolor, rozmiar EU i ich Cena i pokaz ilosc tych butow


CREATE PROCEDURE [Proc_ListaButow] 
@NazwaFirmy nvarchar (100),
@Modele nvarchar (100),
@Ilosc int OUTPUT
AS
BEGIN
	SET NOCOUNT ON 

	SET @Ilosc = (SELECT COUNT(*)
					FROM Buty 
					WHERE NazwaFirmy LIKE @NazwaFirmy AND Modele LIKE @Modele) 

	SELECT Buty.NazwaFirmy, Buty.Modele, RB.Nazwa, K.NazwaKoloru, R.EU, S.Cena
	FROM Buty 
	         LEFT JOIN RodzajButow as RB
			 ON Buty.RodzajButowID = RB.ID

			 LEFT JOIN Kolory as K
			 ON Buty.KolorID = K.ID

			 LEFT JOIN Rozmiar as R
			 ON Buty.RozmiarID = R.ID

			 LEFT JOIN Sprzedano as S
			 on Buty.ID = S.ButyID


	WHERE NazwaFirmy LIKE @NazwaFirmy AND Modele LIKE @Modele and Buty.Modele = 'seria 452' AND  S.Cena IS NOT NULL

END

-- wyswitel
DECLARE @Ilosc INT
EXEC [Proc_ListaButow] 'New%', 'seria 452', @Ilosc OUTPUT  
SELECT @Ilosc as Ilosc


--Usun 
DROP PROCEDURE [Proc_ListaButow] 




-- 3 Stworzy procedure w ktorej mozna wybrac NazweFirmy Butow, Modele, i Ich rozmiar od i do

CREATE PROCEDURE [Proc_WyborButow] 
@NazwaFirmy  nvarchar (100),
@Modele nvarchar (100),
@Od_EU decimal (8,2),
@Do_EU decimal (8,2)

as
select B.NazwaFirmy, B.Modele, R.EU from Rozmiar as R
                                                         left join Buty as B
														 on B.RozmiarID = R.ID 

where @NazwaFirmy like NazwaFirmy and @Modele like Modele and  EU >= @Od_EU and EU <= @Do_EU 
Order by NazwaFirmy, Modele, EU



--ustan  swoj rozmiar 
EXEC Proc_WyborButow  'Adidas','Gazelle', 42,43

--Usun
DROP PROCEDURE [Proc_WyborButow] 





-----------------------------------------------------------------------------------------------------------------------------------------------------------------
                                                       /*Funkcji*/

-- 1 Stworzy funkcje w ktorej mozesz wpisac Cena '395' i wyswietle ci dane: Imie Nazwisko Pracownika(Razem), Imie Nazwisko KLienta(Razem), NazwaFirmy, DataSprzedazy, Cena

-- stworz funknje 

CREATE FUNCTION F_Poszuk
(@Cena decimal(8,2))

RETURNS TABLE 
AS
RETURN 
                 SELECT  Pracownik.Imie +' '+ Pracownik.Nazwisko as ImieNazwisko_Pracownika, 
				         Klient.Imie + '  ' + Klient.Nazwisko as ImieNazwisko_Klienta,
						 Buty.NazwaFirmy , DataZamowieniaSprzedazy.DataSprzedazy,
				         Sprzedano.Cena FROM Sprzedano 
				                       
									    LEFT JOIN Pracownik 
										ON Sprzedano.PracownikID = Pracownik.ID 
										
										LEFT JOIN Klient 
										ON Sprzedano.KlientID = Klient.ID 

										LEFT JOIN Buty  
										ON Sprzedano.ButyID = Buty.ID 

										LEFT JOIN DataZamowieniaSprzedazy
										ON Sprzedano.DataZamowieniaSprzedazyID = DataZamowieniaSprzedazy.ID
								
				                 WHERE Sprzedano.Cena = @Cena 


--Pokaz wynik
SELECT * FROM F_Poszuk(395)

-- usun funkcje 
DROP FUNCTION F_Poszuk







  



--2 stworz funkcje w ktorej ci pokaz ilosc butow konkratnej firmy bez kolobaracji
 

CREATE FUNCTION [F_IloscButow] 
(@NazwaFirmy nvarchar(100)) --Передается наш параметр 

RETURNS INT
AS
BEGIN 
        

	DECLARE @RESULT INT 
	SELECT @RESULT = count(ID) FROM Buty 
	where NazwaFirmy = @NazwaFirmy and  Kolobaracja is null
	RETURN @RESULT 

END


--Pokaz 
SELECT [dbo].[F_IloscButow] ('Adidas')


--Usun 
DROP FUNCTION F_IloscButow









--3 stworzy funkcje. i znajdz za numerem '23' ID Butow,  klienta  


CREATE FUNCTION F_Poszuk_Klienta
(@Buty_ID int)

RETURNS TABLE 
AS
RETURN 
                 SELECT  Klient.Imie + '  ' + Klient.Nazwisko as ImieNazwisko_Klienta,
				         Klient.Telefon,
						 DataZamowieniaSprzedazy.DataSprzedazy,
				         Sprzedano.Cena FROM Sprzedano 
										
										LEFT JOIN Klient 
										ON Sprzedano.KlientID = Klient.ID 

										LEFT JOIN DataZamowieniaSprzedazy
										ON Sprzedano.DataZamowieniaSprzedazyID = DataZamowieniaSprzedazy.ID
								
				                 WHERE Sprzedano.ButyID = @Buty_ID

--Pokaz wynik
SELECT * FROM  F_Poszuk_Klienta('23')

-- usun funkcje 
DROP FUNCTION F_Poszuk_Klienta







