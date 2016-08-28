CREATE TABLE [dbo].[tech_doc_relation]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[tdo_id] [int] NULL,
[geo_id] [int] NULL,
[sbu_id] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tech_doc_relation] ADD CONSTRAINT [PK_tech_doc_relation] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tech_doc_relation] ADD CONSTRAINT [FK_tech_doc_relation_geographical_scope] FOREIGN KEY ([geo_id]) REFERENCES [dbo].[geographical_scope] ([id])
GO
ALTER TABLE [dbo].[tech_doc_relation] ADD CONSTRAINT [FK_tech_doc_relation_sbu] FOREIGN KEY ([sbu_id]) REFERENCES [dbo].[sbu] ([id])
GO
ALTER TABLE [dbo].[tech_doc_relation] ADD CONSTRAINT [FK_tech_doc_relation_tech_docs] FOREIGN KEY ([tdo_id]) REFERENCES [dbo].[tech_docs] ([id]) ON DELETE CASCADE
GO
