CREATE TABLE [dbo].[kpi_values]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[kpe_id] [int] NOT NULL,
[kpt_id] [int] NOT NULL,
[sup_id] [int] NOT NULL,
[rate] [numeric] (3, 0) NOT NULL,
[comment] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]
GO
