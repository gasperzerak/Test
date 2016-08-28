CREATE TABLE [dbo].[supplier_contacts]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[sup_id] [int] NOT NULL,
[email] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[name] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[supplier_contacts] ADD CONSTRAINT [PK_supplier_contacts] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[supplier_contacts] ADD CONSTRAINT [FK_supplier_contacts_supplier] FOREIGN KEY ([sup_id]) REFERENCES [dbo].[supplier] ([id]) ON DELETE CASCADE
GO
