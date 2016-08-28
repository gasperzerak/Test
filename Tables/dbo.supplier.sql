CREATE TABLE [dbo].[supplier]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[name] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[sus_id] [int] NULL,
[portal_group_id] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[sort_order] [int] NULL,
[active] [bit] NOT NULL CONSTRAINT [DF_supplier_active] DEFAULT ((1))
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[supplier] ADD CONSTRAINT [PK_supplier] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[supplier] ADD CONSTRAINT [FK_supplier_supplier_status] FOREIGN KEY ([sus_id]) REFERENCES [dbo].[supplier_status] ([id])
GO
