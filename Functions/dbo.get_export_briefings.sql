SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[get_export_briefings] (
)
RETURNS @export_briefings TABLE 
(
	id int PRIMARY KEY NOT NULL,
	briefing_no nvarchar(50),
	created_by nvarchar(50),
	proj_title nvarchar(100),
	creation_date datetime,
	delivery_date datetime,
	bus_name nvarchar(50),
	sbu_name nvarchar(50),
	pro_name nvarchar(50),
	str_name nvarchar(50),
	cur_name nvarchar(3),
	qud_name nvarchar(50),
	qud_id int,
	prod_forms nvarchar(200),
	costs nvarchar(200),
	dosages nvarchar(200),
	status nvarchar(50),
	decided bit,
	decided_when datetime,
	lgo_name nvarchar(50),
	geos nvarchar(200),
	suppliers nvarchar(200),
	prev_costs nvarchar(200),
	prev_cost_ass nvarchar(200),
	brf_value_lc float,
	brf_value_eur float
)
AS
BEGIN
	declare @brf_value_lc float
	declare @id int
	declare @lgo_id int
	declare @variant_no int
	declare @brf_id_variant int
	declare @briefing_no nvarchar(50)
	declare @created_by nvarchar(50)
	declare @proj_title nvarchar(100)
	declare @creation_date datetime
	declare @delivery_date datetime
	declare @bus_name nvarchar(50)
	declare @sbu_name nvarchar(50)
	declare @pro_name nvarchar(50)
	declare @str_name nvarchar(50)
	declare @cur_name nvarchar(3)
	declare @prod_forms nvarchar(200)
	declare @costs nvarchar(200)
	declare @dosages nvarchar(200)
	declare @status nvarchar(50)
	declare @geos nvarchar(200)
	declare @geo nvarchar(50)
	declare @decided bit
	declare @decided_when datetime
	declare @suppliers nvarchar(200)
	declare @supplier nvarchar(50)
	declare @prev_costs nvarchar(200)
	declare @prev_cost_ass nvarchar(200)
	declare @qud_name nvarchar(50)
	declare @lgo_name nvarchar(50)
	declare @qud_id int
	declare @cur_id int
	declare brf_cursor cursor for
		select brf.id, 
			variant_no,
			brf_id_variant,
			briefing_no,
			created_by, 
			proj_title, 
			creation_date, 
			delivery_date,
			status_since_date, 
			lgo_id,
			bus.name as bus_name, 
			sbu.name as sbu_name, 
			pro.name as pro_name,
			stra.name as str_name,
			cur.id,  
			cur.name as cur_name, 
			sta.name as sta_name
		from briefing brf 
			LEFT OUTER JOIN strat_scope stra ON brf.str_id = stra.id 
			LEFT OUTER JOIN business bus ON brf.bus_id = bus.id 
			LEFT OUTER JOIN sbu ON brf.sbu_id = sbu.id 
			LEFT OUTER JOIN product_category pro ON brf.pro_id =pro.id 
			LEFT OUTER JOIN currency cur ON brf.cur_id = cur.id
			LEFT OUTER JOIN status sta ON brf.sta_id = sta.id
		where (brf_id_variant IS NULL AND NOT (brf_id_variant IS NULL AND sta.name = 'Cancelled' AND variant_no > 1)) OR sta.name = 'Finished'
	open brf_cursor
	fetch NEXT from brf_cursor into @id, @variant_no, @brf_id_variant, @briefing_no, @created_by, @proj_title, @creation_date, @delivery_date, @decided_when, @lgo_id, @bus_name, @sbu_name, @pro_name, @str_name, @cur_id,@cur_name, @status
	while @@FETCH_STATUS = 0
	begin
		set @decided = null
		if (@status = 'Finished')
		begin
			select @status = name from  supplier INNER JOIN dbo.briefing_supplier ON dbo.supplier.id = sup_id and brf_id = @id and winner_yn = 1
			set @decided = 1
		end
		else
			set @decided_when = null
			
		select @lgo_name = name from geographical_scope where id = @lgo_id

		set @geos = ''
		set @geo = null
		declare geo_cursor cursor for
			select name from geographical_scope INNER JOIN briefing_geo ON geographical_scope.id = briefing_geo.geo_id where brf_id = @id
		open geo_cursor
			fetch NEXT from geo_cursor into @geo
			if (@geo is not null)
				set @geos = @geos + @geo
			fetch NEXT from geo_cursor into @geo
			while @@FETCH_STATUS = 0
			begin
				if (@geo is not null)	
					set @geos = @geos + ',' + @geo
				fetch NEXT from geo_cursor into @geo
			end
		close geo_cursor
		deallocate geo_cursor
		
		set @supplier = null
		set @suppliers = ''
		declare supplier_cursor cursor for
			select distinct name from supplier INNER JOIN briefing_supplier ON supplier.id = briefing_supplier.sup_id INNER JOIN briefing ON briefing.id = briefing_supplier.brf_id where briefing_no = @briefing_no
		open supplier_cursor
			fetch NEXT from supplier_cursor into @supplier
			while @@FETCH_STATUS = 0
			begin
				if (@supplier is not null)	
					set @suppliers = @suppliers + ',' + @supplier
				fetch NEXT from supplier_cursor into @supplier
			end
		close supplier_cursor
		deallocate supplier_cursor

		select	@prod_forms = prod_forms, 
				@costs = costs, 
				@dosages = dosages, 
				@qud_name = qud_name, 
				@qud_id = qud_id,
				@prev_costs = prev_costs,
				@prev_cost_ass = prev_cost_ass
		from get_product_forms_for_briefing(@id)
		select @brf_value_lc = dbo.calc_briefing_value_lc(@id)
		insert into @export_briefings
			select 	
			@id, 
			@briefing_no,
			@created_by, 
			@proj_title,
			@creation_date, 
			@delivery_date,
			@bus_name, 
			@sbu_name,
			@pro_name,
			@str_name,
			@cur_name,
			@qud_name,
			@qud_id,
			@prod_forms,
			@costs,
			@dosages,
			@status,
			@decided,
			@decided_when,
			@lgo_name,
			@geos,
			@suppliers,
			@prev_costs,
			@prev_cost_ass,
			@brf_value_lc,
			dbo.convert_to_eur(@brf_value_lc,@cur_id)
		fetch NEXT from brf_cursor into @id, @variant_no, @brf_id_variant, @briefing_no, @created_by, @proj_title, @creation_date, @delivery_date, @decided_when, @lgo_id, @bus_name, @sbu_name, @pro_name, @str_name, @cur_id, @cur_name, @status

	end
	close brf_cursor
	deallocate brf_cursor
	RETURN 
END

GO
