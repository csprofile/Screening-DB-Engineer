/**************************************************************************************************
Script name: 01 - MainServer.Backup
Description: This script will generate backup of database to use table structure to mirror server
Author: CS
Date: 08/22/2016
Version: 1.0
IMPORTANT: The folder C:\BackupSQL must be created before run this script
**************************************************************************************************/

BACKUP DATABASE [ScreeningProject] TO DISK = 'C:\BackupSQL\ScreeningProject.bak';
BACKUP LOG		[ScreeningProject] TO DISK = 'C:\BackupSQL\ScreeningProject.trn';
--Execute Mirror restore