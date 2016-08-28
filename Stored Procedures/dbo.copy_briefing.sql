SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[copy_briefing]
	@id int, 
	@briefing_no nvarchar(50),
	@proj_title nvarchar(500),
	@user varchar(100),
	@create_date datetime,
	@variant_no int
AS
BEGIN
	SET NOCOUNT ON;
	declare @insert_brief_id int;
	
	CREATE TABLE #tempad
	(
	old INT,
	new INT
	)
	
    --COPY BRIEFING
	INSERT INTO briefing 
	(
		variant_no,	briefing_no, proj_title, int_ref, delivery_date,
		creation_date, proj_action, document_msds_yn, document_spec_yn, document_lol_yn,
		document_odor_yn, document_fra_disclo_yn, document_fra_comp_yn, document_sh_cert_yn,
		document_mat_list_yn, document_ifra_yn, document_cert_yn, document_wt_loss,
		document_malodor_yn, document_cost_sheet_yn, document_frag_lev_yn, document_gc_analy_yn,
		document_stab_yn, document_saf_eval, document_tosca, dialyn, bus_id, sbu_id, cur_id,
		pro_id,	str_id,	samp_comment, samp_delivery, addional_inf_yn, mark_concept, bench_comp,
		tgt_group, spec_claims, no_eval_level, deadline, comm_deadl, no_prod_form, frag_desc,
		no_price_level, no_subm, no_concepts, no_total_subm, agree_yn, agree_perc, test_stab_crt,
		del_unfr_bulk, comment, brf_id_variant, eval_type_1, eval_type_2, eval_type_3,
		eval_type_4, sta_id, status_since_date, status_changed_by, perfume_no_samples,
		perfume_weight, perfume_adr_id, created_by, approved_frag, lit_id, final_deadline,
		comm_final_deadl, reopen_yn, lgo_id
	)
		SELECT 
			@variant_no, @briefing_no, @proj_title, int_ref, NULL, 
			@create_date, proj_action, document_msds_yn, document_spec_yn, document_lol_yn,
			document_odor_yn, document_fra_disclo_yn, document_fra_comp_yn, document_sh_cert_yn,
			document_mat_list_yn, document_ifra_yn, document_cert_yn, document_wt_loss,
			document_malodor_yn, document_cost_sheet_yn, document_frag_lev_yn, document_gc_analy_yn,
			document_stab_yn, document_saf_eval, document_tosca, dialyn, bus_id, sbu_id, cur_id,
			pro_id, str_id, samp_comment, samp_delivery, addional_inf_yn, mark_concept, bench_comp,
			tgt_group, spec_claims, no_eval_level, NULL, comm_deadl, no_prod_form, frag_desc,
			no_price_level, no_subm, no_concepts, no_total_subm, agree_yn, agree_perc, test_stab_crt,
			del_unfr_bulk, comment, NULL, eval_type_1, eval_type_2, eval_type_3,
			eval_type_4, 1, @create_date, NULL, perfume_no_samples,
			perfume_weight, perfume_adr_id, @user, 0, lit_id, NULL,
			comm_final_deadl, 0, lgo_id
		FROM briefing WHERE id=@id;

	SET @insert_brief_id = (SELECT scope_identity());

	--COPY TEAM MEMBERS AND ADDRESSES
	declare @tea_id int;
	declare @new_tea_id int;
	declare @adr_id int;
	declare @new_adr_id int;
	declare @portal_user int;
	declare @first_name nvarchar(50);
	declare @last_name nvarchar(100);
	declare @company nvarchar(100);
	declare @department nvarchar(100);
	declare @phone nvarchar(50);
	declare @email nvarchar(100);
	declare @rol_id int;
	declare @editable bit;
	declare	@street_no nvarchar(100);
	declare	@zip_code nvarchar(10);
	declare	@city nvarchar(100);
	declare	@lco_id int;
	declare	@adt_id int;

	declare team_cursor cursor for
		select id, portal_user, first_name, last_name, company, department, phone, email, rol_id, editable
		from team_members
		where brf_id = @id

	open team_cursor
	fetch NEXT from team_cursor into 
		@tea_id,
		@portal_user, 
		@first_name, 
		@last_name, 
		@company, 
		@department, 
		@phone, 
		@email, 
		@rol_id, 
		@editable

	while @@FETCH_STATUS = 0
	begin

		INSERT INTO team_members (brf_id, portal_user, first_name, last_name, company, department, phone, email, rol_id, editable)
		VALUES
		(
			@insert_brief_id,
			@portal_user, 
			@first_name, 
			@last_name, 
			@company, 
			@department, 
			@phone, 
			@email, 
			@rol_id, 
			@editable
		);

		SET @new_tea_id = (SELECT scope_identity());

		declare address_cursor cursor for
			select id,street_no, zip_code, city, lco_id, adt_id
			from addresses
			where tea_id = @tea_id

		open address_cursor
		fetch NEXT from address_cursor into
			@adr_id,
			@street_no,
			@zip_code,
			@city,
			@lco_id,
			@adt_id
		
		while @@FETCH_STATUS = 0
		begin
			
			INSERT INTO addresses (street_no, zip_code, city, lco_id, tea_id, adt_id)
			VALUES
			(
				@street_no,
				@zip_code,
				@city,
				@lco_id,
				@new_tea_id,
				@adt_id		
				
			);
			SET @new_adr_id = (SELECT scope_identity());
			
			INSERT INTO #tempad (old,new) VALUES (@adr_id,@new_adr_id);

			fetch NEXT from address_cursor into 
				@adr_id,
				@street_no,
				@zip_code,
				@city,
				@lco_id,
				@adt_id
		end
		close address_cursor
		deallocate address_cursor	

		fetch NEXT from team_cursor into 
			@tea_id,
			@portal_user, 
			@first_name, 
			@last_name, 
			@company, 
			@department, 
			@phone, 
			@email, 
			@rol_id, 
			@editable
	end
	close team_cursor
	deallocate team_cursor

	--COPY BRIEFING SUPPLIER AND CONTACT PERSON
	declare @brs_id int;
    declare @new_brs_id int;
	declare @sup_id int;
	declare @current_supplier_yn bit;
	declare @winner_yn bit;
	declare @actual_assigned_yn bit;
	declare @comment nvarchar(100);

	declare @name nvarchar(200);
	declare @contact_email nvarchar(200);

	declare brfsup_cursor cursor for
		select id, sup_id, current_supplier_yn, winner_yn, actual_assigned_yn, comment
		from briefing_supplier
		where brf_id = @id

	open brfsup_cursor
	fetch NEXT from brfsup_cursor into 
		@brs_id, 
		@sup_id, 
		@current_supplier_yn, 
		@winner_yn, 
		@actual_assigned_yn, 
		@comment
		
	while @@FETCH_STATUS = 0
	begin

		INSERT INTO briefing_supplier (brf_id, sup_id, current_supplier_yn, winner_yn, actual_assigned_yn, comment)
		VALUES
		(
			@insert_brief_id,
			@sup_id, 
			@current_supplier_yn, 
			@winner_yn, 
			@actual_assigned_yn, 
			@comment			
		);

		SET @new_brs_id = (SELECT scope_identity());

		declare contact_cursor cursor for
			select name, email
			from contact_person
			where brs_id = @brs_id

		open contact_cursor
		fetch NEXT from contact_cursor into 
			@name,
			@contact_email
		
		while @@FETCH_STATUS = 0
		begin
			INSERT INTO contact_person (name, email, brs_id)
			VALUES	
			(
				@name,
				@contact_email,
				@new_brs_id
			);

			fetch NEXT from contact_cursor into 
				@name,
				@contact_email
		end
		close contact_cursor
		deallocate contact_cursor	

		fetch NEXT from brfsup_cursor into 
			@brs_id, 
			@sup_id, 
			@current_supplier_yn, 
			@winner_yn, 
			@actual_assigned_yn, 
			@comment
	end
	close brfsup_cursor
	deallocate brfsup_cursor

	--COPY PRODUCT FORMS AND INITIAL COSTS
	declare @prf_id int;
	declare @new_prf_id int;
	declare @forms_name nvarchar(50);
	declare @quantity nvarchar(50);
	declare @qud_id int;
	declare @current_costlevel nvarchar(50);
	declare @cost_level nvarchar(5);
	declare @costlevel_date nvarchar(20);
	declare @forms_comment nvarchar(200);
	declare @unt_id int;
	declare @weight nvarchar(30);
	declare @no_samples int;

	declare forms_cursor cursor for
		select id, name, quantity, qud_id, current_costlevel, costlevel_date, comment, unt_id, weight, no_samples, adr_id
		from product_forms
		where brf_id = @id

	open forms_cursor
	fetch NEXT from forms_cursor into 
		@prf_id,
		@forms_name,
		@quantity,
		@qud_id,
		@current_costlevel,
		@costlevel_date,
		@forms_comment,
		@unt_id,
		@weight,
		@no_samples,
		@adr_id
		
	while @@FETCH_STATUS = 0
	begin
		
		select @new_adr_id = new from #tempad where old = @adr_id

		INSERT INTO product_forms (brf_id, name, quantity, qud_id, current_costlevel, costlevel_date, comment, unt_id, weight, no_samples, adr_id)
		VALUES
		(
			@insert_brief_id,
			@forms_name,
			@quantity,
			@qud_id,
			@current_costlevel,
			@costlevel_date,
			@forms_comment,
			@unt_id,
			@weight,
			@no_samples,
			@new_adr_id
		);

		SET @new_prf_id = (SELECT scope_identity());

		declare cost_cursor cursor for
			select cost_level
			from costs
			where prf_id = @prf_id

		open cost_cursor
		fetch NEXT from cost_cursor into 
			@cost_level
		
		while @@FETCH_STATUS = 0
		begin
			INSERT INTO costs (value, cost_level, dosage, prf_id)
			VALUES	
			(
				0,
				@cost_level,
				NULL,
				@new_prf_id
			);

			fetch NEXT from cost_cursor into 
				@cost_level

		end
		close cost_cursor
		deallocate cost_cursor			

		fetch NEXT from forms_cursor into 
			@prf_id,
			@forms_name,
			@quantity,
			@qud_id,
			@current_costlevel,
			@costlevel_date,
			@forms_comment,
			@unt_id,
			@weight,
			@no_samples,
			@adr_id
	end
	close forms_cursor
	deallocate forms_cursor
	
	--COPY ATTACHMENTS
	INSERT INTO attachments(filename, data, brf_id, off_id, att_type)
	SELECT filename, data, @insert_brief_id, off_id, att_type FROM attachments WHERE brf_id = @id;

	--COPY TECH DOCS
	INSERT INTO tech_docs(title, data, date, brf_id)
	SELECT title, data, date, @insert_brief_id FROM tech_docs WHERE brf_id = @id;

	RETURN @insert_brief_id
	
END

GO
