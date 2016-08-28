SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
Create function [dbo].[MDate](@Year int, @Month int, @Day int)

  returns datetime

AS

  BEGIN

  declare @d datetime;

  set @d = dateadd(year,(@Year - 1753),'1/1/1753');

  set @d = dateadd(month,@Month - 1,@d);

  return dateadd(day,@Day - 1,@d)

END
GO
