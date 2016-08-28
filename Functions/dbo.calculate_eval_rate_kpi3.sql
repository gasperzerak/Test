SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS OFF
GO

CREATE FUNCTION [dbo].[calculate_eval_rate_kpi3] 
(
	@geo_id int,
	@lco_id int,
	@project varchar(50),
	@start_date datetime,
	@end_date datetime
)
RETURNS 
@kpi_table TABLE 
(
	sup_id int PRIMARY KEY NOT NULL,
	sort_order int,
	sup_name nvarchar(200),
	rate_insights float,
	rate_newness float,
	rate_technology float,
	rate_managment float,
	rate_expertise float,
	rate_concept float
)
AS
BEGIN
	declare @sup_id int;
	declare @sort_order int;
	declare @sup_name nvarchar(200);
	declare @rate_insights float;
	declare @rate_newness float;
	declare @rate_technology float;
	declare @rate_managment float;
	declare @rate_expertise float;
	declare @rate_concept float;
	declare @func_res float;
	declare @count_insights int;
	declare @count_newness int;
	declare @count_technology int;
	declare @count_managment int;
	declare @count_expertise int;
	declare @count_concept int;
	declare @i int;
	declare sup_cursor cursor for
		select id,sort_order,name
		from supplier
	open sup_cursor
	fetch NEXT from sup_cursor into @sup_id, @sort_order, @sup_name
	while @@FETCH_STATUS = 0
	begin
		set @i = 1;
		set @func_res = 0;
		set @rate_insights = 0;
		set @rate_newness = 0;
		set @rate_technology = 0;
		set @rate_managment = 0;
		set @rate_expertise = 0;
		set @rate_concept = 0;
		set @count_insights = 0;
		set @count_newness = 0;
		set @count_technology = 0;
		set @count_managment = 0;
		set @count_expertise = 0;
		set @count_concept = 0;
		if @geo_id = 7
		begin
			while (@i < 7)
			begin
				set @func_res = dbo.eval_rate_kpi3_per_kpt(@sup_id,@i,@lco_id,@project,1,@start_date,@end_date);
					if @func_res > 0
					begin
						set @rate_insights = @rate_insights + @func_res;
						set @count_insights = @count_insights + 1;
					end
				set @func_res = dbo.eval_rate_kpi3_per_kpt(@sup_id,@i,@lco_id,@project,2,@start_date,@end_date);
					if @func_res > 0
					begin
						set @rate_newness = @rate_newness + @func_res;
						set @count_newness = @count_newness + 1;
					end
				set @func_res = dbo.eval_rate_kpi3_per_kpt(@sup_id,@i,@lco_id,@project,3,@start_date,@end_date);
					if @func_res > 0
					begin
						set @rate_technology = @rate_technology +  @func_res;
						set @count_technology = @count_technology + 1;
					end
				set @func_res = dbo.eval_rate_kpi3_per_kpt(@sup_id,@i,@lco_id,@project,4,@start_date,@end_date);
					if @func_res > 0
					begin
						set @rate_managment = @rate_managment + @func_res;
						set @count_managment = @count_managment + 1;
					end
				set @func_res = dbo.eval_rate_kpi3_per_kpt(@sup_id,@i,@lco_id,@project,5,@start_date,@end_date);
					if @func_res > 0
					begin
						set @rate_expertise = @rate_expertise + @func_res;
						set @count_expertise = @count_expertise + 1;
					end
				set @func_res = dbo.eval_rate_kpi3_per_kpt(@sup_id,@i,@lco_id,@project,6,@start_date,@end_date);
					if @func_res > 0
					begin
						set @rate_concept = @rate_concept + @func_res;
						set @count_concept = @count_concept + 1;
					end
				set @i = @i + 1;
			end
			if @count_insights > 0
				set @rate_insights = @rate_insights/@count_insights;
			if @count_newness > 0
				set @rate_newness = @rate_newness/@count_newness;
			if @count_technology > 0
				set @rate_technology = @rate_technology/@count_technology;
			if @count_managment > 0 
				set @rate_managment = @rate_managment/@count_managment;
			if @count_expertise > 0
				set @rate_expertise = @rate_expertise/@count_expertise;
			if @count_concept > 0
				set @rate_concept = @rate_concept/@count_concept;
		end
		else
		begin
			set @rate_insights = dbo.eval_rate_kpi3_per_kpt(@sup_id,@geo_id,@lco_id,@project,1,@start_date,@end_date);
			set @rate_newness = dbo.eval_rate_kpi3_per_kpt(@sup_id,@geo_id,@lco_id,@project,2,@start_date,@end_date);
			set @rate_technology = dbo.eval_rate_kpi3_per_kpt(@sup_id,@geo_id,@lco_id,@project,3,@start_date,@end_date);
			set @rate_managment = dbo.eval_rate_kpi3_per_kpt(@sup_id,@geo_id,@lco_id,@project,4,@start_date,@end_date);
			set @rate_expertise = dbo.eval_rate_kpi3_per_kpt(@sup_id,@geo_id,@lco_id,@project,5,@start_date,@end_date);
			set @rate_concept = dbo.eval_rate_kpi3_per_kpt(@sup_id,@geo_id,@lco_id,@project,6,@start_date,@end_date);
		end
		insert into @kpi_table
			select 	
			@sup_id,
			@sort_order,
			@sup_name,
			@rate_insights,
			@rate_newness,
			@rate_technology,
			@rate_managment,
			@rate_expertise,
			@rate_concept	
		fetch next from sup_cursor into @sup_id,@sort_order, @sup_name 
	end
	close sup_cursor
	deallocate sup_cursor
	RETURN  
END



GO
