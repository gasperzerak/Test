SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE FUNCTION [dbo].[get_kpi4_values] 
(
	@brf_id int,
	@sup_id int
)
RETURNS nvarchar(1000)
AS
BEGIN
	declare @ret_value nvarchar(1000)
	declare @brs_id int
	declare @kpv_rate numeric (3,0)
	set @ret_value = ''
	select @brs_id = id from briefing_supplier where brf_id = @brf_id and sup_id = @sup_id
	if (@brs_id is not null)
	begin
		declare kpv_cursor cursor for
			select kpv.rate 
			from kpi_values kpv
				inner join kpi_evaluation kpe on kpv.kpe_id = kpe.id
				inner join kpi_type kpt on kpt.id = kpv.kpt_id
			where 
				kpe.brf_id = @brf_id and
				kpv.sup_id = @sup_id
			order by
				kpt.sort_order
		open kpv_cursor
			fetch NEXT from kpv_cursor into @kpv_rate
		while @@FETCH_STATUS = 0 
		begin
			set @ret_value = @ret_value + cast(@kpv_rate as nvarchar)
			fetch NEXT from kpv_cursor into @kpv_rate
			if (@@FETCH_STATUS = 0 )
				set @ret_value = @ret_value + ','
		end
		close kpv_cursor
		deallocate kpv_cursor
	end
	if (@ret_value = '') set @ret_value = '-'
	return @ret_value  
END


GO
