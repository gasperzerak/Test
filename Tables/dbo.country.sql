CREATE TABLE [dbo].[country]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[iso_code] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[geo_id] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[country] ADD CONSTRAINT [PK_country1] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
