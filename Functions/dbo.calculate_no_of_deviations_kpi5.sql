SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE FUNCTION [dbo].[calculate_no_of_deviations_kpi5] 
(
	@start_date datetime,
	@end_date datetime,
	@geo_id int,
	@pco_id int
)
RETURNS 
@kpi_table TABLE 
(
	sup_id int PRIMARY KEY NOT NULL,
	sort_order int,
	sup_name nvarchar(200),
	no_quality float,
	no_environment float,
	no_time float,
	no_quantity float
)
AS
BEGIN
	declare @sup_id int;
	declare @sort_order int;
	declare @sup_name nvarchar(200);
	declare @count_quality int;
	declare @count_environment int;
	declare @count_time int;
	declare @count_quantity int;
	declare @no_quality float;
	declare @no_environment float;
	declare @no_time float;
	declare @no_quantity float;
	declare @func_res float;
	--declare @weight float;
	declare @i int;
	declare sup_cursor cursor for
		select id,sort_order,name
		from supplier
	open sup_cursor
	fetch NEXT from sup_cursor into @sup_id,@sort_order, @sup_name
	while @@FETCH_STATUS = 0
	begin
		set @i = 1;
		set @func_res = 0;
		set @no_quality = 0;
		set @no_environment = 0;
		set @no_time = 0;
		set @no_quantity =0;
		if @geo_id = 7
		begin
			while (@i < 7) 
			begin
				--select @weight = weight from geographical_scope where id = @i;
				set @func_res = dbo.no_deviations_kpi5_per_kpt(@sup_id,@i,@pco_id,13,@start_date,@end_date);
				if @func_res > 0
				begin
					set @no_quality = @no_quality + @func_res;--*@weight;
				end
				set @func_res = dbo.no_deviations_kpi5_per_kpt(@sup_id,@i,@pco_id,14,@start_date,@end_date);
				if @func_res > 0
				begin
					set @no_environment = @no_environment + @func_res;--*@weight;
				end
				set @func_res = dbo.no_deviations_kpi5_per_kpt(@sup_id,@i,@pco_id,15,@start_date,@end_date);
				if @func_res > 0
				begin
					set @no_time = @no_time + @func_res;--*@weight;
				end
				set @func_res = dbo.no_deviations_kpi5_per_kpt(@sup_id,@i,@pco_id,16,@start_date,@end_date);
				if @func_res > 0
				begin
					set @no_quantity = @no_quantity + @func_res;--*@weight;
				end
				set @i = @i + 1;
			end
		end
		else
		begin
			set @no_quality = dbo.no_deviations_kpi5_per_kpt(@sup_id,@geo_id,@pco_id,13,@start_date,@end_date);
			set @no_environment = dbo.no_deviations_kpi5_per_kpt(@sup_id,@geo_id,@pco_id,14,@start_date,@end_date);
			set @no_time = dbo.no_deviations_kpi5_per_kpt(@sup_id,@geo_id,@pco_id,15,@start_date,@end_date);
			set @no_quantity = dbo.no_deviations_kpi5_per_kpt(@sup_id,@geo_id,@pco_id,16,@start_date,@end_date);
		end
		insert into @kpi_table
			select 	
			@sup_id,
			@sort_order,
			@sup_name,
			@no_quality,
			@no_environment,
			@no_time,
			@no_quantity
		fetch next from sup_cursor into @sup_id,@sort_order, @sup_name 
	end
	close sup_cursor
	deallocate sup_cursor
	RETURN  
END
GO
