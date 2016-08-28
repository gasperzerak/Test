SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS OFF
GO

CREATE FUNCTION [dbo].[calculate_eval_rate_kpi6] 
(
	@geo_id int,
	@pco_id int,
	@start_date datetime,
	@end_date datetime
)
RETURNS 
@kpi_table TABLE 
(
	sup_id int PRIMARY KEY NOT NULL,
	sort_order int,
	sup_name nvarchar(200),
	rate_purchase float,
	rate_logistic float,
	rate_supply float,
	rate_needs float,
	rate_marketing float,
	rate_fc float,
	rate_issues float,
	rate_steering float
)
AS
BEGIN
	declare @sup_id int;
	declare @sort_order int;
	declare @sup_name nvarchar(200);
	declare @rate_purchase float;
	declare @rate_logistic float;
	declare @rate_supply float;
	declare @rate_needs float;
	declare @rate_marketing float;
	declare @rate_fc float;
	declare @rate_issues float;
	declare @rate_steering float;
	declare @func_res float;
	declare @count_purchase int;
	declare @count_logistic int;
	declare @count_supply int;
	declare @count_needs int;
	declare @count_marketing int;
	declare @count_fc int;
	declare @count_issues int;
	declare @count_steering int;
	declare @i int;
	declare @weight float;
	declare @total_weight_fc float;
	declare @total_weight_purchase float;
	declare @total_weight_supply float;
	declare @total_weight_marketing float;
	declare @total_weight_steering float;	
	declare @total_weight_issues float;
	declare @total_weight_logistic float;
	declare @total_weight_needs float;
	declare sup_cursor cursor for
		select id,sort_order,name
		from supplier
	open sup_cursor
	fetch NEXT from sup_cursor into @sup_id,@sort_order, @sup_name
	while @@FETCH_STATUS = 0
	begin
		set @i = 1;
		set @func_res = 0;
		set @rate_fc = 0;
		set @rate_purchase = 0;
		set @rate_supply = 0;
		set @rate_marketing = 0;
		set @rate_steering = 0;
		set @rate_issues = 0;
		set @rate_logistic = 0;
		set @rate_needs = 0;
		set @count_fc = 0;
		set @count_purchase = 0;
		set @count_supply = 0;
		set @count_marketing = 0;
		set @count_steering = 0;
		set @count_issues = 0;
		set @count_logistic = 0;
		set @count_needs = 0;
		set @total_weight_fc = 0;
		set @total_weight_purchase = 0;
		set @total_weight_supply = 0;
		set @total_weight_marketing = 0;
		set @total_weight_steering = 0;		
		set @total_weight_issues = 0;
		set @total_weight_logistic = 0;
		set @total_weight_needs = 0;

		if @geo_id = 7
		begin

			while (@i < 7)
			begin
				select @weight = weight from geographical_scope where id = @i;
				set @func_res = dbo.eval_rate_kpi6_per_kpt(@sup_id,@i,@pco_id,17,@start_date,@end_date);
					if @func_res > 0
					begin
						set @total_weight_fc = @total_weight_fc + @weight;
					end
				set @func_res = dbo.eval_rate_kpi6_per_kpt(@sup_id,@i,@pco_id,18,@start_date,@end_date);
					if @func_res > 0
					begin
						set @total_weight_purchase = @total_weight_purchase + @weight;
					end
				set @func_res = dbo.eval_rate_kpi6_per_kpt(@sup_id,@i,@pco_id,19,@start_date,@end_date);
					if @func_res > 0
					begin
						set @total_weight_supply = @total_weight_supply + @weight;
					end
				set @func_res = dbo.eval_rate_kpi6_per_kpt(@sup_id,@i,@pco_id,20,@start_date,@end_date);
					if @func_res > 0
					begin
						set @total_weight_marketing = @total_weight_marketing + @weight;
					end
				set @func_res = dbo.eval_rate_kpi6_per_kpt(@sup_id,@i,@pco_id,21,@start_date,@end_date);
					if @func_res > 0
					begin
						set @total_weight_steering = @total_weight_steering + @weight;
					end
				set @func_res = dbo.eval_rate_kpi6_per_kpt(@sup_id,@i,@pco_id,22,@start_date,@end_date);
					if @func_res > 0
					begin
						set @total_weight_issues = @total_weight_issues + @weight;
					end
				set @func_res = dbo.eval_rate_kpi6_per_kpt(@sup_id,@i,@pco_id,23,@start_date,@end_date);
					if @func_res > 0
					begin
						set @total_weight_logistic = @total_weight_logistic + @weight;
					end
				set @func_res = dbo.eval_rate_kpi6_per_kpt(@sup_id,@i,@pco_id,24,@start_date,@end_date);
					if @func_res > 0
					begin
						set @total_weight_needs = @total_weight_needs + @weight;
					end
				set @i = @i + 1;
			end

			set @i = 1;

			while (@i < 7)
			begin
				select @weight = weight from geographical_scope where id = @i;
				set @func_res = dbo.eval_rate_kpi6_per_kpt(@sup_id,@i,@pco_id,17,@start_date,@end_date);
					if @func_res > 0
					begin

						set @rate_fc = @rate_fc + @func_res*@weight/@total_weight_fc;
						set @count_fc = @count_fc + 1;
					end
				set @func_res = dbo.eval_rate_kpi6_per_kpt(@sup_id,@i,@pco_id,18,@start_date,@end_date);
					if @func_res > 0
					begin
						set @rate_purchase = @rate_purchase + @func_res*@weight/@total_weight_purchase;
						set @count_purchase = @count_purchase + 1;
					end
				set @func_res = dbo.eval_rate_kpi6_per_kpt(@sup_id,@i,@pco_id,19,@start_date,@end_date);
					if @func_res > 0
					begin
						set @rate_supply = @rate_supply +  @func_res*@weight/@total_weight_supply;
						set @count_supply = @count_supply + 1;
					end
				set @func_res = dbo.eval_rate_kpi6_per_kpt(@sup_id,@i,@pco_id,20,@start_date,@end_date);
					if @func_res > 0
					begin
						set @rate_marketing = @rate_marketing + @func_res*@weight/@total_weight_marketing;
						set @count_marketing = @count_marketing + 1;
					end
				set @func_res = dbo.eval_rate_kpi6_per_kpt(@sup_id,@i,@pco_id,21,@start_date,@end_date);
					if @func_res > 0
					begin
						set @rate_steering = @rate_steering + @func_res*@weight/@total_weight_steering;
						set @count_steering = @count_steering + 1;
					end
				set @func_res = dbo.eval_rate_kpi6_per_kpt(@sup_id,@i,@pco_id,22,@start_date,@end_date);
					if @func_res > 0
					begin
						set @rate_issues = @rate_issues + @func_res*@weight/@total_weight_issues;
						set @count_issues = @count_issues + 1;
					end
				set @func_res = dbo.eval_rate_kpi6_per_kpt(@sup_id,@i,@pco_id,23,@start_date,@end_date);
					if @func_res > 0
					begin
						set @rate_logistic = @rate_logistic + @func_res*@weight/@total_weight_logistic;
						set @count_logistic = @count_logistic + 1;
					end
				set @func_res = dbo.eval_rate_kpi6_per_kpt(@sup_id,@i,@pco_id,24,@start_date,@end_date);
					if @func_res > 0
					begin
						set @rate_needs = @rate_needs + @func_res*@weight/@total_weight_needs;
						set @count_needs = @count_needs + 1;
					end
				set @i = @i + 1;
			end
/*			if @count_fc > 0
				set @rate_fc = @rate_fc/@count_fc;
			if @count_purchase > 0
				set @rate_purchase = @rate_purchase/@count_purchase;
			if @count_supply > 0
				set @rate_supply = @rate_supply/@count_supply;
			if @count_marketing > 0 
				set @rate_marketing = @rate_marketing/@count_marketing;
			if @count_steering > 0
				set @rate_steering = @rate_steering/@count_steering;
			if @count_issues > 0
				set @rate_issues = @rate_issues/@count_issues;
			if @count_logistic > 0
				set @rate_logistic = @rate_logistic/@count_logistic;
			if @count_needs > 0
				set @rate_needs = @rate_needs/@count_needs;*/
		end
		else
		begin
			set @rate_fc = dbo.eval_rate_kpi6_per_kpt(@sup_id,@geo_id,@pco_id,17,@start_date,@end_date);
			set @rate_purchase = dbo.eval_rate_kpi6_per_kpt(@sup_id,@geo_id,@pco_id,18,@start_date,@end_date);
			set @rate_supply = dbo.eval_rate_kpi6_per_kpt(@sup_id,@geo_id,@pco_id,19,@start_date,@end_date);
			set @rate_marketing = dbo.eval_rate_kpi6_per_kpt(@sup_id,@geo_id,@pco_id,20,@start_date,@end_date);
			set @rate_steering = dbo.eval_rate_kpi6_per_kpt(@sup_id,@geo_id,@pco_id,21,@start_date,@end_date);
			set @rate_issues = dbo.eval_rate_kpi6_per_kpt(@sup_id,@geo_id,@pco_id,22,@start_date,@end_date);
			set @rate_logistic = dbo.eval_rate_kpi6_per_kpt(@sup_id,@geo_id,@pco_id,23,@start_date,@end_date);
			set @rate_needs = dbo.eval_rate_kpi6_per_kpt(@sup_id,@geo_id,@pco_id,24,@start_date,@end_date);
		end
		insert into @kpi_table
			select 	
			@sup_id,
			@sort_order,
			@sup_name,
			@rate_purchase,
			@rate_logistic,
			@rate_supply,
			@rate_needs,
			@rate_marketing,
			@rate_fc,	
			@rate_issues,	
			@rate_steering	
		fetch next from sup_cursor into @sup_id, @sort_order, @sup_name 
	end
	close sup_cursor
	deallocate sup_cursor
	RETURN  
END

GO
