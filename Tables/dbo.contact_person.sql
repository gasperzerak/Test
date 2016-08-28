CREATE TABLE [dbo].[contact_person]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[name] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[email] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[brs_id] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[contact_person] ADD CONSTRAINT [PK_contact_person] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[contact_person] ADD CONSTRAINT [FK_contact_person_briefing_supplier] FOREIGN KEY ([brs_id]) REFERENCES [dbo].[briefing_supplier] ([id]) ON DELETE CASCADE
GO
