USE ScreeningProject
GO

/************************************************************************************************
Script name: 03 - dbo.InsteadInsert_ProductCompanyPrice.Trigger
Tested object: InsteadInsert_ProductCompanyPrice [TRIGGER]
Description: This script will test restrictions to insert data in the table "ProductCompanyPrice"
Author: CS
Date: 08/22/2016
Version: 1.0
IMPORTANT: Execute script in test database and check results in "TestStatus" column 
************************************************************************************************/

BEGIN TRAN
	--Creating Mock environment
	DECLARE @ProductCompanyPrice_Test TABLE (
		 Id INT IDENTITY(1,1)
		,Product_Id		INT
		,Company_Id		INT
		,Price			INT
		,TESTRESULT		VARCHAR(MAX) DEFAULT 'No error'
		,RIGHTRESULT	VARCHAR(MAX)
	)
	DECLARE @Subsidiarie_Id INT
	DECLARE @Order_Id INT
	DECLARE @Test_Id INT = 1
	DECLARE @ReseedVal INT


	--Dummy data and expected results
	INSERT INTO @ProductCompanyPrice_Test (Product_Id, Company_Id, Price, RIGHTRESULT) VALUES (1, 2, 10, 'Supplier cannot sell your own product')
	INSERT INTO @ProductCompanyPrice_Test (Product_Id, Company_Id, Price, RIGHTRESULT) VALUES (1,1,10,'No error')

	WHILE(@Test_Id <= (SELECT COUNT(*) FROM @ProductCompanyPrice_Test))BEGIN
		BEGIN TRY
			BEGIN TRAN
				INSERT INTO [dbo].[ProductCompanyPrice] (Product_Id, Company_Id, Price)
				SELECT Product_Id, Company_Id, Price
				FROM @ProductCompanyPrice_Test 
				WHERE Id = @Test_Id
			ROLLBACK
		END TRY
		BEGIN CATCH
			UPDATE @ProductCompanyPrice_Test SET TESTRESULT = ERROR_MESSAGE() WHERE Id = @Test_Id
			ROLLBACK
		END CATCH

		SET @Test_Id += 1
	END

	
	--Reseed ProductCompanyPrice
	SELECT @ReseedVal = ISNULL(max(Id),0)+1 FROM [dbo].[ProductCompanyPrice]
	DBCC CHECKIDENT('ProductCompanyPrice', RESEED, @ReseedVal)

SELECT *,IIF(TESTRESULT = RIGHTRESULT, 'OK', 'FAIL') AS TestStatus FROM @ProductCompanyPrice_Test