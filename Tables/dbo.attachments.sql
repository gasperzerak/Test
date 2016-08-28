CREATE TABLE [dbo].[attachments]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[filename] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[data] [image] NULL,
[brf_id] [int] NULL,
[off_id] [int] NULL,
[att_type] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[attachments] ADD CONSTRAINT [PK_attachments] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[attachments] WITH NOCHECK ADD CONSTRAINT [FK_attachment_off] FOREIGN KEY ([off_id]) REFERENCES [dbo].[offer] ([id])
GO
ALTER TABLE [dbo].[attachments] ADD CONSTRAINT [FK_attachments_brf] FOREIGN KEY ([brf_id]) REFERENCES [dbo].[briefing] ([id]) ON DELETE CASCADE
GO
