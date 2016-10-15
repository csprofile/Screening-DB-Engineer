/************************************************************************************************
Script name: 01 - Base.Tables
Description: This script will create the database [ScreeningProject] and base tables for the project
Author: CS
Date: 08/22/2016
Version: 1.0
************************************************************************************************/

CREATE DATABASE [ScreeningProject]
GO

USE [ScreeningProject]
GO

CREATE TABLE [dbo].[Product](
	 [Id]					INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	,[Name]					VARCHAR(300) NOT NULL
	,[Price]				MONEY NOT NULL
	,[Description]			VARCHAR(MAX)
)
GO

CREATE TABLE [dbo].[Company](
	 [Id]					INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	,[CUIT]					BIGINT NOT NULL UNIQUE
	,[Name]					VARCHAR(300)
	,[WebSite]				VARCHAR(100)
	,[StartDate]			DATETIME
	,[Address_Id]			INT NOT NULL UNIQUE
	,[ContactBalancer_Id]	INT UNIQUE
)
GO

CREATE TABLE [dbo].[Subsidiarie](
	 [Id]					INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	,[SUIT]					BIGINT NOT NULL UNIQUE
	,[NickName]				VARCHAR(300) NOT NULL
	,[Address_Id]			INT NOT NULL UNIQUE
	,[Company_Id]			INT NOT NULL
	,[ContactBalancer_Id]	INT UNIQUE
)
GO

CREATE TABLE [dbo].[Supplier](
	  [Id]					INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	 ,[Company_Id]			INT	NOT NULL
)

CREATE TABLE [dbo].[Customer](
	 [Id]					INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	,[DocNumber]			BIGINT NOT NULL UNIQUE
	,[Name]					VARCHAR(300)
	,[Birth]				DATETIME
	,[Address_Id]			INT NOT NULL UNIQUE
	,[ContactBalancer_Id]	INT UNIQUE
)
GO

CREATE TABLE [dbo].[Address](
	 [Id]					INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	,[ZipCode]				INT
	,[Street]				VARCHAR(300)
	,[State]				VARCHAR(100)
	,[Number]				INT
	,[City]					VARCHAR(100)
	,[Country]				VARCHAR(100)
)
GO

CREATE TABLE [dbo].[ContactBalancer](
	  [Id]					INT IDENTITY(1,1) NOT NULL PRIMARY KEY
)
GO

CREATE TABLE [dbo].[Contact](
	 [Id]					INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	,[Value]				VARCHAR(MAX)
	,[ContactBalancer_Id]	INT NOT NULL
	,[ContactType_Id]		INT NOT NULL
)
GO

CREATE TABLE [dbo].[ContactType](
	 [Id]					INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	,[Description]			VARCHAR(MAX)
)
GO

CREATE TABLE [dbo].[Order](
	 [Id]					INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	,[Customer_Id]			INT NOT NULL
	,[Subsidiarie_Id]		INT NOT NULL
	,[Date]					DATETIME
)
GO

CREATE TABLE [dbo].[OrderItems](
	 [Id]						INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	,[ProductCompanyPrice_Id]	INT NOT NULL
	,[Order_Id]					INT NOT NULL
	,[Qtd]						INT
)
GO

CREATE TABLE [dbo].[ProductCompanyPrice](
	 [Id]				INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	,[Product_Id]		INT NOT NULL
	,[Company_Id]		INT NOT NULL
	,[Price]			MONEY NOT NULL
)
GO