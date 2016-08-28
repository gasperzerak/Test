CREATE TABLE [dbo].[product_category]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[name] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[sbu_id] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[product_category] ADD CONSTRAINT [PK_product_category] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[product_category] ADD CONSTRAINT [FK_product_category_sbu] FOREIGN KEY ([sbu_id]) REFERENCES [dbo].[sbu] ([id])
GO
