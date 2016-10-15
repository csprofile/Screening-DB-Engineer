USE [ScreeningProject]
GO

/************************************************************************************************
Script name: 01 - DefaultValues.Insert
Description: This script will create predefined values for parameterizable tables  
Author: CS
Date: 08/22/2016
Version: 1.0
************************************************************************************************/

--IMPORTANT: ContactType Ids are used in InsertNewSubsidiarie Stored Procedure, do not change the insert order
INSERT INTO [dbo].[ContactType] VALUES
	 ('EMail')
	,('Cell')
	,('Phone')
	,('Fax')
	,('Skype')
GO