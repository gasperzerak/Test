SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

CREATE FUNCTION [dbo].[kpi_no_briefings_decided_part] 
(
	@start_date datetime,
	@end_date datetime,
	@geo_id int,
	@sbu_id int,
	@pro_id int
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
	declare @result int
	if ( @geo_id is null AND @sbu_id is null AND @pro_id is null) 
		-- for kpi 1
		select @result = count (brs.id) 
			from briefing_supplier brs inner join briefing brf on brs.brf_id = brf.id
			where brf.sta_id = @status_finshed and 
				brf.str_id in (select * from @str_cond_table) and
				status_since_date between @start_date and @end_date
	else
		-- for kpi 2 - geo_id cannot be null / geo_id=7 is global
		if (@geo_id = 7)
			if ( @sbu_id is null)
				select @result = count (brs.id) 
					from briefing_supplier brs inner join briefing brf on brs.brf_id = brf.id
					where brf.sta_id = @status_finshed and
						brf.str_id in (select * from @str_cond_table) and
						status_since_date between @start_date and @end_date	
				else
					select @result = count (brs.id) 
						from briefing_supplier brs inner join briefing brf on brs.brf_id = brf.id
						where brf.sta_id = @status_finshed and
							brf.str_id in (select * from @str_cond_table) and
							brf.sbu_id = @sbu_id and
							brf.status_since_date between @start_date and @end_date
		else
			if ( @pro_id is null AND @sbu_id is null)
				-- no sbu or product category specified
				select @result = count (brs.id) 
					from briefing_supplier brs inner join briefing brf on brs.brf_id = brf.id INNER JOIN
						briefing_geo brg ON brf.id = brg.brf_id
					where 
						(brf.status_since_date between @start_date and @end_date) and
						brf.sta_id = @status_finshed and
						brf.str_id in (select * from @str_cond_table) and
						brg.geo_id = @geo_id
			else
					select @result = count (brs.id) 
						from briefing_supplier brs inner join briefing brf on brs.brf_id = brf.id INNER JOIN
							briefing_geo brg ON brf.id = brg.brf_id
						where 
							(status_since_date between @start_date and @end_date) and
							brf.sta_id = @status_finshed and
							brf.str_id in (select * from @str_cond_table) and
							brf.sbu_id = @sbu_id and
							brg.geo_id = @geo_id
	return @result
END


GO
