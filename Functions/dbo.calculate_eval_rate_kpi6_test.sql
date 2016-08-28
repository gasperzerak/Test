SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS OFF
GO

CREATE FUNCTION [dbo].[calculate_eval_rate_kpi6_test] 
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
	rate_marketing float,
	total_weight_marketing float,
	weight float
)
AS
BEGIN
	declare @sup_id int;
	declare @rate_marketing float;
	declare @func_res float;
	declare @count_marketing int;
	declare @i int;
	declare @weight float;
	declare @total_weight_marketing float;

		set @i = 1;
		set @func_res = 0;
		set @rate_marketing = 0;
		set @count_marketing = 0;
		set @total_weight_marketing = 0;

		if @geo_id = 7
		begin

			while (@i < 7)
			begin
				select @weight = weight from geographical_scope where id = @i;
				set @func_res = dbo.eval_rate_kpi6_per_kpt(7,@i,@pco_id,20,@start_date,@end_date);
					if @func_res > 0
					begin
						set @total_weight_marketing = @total_weight_marketing + @weight;
					end
				set @i = @i + 1;
			end

			set @i = 1;

			while (@i < 7)
			begin
				select @weight = weight from geographical_scope where id = @i;
				set @func_res = dbo.eval_rate_kpi6_per_kpt(7,@i,@pco_id,20,@start_date,@end_date);
					if @func_res > 0
					begin
						set @rate_marketing = @rate_marketing + @func_res*@weight/@total_weight_marketing;
						set @count_marketing = @count_marketing + 1;
					end
				set @i = @i + 1;
			end
		end
		insert into @kpi_table
			select 	
			7,
			@rate_marketing,
			@total_weight_marketing,
			@weight
	RETURN  
END

GO
