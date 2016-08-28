SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS OFF
GO

CREATE FUNCTION [dbo].[evaluation_rate_kpi4] 
(
	@start_date datetime,
	@end_date datetime
)
RETURNS 
@kpi_table TABLE 
(
	sup_id int PRIMARY KEY NOT NULL,
	sup_name nvarchar(200),
	no_docs float,
	no_samples float,
	no_deadline float,
	no_restrictions float,
	no_price float,
	no_submissions float
)
AS
BEGIN
	declare @sup_id int;
	declare @sup_name nvarchar(200);
	declare @no_docs float;
	declare @no_samples float;
	declare @no_deadline float;
	declare @no_restrictions float;
	declare @no_price float;
	declare @no_submissions float;
	declare sup_cursor cursor for
		select id,name
		from supplier
	open sup_cursor
	fetch NEXT from sup_cursor into @sup_id, @sup_name
	while @@FETCH_STATUS = 0
	begin
		set @no_docs = dbo.eval_rate_kpi4_per_kpt(@sup_id,7,@start_date,@end_date);
		set @no_samples = dbo.eval_rate_kpi4_per_kpt(@sup_id,8,@start_date,@end_date);
		set @no_deadline = dbo.eval_rate_kpi4_per_kpt(@sup_id,9,@start_date,@end_date);
		set @no_restrictions = dbo.eval_rate_kpi4_per_kpt(@sup_id,10,@start_date,@end_date);
		set @no_price = dbo.eval_rate_kpi4_per_kpt(@sup_id,11,@start_date,@end_date);
		set @no_submissions = dbo.eval_rate_kpi4_per_kpt(@sup_id,12,@start_date,@end_date);
		insert into @kpi_table
			select 	
			@sup_id,
			@sup_name,
			@no_docs,
			@no_samples,
			@no_deadline,
			@no_restrictions,
			@no_price,
			@no_submissions	
		fetch next from sup_cursor into @sup_id, @sup_name 
	end
	close sup_cursor
	deallocate sup_cursor
	RETURN  
END



GO
