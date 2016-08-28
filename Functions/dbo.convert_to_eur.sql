SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[convert_to_eur] 
(
	@value float,
	@cur_id int
)
RETURNS float
BEGIN
	declare @ret_value float
	declare @exch_rate float
	if (@cur_id is not null) begin
		select @exch_rate = exch_rate from currency where id = @cur_id
		set @ret_value = round(@value / @exch_rate,2)
	end
	else
		set @ret_value = 0
	return @ret_value
END
GO
