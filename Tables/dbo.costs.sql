CREATE TABLE [dbo].[costs]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[value] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cost_level] [nvarchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[dosage] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[prf_id] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[costs] ADD CONSTRAINT [PK_costs] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[costs] ADD CONSTRAINT [FK_costs_prf] FOREIGN KEY ([prf_id]) REFERENCES [dbo].[product_forms] ([id]) ON DELETE CASCADE
GO
