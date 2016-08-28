CREATE TABLE [dbo].[evaluation_type]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[name] [nchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[evaluation_type] ADD CONSTRAINT [PK_evaluation_type] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
