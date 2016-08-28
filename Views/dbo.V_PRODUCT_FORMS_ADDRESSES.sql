SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[V_PRODUCT_FORMS_ADDRESSES]
AS
SELECT     prf.id, prf.name AS prf_name, prf.quantity AS prf_quantity, prf.qud_id AS prf_qud_id, prf.current_costlevel AS prf_cost_level, 
                      prf.comment AS prf_comment, prf.unt_id AS prf_unt_id, prf.weight AS prf_weight, prf.no_samples AS prf_no_samples, prf.brf_id, prf.adr_id AS prf_adr_id,
                       adr.street_no AS adr_street_no, adr.zip_code AS adr_zip_code, adr.city AS adr_city, adr.lco_id AS adr_lco_id, adr.tea_id AS adr_tea_id, 
                      adr.adt_id AS adr_adt_id, tea.first_name AS tea_firstname, tea.last_name AS tea_lastname, prf.costlevel_date AS prf_costlevel_date, adr.lco_id
FROM         dbo.addresses AS adr RIGHT OUTER JOIN
                      dbo.product_forms AS prf ON adr.id = prf.adr_id LEFT OUTER JOIN
                      dbo.team_members AS tea ON adr.tea_id = tea.id


GO
