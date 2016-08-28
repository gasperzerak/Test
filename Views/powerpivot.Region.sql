SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE view [powerpivot].[Region]
as
select gs.name as 'Region Name',  
	   gs.weight as 'Region Weight',
	   gs.ID as 'lgo_id' 
from dbo.geographical_scope as gs;
GO
