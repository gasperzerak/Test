SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[get_supplier_inc_rates] (
	@from datetime,
	@til datetime
)
RETURNS @supplier TABLE 
(
	id int,
	name nvarchar(200),
	active bit,
	status nvarchar(100),
	part_rate nvarchar(7),
	value_rate nvarchar(7),
	--TEMPORARY
    part_rate_july nvarchar(7),
    value_rate_july nvarchar(7)
    --part_rate_august nvarchar(7),
    --value_rate_august nvarchar(7)
	--/TEMPORARY
)
AS
BEGIN
	declare @id int
	declare @name nvarchar(200)
	declare @status nvarchar(100)
	declare @active bit
	declare @part_rate nvarchar(7)
	declare @value_rate nvarchar(7)

	-- internal use
	declare @sup_part_rate float
	declare @sup_value_rate float
	declare @no_brf float
	declare @total_value float
	declare @no_assigned float
	declare @sup_value float
	-- init
	set @no_brf = 0
	set @no_assigned = 0
	set @part_rate = 0
	set @value_rate = 'n.a.'

	--TEMPORARY

	declare @sup_part_rate_july float
	declare @sup_value_rate_july float
	declare @sup_part_rate_august float
	declare @sup_value_rate_august float
	declare @part_rate_july nvarchar(7)
	declare @value_rate_july nvarchar(7)
	declare @part_rate_august nvarchar(7)
	declare @value_rate_august nvarchar(7)
	declare @no_brf_july float
	declare @no_brf_august float
	declare @total_value_july float
	declare @total_value_august float
	declare @no_assigned_july float
	declare @sup_value_july float
	declare @no_assigned_august float
	declare @sup_value_august float

	set @no_brf_july = 0
	set @no_brf_august = 0
	set @no_assigned_july = 0
	set @part_rate_july = 0
	set @value_rate_july = 'n.a.'
	set @no_assigned_august = 0
	set @part_rate_august = 0
	set @value_rate_august = 'n.a.'

	select @no_brf_july = count(id) from briefing where creation_date >= '20110701' and creation_date < @til and str_id in (1,2,8) and sta_id in (4,5) and (brf_id_variant is null or sta_id = 5)
	select @total_value_july = sum(dbo.convert_to_eur(dbo.calc_briefing_value_lc(brf.id),brf.cur_id)) from 
		briefing brf where 
			creation_date >= '20110701' and creation_date < @til and str_id in (1,2,8)
			and sta_id in (4,5)
			and (brf_id_variant is null or sta_id = 5)

	/*select @no_brf_august = count(id) from briefing where creation_date >= '20080801' and creation_date < @til and str_id in (1,2,8) and sta_id in (4,5) and (brf_id_variant is null or sta_id = 5)
	select @total_value_august = sum(dbo.convert_to_eur(dbo.calc_briefing_value_lc(brf.id),brf.cur_id)) from 
		briefing brf where 
			creation_date >= '20080801' and creation_date < @til and str_id in (1,2,8)
			and sta_id in (4,5)*/

	--/TEMPORARY

	select @no_brf = count(id) from briefing where creation_date >= @from and creation_date < @til and str_id in (1,2,8) and sta_id in (4,5) and (brf_id_variant is null or sta_id = 5)
	select @total_value = sum(dbo.convert_to_eur(dbo.calc_briefing_value_lc(brf.id),brf.cur_id)) from 
		briefing brf where 
			creation_date >= @from and creation_date < @til and str_id in (1,2,8)
			and sta_id in (4,5) and (brf_id_variant is null or sta_id = 5)
	declare sup_cursor cursor for
		select sup.id, 
			sup.name,
			sup.active,
			sus.name 
		from supplier sup
			inner join  supplier_status sus on sup.sus_id = sus.id
		where sup.id <> 5
	open sup_cursor
		fetch NEXT from sup_cursor into 
			@id, 
			@name, 
			@active,
			@status
	while @@FETCH_STATUS = 0 
	begin 

		--TEMPORARY

		select @no_assigned_july  = count (distinct brf.briefing_no)     
			from briefing brf INNER JOIN
				briefing_supplier brs ON brf.id = brs.brf_id
			where 
				briefing_no in (select briefing_no from briefing brf INNER JOIN briefing_supplier brs ON brf.id = brs.brf_id where
				(brf.creation_date >= '20110701' and brf.creation_date < @til) and
				brf.sta_id in (4,5) and
				brf.str_id in (1,2,8)) and
				brs.sup_id = @id
				and (brf_id_variant is null or sta_id = 5)

		/*select @no_assigned_jan  = count(brs.id) 
		from
			briefing_supplier brs
				inner join briefing brf on brs.brf_id = brf.id
		where ( brf.creation_date >= '20100101' and brf.creation_date < @til )
			and brf.str_id in (1,2,8)  
			and brs.sup_id = @id
			and brf.sta_id in (4,5)*/

		if ( @no_brf_july > 0 )
			set @sup_part_rate_july = round(@no_assigned_july / @no_brf_july,4) * 100
		set @part_rate_july = cast( @sup_part_rate_july as nvarchar) + '%'
		select @sup_value_july = sum(dbo.convert_to_eur(dbo.calc_briefing_value_lc(brf.id),brf.cur_id)) 
			from 
				briefing brf 
					inner join briefing_supplier brs on brf.id = brs.brf_id 
			where creation_date >= '20110701' and creation_date < @til 
				and str_id in (1,2,8) 
				and brs.sup_id = @id
				and brf.sta_id in (4,5)
				and (brf_id_variant is null or sta_id = 5)
		if ( @total_value_july <> 0 ) begin
			set @sup_value_rate_july = round(@sup_value_july / @total_value_july,4) * 100
			set @value_rate_july = cast( @sup_value_rate_july as nvarchar) + '%'
		end


		/*select @no_assigned_august  = count (distinct brf.briefing_no)     
			from briefing brf INNER JOIN
				briefing_supplier brs ON brf.id = brs.brf_id
			where 
				briefing_no in (select briefing_no from briefing brf INNER JOIN briefing_supplier brs ON brf.id = brs.brf_id where
				(brf.creation_date >= '20080801' and brf.creation_date < @til) and
				brf.sta_id in (4,5) and
				brf.str_id in (1,2,8)) and
				brs.sup_id = @id

		/*select @no_assigned_august  = count(brs.id) 
		from
			briefing_supplier brs
				inner join briefing brf on brs.brf_id = brf.id
		where ( brf.creation_date >= '20080801' and brf.creation_date < @til )
			and brf.str_id in (1,2,8)  
			and brs.sup_id = @id
			and brf.sta_id in (4,5)*/

		if ( @no_brf_august > 0 )
			set @sup_part_rate_august = round(@no_assigned_august / @no_brf_august,4) * 100
		set @part_rate_august = cast( @sup_part_rate_august as nvarchar) + '%'
		select @sup_value_august = sum(dbo.convert_to_eur(dbo.calc_briefing_value_lc(brf.id),brf.cur_id)) 
			from 
				briefing brf 
					inner join briefing_supplier brs on brf.id = brs.brf_id 
			where creation_date >= '20080801' and creation_date < @til 
				and str_id in (1,2,8) 
				and brs.sup_id = @id
				and brf.sta_id in (4,5)
		if ( @total_value_august <> 0 ) begin
			set @sup_value_rate_august = round(@sup_value_august / @total_value_august,4) * 100
			set @value_rate_august = cast( @sup_value_rate_august as nvarchar) + '%'
		end*/



		--/TEMPORARY

		/*select @no_assigned  = count(brs.id) 
		from
			briefing_supplier brs
				inner join briefing brf on brs.brf_id = brf.id
		where ( brf.creation_date >= @from and brf.creation_date < @til )
			and brf.str_id in (1,2,8)  
			and brs.sup_id = @id
			and brf.sta_id in (4,5)*/

		select @no_assigned  = count (distinct brf.briefing_no)     
			from briefing brf INNER JOIN
				briefing_supplier brs ON brf.id = brs.brf_id
			where 
				briefing_no in (select briefing_no from briefing brf INNER JOIN briefing_supplier brs ON brf.id = brs.brf_id where
				(brf.creation_date >= @from and brf.creation_date < @til) and
				brf.sta_id in (4,5) and
				brf.str_id in (1,2,8)) and
				(brf_id_variant is null or sta_id = 5) and
				brs.sup_id = @id


		if ( @no_brf > 0 )
			set @sup_part_rate = round(@no_assigned / @no_brf,4) * 100
		set @part_rate = cast( @sup_part_rate as nvarchar) + '%'
		select @sup_value = sum(dbo.convert_to_eur(dbo.calc_briefing_value_lc(brf.id),brf.cur_id)) 
			from 
				briefing brf 
					inner join briefing_supplier brs on brf.id = brs.brf_id 
			where creation_date >= @from and creation_date < @til 
				and str_id in (1,2,8) 
				and brs.sup_id = @id
				and brf.sta_id in (4,5)
				and (brf_id_variant is null or sta_id = 5)
		if ( @total_value <> 0 ) begin
			set @sup_value_rate = round(@sup_value / @total_value,4) * 100
			set @value_rate = cast( @sup_value_rate as nvarchar) + '%'
		end
		insert into @supplier
				(id, name,active,status,part_rate,value_rate,part_rate_july,value_rate_july)--,part_rate_august,value_rate_august) 
			values (@id, @name,@active, @status, @part_rate, @value_rate, @part_rate_july, @value_rate_july)--, @part_rate_august, @value_rate_august)
		fetch NEXT from sup_cursor into @id, @name,@active,@status
	end
	close sup_cursor		
	deallocate sup_cursor
	RETURN 
END
GO
