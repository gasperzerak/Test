IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'DEHENSV643\maestro')
CREATE LOGIN [DEHENSV643\maestro] FROM WINDOWS
GO
CREATE USER [DEHENSV643\maestro] FOR LOGIN [DEHENSV643\maestro]
GO