/************************************************************************************************
Script name: 03 - Constraints.ForeignKeys
Description: This script will create the FKs and references in tables
Author: CS
Date: 08/22/2016
Version: 1.0
************************************************************************************************/
USE [ScreeningProject]
GO

ALTER TABLE [dbo].[Order_OrderItems] ADD FOREIGN KEY (Order_Id) REFERENCES [dbo].[Order](Id)
ALTER TABLE [dbo].[Order_OrderItems] ADD FOREIGN KEY (OrderItems_Id) REFERENCES [dbo].[OrderItems](Id)
GO			
			
ALTER TABLE [dbo].[Supplier_Product] ADD FOREIGN KEY (Supplier_Id) REFERENCES [dbo].[Supplier](Id)
ALTER TABLE [dbo].[Supplier_Product] ADD FOREIGN KEY (Product_Id) REFERENCES [dbo].[Product](Id)
GO			
			
ALTER TABLE [dbo].[Subsidiarie] ADD FOREIGN KEY (Address_Id) REFERENCES [dbo].[Address](Id)
ALTER TABLE [dbo].[Subsidiarie] ADD FOREIGN KEY (Company_Id) REFERENCES [dbo].[Company](Id)
ALTER TABLE [dbo].[Subsidiarie] ADD FOREIGN KEY (ContactBalancer_Id) REFERENCES [dbo].[ContactBalancer](Id)
GO			
			
ALTER TABLE [dbo].[Company] ADD FOREIGN KEY (Address_Id) REFERENCES [dbo].[Address](Id)
ALTER TABLE [dbo].[Company] ADD FOREIGN KEY (ContactBalancer_Id) REFERENCES [dbo].[ContactBalancer](Id)
GO			
			
ALTER TABLE [dbo].[Customer] ADD FOREIGN KEY (Address_Id) REFERENCES [dbo].[Address](Id)
ALTER TABLE [dbo].[Customer] ADD FOREIGN KEY (ContactBalancer_Id) REFERENCES [dbo].[ContactBalancer](Id)
GO			
			
ALTER TABLE [dbo].[Supplier] ADD FOREIGN KEY (Company_Id) REFERENCES [dbo].[Company](Id)
GO			
			
ALTER TABLE [dbo].[Order] ADD FOREIGN KEY (Customer_Id) REFERENCES [dbo].[Customer](Id)
ALTER TABLE [dbo].[Order] ADD FOREIGN KEY (Subsidiarie_Id) REFERENCES [dbo].[Subsidiarie](Id)
GO			
			
ALTER TABLE [dbo].[OrderItems] ADD FOREIGN KEY (ProductCompanyPrice_Id) REFERENCES [dbo].[ProductCompanyPrice](Id)
ALTER TABLE [dbo].[OrderItems] ADD FOREIGN KEY (Order_Id) REFERENCES [Order](Id)
GO			
			
ALTER TABLE [dbo].[ProductCompanyPrice] ADD FOREIGN KEY (Product_Id) REFERENCES [dbo].[Product](Id)
ALTER TABLE [dbo].[ProductCompanyPrice] ADD FOREIGN KEY (Company_Id) REFERENCES [dbo].[Company](Id)
GO			
			
ALTER TABLE [dbo].[Contact] ADD FOREIGN KEY (ContactBalancer_Id) REFERENCES [dbo].[ContactBalancer](Id)
ALTER TABLE [dbo].[Contact] ADD FOREIGN KEY (ContactType_Id) REFERENCES [dbo].[ContactType](Id)
GO