IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'DEHENSV643\wbwhuadmin')
CREATE LOGIN [DEHENSV643\wbwhuadmin] FROM WINDOWS
GO
CREATE USER [DEHENSV643\wbwhuadmin] FOR LOGIN [DEHENSV643\wbwhuadmin]
GO
