CREATE TABLE [dbo].[tech_docs]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[title] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[data] [image] NULL,
[date] [datetime] NULL,
[brf_id] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[tech_docs] ADD CONSTRAINT [PK_tech_docs] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tech_docs] ADD CONSTRAINT [FK_tech_docs_briefing] FOREIGN KEY ([brf_id]) REFERENCES [dbo].[briefing] ([id]) ON DELETE CASCADE
GO
