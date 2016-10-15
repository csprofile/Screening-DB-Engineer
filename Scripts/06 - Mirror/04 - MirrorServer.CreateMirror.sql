/**************************************************************************************************
Script name: 04 - MirrorServer.CreateMirror
Description: This script will restore database in mirror server
Author: CS
Date: 08/22/2016
Version: 1.0
IMPORTANT: The folder C:\BackupSQL must be created before run this script
**************************************************************************************************/
RESTORE DATABASE [ScreeningProject]
FROM DISK = 'C:\BackupSQL\ScreeningProject.bak'
WITH RECOVERY,
MOVE 'ScreeningProject' TO 'C:\Program Files\Microsoft SQL Server\MSSQL12.MIRROR\MSSQL\DATA\ScreeningProject.mdf',
MOVE 'ScreeningProject_log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL12.MIRROR\MSSQL\DATA\ScreeningProject_log.ldf'
GO
