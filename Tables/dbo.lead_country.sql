CREATE TABLE [dbo].[lead_country]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[iso_code] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[geo_id] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[lead_country] ADD CONSTRAINT [PK_country] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[lead_country] ADD CONSTRAINT [FK_country_geo] FOREIGN KEY ([geo_id]) REFERENCES [dbo].[geographical_scope] ([id]) ON DELETE CASCADE
GO
