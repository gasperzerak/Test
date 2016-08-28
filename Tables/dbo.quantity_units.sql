CREATE TABLE [dbo].[quantity_units]
(
[id] [int] NOT NULL,
[name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[quantity_units] ADD CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
