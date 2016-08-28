SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[no_deviations_kpi5_per_kpt] 
(
	@sup_id int,
	@geo_id int,
	@pco_id int,
	@kpt_id int,
	@start_date datetime,
	@end_date datetime
)
RETURNS float
AS
BEGIN
	declare @result float;
	set @result = 0;
	if (@pco_id is null)
		select  @result = sum(kpv.rate)
		from	kpi_evaluation as kpe INNER JOIN
				kpi_values AS kpv ON kpe.id = kpv.kpe_id 
		where   kpv.kpt_id = @kpt_id and
				kpv.rate <> -1 and
				kpv.sup_id = @sup_id and
				kpe.geo_id = @geo_id and
				kpe.date between @start_date and @end_date
		group by kpv.sup_id;
	else
		select  @result = sum(kpv.rate)
		from	kpi_evaluation as kpe INNER JOIN
				kpi_values AS kpv ON kpe.id = kpv.kpe_id 
		where   kpv.kpt_id = @kpt_id and
				kpv.rate <> -1 and
				kpv.sup_id = @sup_id and
				kpe.geo_id = @geo_id and
				kpe.pco_id = @pco_id and
				kpe.date between @start_date and @end_date
		group by kpv.sup_id;	
	if (@result is null) set @result = -1;
	return @result;
END







GO
