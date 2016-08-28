SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create view [powerpivot].[Costs]
as
select c.value as 'Cost Value',
	  c.cost_level as 'Cost Level',
	  pf.quantity,
	  pf.weight,
	  pf.brf_id
from dbo.costs as c
inner join product_forms as pf
on c.prf_id = pf.id
GO
