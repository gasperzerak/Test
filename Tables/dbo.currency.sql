CREATE TABLE [dbo].[currency]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[name] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[exch_rate] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[currency] ADD CONSTRAINT [PK_currency] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
