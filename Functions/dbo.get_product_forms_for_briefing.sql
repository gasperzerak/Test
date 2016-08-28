SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE FUNCTION [dbo].[get_product_forms_for_briefing] (
	@id int
)
RETURNS @prod_form TABLE 
(
	qud_name nvarchar(50),
	qud_id int,
	prod_forms varchar(200),
	costs nvarchar(200),
	dosages nvarchar(200),
	prev_costs nvarchar(200),
	prev_cost_ass nvarchar(200)
)
AS
BEGIN
	declare @prod_forms varchar(200)
	declare @prf_name nvarchar(50)
	declare @prf_id int
	declare @prf_quantity nvarchar(50)
	declare @prf_qud_name nvarchar(50)
	declare @prf_qud_id int
	declare @dosage nvarchar(50)
	declare @single_dosages nvarchar(200)
	declare @dosages nvarchar(200)
	declare @cost nvarchar(50)
	declare @single_costs nvarchar(200)
	declare @costs nvarchar(200)
	declare @prev_cost_as nvarchar(50)
	declare @prev_cost_ass nvarchar(200)
	declare @prev_cost nvarchar(50)
	declare @prev_costs nvarchar(200)
	declare @first_prf bit
	declare @first_cst bit
	declare @cst_index int
	declare @dosage_inc bit
	declare @count_prf int
	set @prod_forms = ''
	set @costs = ''
	set @dosages = ''
	set @prev_cost_ass = ''
	set @prev_costs = ''
	set @first_prf = 0
	set @first_cst = 0
	select @count_prf = count(id) from product_forms where brf_id = @id
	declare prf_cursor cursor for
	select prf.id, 
		prf.name, 
		qud.unit as qud_name, 
		qud.id, 
		prf.quantity,
		prf.current_costlevel,
		prf.costlevel_date 
	from product_forms prf
		LEFT OUTER JOIN dbo.quantity_description qud ON prf.qud_id = qud.id 
	where brf_id = @id
	open prf_cursor
		fetch NEXT from prf_cursor into 
			@prf_id, 
			@prf_name, 
			@prf_qud_name, 
			@prf_qud_id, 
			@prf_quantity, 
			@prev_cost, 
			@prev_cost_as
	while @@FETCH_STATUS = 0
	begin
		set @dosage_inc = 1
		if (@prf_qud_id = 1 OR @prf_qud_id = 3) set @dosage_inc = 0
		if (@first_prf = 1)
		begin
			set @prod_forms = @prod_forms + '#'
			set @costs = @costs + '#'
			set @prev_costs = @prev_costs + '#'
			set @prev_cost_ass = @prev_cost_ass + '#'
			if (@dosage_inc = 0) set @dosages = @dosages + '#'  
		end
		if ( @prf_name is null OR @prf_name = '' ) set @prf_name = ''
		-- quantity
		if (@count_prf > 1)
			set @prod_forms = @prod_forms + @prf_name + ':' + @prf_quantity
		else 
			set @prod_forms = @prf_quantity
		-- previous cost level
		if (@count_prf > 1)
			set @prev_costs = @prev_costs + @prf_name + ':' + @prev_cost
		else
			set @prev_costs = @prev_cost
		-- previuos cost level as
		if (@count_prf > 1)
			set @prev_cost_ass = @prev_cost_ass + @prf_name + ':' + @prev_cost_as
		else
			set @prev_cost_ass = @prev_cost_as 
		set @first_prf = 1
		-- costs for product form
		set @cst_index = 1; 
		set @single_costs = ''
		set @single_dosages = ''
		declare @count_cost int
		select @count_cost = count(id) from costs where prf_id = @prf_id
		declare cst_cursor  cursor for
			select value, dosage from costs where prf_id = @prf_id	
		open cst_cursor
			fetch NEXT from cst_cursor into 
				@cost, 
				@dosage
		while @@FETCH_STATUS = 0
		begin
			if (@first_cst = 1) 
			begin 
				set @single_costs = @single_costs + ';'
				if (@dosage_inc = 0) set @single_dosages = @single_dosages +';' 
			end
			if ( @cost is null ) set @cost = 'n.a.'
			if (@dosage_inc = 0)
			begin
				if ( @dosage is null ) set @dosage = 'n.a.'
				if (@count_cost > 1) 
					set @single_dosages = @single_dosages + 'CL' + cast(@cst_index as nvarchar) + '=' + @dosage
				else
					set @single_dosages = @dosage	
			end
			if (@count_cost > 1)
				set @single_costs = @single_costs + 'CL' + cast(@cst_index as nvarchar) + '=' + @cost
			else
				set @single_costs = @cost	
			set @first_cst = 1
			set @cst_index = @cst_index + 1
			fetch NEXT from cst_cursor into @cost, @dosage
		end
		close cst_cursor
		deallocate cst_cursor 
		if (@count_prf > 1)
			set @costs = @costs + @prf_name + ':' + @single_costs
		else
			set @costs = @single_costs	
		if (@dosage_inc = 0) 
			if (@count_prf > 1)
				set @dosages = @dosages + @prf_name + ':' + @single_dosages
			else
				set @dosages = @single_dosages	
		fetch NEXT from prf_cursor into @prf_id, @prf_name, @prf_qud_name, @prf_qud_id, @prf_quantity, @prev_cost, @prev_cost_as		
	end		
	insert into @prod_form (qud_name, qud_id, prod_forms, costs, dosages, prev_costs, prev_cost_ass) values (@prf_qud_name, @prf_qud_id, @prod_forms, @costs, @dosages, @prev_costs, @prev_cost_ass)
	close prf_cursor		
	deallocate prf_cursor
	RETURN 
END


GO
