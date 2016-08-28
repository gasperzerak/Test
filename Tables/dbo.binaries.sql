CREATE TABLE [dbo].[binaries]
(
[application] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[filename] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[data] [image] NOT NULL,
[last_update] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
