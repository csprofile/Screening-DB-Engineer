USE [ScreeningProject]
GO

CREATE TRIGGER [dbo].[InsteadInsert_ProductCompanyPrice] on [dbo].[ProductCompanyPrice]
INSTEAD OF INSERT
AS
BEGIN
	/*****************************************************************************************************************
	InsteadInsert_ProductCompanyPrice
	Description: This trigger will ensure that a supplier can't give the price of your own product as a buyer company
	Author: CS
	Date: 08/22/2016
	Version: 1.0
	******************************************************************************************************************/
	DECLARE @Product_Id INT

	SELECT 
		 @Product_Id			= T02.Id
	FROM
		inserted								T01 
		INNER JOIN	[dbo].[Product]				T02		ON		T02.Id = T01.Product_Id
		INNER JOIN	[dbo].[Supplier_Product]	T03		ON		T03.Product_Id = T02.Id
		INNER JOIN	[dbo].[Supplier]			T04		ON		T04.Id = T03.Supplier_Id
	WHERE
		T04.Company_Id = T01.Company_Id

	
	IF(@Product_Id IS NULL)BEGIN
		INSERT INTO 
			[dbo].[ProductCompanyPrice]
		SELECT
			Product_Id
			,Company_Id
			,Price
       FROM 
			inserted
	END
	ELSE BEGIN
		RAISERROR('Supplier cannot sell your own product', 16, 1)
	END
END
GO