SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[V_BRIEFING_OVERVIEW_SUPPLIER]
AS
SELECT     TOP 100 PERCENT dbo.briefing.id, dbo.briefing.proj_title, dbo.sbu.name AS sbu_name, dbo.briefing.creation_date, dbo.briefing.sta_id, 
                      dbo.briefing.briefing_no, dbo.business.name AS bus_name, dbo.briefing.brf_id_variant, dbo.briefing_supplier.sup_id, 
                      dbo.status.name AS sta_name, winner_yn
FROM         dbo.briefing INNER JOIN
                      dbo.status ON dbo.briefing.sta_id = dbo.status.id LEFT OUTER JOIN
                      dbo.business ON dbo.briefing.bus_id = dbo.business.id LEFT OUTER JOIN
                      dbo.sbu ON dbo.briefing.sbu_id = dbo.sbu.id LEFT OUTER JOIN
                      dbo.briefing_supplier ON dbo.briefing.id = dbo.briefing_supplier.brf_id
ORDER BY dbo.briefing.creation_date DESC
GO
