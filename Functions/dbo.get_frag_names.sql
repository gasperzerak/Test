SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[get_frag_names] 
(
	@brf_id int
)
RETURNS nvarchar(4000)
AS
BEGIN
	declare @ret nvarchar(4000)
	declare @hold nvarchar(4000)
	declare brf_cursor cursor for
		select dbo.offer_costs.fragrance_name 
		from dbo.offer_costs 
			INNER JOIN dbo.offer ON dbo.offer_costs.off_id = dbo.offer.id 
			INNER JOIN dbo.briefing_supplier ON dbo.briefing_supplier.id = dbo.offer.brs_id 
		where dbo.briefing_supplier.brf_id = @brf_id AND offer.saved = 1
	open brf_cursor
			fetch NEXT from brf_cursor into @hold

	while @@FETCH_STATUS = 0 
	begin
		if NOT @hold IS NULL
			if @ret IS NULL
				set @ret = @hold
			else
				set @ret = @ret + ',' + @hold
		fetch NEXT from brf_cursor into @hold
	end
	close brf_cursor
	deallocate brf_cursor
	return @ret
END
GO
