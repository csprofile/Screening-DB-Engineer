USE [ScreeningProject]
GO

/************************************************************************************************
Script name: 04 - dbo.InsertNewSubsidiarie.StoredProcedure
Tested object: InsteadInsert_ProductCompanyPrice [STOREDPROCEDURE]
Description: This script will test the creation of new subsidiarie
Author: CS
Date: 08/22/2016
Version: 1.0
IMPORTANT: Execute script in test database and check results in "TestStatus" column 
************************************************************************************************/

--Creating Mock environment
DECLARE @NewSubsidiarie_Test TABLE(
	Id				INT IDENTITY(1,1)
	,RIGHTRESULT	VARCHAR(MAX)
	,TESTRESULT		VARCHAR(MAX) DEFAULT 'No Error'
)

DECLARE @ReseedVal INT

--Dummy data and expected results
INSERT INTO @NewSubsidiarie_Test (RIGHTRESULT) VALUES ('Company doesn''t exist and AutoCreateCompany parameter is off')
INSERT INTO @NewSubsidiarie_Test (RIGHTRESULT) VALUES ('No error')

BEGIN TRY
	BEGIN TRAN
		--TEST 001
		EXEC [dbo].[InsertNewSubsidiarie]
			@Subsidiarie_SUIT				= 8877
			,@Subsidiarie_NickName			= 'New Subsidiarie Test'
			,@Company_CUIT					= 333
			,@AutoCreateCompany				= 0
	ROLLBACK
END TRY
BEGIN CATCH
	UPDATE @NewSubsidiarie_Test SET TESTRESULT = ERROR_MESSAGE() WHERE Id = 1
	ROLLBACK
END CATCH
	
BEGIN TRY
	BEGIN TRAN
		--TEST 002
		EXEC [dbo].[InsertNewSubsidiarie]
			@Subsidiarie_SUIT				= 8877
			,@Subsidiarie_NickName			= 'New Subsidiarie Test'
			,@Company_CUIT					= 333
			,@AutoCreateCompany				= 1
	ROLLBACK
END TRY
BEGIN CATCH
	UPDATE @NewSubsidiarie_Test SET TESTRESULT = ERROR_MESSAGE() WHERE Id = 2
	ROLLBACK
END CATCH


	
--Ressed ContactBalancer
SELECT @ReseedVal = ISNULL(max(Id),0)+1 FROM [dbo].[ContactBalancer]
DBCC CHECKIDENT('ContactBalancer', RESEED, @ReseedVal)
--Ressed Address
SELECT @ReseedVal = ISNULL(max(Id),0)+1 FROM [dbo].[Address]
DBCC CHECKIDENT('[Address]', RESEED, @ReseedVal)
--Ressed Company
SELECT @ReseedVal = ISNULL(max(Id),0)+1 FROM [dbo].[Company]
DBCC CHECKIDENT('Company', RESEED, @ReseedVal)
--Ressed Subsidiarie
SELECT @ReseedVal = ISNULL(max(Id),0)+1 FROM [dbo].[Subsidiarie]
DBCC CHECKIDENT('Subsidiarie', RESEED, @ReseedVal)


SELECT *,IIF(TESTRESULT = RIGHTRESULT, 'OK', 'FAIL') AS TestStatus FROM @NewSubsidiarie_Test