SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE FUNCTION [dbo].[no_eval_kpi4_per_kpt] 
(
	@sup_id int,
	@kpt_id int,
	@start_date datetime,
	@end_date datetime
)
RETURNS int
AS
BEGIN
	declare @result int;
	select  @result = count(kpv.id)
	from	kpi_evaluation kpe 
			INNER JOIN kpi_values kpv ON kpe.id = kpv.kpe_id
			INNER JOIN briefing brf ON kpe.brf_id = brf.id  
	where   kpv.kpt_id = @kpt_id and
			kpv.rate <> -1 and
			kpv.sup_id = @sup_id and
			brf.status_since_date between @start_date and @end_date
	group by kpv.sup_id;
	if (@result is null) set @result = 0;
	return @result;
END





GO
