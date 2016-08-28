SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[V_BRIEFING_TEAM]
AS
SELECT     tea.id, tea.company, tea.department, tea.phone, tea.email, rol.id AS rol_id, rol.name AS rol_name, tea.brf_id, tea.first_name, tea.last_name, tea.editable
FROM         dbo.roles AS rol INNER JOIN
                      dbo.team_members AS tea ON rol.id = tea.rol_id


GO
