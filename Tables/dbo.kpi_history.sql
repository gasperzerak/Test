CREATE TABLE [dbo].[kpi_history]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[eval_id] [int] NOT NULL,
[user] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[action] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date] [datetime] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[kpi_history] ADD CONSTRAINT [FK_kpi_history_kpi_evaluation] FOREIGN KEY ([eval_id]) REFERENCES [dbo].[kpi_evaluation] ([id]) ON DELETE CASCADE
GO
