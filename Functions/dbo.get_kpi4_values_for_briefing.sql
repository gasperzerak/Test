SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE FUNCTION [dbo].[get_kpi4_values_for_briefing] 
(
	@brf_id int	
)
RETURNS nvarchar(1000)
AS
BEGIN
	declare @sup_id int
	declare @sup_name nvarchar(50)
	declare @kpi4_values nvarchar(1000)
	declare @supplier nvarchar(100)
	set @kpi4_values = ''
	declare sup_cursor cursor for
		select sup.id, 
			sup.name 
		from supplier sup 
		order by sup.sort_order  
	open sup_cursor
		fetch NEXT from sup_cursor into @sup_id, @sup_name
	while @@FETCH_STATUS = 0
		begin
			set @kpi4_values = @kpi4_values + dbo.get_kpi4_values(@brf_id,@sup_id)
			fetch NEXT from sup_cursor into @sup_id, @sup_name
			if (@@FETCH_STATUS = 0) set @kpi4_values = @kpi4_values + '#'
		end
	if (@kpi4_values = '') set @kpi4_values = '-'
	return @kpi4_values
END



GO
