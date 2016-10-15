USE [ScreeningProject]
GO

CREATE TRIGGER [dbo].[InsteadInsert_OrderItems] on [dbo].[OrderItems]
INSTEAD OF INSERT
AS
BEGIN
	/***********************************************************************************************************************************************
	InsteadInsert_OrderItems
	Description: This trigger will ensure that a purchase order issued by a subsidiary will not have items from company unrelated to this subsidiary
	Author: CS
	Date: 08/22/2016
	Version: 1.0
	************************************************************************************************************************************************/
	DECLARE @Subsidiarie_Company_Id INT
	DECLARE @ProductCompanyPrice_Company_Id INT

	SELECT 
		 @Subsidiarie_Company_Id			= T03.Company_Id
		,@ProductCompanyPrice_Company_Id	= T04.Company_Id
	FROM
		inserted								T01 
		INNER JOIN [dbo].[Order]				T02 ON T02.Id = T01.Order_Id
		INNER JOIN [dbo].[Subsidiarie]			T03 ON T03.Id = T02.Subsidiarie_Id
		INNER JOIN [dbo].[ProductCompanyPrice]	T04 ON T04.Id = T01.ProductCompanyPrice_Id

	
	IF(@Subsidiarie_Company_Id = @ProductCompanyPrice_Company_Id)BEGIN
		INSERT INTO 
			[dbo].[OrderItems]
		SELECT
			 [ProductCompanyPrice_Id]
			,[Order_Id]
			,[Qtd]
       FROM 
			inserted
	END
	ELSE BEGIN
		RAISERROR('Item must be sold by same company of purchase Order', 16, 1)
	END
END
GO