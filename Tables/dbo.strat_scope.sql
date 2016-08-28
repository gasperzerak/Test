CREATE TABLE [dbo].[strat_scope]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[name] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[strat_scope] ADD CONSTRAINT [PK_strat_scope] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
