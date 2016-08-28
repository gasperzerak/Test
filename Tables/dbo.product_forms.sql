CREATE TABLE [dbo].[product_forms]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[quantity] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[qud_id] [int] NULL,
[current_costlevel] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[costlevel_date] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[comment] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[unt_id] [int] NULL,
[weight] [nvarchar] (30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[no_samples] [int] NULL,
[brf_id] [int] NULL,
[adr_id] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[product_forms] ADD CONSTRAINT [PK_product_forms] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[product_forms] ADD CONSTRAINT [FK_product_forms_addresses] FOREIGN KEY ([adr_id]) REFERENCES [dbo].[addresses] ([id])
GO
ALTER TABLE [dbo].[product_forms] ADD CONSTRAINT [FK_product_forms_brf] FOREIGN KEY ([brf_id]) REFERENCES [dbo].[briefing] ([id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[product_forms] ADD CONSTRAINT [FK_product_forms_quantity_description] FOREIGN KEY ([qud_id]) REFERENCES [dbo].[quantity_description] ([id])
GO
ALTER TABLE [dbo].[product_forms] ADD CONSTRAINT [FK_product_forms_units] FOREIGN KEY ([unt_id]) REFERENCES [dbo].[units] ([id])
GO
