USE ScreeningProject
GO

--Getting total orders paid from all companies coming from a specific end-customer.
SELECT
	COUNT(*) AS TotalOrders
	,T03.Name
FROM
	[Order] T01
	INNER JOIN Subsidiarie T02 ON T02.Id = T01.Subsidiarie_Id
	INNER JOIN Customer	   T03 ON T03.Id = T01.Customer_Id
WHERE
	T03.Name = 'João da Silva'
GROUP BY
	T03.Name