SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create view [powerpivot].[Date]
as
select [DateKey], 
	   [DateTime], 
	   DateTimeNextDay, 
	   [Year],
	   [Quarter],
	   QuarterName as 'Quarter Name',
	   [Month],
	   [MonthName] as 'Month Name',
	   ISOWeekOfYear as 'Week Of Year',
	   [Day],
	   [WeekDay],
	   WeekDayName,
	   [Date]
from dbo.DateDimension;
GO
