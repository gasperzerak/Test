CREATE TABLE [dbo].[samples]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[brs_id] [int] NULL,
[name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[winner_yn] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[samples] ADD CONSTRAINT [PK_samples] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[samples] ADD CONSTRAINT [FK_samples_briefing_supplier] FOREIGN KEY ([brs_id]) REFERENCES [dbo].[briefing_supplier] ([id]) ON DELETE CASCADE
GO
