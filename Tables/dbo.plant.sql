CREATE TABLE [dbo].[plant]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[pco_id] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[plant] ADD CONSTRAINT [PK_plant] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[plant] ADD CONSTRAINT [FK_plant_plant_country] FOREIGN KEY ([pco_id]) REFERENCES [dbo].[plant_country] ([id])
GO
