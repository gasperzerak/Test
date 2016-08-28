CREATE TABLE [dbo].[history]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[brf_id] [int] NULL,
[user] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[action] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date] [datetime] NULL
) ON [PRIMARY]
GO
