SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[V_BRIEFING_OVERVIEW_SEARCH]
AS
SELECT     TOP (100) PERCENT dbo.briefing.id, dbo.briefing.int_ref, dbo.briefing.proj_title, dbo.briefing.pro_id, dbo.briefing.cur_id, dbo.briefing.bus_id, 
                      dbo.briefing.dialyn, dbo.briefing.created_by, dbo.team_members.email, dbo.sbu.name AS sbu_name, dbo.sbu.id AS sbu_id, dbo.briefing.creation_date, 
                      dbo.briefing.sta_id, dbo.briefing.str_id, dbo.briefing.briefing_no, dbo.business.name AS bus_name, dbo.briefing_country.lco_id, 
                      dbo.briefing_geo.geo_id, dbo.briefing_appl_forms.apf_id, dbo.status.name AS sta_name,
                          (SELECT     COUNT(id) AS Expr1
                            FROM          dbo.briefing_supplier
                            WHERE      (brf_id = dbo.briefing.id)) AS supplier,
                          (SELECT     COUNT(dbo.offer.id) AS Expr1
                            FROM          dbo.offer INNER JOIN
                                                   dbo.briefing_supplier AS briefing_supplier_2 ON briefing_supplier_2.id = dbo.offer.brs_id
                            WHERE      (briefing_supplier_2.brf_id = dbo.briefing.id) AND (dbo.offer.saved = 1)) AS offer, dbo.offer_costs.fragrance_name AS frag_names
FROM         dbo.briefing INNER JOIN
                      dbo.status ON dbo.briefing.sta_id = dbo.status.id LEFT OUTER JOIN
                      dbo.briefing_country ON dbo.briefing.id = dbo.briefing_country.brf_id LEFT OUTER JOIN
                      dbo.lead_country ON dbo.briefing_country.lco_id = dbo.lead_country.id LEFT OUTER JOIN
                      dbo.briefing_geo ON dbo.briefing.id = dbo.briefing_geo.brf_id LEFT OUTER JOIN
                      dbo.geographical_scope ON dbo.briefing_geo.geo_id = dbo.geographical_scope.id LEFT OUTER JOIN
                      dbo.briefing_appl_forms ON dbo.briefing.id = dbo.briefing_appl_forms.brf_id LEFT OUTER JOIN
                      dbo.appl_forms ON dbo.briefing_appl_forms.apf_id = dbo.appl_forms.id LEFT OUTER JOIN
                      dbo.sbu ON dbo.briefing.sbu_id = dbo.sbu.id LEFT OUTER JOIN
                      dbo.business ON dbo.briefing.bus_id = dbo.business.id LEFT OUTER JOIN
                      dbo.briefing_supplier AS briefing_supplier_1 ON briefing_supplier_1.brf_id = dbo.briefing.id LEFT OUTER JOIN
                      dbo.offer AS offer_1 ON offer_1.brs_id = briefing_supplier_1.id LEFT OUTER JOIN
                      dbo.offer_costs ON dbo.offer_costs.off_id = offer_1.id LEFT OUTER JOIN
                      dbo.team_members ON dbo.briefing.id = dbo.team_members.brf_id
ORDER BY dbo.briefing.briefing_no
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
         Top = -418
         Left = 0
      End
      Begin Tables = 
         Begin Table = "briefing"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 114
               Right = 242
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "status"
            Begin Extent = 
               Top = 6
               Left = 280
               Bottom = 84
               Right = 431
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "briefing_country"
            Begin Extent = 
               Top = 84
               Left = 280
               Bottom = 177
               Right = 431
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "lead_country"
            Begin Extent = 
               Top = 114
               Left = 38
               Bottom = 222
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "briefing_geo"
            Begin Extent = 
               Top = 180
               Left = 227
               Bottom = 273
               Right = 378
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "geographical_scope"
            Begin Extent = 
               Top = 222
               Left = 38
               Bottom = 315
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "briefing_appl_forms"
            Begin Extent = 
               Top = 276
               Left = 227
               Bottom = 369
               Right = 378
     ', 'SCHEMA', N'dbo', 'VIEW', N'V_BRIEFING_OVERVIEW_SEARCH', NULL, NULL
GO
EXEC sp_addextendedproperty N'MS_DiagramPane2', N'       End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "appl_forms"
            Begin Extent = 
               Top = 318
               Left = 38
               Bottom = 411
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "sbu"
            Begin Extent = 
               Top = 372
               Left = 227
               Bottom = 465
               Right = 378
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "business"
            Begin Extent = 
               Top = 414
               Left = 38
               Bottom = 492
               Right = 189
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "briefing_supplier_1"
            Begin Extent = 
               Top = 468
               Left = 227
               Bottom = 576
               Right = 403
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "team_members"
            Begin Extent = 
               Top = 576
               Left = 227
               Bottom = 684
               Right = 378
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "offer_1"
            Begin Extent = 
               Top = 6
               Left = 469
               Bottom = 114
               Right = 625
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "offer_costs"
            Begin Extent = 
               Top = 114
               Left = 469
               Bottom = 222
               Right = 628
            End
            DisplayFlags = 280
            TopColumn = 6
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
         Table = 1170
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
', 'SCHEMA', N'dbo', 'VIEW', N'V_BRIEFING_OVERVIEW_SEARCH', NULL, NULL
GO
DECLARE @xp int
SELECT @xp=2
EXEC sp_addextendedproperty N'MS_DiagramPaneCount', @xp, 'SCHEMA', N'dbo', 'VIEW', N'V_BRIEFING_OVERVIEW_SEARCH', NULL, NULL
GO
