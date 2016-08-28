SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE view [powerpivot].[Business]
as
select bus.name as 'Business Name',
	   sbu.name as 'Subbusiness Name',
	   prodcut.name as 'Product Category Name',
	   af.name as 'Application Forms Name',
	   baf.brf_id as 'brf_id'
 from dbo.business as bus
inner join sbu as sbu
on sbu.bus_id = bus.id
inner join dbo.product_category as prodcut
on prodcut.sbu_id = sbu.id
inner join dbo.appl_forms as af
on af.pro_id = prodcut.id
inner join dbo.briefing_appl_forms as baf
on baf.apf_id = af.id
GO
