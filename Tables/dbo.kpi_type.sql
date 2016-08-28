CREATE TABLE [dbo].[kpi_type]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[editable_yn] [bit] NULL,
[briefing_relevant_yn] [bit] NULL,
[for_kpi_no] [int] NULL,
[weight] [numeric] (3, 2) NULL,
[sort_order] [int] NULL
) ON [PRIMARY]
GO
