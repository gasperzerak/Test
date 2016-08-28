CREATE TABLE [dbo].[addresses]
(
[id] [int] NOT NULL IDENTITY(1, 1),
[street_no] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[zip_code] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[city] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[lco_id] [int] NULL,
[tea_id] [int] NULL,
[adt_id] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[addresses] ADD CONSTRAINT [PK_addresses] PRIMARY KEY CLUSTERED  ([id]) ON [PRIMARY]
GO
ALTER TABLE [dbo].[addresses] ADD CONSTRAINT [FK_addresses_address_type] FOREIGN KEY ([adt_id]) REFERENCES [dbo].[address_type] ([id]) ON DELETE CASCADE
GO
