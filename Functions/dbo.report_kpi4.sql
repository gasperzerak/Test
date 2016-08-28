SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[report_kpi4] (
@today datetime
)
RETURNS @report_kpi4 TABLE 
(
	id int PRIMARY KEY NOT NULL,
	briefing_no nvarchar(50),
	created_by nvarchar(50),
	proj_title nvarchar(100),
	creation_date datetime,
	bus_name nvarchar(50),
	pro_name nvarchar(50),
	str_name nvarchar(50),
	geos nvarchar(200),
	sta_name nvarchar(50),
	kpi4_values nvarchar(1000),
	comments nvarchar(500),
	status_since_date datetime,
	suppliers nvarchar(200)
)
AS
BEGIN
	declare @id int
	declare @brf_id_variant int
	declare @variant_no int
	declare @briefing_no nvarchar(50)
	declare @created_by nvarchar(50)
	declare @proj_title nvarchar(100)
	declare @creation_date datetime
	declare @bus_name nvarchar(50)
	declare @pro_name nvarchar(50)
	declare @str_name nvarchar(50)
	declare @geos nvarchar(200)
	declare @geo nvarchar(50)
	declare @suppliers nvarchar(200)
	declare @supplier nvarchar(50)
	declare @sta_name nvarchar(50)
	declare @comments nvarchar(1000)
	declare @comment nvarchar(500)
	declare @kpi4_values nvarchar(1000)
	declare @status_since_date datetime
	declare @startDate datetime
	declare @endDate datetime
	SET @endDate = dbo.MDate(YEAR(@today),MONTH(@today),1) - 1
	SET @startDate = dbo.MDate(Year(@today),Month(@today)-6,1)
	declare brf_cursor cursor for
		select distinct brf.id, 
			variant_no,
			brf_id_variant,
			briefing_no,
			created_by, 
			proj_title, 
			creation_date, 
			bus.name as bus_name, 
			pro.name as pro_name,
			stra.name as str_name, 
			sta.name as sta_name,
			--kpe.comment as comments,
			brf.status_since_date as status_since_date
		from briefing brf 
			LEFT OUTER JOIN strat_scope stra ON brf.str_id = stra.id 
			LEFT OUTER JOIN business bus ON brf.bus_id = bus.id 
			LEFT OUTER JOIN product_category pro ON brf.pro_id =pro.id 
			LEFT OUTER JOIN status sta ON brf.sta_id = sta.id
			--LEFT OUTER JOIN kpi_evaluation kpe on kpe.brf_id = brf.id
		where ((brf_id_variant IS NULL AND NOT (brf_id_variant IS NULL AND sta.name = 'Cancelled' AND variant_no > 1)) OR sta.name = 'Finished')
			  AND NOT sta.name = 'Cancelled' and
			  brf.status_since_date between @startDate and @endDate
	open brf_cursor
	fetch NEXT from brf_cursor into @id, @variant_no, @brf_id_variant, @briefing_no,@created_by, @proj_title, @creation_date, @bus_name, @pro_name, @str_name, @sta_name, @status_since_date
	while @@FETCH_STATUS = 0
	begin
		set @comments = null
		set @comment = null
		declare comment_cursor cursor for
			select comment from kpi_evaluation where brf_id = @id
		open comment_cursor
			fetch NEXT from comment_cursor into @comment
			while @@FETCH_STATUS = 0
			begin
				if (@comment is not null)
					if (@comments is not null)
						set @comments = @comments + ',' + @comment
					else
						set @comments = @comment
						
				fetch NEXT from comment_cursor into @comment
			end
		close comment_cursor
		deallocate comment_cursor
		
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

		set @kpi4_values = dbo.get_kpi4_values_brfno_for_briefing(@briefing_no)

		insert into @report_kpi4
			select 	
			@id, 
			@briefing_no,
			@created_by, 
			@proj_title,
			@creation_date, 
			@bus_name, 
			@pro_name,
			@str_name,
			@geos,
			@sta_name,
			@kpi4_values,
			@comments,
			@status_since_date,
			@suppliers
		fetch NEXT from brf_cursor into @id, @variant_no, @brf_id_variant, @briefing_no, @created_by, @proj_title, @creation_date, @bus_name, @pro_name, @str_name, @sta_name, @status_since_date
	end
	close brf_cursor
	deallocate brf_cursor
	RETURN 
END
GO
