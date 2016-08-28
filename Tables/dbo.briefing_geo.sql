CREATE TABLE [dbo].[briefing_geo]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[brf_id] [int] NULL,
[geo_id] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[briefing_geo] ADD CONSTRAINT [PK_briefing_geo] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[briefing_geo] ADD CONSTRAINT [FK_briefing_geo_briefing] FOREIGN KEY ([brf_id]) REFERENCES [dbo].[briefing] ([id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[briefing_geo] ADD CONSTRAINT [FK_briefing_geo_geo] FOREIGN KEY ([geo_id]) REFERENCES [dbo].[geographical_scope] ([id])
GO
