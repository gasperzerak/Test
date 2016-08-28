IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'LAB\tec-sp-admin')
CREATE LOGIN [LAB\tec-sp-admin] FROM WINDOWS
GO
CREATE USER [LAB\tec-sp-admin] FOR LOGIN [LAB\tec-sp-admin]
GO
