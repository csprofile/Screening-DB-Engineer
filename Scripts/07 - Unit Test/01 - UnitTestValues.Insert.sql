USE [ScreeningProject]
GO

/************************************************************************************************
Script name: 01 - UnitTestValues.Insert
Description: This script will create data values for unit test (Check folder "scripts/07 - Unit Test")
Author: CS
Date: 08/22/2016
Version: 1.0
************************************************************************************************/

INSERT INTO [dbo].[Address](
	 ZipCode
	,Street
	,[State]
	,Number
	,City
	,Country
)
VALUES
	 (99778801, 'Gen. Victor Algusto', 'Rio Grande do Sul', 225, 'Porto Alegre', 'Brasil')
	,(99778802, 'Av. Pedro Alvares Cabral', 'São Paulo', 1022, 'São Paulo', 'Brasil')
	,(55667723, 'Rua Ametista Oliveira', 'Rio de Janeiro', 15, 'Rio de Janeiro', 'Brasil')
	,(11442255, 'Rua Julia Rosa Flores', 'Paraná', 138, 'Curitiba', 'Brasil')
	,(12344568, 'Rua das Areias', 'Santa Catarina', 1510, 'Joinvile', 'Brasil')
	,(77895548, 'Av. Guanabara', 'Pernambuco', 1510, 'Recife', 'Brasil')
GO

INSERT INTO [dbo].[ContactBalancer] DEFAULT VALUES
INSERT INTO [dbo].[ContactBalancer] DEFAULT VALUES
INSERT INTO [dbo].[ContactBalancer] DEFAULT VALUES
INSERT INTO [dbo].[ContactBalancer] DEFAULT VALUES
INSERT INTO [dbo].[ContactBalancer] DEFAULT VALUES
INSERT INTO [dbo].[ContactBalancer] DEFAULT VALUES
GO

INSERT INTO [dbo].[Company] 
(
	 CUIT
	,Name
	,WebSite
	,StartDate
	,Address_Id
	,ContactBalancer_Id
)
VALUES
	 (11111, 'Best Buy', 'www.bestbuy.com','2016-01-02',1,1)
	,(22222, 'Deal Extreme','www.dx.com','2010-01-01',2,2)
GO

INSERT INTO [dbo].[Subsidiarie](
	 SUIT
	,NickName
	,Address_Id
	,Company_Id
	,ContactBalancer_Id
)
VALUES
	  (11333, 'Bestbuy - Brasil', 3, 1, 3)
	 ,(11444, 'Bestbuy - EUA', 4, 1, 4)
GO

INSERT INTO [dbo].[Customer](
	 DocNumber
	,Name
	,Birth
	,Address_Id
	,ContactBalancer_Id
)
VALUES
	  (83417524091, 'João da Silva', '1980-07-28', 5, 5)
	 ,(8899002211, 'Maria Mercedes', '1984-01-25', 6, 6)
GO

INSERT INTO [dbo].[Supplier] (Company_Id) VALUES (2)
GO

INSERT INTO [dbo].[Contact](
	Value
	,ContactBalancer_Id
	,ContactType_Id
)
VALUES
	 ('bestbuyprincipal@bestbuy.com.br', 1, 1)
	,('bestbuybrasil@bestbuy.com.br', 3, 1)
	,('bestbuyeua@bestbuy.com.br', 4, 1)
	,('33554444', 3, 3)
	,('55887755', 4, 4)
	,('jSilva',5, 5)
	,('MariaMercedes',6,5)
	,('85477856',6,2)
GO

INSERT INTO [dbo].[Product](
	Name
	,Price
	,[Description]
)
VALUES
	 ('Action Figure Goku', 10.00, 'Action figure Dragon Toy - Goku Lvl 1')
	,('Book Hyrule Historia', 22.90, 'Book of The Legend of Zelda Game')
	,('Mouse Razor XPTO', 59.00, 'Mouse pro gamer')
	,('Pen Drive Kingstom 32GB',15.00,'Pen Drive')
GO

INSERT INTO [dbo].[Supplier_Product](
	 Supplier_Id
	,Product_Id
)
VALUES
	 (1,1)
	,(1,2)
	,(1,3)
	,(1,4)
GO

INSERT INTO [dbo].[ProductCompanyPrice](
	 Product_Id
	,Company_Id
	,Price
)
VALUES
	 (1,1,11.00)
	,(2,1,29.99)
	,(3,1,67.70)
	,(4,1,28.90)
GO

INSERT INTO [dbo].[Order](
	 Customer_Id
	,Subsidiarie_Id
	,[Date]
)
VALUES
	 (1,1,GETDATE())
	,(1,2,GETDATE())
	,(2,2,GETDATE())
GO

INSERT INTO [dbo].[OrderItems](
	 ProductCompanyPrice_Id
	,Order_Id
	,Qtd
)
VALUES
	 (1,1,1)
	,(2,1,3)
	,(1,2,2)
	,(2,3,2)
	,(3,3,1)
	,(4,3,4)