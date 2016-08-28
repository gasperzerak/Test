SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE FUNCTION [dbo].[get_export_briefings_TEST] (
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
	status nvarchar(50),
	brf_value_lc float,
	brf_value_eur float
)
AS
BEGIN
	declare @brf_value_lc float
	declare @id int
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
	declare @status nvarchar(50)
	declare @decided bit
	declare @decided_when datetime
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
		where creation_date between '20121112' AND '20121112' AND ((brf_id_variant IS NULL AND NOT (brf_id_variant IS NULL AND sta.name = 'Cancelled' AND variant_no > 1)) OR sta.name = 'Finished')
	open brf_cursor
	fetch NEXT from brf_cursor into @id, @variant_no, @brf_id_variant, @briefing_no, @created_by, @proj_title, @creation_date, @delivery_date, @decided_when, @bus_name, @sbu_name, @pro_name, @str_name, @cur_id,@cur_name, @status
	while @@FETCH_STATUS = 0
	begin

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
			@status,
			@brf_value_lc,
			dbo.convert_to_eur(@brf_value_lc,@cur_id)
		fetch NEXT from brf_cursor into @id, @variant_no, @brf_id_variant, @briefing_no, @created_by, @proj_title, @creation_date, @delivery_date, @decided_when, @bus_name, @sbu_name, @pro_name, @str_name, @cur_id, @cur_name, @status

	end
	close brf_cursor
	deallocate brf_cursor
	RETURN 
END

GO
