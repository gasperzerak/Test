SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[V_BRIEFING_OVERVIEW]
AS
SELECT     TOP 100 PERCENT dbo.briefing.id, dbo.briefing.proj_title, dbo.sbu.name AS sbu_name, dbo.briefing.creation_date, dbo.briefing.sta_id, 
                      dbo.briefing.briefing_no, dbo.business.name AS bus_name, dbo.briefing.brf_id_variant, dbo.briefing.created_by, dbo.team_members.email, 
                      dbo.status.name AS sta_name, (SELECT count(id) FROM dbo.briefing_supplier WHERE dbo.briefing_supplier.brf_id = dbo.briefing.id) AS supplier,
					  (SELECT count(dbo.offer.id) FROM dbo.offer INNER JOIN dbo.briefing_supplier ON dbo.briefing_supplier.id = dbo.offer.brs_id WHERE dbo.briefing_supplier.brf_id = dbo.briefing.id AND offer.saved = 1) AS offer
FROM         dbo.briefing INNER JOIN
 					  dbo.status ON dbo.briefing.sta_id = dbo.status.id LEFT OUTER JOIN
                      dbo.business ON dbo.briefing.bus_id = dbo.business.id LEFT OUTER JOIN
                      dbo.sbu ON dbo.briefing.sbu_id = dbo.sbu.id LEFT OUTER JOIN
                      dbo.team_members ON dbo.briefing.id = dbo.team_members.brf_id
ORDER BY dbo.briefing.creation_date DESC
GO
