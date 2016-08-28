SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[V_BRIEFING_SUPPLIER]
AS
SELECT     TOP 100 PERCENT 
			brs.id, 
			sup.name, 
			brs.comment, 
			brs.current_supplier_yn, 
			brs.brf_id, 
			brs.sup_id, 
			brs.actual_assigned_yn, 
            sus.name AS status,
			ofr.id AS ofr_id 
FROM         dbo.supplier AS sup INNER JOIN
                    dbo.briefing_supplier AS brs ON sup.id = brs.sup_id INNER JOIN
                    dbo.supplier_status as sus ON sup.sus_id = sus.id LEFT JOIN
					dbo.offer AS ofr ON ofr.brs_id = brs.id AND ofr.saved = 1 	
WHERE     (brs.actual_assigned_yn = 1)
ORDER BY sup.name
GO
