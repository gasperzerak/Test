SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

CREATE FUNCTION [dbo].[kpi_no_briefings_won] 
(
	@sup_id int,
	@geo_id int,
	@sbu_id int,
	@pro_id int,
	@start_date datetime,
	@end_date datetime
)
RETURNS int
AS
BEGIN
	declare @status_finshed int;
	set @status_finshed = 5;
	declare @str_cond_table table( id int );
	insert into @str_cond_table values(1);
	insert into @str_cond_table values(2);
	insert into @str_cond_table values(8);
	declare @result int;
	if ((@geo_id is null OR @geo_id = 7) AND @sbu_id is null AND @pro_id is null)
		-- kpi 1
		select @result = count (brf.id)     
		from         
			briefing as brf INNER JOIN
			briefing_supplier brs ON brf.id = brs.brf_id
		where 
			brs.sup_id = @sup_id and
			(brf.status_since_date between @start_date and @end_date) and
			brf.sta_id = @status_finshed and
			brf.str_id in (select * from @str_cond_table) and
			brs.winner_yn = 1
	else
		-- kpi 2 / geo_id is not null / geo_id=7 --> global
		if (@geo_id = 7)
			if (@sbu_id is null)
				select @result = count (brf.id)     
				from         
					briefing as brf INNER JOIN
					briefing_supplier brs ON brf.id = brs.brf_id
				where 
					brs.sup_id = @sup_id and
					(brf.status_since_date between @start_date and @end_date) and
					brf.sta_id = @status_finshed and
					brf.str_id in (select * from @str_cond_table) and
					brs.winner_yn = 1 --and
					--brf.pro_id = @pro_id
			else
				select @result = count (brf.id)     
				from         
					briefing as brf INNER JOIN
					briefing_supplier brs ON brf.id = brs.brf_id
				where 
					brs.sup_id = @sup_id and
					(brf.status_since_date between @start_date and @end_date) and
					brf.sta_id = @status_finshed and
					brf.str_id in (select * from @str_cond_table) and
					brs.winner_yn = 1 and
					brf.sbu_id = @sbu_id
		else
			if (@sbu_id is null AND @pro_id is null)
				select @result = count (brf.id)     
				from briefing brf INNER JOIN
					briefing_supplier brs ON brf.id = brs.brf_id
				where 
					brs.sup_id = @sup_id and
					(brf.status_since_date between @start_date and @end_date) and
					brf.sta_id = @status_finshed and
					brf.str_id in (select * from @str_cond_table) and
					brs.winner_yn = 1 and
					brf.lgo_id = @geo_id
			else
				if (@sbu_id is null)
					select @result = count (brf.id)     
					from briefing brf INNER JOIN
						briefing_supplier brs ON brf.id = brs.brf_id
					where 
						brs.sup_id = @sup_id and
						(brf.status_since_date between @start_date and @end_date) and
						brf.sta_id = @status_finshed and
						brf.str_id in (select * from @str_cond_table) and
						brs.winner_yn = 1 and
						brf.lgo_id = @geo_id --and
						--brf.pro_id = @pro_id
				else
					select @result = count (brf.id)     
					from briefing brf INNER JOIN
						briefing_supplier brs ON brf.id = brs.brf_id
					where 
						brs.sup_id = @sup_id and
						(brf.status_since_date between @start_date and @end_date) and
						brf.sta_id = @status_finshed and
						brf.str_id in (select * from @str_cond_table) and
						brs.winner_yn = 1 and
						brf.lgo_id = @geo_id and
						brf.sbu_id = @sbu_id
	return @result
END
GO
