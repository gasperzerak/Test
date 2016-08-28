CREATE TABLE [dbo].[status]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[status] ADD CONSTRAINT [PK_briefing_status] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
