USE [ScreeningProject]
GO

/************************************************************************************************
Script name: 02 - dbo.InsteadInsert_OrderItems.Trigger
Tested object: InsteadInsert_OrderItems [TRIGGER]
Description: This script will test restrictions to insert data in the table "OrderItems"
Author: CS
Date: 08/22/2016
Version: 1.0
IMPORTANT: Execute script in test database and check results in "TestStatus" column 
************************************************************************************************/

SET NOCOUNT ON
SET ANSI_WARNINGS OFF

GO

BEGIN TRAN
	--Creating Mock environment
	DECLARE @OrderItems_Test TABLE (
		 Id						INT IDENTITY(1,1)
		,ProductCompanyPrice_Id INT
		,Order_Id				INT
		,Qtd					INT
		,TESTRESULT				VARCHAR(MAX) DEFAULT 'No error'
		,RIGHTRESULT			VARCHAR(MAX)
	)
	DECLARE @Subsidiarie_Id INT
	DECLARE @Company_Id INT
	DECLARE @Order_Id INT
	DECLARE @Test_Id INT = 1
	DECLARE @ReseedVal INT

	--Force company 3
	INSERT INTO [dbo].[Company] (CUIT, Address_Id, ContactBalancer_Id) VALUES (99, 3, 3)
	SET @Company_Id = SCOPE_IDENTITY()
	--Force subsidiarie for company 3
	INSERT INTO [dbo].[Subsidiarie] VALUES (9999, 'Test', 1, @Company_Id, 1)
	SET @Subsidiarie_Id = SCOPE_IDENTITY()
	--Force order for company 3
	INSERT INTO [dbo].[Order] VALUES (1, @Subsidiarie_Id, GETDATE())
	SET @Order_Id = SCOPE_IDENTITY()

	--Dummy data and expected results
	INSERT INTO @OrderItems_Test (ProductCompanyPrice_Id, Order_Id, Qtd, RIGHTRESULT) VALUES (1, @Order_Id, 10, 'Item must be sold by same company of purchase Order')
	INSERT INTO @OrderItems_Test (ProductCompanyPrice_Id, Order_Id, Qtd, RIGHTRESULT) VALUES (1,1,10,'No error')

	WHILE(@Test_Id <= (SELECT COUNT(*) FROM @OrderItems_Test))BEGIN
		BEGIN TRY
			BEGIN TRAN
				INSERT INTO [dbo].[OrderItems] (ProductCompanyPrice_Id, Order_Id, Qtd)
				SELECT ProductCompanyPrice_Id, Order_Id, Qtd
				FROM @OrderItems_Test 
				WHERE Id = @Test_Id
			ROLLBACK
		END TRY
		BEGIN CATCH
			UPDATE @OrderItems_Test SET TESTRESULT = ERROR_MESSAGE() WHERE Id = @Test_Id
			ROLLBACK
		END CATCH

		SET @Test_Id += 1
	END

	--Reseed Company
	SELECT @ReseedVal = ISNULL(max(Id),0)+1 FROM [dbo].[Company]
	DBCC CHECKIDENT('Company', RESEED, @ReseedVal)
	--Reseed Subsidiarie
	SELECT @ReseedVal = ISNULL(max(Id),0)+1 FROM [dbo].[Subsidiarie]
	DBCC CHECKIDENT('Subsidiarie', RESEED, @ReseedVal)
	--Reseed Order
	SELECT @ReseedVal = ISNULL(max(Id),0)+1 FROM [dbo].[Order]
	DBCC CHECKIDENT('[Order]', RESEED, @ReseedVal)
	--Reseed OrderItems
	SELECT @ReseedVal = ISNULL(max(Id),0)+1 FROM [dbo].[OrderItems]
	DBCC CHECKIDENT('OrderItems', RESEED, @ReseedVal)

SELECT *,IIF(TESTRESULT = RIGHTRESULT, 'OK', 'FAIL') AS TestStatus FROM @OrderItems_Test