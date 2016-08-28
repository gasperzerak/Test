CREATE TABLE [dbo].[supplier_status]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[supplier_status] ADD CONSTRAINT [PK_supplier_type] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
