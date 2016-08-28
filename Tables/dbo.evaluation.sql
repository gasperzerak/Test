CREATE TABLE [dbo].[evaluation]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[smp_id] [int] NULL,
[level_no] [int] NULL,
[eval_yn] [bit] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[evaluation] ADD CONSTRAINT [PK_evaluation] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[evaluation] ADD CONSTRAINT [FK_evaluation_smp] FOREIGN KEY ([smp_id]) REFERENCES [dbo].[samples] ([id]) ON DELETE CASCADE
GO
