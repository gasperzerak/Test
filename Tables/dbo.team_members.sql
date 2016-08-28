CREATE TABLE [dbo].[team_members]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[brf_id] [int] NULL,
[portal_user] [int] NULL,
[first_name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[last_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[company] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[department] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[phone] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[email] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[rol_id] [int] NULL,
[editable] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[team_members] ADD CONSTRAINT [PK_team_members] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[team_members] ADD CONSTRAINT [FK_team_members_briefing] FOREIGN KEY ([brf_id]) REFERENCES [dbo].[briefing] ([id]) ON DELETE CASCADE
GO
ALTER TABLE [dbo].[team_members] ADD CONSTRAINT [FK_team_members_roles] FOREIGN KEY ([rol_id]) REFERENCES [dbo].[roles] ([id])
GO
