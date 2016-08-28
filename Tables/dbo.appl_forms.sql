CREATE TABLE [dbo].[appl_forms]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[name] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pro_id] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[appl_forms] ADD CONSTRAINT [PK_appl_forms] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[appl_forms] WITH NOCHECK ADD CONSTRAINT [FK_appl_forms_pro] FOREIGN KEY ([pro_id]) REFERENCES [dbo].[product_category] ([id]) ON DELETE CASCADE
GO
