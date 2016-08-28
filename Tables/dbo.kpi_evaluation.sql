CREATE TABLE [dbo].[kpi_evaluation]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[date] [datetime] NULL,
[brf_id] [int] NULL,
[usr_id_rater] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[comment] [varchar] (1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[kpi_no] [int] NULL,
[calculated_yn] [bit] NULL,
[plt_id] [int] NULL,
[lco_id] [int] NULL,
[project] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[geo_id] [int] NULL,
[pco_id] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[kpi_evaluation] ADD CONSTRAINT [PK_kpi_evaluation] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[kpi_evaluation] ADD CONSTRAINT [FK_kpi_evaluation_briefing] FOREIGN KEY ([brf_id]) REFERENCES [dbo].[briefing] ([id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[kpi_evaluation] ADD CONSTRAINT [FK_kpi_evaluation_plant] FOREIGN KEY ([plt_id]) REFERENCES [dbo].[plant] ([id])
GO
