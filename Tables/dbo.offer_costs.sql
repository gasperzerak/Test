CREATE TABLE [dbo].[offer_costs]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[submission] [int] NULL,
[value_ddp] [numeric] (18, 2) NULL,
[value_ex_works] [numeric] (18, 2) NULL,
[dosage] [numeric] (18, 2) NULL,
[off_id] [int] NULL,
[min_quantity] [nvarchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fragrance_name] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[quu_id] [int] NULL,
[cur_id] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[offer_costs] ADD CONSTRAINT [PK_offer_costs] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[offer_costs] ADD CONSTRAINT [FK_offer_costs_currency] FOREIGN KEY ([cur_id]) REFERENCES [dbo].[currency] ([id])
GO
ALTER TABLE [dbo].[offer_costs] WITH NOCHECK ADD CONSTRAINT [FK_offer_costs_offer] FOREIGN KEY ([off_id]) REFERENCES [dbo].[offer] ([id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[offer_costs] ADD CONSTRAINT [FK_offer_costs_quantity_units] FOREIGN KEY ([quu_id]) REFERENCES [dbo].[quantity_units] ([id])
GO
