SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS OFF
GO

CREATE FUNCTION [dbo].[calculate_eval_rate_kpi4] 
(
	@start_date datetime,
	@end_date datetime
)
RETURNS 
@kpi_table TABLE 
(
	sup_id int PRIMARY KEY NOT NULL,
	sort_order int,
	sup_name nvarchar(200),
	rate_docs float,
	rate_samples float,
	rate_deadline float,
	rate_restrictions float,
	rate_price float,
	rate_submissions float
)
AS
BEGIN
	declare @sup_id int;
	declare @sort_order int;
	declare @sup_name nvarchar(200);
	declare @rate_docs float;
	declare @rate_samples float;
	declare @rate_deadline float;
	declare @rate_restrictions float;
	declare @rate_price float;
	declare @rate_submissions float;
	declare sup_cursor cursor for
		select id,sort_order,name
		from supplier
	open sup_cursor
	fetch NEXT from sup_cursor into @sup_id,@sort_order, @sup_name
	while @@FETCH_STATUS = 0
	begin
		set @rate_docs = dbo.eval_rate_kpi4_per_kpt(@sup_id,7,@start_date,@end_date);
		set @rate_samples = dbo.eval_rate_kpi4_per_kpt(@sup_id,8,@start_date,@end_date);
		set @rate_deadline = dbo.eval_rate_kpi4_per_kpt(@sup_id,9,@start_date,@end_date);
		set @rate_restrictions = dbo.eval_rate_kpi4_per_kpt(@sup_id,10,@start_date,@end_date);
		set @rate_price = dbo.eval_rate_kpi4_per_kpt(@sup_id,11,@start_date,@end_date);
		set @rate_submissions = dbo.eval_rate_kpi4_per_kpt(@sup_id,12,@start_date,@end_date);
		insert into @kpi_table
			select 	
			@sup_id,
			@sort_order,
			@sup_name,
			@rate_docs,
			@rate_samples,
			@rate_deadline,
			@rate_restrictions,
			@rate_price,
			@rate_submissions	
		fetch next from sup_cursor into @sup_id,@sort_order, @sup_name 
	end
	close sup_cursor
	deallocate sup_cursor
	RETURN  
END




GO
