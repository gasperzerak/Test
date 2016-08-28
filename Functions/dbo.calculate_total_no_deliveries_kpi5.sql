SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS OFF
GO

CREATE FUNCTION [dbo].[calculate_total_no_deliveries_kpi5] 
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
	no_deliveries int
)
AS
BEGIN
	declare @i int;
	declare @sup_id int;
	declare @sort_order int;
	declare @sup_name nvarchar(200);
	declare @no_deliveries int;
	declare sup_cursor cursor for
		select id,sort_order,name
		from supplier
	open sup_cursor
	fetch NEXT from sup_cursor into @sup_id,@sort_order, @sup_name
	while @@FETCH_STATUS = 0
	begin
		set @i = 1;
		set @no_deliveries = 0;
		if @geo_id = 7 
			while (@i < 7)
			begin
				set @no_deliveries = @no_deliveries + dbo.total_no_deliveries(@sup_id,@i,@pco_id,@start_date,@end_date);
				set @i = @i + 1;
			end
		else
			set @no_deliveries = dbo.total_no_deliveries(@sup_id,@geo_id,@pco_id,@start_date,@end_date);
		insert into @kpi_table
		select 	
			@sup_id,
			@sort_order,
			@sup_name,
			@no_deliveries
		fetch next from sup_cursor into @sup_id,@sort_order, @sup_name 
	end
	close sup_cursor
	deallocate sup_cursor
	RETURN  
END



















GO
