@ECHO IMPORTANT: This script will drop your database, if you are unsure if you want it, close this windows!
pause
sqlcmd -S localhost -i "..\Scripts\xx - DropObjects\01 - MainServer.DropAllObjects.sql"