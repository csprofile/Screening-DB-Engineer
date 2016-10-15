USE ScreeningProject
GO

--Getting how much products did a certain company order per month, broken down into subsidiaries.
SELECT
	 T03.CUIT AS CompanyCod
	,T06.NickName
	,DATEPART(MONTH,T05.[Date]) AS [Month]
	,SUM(T01.Price * T04.Qtd) AS SalesPerMonth
FROM
	ProductCompanyPrice		T01
	INNER JOIN Product		T02		ON T02.Id = T01.Product_Id
	INNER JOIN Company		T03		ON T03.Id = T01.Company_Id
	INNER JOIN OrderItems	T04		ON T04.ProductCompanyPrice_Id = T01.Id
	INNER JOIN [Order]		T05		ON T05.Id = T04.Order_Id
	INNER JOIN Subsidiarie	T06		ON T06.Id = T05.Subsidiarie_Id
WHERE
	DATEPART(YEAR,T05.[Date]) = '2016'
GROUP BY
	 T03.CUIT
	,T06.NickName
	,DATEPART(MONTH,T05.[Date])