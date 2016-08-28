CREATE TABLE [dbo].[sbu]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[name] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bus_id] [int] NULL,
[disabled_since] [date] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[sbu] ADD CONSTRAINT [PK_sbu] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[sbu] ADD CONSTRAINT [FK_sbu_business] FOREIGN KEY ([bus_id]) REFERENCES [dbo].[business] ([id])
GO
