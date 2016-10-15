USE [ScreeningProject]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[InsertNewSubsidiarie]
	 @Subsidiarie_SUIT				BIGINT
	,@Subsidiarie_NickName			VARCHAR(300)
	,@Company_CUIT					BIGINT			
	
	,@Company_Name					VARCHAR(300)	= NULL
	,@Company_WebSite				VARCHAR(100)	= NULL
	,@Company_StartDate				DATETIME		= NULL
	,@Company_Address_ZipCode		INT				= NULL
	,@Company_Address_Street		VARCHAR(300)	= NULL
	,@Company_Address_State			VARCHAR(100)	= NULL
	,@Company_Address_Number		INT				= NULL
	,@Company_Address_City			VARCHAR(100)	= NULL
	,@Company_Address_Country		VARCHAR(100)	= NULL
	,@Company_Contact_EMail			VARCHAR(100)	= NULL
	,@Company_Contact_Phone			VARCHAR(100)	= NULL

	,@Subsidiarie_Address_ZipCode	INT				= NULL
	,@Subsidiarie_Address_Street	VARCHAR(300)	= NULL
	,@Subsidiarie_Address_State		VARCHAR(100)	= NULL
	,@Subsidiarie_Address_Number	INT				= NULL
	,@Subsidiarie_Address_City		VARCHAR(100)	= NULL
	,@Subsidiarie_Address_Country	VARCHAR(100)	= NULL
	,@Subsidiarie_Contact_EMail		VARCHAR(100)	= NULL
	,@Subsidiarie_Contact_Phone		VARCHAR(100)	= NULL
	,@AutoCreateCompany				BIT				= 1
AS
BEGIN
	/*********************************************************************************************************************************************************************************
	InsertNewSubsidiarie
	Description: This stored procedure allows the registration of a new subsidiary, their contact information and register their company information, if it does not exist
	Author: CS
	Date: 08/22/2016
	Version: 1.0

	PARAMETERS:
	@Subsidiarie_SUIT				- SUIT identification of subsidiarie
	@Subsidiarie_NickName			- Nickname of subsidiarie
	@Company_CUIT					- Company CUIT existent or new [Check AutoCreateCompany	parameter]*
	
	-------------------------------In the case of new company
	@Company_Name					- New company name
	@Company_WebSite				- New company web site
	@Company_StartDate				- New company start date
	@Company_Address_ZipCode		- New company zipcode
	@Company_Address_Street			- New company street
	@Company_Address_State			- New company state
	@Company_Address_Number			- New company number [of address]*
	@Company_Address_City			- New company city
	@Company_Address_Country		- New company country
	@Company_Contact_EMail			- New company email
	@Company_Contact_Phone			- New company main contact phone
	-------------------------------

	@Subsidiarie_Address_ZipCode	- New subsidiarie zipcode
	@Subsidiarie_Address_Street		- New subsidiarie street
	@Subsidiarie_Address_State		- New subsidiarie state
	@Subsidiarie_Address_Number		- New subsidiarie number [of address]*
	@Subsidiarie_Address_City		- New subsidiarie city
	@Subsidiarie_Address_Country	- New subsidiarie country
	@Subsidiarie_Contact_EMail		- New subsidiarie email
	@Subsidiarie_Contact_Phone		- New subsidiarie main contact phone

	@AutoCreateCompany				- [1: Allow script to create new company]
									  [0: Verify if company exists, if doesn't exist, the script will return the error "Company doesn't exist and AutoCreateCompany parameter is off"]
	*********************************************************************************************************************************************************************************/
	DECLARE @ContactBalancer_Id INT
	DECLARE @Address_Id INT
	DECLARE @Company_Id INT
	DECLARE @Error_Message VARCHAR(3000)

	SELECT TOP 1 @Company_Id = Id FROM Company WHERE CUIT = @Company_CUIT

	--If company doesn't exist
	IF (@Company_Id IS NULL) BEGIN
		IF(@AutoCreateCompany = 1)BEGIN
			BEGIN TRY
				BEGIN TRAN
					--Creating contact Id for new company
					INSERT INTO [dbo].[ContactBalancer] DEFAULT VALUES
					SET @ContactBalancer_Id = SCOPE_IDENTITY()

					--Inserting contact information
					INSERT INTO [dbo].[Contact] VALUES (@Company_Contact_EMail, @ContactBalancer_Id, 1)
					INSERT INTO [dbo].[Contact] VALUES (@Company_Contact_Phone, @ContactBalancer_Id, 3)

					--Inserting new address
					INSERT INTO [dbo].[Address] (
						 ZipCode
						,Street
						,[State]
						,Number
						,City
						,Country
					)VALUES(
						 @Company_Address_ZipCode
						,@Company_Address_Street
						,@Company_Address_State
						,@Company_Address_Number
						,@Company_Address_City	
						,@Company_Address_Country
					)
					SET @Address_Id = SCOPE_IDENTITY()

					--Creating company
					INSERT INTO [dbo].[Company] (
						 CUIT
						,Name
						,WebSite
						,StartDate
						,Address_Id
						,ContactBalancer_Id
					)VALUES(
						 @Company_CUIT	
						,@Company_Name
						,@Company_WebSite
						,@Company_StartDate
						,@Address_Id
						,@ContactBalancer_Id
					)

					--Geting inserted company Id
					SET @Company_Id = SCOPE_IDENTITY()

					SET @Address_Id = NULL
					SET @ContactBalancer_Id = NULL
				COMMIT TRAN
			END TRY
			BEGIN CATCH
				ROLLBACK TRAN
				SET @Error_Message = ERROR_MESSAGE()
				RAISERROR(@Error_Message,16,1)
				RETURN
			END CATCH
		END
		ELSE BEGIN
			RAISERROR('Company doesn''t exist and AutoCreateCompany parameter is off',16,1)
			RETURN
		END
	END
	

	BEGIN TRY
		BEGIN TRAN
			--Creating contact Id for new company
			INSERT INTO [dbo].[ContactBalancer] DEFAULT VALUES
			SET @ContactBalancer_Id = SCOPE_IDENTITY()

			--Inserting contact information
			INSERT INTO [dbo].[Contact] VALUES (@Subsidiarie_Contact_EMail, @ContactBalancer_Id, 1)
			INSERT INTO [dbo].[Contact] VALUES (@Subsidiarie_Contact_Phone, @ContactBalancer_Id, 3)

			--Inserting new address
			INSERT INTO [dbo].[Address] (
				 ZipCode
				,Street
				,[State]
				,Number
				,City
				,Country
			)VALUES(
				 @Subsidiarie_Address_ZipCode
				,@Subsidiarie_Address_Street
				,@Subsidiarie_Address_State
				,@Subsidiarie_Address_Number
				,@Subsidiarie_Address_City	
				,@Subsidiarie_Address_Country
			)
			SET @Address_Id = SCOPE_IDENTITY()

			--Creating new subsidiarie with relationship to company Id
			INSERT INTO [dbo].[Subsidiarie] (
				 SUIT
				,NickName
				,Address_Id
				,Company_Id
				,ContactBalancer_Id
			)VALUES(
				 @Subsidiarie_SUIT
				,@Subsidiarie_NickName
				,@Address_Id
				,@Company_Id
				,@ContactBalancer_Id
			)
		COMMIT
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN
		SET @Error_Message = ERROR_MESSAGE()
		RAISERROR(@Error_Message,16,1)
		RETURN
	END CATCH
    
END