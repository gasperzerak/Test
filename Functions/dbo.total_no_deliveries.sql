SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[total_no_deliveries]
(
	@sup_id int,
	@geo_id int,
	@pco_id int,
	@start_date datetime,
	@end_date datetime
)
RETURNS int
AS
BEGIN
	declare @result int;
	set @result = 0;
	if (@pco_id is null)
		select	@result = sum(kpd.no_of_deliveries)
		from	kpi_evaluation kpe INNER JOIN
                	kpi5_deliveries kpd ON kpe.id = kpd.kpe_id
		where	kpd.sup_id = @sup_id and 
				(kpe.date between @start_date and @end_date) and
				kpe.geo_id = @geo_id
		group by kpd.sup_id
	else
		select	@result = sum(kpd.no_of_deliveries)
		from	kpi_evaluation kpe INNER JOIN
                	kpi5_deliveries kpd ON kpe.id = kpd.kpe_id
		where	kpd.sup_id = @sup_id and 
				(kpe.date between @start_date and @end_date) and
				kpe.geo_id = @geo_id and
				kpe.pco_id = @pco_id
		group by kpd.sup_id	
	return @result 

END




GO
