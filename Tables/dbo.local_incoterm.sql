CREATE TABLE [dbo].[local_incoterm]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[local_incoterm] ADD CONSTRAINT [PK_local_incoterm] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
