SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [dbo].[calculate_winrate] (
	@geo_id int,
	@sbu_id int,
	@pro_id int,
	@start_date datetime,
	@end_date datetime
)
RETURNS @kpi1_supplier TABLE 
(
	sup_id int PRIMARY KEY NOT NULL,
	sort_order int,
	sup_name nvarchar(200),
	no_briefings_part int,
	no_briefings_part_part int,
	part_rate float,
	no_briefings_won int,
	win_rate float,
	diff float,
	indicator int
)
AS
BEGIN
	declare @sup_id int
	declare @sort_order int
	declare @sup_name nvarchar(200)
	declare @no_briefings float
	declare @no_briefings_part float
	declare @no_part_part float
	declare @part_rate float
	declare @no_won float
	declare @win_rate float
	declare @diff float
	declare @indicator float
	declare sup_cursor cursor for
		select id,sort_order,name from supplier
	open sup_cursor
	fetch NEXT from sup_cursor into @sup_id, @sort_order, @sup_name
	while @@FETCH_STATUS = 0
	begin
		set @no_briefings_part = dbo.kpi_no_briefings_part(@sup_id,@geo_id,@sbu_id,@pro_id,@start_date,@end_date)
		set @no_part_part  = dbo.kpi_no_briefings_part_part (@sup_id, @geo_id,@sbu_id,@pro_id, @start_date,@end_date)
		if @no_part_part = 0 
			set @part_rate = 0
		else
			set @part_rate = round(@no_briefings_part / @no_part_part , 4 )
		set @no_won = dbo.kpi_no_briefings_won( @sup_id,@geo_id,@sbu_id,@pro_id, @start_date,@end_date)
		if @no_briefings_part = 0
			set @win_rate = 0
		else
			set @win_rate = round(@no_won / @no_briefings_part , 4)
		set @diff = @win_rate - @part_rate
		if @diff > 0
			set @indicator = 0
		else if @diff = 0
				set @indicator = 1
			else
				set @indicator = 2
		insert into @kpi1_supplier
			select 	
			@sup_id,
			@sort_order,
			@sup_name,
			@no_briefings_part,
			@no_part_part,
			@part_rate,
			@no_won,
			@win_rate,
			@diff,
			@indicator
			
		fetch next from sup_cursor into @sup_id, @sort_order, @sup_name
	end
	close sup_cursor
	deallocate sup_cursor
	RETURN 
END





GO
