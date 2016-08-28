CREATE TABLE [dbo].[briefing_supplier]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[brf_id] [int] NULL,
[sup_id] [int] NULL,
[current_supplier_yn] [bit] NOT NULL,
[winner_yn] [bit] NULL,
[actual_assigned_yn] [bit] NULL CONSTRAINT [DF_briefing_supplier_actually_assigned_yn] DEFAULT ((1)),
[comment] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[briefing_supplier] ADD CONSTRAINT [PK_briefing_supplier] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[briefing_supplier] ADD CONSTRAINT [FK_briefing_supplier_brf] FOREIGN KEY ([brf_id]) REFERENCES [dbo].[briefing] ([id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[briefing_supplier] ADD CONSTRAINT [FK_briefing_supplier_sup] FOREIGN KEY ([sup_id]) REFERENCES [dbo].[supplier] ([id])
GO
