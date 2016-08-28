SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create view [powerpivot].[Briefing_Supplier]
as
select brf_id,
	   sup_id,
	   current_supplier_yn,
	   winner_yn,
	   actual_assigned_yn 
from dbo.briefing_supplier
GO
