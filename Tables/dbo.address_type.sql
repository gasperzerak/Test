CREATE TABLE [dbo].[address_type]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[name] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[address_type] ADD CONSTRAINT [PK_address_type] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
