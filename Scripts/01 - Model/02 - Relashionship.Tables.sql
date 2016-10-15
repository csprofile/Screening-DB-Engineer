/************************************************************************************************
Script name: 02 - Relashionship.Tables
Description: This script will create the relashionship [N...N] tables for the project
Author: CS
Date: 08/22/2016
Version: 1.0
************************************************************************************************/
USE [ScreeningProject]
GO


CREATE TABLE [dbo].[Order_OrderItems](
	 [Id]				INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	,[Order_Id]			INT NOT NULL
	,[OrderItems_Id]	INT NOT NULL
)

CREATE TABLE [dbo].[Supplier_Product](
	  [Id]				INT IDENTITY(1,1) NOT NULL PRIMARY KEY
	 ,[Supplier_Id]		INT
	 ,[Product_Id]		INT
)