CREATE TABLE [dbo].[plant_country]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[geo_id] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[plant_country] ADD CONSTRAINT [PK_plant_country] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
