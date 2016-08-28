SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[V_BRIEFING_SAMPLES]
AS
SELECT     dbo.supplier.name AS sup_name, dbo.samples.id, dbo.samples.brs_id, dbo.samples.name, dbo.samples.winner_yn, dbo.briefing_supplier.brf_id, 
                      dbo.briefing_supplier.sup_id
FROM         dbo.briefing_supplier INNER JOIN
                      dbo.samples ON dbo.briefing_supplier.id = dbo.samples.brs_id INNER JOIN
                      dbo.supplier ON dbo.briefing_supplier.sup_id = dbo.supplier.id


GO
