SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[V_EXPORT_OFFER]
AS
SELECT     dbo.briefing.id as briefing_id, dbo.briefing.briefing_no, dbo.briefing.proj_title, dbo.briefing.creation_date, dbo.business.name AS bu, 
                      dbo.product_category.name AS product_category, dbo.geographical_scope.name AS regional_scope, dbo.currency.name AS currency,  
					  dbo.briefing.deadline, supplier_1.name AS supplier, 
                      dbo.offer_costs.submission,dbo.offer_costs.fragrance_name, dbo.offer_costs.dosage, dbo.offer_costs.value_ex_works AS exw, dbo.offer_costs.value_ddp AS ddp, 
                      dbo.offer_costs.min_quantity, dbo.briefing.delivery_date, dbo.offer.valid_until_date AS valid_until,
                          (SELECT     dbo.supplier.name
                            FROM          dbo.supplier INNER JOIN
                                                   dbo.briefing_supplier ON dbo.briefing_supplier.sup_id = dbo.supplier.id
                            WHERE      (dbo.briefing_supplier.brf_id = dbo.briefing.id) AND (dbo.briefing_supplier.winner_yn = 'TRUE')) AS winner, dbo.offer.comment
FROM         dbo.briefing INNER JOIN
                      dbo.product_category ON dbo.product_category.id = dbo.briefing.pro_id INNER JOIN
                      dbo.business ON dbo.business.id = dbo.briefing.bus_id INNER JOIN
                      dbo.geographical_scope ON dbo.briefing.lgo_id = dbo.geographical_scope.id INNER JOIN
                      dbo.briefing_supplier AS briefing_supplier_1 ON briefing_supplier_1.brf_id = dbo.briefing.id INNER JOIN
                      dbo.supplier AS supplier_1 ON briefing_supplier_1.sup_id = supplier_1.id INNER JOIN
                      dbo.offer ON briefing_supplier_1.id = dbo.offer.brs_id INNER JOIN
                      dbo.offer_costs ON dbo.offer_costs.off_id = dbo.offer.id LEFT OUTER JOIN
					  dbo.currency ON dbo.offer_costs.cur_id = dbo.currency.id
WHERE		dbo.offer.saved = 1
GO
