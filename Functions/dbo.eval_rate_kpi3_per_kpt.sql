SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

CREATE FUNCTION [dbo].[eval_rate_kpi3_per_kpt] 
(
	@sup_id int,
	@geo_id int,
	@lco_id int,
	@project varchar(30),
	@kpt_id int,
	@start_date datetime,
	@end_date datetime
)
RETURNS float
AS
BEGIN
	declare @result float;
	set @result = 0;
	if (@lco_id is null)
		select  @result = avg(kpv.rate)
		from	kpi_evaluation as kpe INNER JOIN	
				kpi_values AS kpv ON kpe.id = kpv.kpe_id 
		where   kpv.kpt_id = @kpt_id and
				kpv.rate <> -1 and
				kpv.sup_id = @sup_id and
				kpe.geo_id = @geo_id and
				kpe.project = @project and
				kpe.date between @start_date and @end_date
		group by kpv.sup_id;
	else
		select  @result = avg(kpv.rate)
		from	kpi_evaluation as kpe INNER JOIN	
				kpi_values AS kpv ON kpe.id = kpv.kpe_id 
		where   kpv.kpt_id = @kpt_id and
				kpv.rate <> -1 and
				kpv.sup_id = @sup_id and
				kpe.geo_id = @geo_id and
				kpe.lco_id = @lco_id and
				kpe.project = @project and
				kpe.date between @start_date and @end_date
		group by kpv.sup_id;	
	if (@result is null) set @result = -1;
	return @result;
END




GO
