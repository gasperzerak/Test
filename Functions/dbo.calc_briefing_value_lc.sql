SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[calc_briefing_value_lc] 
(
	@brf_id int
)
RETURNS float
AS
BEGIN
	declare @brf_value float
	declare @prf_id int
	declare @str_quantity nvarchar(50)
	declare @quantity float
	declare @str_cost nvarchar(10)
	declare @cost float
	declare @avg_costs float
	declare @total_costs float
	declare @cost_count int
	declare @success bit
	set @brf_value = 0
	set @success = 1
	declare prf_cursor cursor for
		select 
			prf.id,
			prf.quantity 
		from product_forms prf
		where 
			brf_id = @brf_id
	open prf_cursor
			fetch NEXT from prf_cursor into @prf_id, @str_quantity
	while @@FETCH_STATUS = 0 
	begin
		if (ISNUMERIC(@str_quantity) = 1) 
			set @quantity = convert(float,@str_quantity)
		else begin
			set @quantity = 0
			set @success = 0
		end
		set @total_costs = 0
		set @cost_count = 1
		declare cst_cursor cursor for
			select value from costs
			where prf_id = @prf_id 
		open cst_cursor
			fetch NEXT from cst_cursor into @str_cost
		while @@FETCH_STATUS = 0 
		begin
			if (ISNUMERIC(@str_cost) = 1)
				set @cost = convert(float,@str_cost)
			else begin
				set @cost = 0
				set @success = 0
			end
			set @total_costs = @total_costs + @cost
			fetch NEXT from cst_cursor into @str_cost
			if (@@FETCH_STATUS = 0) 
				set @cost_count = @cost_count + 1 
		end
		set @avg_costs = @total_costs / @cost_count
		set @brf_value = @brf_value + (@avg_costs * @quantity)
		close cst_cursor
		deallocate cst_cursor
		fetch NEXT from prf_cursor into @prf_id,@str_quantity
	end
	if (@success = 0) 
		set @brf_value = 0
	close prf_cursor
	deallocate prf_cursor
	return @brf_value  
END
GO
