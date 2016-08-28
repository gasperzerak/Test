CREATE TABLE [dbo].[quantity_description]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[name] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[dialYn] [bit] NOT NULL,
[unit] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[quantity_description] ADD CONSTRAINT [PK_quantity_description] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
