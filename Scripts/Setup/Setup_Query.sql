-- Create the database if it doesn't exist
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'CustomerProductDB')
BEGIN
    CREATE DATABASE CustomerProductDB;
END;

-- Switch to the database
USE CustomerProductDB;

-- Drop tables if they exist to ensure clean setup
IF OBJECT_ID('dbo.DuplicateCustomerAccounts', 'U') IS NOT NULL DROP TABLE dbo.DuplicateCustomerAccounts;
IF OBJECT_ID('dbo.TvProducts', 'U') IS NOT NULL DROP TABLE dbo.TvProducts;
IF OBJECT_ID('dbo.DslProducts', 'U') IS NOT NULL DROP TABLE dbo.DslProducts;
IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL DROP TABLE dbo.Customers;

-- Create Customers table
CREATE TABLE Customers (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Email NVARCHAR(100) NOT NULL,
    Address NVARCHAR(200) NOT NULL
);

-- Create TvProducts table
CREATE TABLE TvProducts (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId INT NOT NULL,
    Product NVARCHAR(50) NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME,
    FOREIGN KEY (CustomerId) REFERENCES Customers(Id)
);

-- Create DslProducts table
CREATE TABLE DslProducts (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CustomerId INT NOT NULL,
    Product NVARCHAR(50) NOT NULL,
    StartDate DATETIME NOT NULL,
    EndDate DATETIME,
    FOREIGN KEY (CustomerId) REFERENCES Customers(Id)
);

-- Insert mock data into Customers
INSERT INTO Customers (Email, Address) VALUES
('john.doe@gmail.com', 'Kyiv, Ukraine'),
('jane.smith@gmail.com', 'Lviv, Ukraine'),
('bob.jones@gmail.com', 'Odessa, Ukraine'),
('alice.brown@gmail.com', 'Kharkiv, Ukraine'),
('max.power@gmail.com', 'Dnipro, Ukraine'),
('max.power@gmail.com', 'Dnipro, Ukraine'),
('sarah.connor@gmail.com', 'Zaporizhzhia, Ukraine');

-- Insert mock data into TvProducts using GETDATE() and DATEADD
INSERT INTO TvProducts (CustomerId, Product, StartDate, EndDate) VALUES
(1, 'TvProd1', GETDATE(), NULL),
(1, 'TvProd2', DATEADD(MONTH, -2, GETDATE()), DATEADD(MONTH, 7, GETDATE())),
(3, 'TvProd3', DATEADD(MONTH, -3, GETDATE()), NULL),
(4, 'TvProd4', DATEADD(MONTH, -4, GETDATE()), DATEADD(MONTH, 8, GETDATE())),
(4, 'TvProd5', DATEADD(MONTH, -1, GETDATE()), NULL),
(5, 'TvProd6', DATEADD(DAY, -10, GETDATE()), NULL),
(7, 'TvProd7', DATEADD(YEAR, -1, GETDATE()), DATEADD(DAY, -1, GETDATE()));

-- Insert mock data into DslProducts using GETDATE() and DATEADD
INSERT INTO DslProducts (CustomerId, Product, StartDate, EndDate) VALUES
(2, 'DslProd1', DATEADD(MONTH, -1, GETDATE()), NULL),
(2, 'DslProd2', GETDATE(), DATEADD(MONTH, 6, GETDATE())),
(3, 'DslProd3', DATEADD(MONTH, -2, GETDATE()), NULL),
(6, 'DslProd4', GETDATE(), NULL),
(7, 'DslProd5', DATEADD(MONTH, -11, GETDATE()), DATEADD(DAY, -1, GETDATE()));
