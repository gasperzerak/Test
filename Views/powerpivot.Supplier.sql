SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE view [powerpivot].[Supplier]
as
select sup.id,
	   sup.name as 'Supplier Name',
	   sup.sort_order as 'Supplier Sort Order'
from dbo.supplier as sup
GO
