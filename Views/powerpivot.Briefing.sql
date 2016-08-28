SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create view [powerpivot].[Briefing]
as
select id, 
	   variant_no,
	   briefing_no,
	   proj_title,
	   delivery_date,
	   creation_date,
	   deadline,
	   no_price_level,
	   no_subm,
	   no_concepts,
	   no_total_subm,
	   eval_type_1,
	   eval_type_2,
	   eval_type_3,
	   eval_type_4,
	   sta_id,
	   approved_frag,
	   lit_id,
	   final_deadline,
	   lgo_id,
	   fragrance_names
 from dbo.briefing;
GO
