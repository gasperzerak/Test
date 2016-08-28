CREATE TABLE [dbo].[units]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[dialYn] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[units] ADD CONSTRAINT [PK_units] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
