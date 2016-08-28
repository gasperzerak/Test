SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[V_BRIEFING_ADDRESSES_FOR_PDF_NEW]
AS
SELECT     prf.name AS prf_name, tea.brf_id, adr.id AS adt_id, adr.street_no, adr.zip_code, adr.city, lco.name AS lco_name, adr.tea_id, at.name AS adt_name, 
                      tea.first_name AS tea_firstname, tea.last_name AS tea_lastname, rol.name AS rol_name
FROM         dbo.product_forms AS prf RIGHT OUTER JOIN
                      dbo.addresses AS adr ON prf.adr_id = adr.id LEFT OUTER JOIN
                      dbo.team_members AS tea INNER JOIN
                      dbo.roles AS rol ON tea.rol_id = rol.id ON adr.tea_id = tea.id INNER JOIN
                      dbo.lead_country AS lco ON adr.lco_id = lco.id RIGHT OUTER JOIN
                      dbo.address_type AS at ON adr.adt_id = at.id
GO
EXEC sp_addextendedproperty N'MS_DiagramPane1', N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "prf"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 125
               Right = 210
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "adr"
            Begin Extent = 
               Top = 6
               Left = 248
               Bottom = 125
               Right = 408
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "tea"
            Begin Extent = 
               Top = 126
               Left = 38
               Bottom = 245
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "rol"
            Begin Extent = 
               Top = 126
               Left = 236
               Bottom = 215
               Right = 396
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "lco"
            Begin Extent = 
               Top = 216
               Left = 236
               Bottom = 335
               Right = 396
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "at"
            Begin Extent = 
               Top = 246
               Left = 38
               Bottom = 335
               Right = 198
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1', 'SCHEMA', N'dbo', 'VIEW', N'V_BRIEFING_ADDRESSES_FOR_PDF_NEW', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', 'SCHEMA', N'dbo', 'VIEW', N'V_BRIEFING_ADDRESSES_FOR_PDF_NEW', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'V_BRIEFING_ADDRESSES_FOR_PDF_NEW', NULL, NULL
GO
