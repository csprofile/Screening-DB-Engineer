@ECHO IMPORTANT: Before create mirror server make sure that the scripts in the folder "scripts/06 - Mirror" are properly configured according to the instructions in the header!
pause
sqlcmd -S localhost -i "..\Scripts\06 - Mirror\01 - MainServer.Backup.sql"
sqlcmd -S localhost -i "..\Scripts\06 - Mirror\02 - MainServer.CreatePublication.sql"
sqlcmd -S localhost -i "..\Scripts\06 - Mirror\03 - MainServer.CreateSubscription.sql"

sqlcmd -S localhost\MIRROR -i "..\Scripts\06 - Mirror\04 - MirrorServer.CreateMirror.sql"