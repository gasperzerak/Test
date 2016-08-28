CREATE TABLE [dbo].[geographical_scope]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[name] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[weight] [numeric] (5, 3) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[geographical_scope] ADD CONSTRAINT [PK_geographical_scope] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
