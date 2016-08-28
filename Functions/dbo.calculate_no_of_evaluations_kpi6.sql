SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS OFF
GO

CREATE FUNCTION [dbo].[calculate_no_of_evaluations_kpi6] 
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
	sup_name nvarchar(200),
	no_purchase int,
	no_logistic int,
	no_supply int,
	no_needs int,
	no_marketing int,
	no_fc int,
	no_issues int,
	no_steering int
)
AS
BEGIN
	declare @sup_id int;
	declare @sup_name nvarchar(200);
	declare @no_purchase int;
	declare @no_logistic int;
	declare @no_supply int;
	declare @no_needs int;
	declare @no_marketing int;
	declare @no_fc int;
	declare @no_issues int;
	declare @no_steering int;
	declare @i int;
	declare sup_cursor cursor for
		select id,name
		from supplier
	open sup_cursor
	fetch NEXT from sup_cursor into @sup_id, @sup_name
	while @@FETCH_STATUS = 0
	begin	
		set @i = 1;
		set @no_fc = 0;
		set @no_purchase = 0;
		set @no_supply = 0;
		set @no_marketing = 0;
		set @no_steering = 0;
		set @no_issues = 0;
		set @no_logistic = 0;
		set @no_needs = 0;
		if @geo_id = 7
			while (@i < 7)
			begin
				set @no_fc = @no_fc + dbo.no_eval_kpi6_per_kpt(@sup_id,@i,@pco_id,17,@start_date,@end_date);
				set @no_purchase = @no_purchase + dbo.no_eval_kpi6_per_kpt(@sup_id,@i,@pco_id,18,@start_date,@end_date);
				set @no_supply = @no_supply + dbo.no_eval_kpi6_per_kpt(@sup_id,@i,@pco_id,19,@start_date,@end_date);
				set @no_marketing = @no_marketing + dbo.no_eval_kpi6_per_kpt(@sup_id,@i,@pco_id,20,@start_date,@end_date);		
				set @no_steering = @no_steering + dbo.no_eval_kpi6_per_kpt(@sup_id,@i,@pco_id,21,@start_date,@end_date);
				set @no_issues = @no_issues + dbo.no_eval_kpi6_per_kpt(@sup_id,@i,@pco_id,22,@start_date,@end_date);
				set @no_logistic = @no_logistic + dbo.no_eval_kpi6_per_kpt(@sup_id,@i,@pco_id,23,@start_date,@end_date);
				set @no_needs = @no_needs + dbo.no_eval_kpi6_per_kpt(@sup_id,@i,@pco_id,24,@start_date,@end_date);	
				set @i = @i + 1;			
			end
		else
		begin
			set @no_fc = dbo.no_eval_kpi6_per_kpt(@sup_id,@geo_id,@pco_id,17,@start_date,@end_date);
			set @no_purchase = dbo.no_eval_kpi6_per_kpt(@sup_id,@geo_id,@pco_id,18,@start_date,@end_date);
			set @no_supply = dbo.no_eval_kpi6_per_kpt(@sup_id,@geo_id,@pco_id,19,@start_date,@end_date);
			set @no_marketing = dbo.no_eval_kpi6_per_kpt(@sup_id,@geo_id,@pco_id,20,@start_date,@end_date);		
			set @no_steering = dbo.no_eval_kpi6_per_kpt(@sup_id,@geo_id,@pco_id,21,@start_date,@end_date);
			set @no_issues = dbo.no_eval_kpi6_per_kpt(@sup_id,@geo_id,@pco_id,22,@start_date,@end_date);
			set @no_logistic = dbo.no_eval_kpi6_per_kpt(@sup_id,@geo_id,@pco_id,23,@start_date,@end_date);
			set @no_needs = dbo.no_eval_kpi6_per_kpt(@sup_id,@geo_id,@pco_id,24,@start_date,@end_date);
		end
		insert into @kpi_table
			select 	
			@sup_id,
			@sup_name,
			@no_purchase,
			@no_logistic,
			@no_supply,
			@no_needs,
			@no_marketing,
			@no_fc,	
			@no_issues,	
			@no_steering	
		fetch next from sup_cursor into @sup_id, @sup_name 
	end
	close sup_cursor
	deallocate sup_cursor
	RETURN  
END






GO
