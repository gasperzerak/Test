SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS OFF
GO

CREATE FUNCTION [dbo].[calculate_no_of_evaluations_kpi3] 
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
	sup_name nvarchar(200),
	no_insights int,
	no_newness int,
	no_technology int,
	no_managment int,
	no_expertise int,
	no_concept int
)
AS
BEGIN
	declare @sup_id int;
	declare @sup_name nvarchar(200);
	declare @no_insights int;
	declare @no_newness int;
	declare @no_technology int;
	declare @no_managment int;
	declare @no_expertise int;
	declare @no_concept int;
	declare @i int;
	declare sup_cursor cursor for
		select id,name
		from supplier
	open sup_cursor
	fetch NEXT from sup_cursor into @sup_id, @sup_name
	while @@FETCH_STATUS = 0
	begin	
		set @i = 1;
		set @no_insights = 0;
		set @no_newness = 0;
		set @no_technology = 0;
		set @no_managment = 0;
		set @no_expertise = 0;
		set @no_concept = 0;
		if @geo_id = 7
			while (@i < 7)
			begin
				set @no_insights = @no_insights + dbo.no_eval_kpi3_per_kpt(@sup_id,@i,@lco_id,@project,1,@start_date,@end_date);
				set @no_newness = @no_newness + dbo.no_eval_kpi3_per_kpt(@sup_id,@i,@lco_id,@project,2,@start_date,@end_date);
				set @no_technology = @no_technology + dbo.no_eval_kpi3_per_kpt(@sup_id,@i,@lco_id,@project,3,@start_date,@end_date);
				set @no_managment = @no_managment + dbo.no_eval_kpi3_per_kpt(@sup_id,@i,@lco_id,@project,4,@start_date,@end_date);		
				set @no_expertise = @no_expertise + dbo.no_eval_kpi3_per_kpt(@sup_id,@i,@lco_id,@project,5,@start_date,@end_date);
				set @no_concept = @no_concept + dbo.no_eval_kpi3_per_kpt(@sup_id,@i,@lco_id,@project,6,@start_date,@end_date);
				set @i = @i + 1;			
			end
		else
		begin
			set @no_insights = dbo.no_eval_kpi3_per_kpt(@sup_id,@geo_id,@lco_id,@project,1,@start_date,@end_date);
			set @no_newness = dbo.no_eval_kpi3_per_kpt(@sup_id,@geo_id,@lco_id,@project,2,@start_date,@end_date);
			set @no_technology = dbo.no_eval_kpi3_per_kpt(@sup_id,@geo_id,@lco_id,@project,3,@start_date,@end_date);
			set @no_managment = dbo.no_eval_kpi3_per_kpt(@sup_id,@geo_id,@lco_id,@project,4,@start_date,@end_date);		
			set @no_expertise = dbo.no_eval_kpi3_per_kpt(@sup_id,@geo_id,@lco_id,@project,5,@start_date,@end_date);
			set @no_concept = dbo.no_eval_kpi3_per_kpt(@sup_id,@geo_id,@lco_id,@project,6,@start_date,@end_date);
		end
		insert into @kpi_table
			select 	
			@sup_id,
			@sup_name,
			@no_insights,
			@no_newness,
			@no_technology,
			@no_managment,
			@no_expertise,
			@no_concept
		fetch next from sup_cursor into @sup_id, @sup_name 
	end
	close sup_cursor
	deallocate sup_cursor
	RETURN  
END


GO
