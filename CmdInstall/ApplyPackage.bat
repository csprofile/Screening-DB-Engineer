sqlcmd -S localhost -i "..\Scripts\01 - Model\01 - Base.Tables.sql"
sqlcmd -S localhost -i "..\Scripts\01 - Model\02 - Relashionship.Tables.sql"
sqlcmd -S localhost -i "..\Scripts\01 - Model\03 - Constraints.ForeignKeys.sql"

sqlcmd -S localhost -i "..\Scripts\02 - Objects\01 - dbo.InsteadInsert_OrderItems.Trigger.sql"
sqlcmd -S localhost -i "..\Scripts\02 - Objects\02 - dbo.InsteadInsert_ProductCompanyPrice.Trigger.sql"
sqlcmd -S localhost -i "..\Scripts\02 - Objects\03 - dbo.InsertNewSubsidiarie.StoredProcedure.sql"
          
sqlcmd -S localhost -i "..\Scripts\03 - Jobs\01 - Backup.Job.sql"
sqlcmd -S localhost -i "..\Scripts\04 - Data\01 - DefaultValues.Insert.sql"