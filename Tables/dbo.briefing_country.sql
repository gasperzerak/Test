CREATE TABLE [dbo].[briefing_country]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[brf_id] [int] NULL,
[lco_id] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[briefing_country] ADD CONSTRAINT [PK_briefing_country] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[briefing_country] ADD CONSTRAINT [FK_briefing_country_brf] FOREIGN KEY ([brf_id]) REFERENCES [dbo].[briefing] ([id]) ON DELETE CASCADE
GO
