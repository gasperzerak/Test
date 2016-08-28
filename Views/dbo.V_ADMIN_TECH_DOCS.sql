SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[V_ADMIN_TECH_DOCS]
AS
SELECT     dbo.tech_docs.title, dbo.tech_docs.id, dbo.tech_docs.date, dbo.geographical_scope.name AS geo_name, dbo.sbu.name AS sbu_name
FROM         dbo.tech_doc_relation INNER JOIN
                      dbo.tech_docs ON dbo.tech_doc_relation.tdo_id = dbo.tech_docs.id INNER JOIN
                      dbo.sbu ON dbo.tech_doc_relation.sbu_id = dbo.sbu.id INNER JOIN
                      dbo.geographical_scope ON dbo.tech_doc_relation.geo_id = dbo.geographical_scope.id
WHERE     (dbo.tech_docs.brf_id IS NULL)


GO
