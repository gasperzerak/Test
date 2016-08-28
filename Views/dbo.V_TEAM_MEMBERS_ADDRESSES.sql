SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[V_TEAM_MEMBERS_ADDRESSES]
AS
SELECT     dbo.team_members.first_name AS tea_firstname, dbo.team_members.last_name AS tea_lastname, dbo.briefing.creation_date, dbo.addresses.id, 
                      dbo.addresses.street_no, dbo.addresses.zip_code, dbo.addresses.city, dbo.addresses.lco_id, dbo.addresses.tea_id, dbo.addresses.adt_id
FROM         dbo.team_members INNER JOIN
                      dbo.addresses ON dbo.team_members.id = dbo.addresses.tea_id INNER JOIN
                      dbo.briefing ON dbo.team_members.brf_id = dbo.briefing.id
GO
