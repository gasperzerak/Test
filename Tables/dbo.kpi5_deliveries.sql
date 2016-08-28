CREATE TABLE [dbo].[kpi5_deliveries]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[no_of_deliveries] [int] NULL,
[sup_id] [int] NULL,
[kpe_id] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[kpi5_deliveries] ADD CONSTRAINT [PK_kpi5_deliveries] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[kpi5_deliveries] ADD CONSTRAINT [FK_kpi5_deliveries_kpi_evaluation] FOREIGN KEY ([kpe_id]) REFERENCES [dbo].[kpi_evaluation] ([id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[kpi5_deliveries] ADD CONSTRAINT [FK_kpi5_deliveries_supplier] FOREIGN KEY ([sup_id]) REFERENCES [dbo].[supplier] ([id])
GO
