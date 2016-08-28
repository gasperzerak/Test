SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create view [powerpivot].[BriefingDistinct]
as
select distinct id from dbo.briefing;
GO
