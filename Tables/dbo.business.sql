CREATE TABLE [dbo].[business]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[name] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[business] ADD CONSTRAINT [PK_business] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
