SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[V_BRIEFING_TECH_DOCS]
AS
SELECT     tdo.id, tdo.title, tdo.brf_id, tdr.geo_id, tdr.sbu_id
FROM         dbo.tech_docs AS tdo INNER JOIN
                      dbo.tech_doc_relation AS tdr ON tdo.id = tdr.tdo_id
WHERE     (tdo.brf_id IS NULL)
UNION ALL
SELECT     id, title, brf_id, NULL AS geo_id, NULL AS sbu_id
FROM         dbo.tech_docs
WHERE     (brf_id IS NOT NULL)


GO
