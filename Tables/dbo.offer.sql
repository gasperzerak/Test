CREATE TABLE [dbo].[offer]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[brs_id] [int] NULL,
[comment] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[valid_until_date] [datetime] NULL,
[lit_id] [int] NULL,
[saved] [bit] NOT NULL CONSTRAINT [DF_offer_saved] DEFAULT ((0))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[offer] ADD CONSTRAINT [PK_offer] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[offer] WITH NOCHECK ADD CONSTRAINT [FK_offer_brs] FOREIGN KEY ([brs_id]) REFERENCES [dbo].[briefing_supplier] ([id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[offer] ADD CONSTRAINT [FK_offer_local_incoterm] FOREIGN KEY ([lit_id]) REFERENCES [dbo].[local_incoterm] ([id])
GO
