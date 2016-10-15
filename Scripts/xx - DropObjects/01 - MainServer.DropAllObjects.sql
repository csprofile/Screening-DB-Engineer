/***********************************************************************************************************************************************
Script name: 01 - MainServer.DropAllObjects
Description: This script will unstall (drop) the project from db server
Author: CS
Date: 08/22/2016
Version: 1.0
************************************************************************************************************************************************/

USE [MASTER]
GO

EXEC msdb.dbo.sp_removedbreplication 'ScreeningProject'
GO

EXEC msdb.dbo.sp_delete_job  @job_name = N'BACKUP_ScreeningProject'
GO

DROP DATABASE [ScreeningProject]