CREATE TABLE [dbo].[briefing_appl_forms]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[brf_id] [int] NULL,
[apf_id] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[briefing_appl_forms] ADD CONSTRAINT [PK_briefing_appl_forms] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[briefing_appl_forms] ADD CONSTRAINT [FK_briefing_appl_forms_apf] FOREIGN KEY ([apf_id]) REFERENCES [dbo].[appl_forms] ([id])
GO
ALTER TABLE [dbo].[briefing_appl_forms] ADD CONSTRAINT [FK_briefing_appl_forms_brf] FOREIGN KEY ([brf_id]) REFERENCES [dbo].[briefing] ([id]) ON DELETE CASCADE
GO
