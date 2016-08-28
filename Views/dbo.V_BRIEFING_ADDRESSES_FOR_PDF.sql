SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[V_BRIEFING_ADDRESSES_FOR_PDF]
AS
SELECT     adr.id AS adt_id, adr.street_no, adr.zip_code, adr.city, prf.name AS prf_name, adt.name AS adt_name, lco.name AS lco_name, adr.tea_id, tea.brf_id, 
                      rol.name AS rol_name, tea.first_name AS tea_firstname, tea.last_name AS tea_lastname
FROM         dbo.product_forms AS prf RIGHT OUTER JOIN
                      dbo.lead_country AS lco INNER JOIN
                      dbo.addresses AS adr ON lco.id = adr.lco_id RIGHT OUTER JOIN
                      dbo.address_type AS adt ON adr.adt_id = adt.id LEFT OUTER JOIN
                      dbo.team_members AS tea INNER JOIN
                      dbo.roles AS rol ON tea.rol_id = rol.id ON adr.tea_id = tea.id ON prf.adr_id = adr.id


GO
