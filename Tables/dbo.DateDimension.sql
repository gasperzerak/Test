CREATE TABLE [dbo].[DateDimension]
(
[DateKey] [int] NOT NULL,
[Date] [date] NOT NULL,
[DateTime] [datetime] NOT NULL,
[DateTimeNextDay] [datetime] NOT NULL,
[Day] [tinyint] NOT NULL,
[DaySuffix] [char] (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Weekday] [tinyint] NOT NULL,
[WeekDayName] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsWeekend] [bit] NOT NULL,
[IsHoliday] [bit] NOT NULL,
[HolidayText] [varchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS SPARSE NULL,
[DOWInMonth] [tinyint] NOT NULL,
[DayOfYear] [smallint] NOT NULL,
[WeekOfMonth] [tinyint] NOT NULL,
[WeekOfYear] [tinyint] NOT NULL,
[ISOWeekOfYear] [tinyint] NOT NULL,
[Month] [tinyint] NOT NULL,
[MonthName] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Quarter] [tinyint] NOT NULL,
[QuarterName] [varchar] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Year] [int] NOT NULL,
[MMYYYY] [char] (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MonthYear] [char] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FirstDayOfMonth] [date] NOT NULL,
[LastDayOfMonth] [date] NOT NULL,
[FirstDayOfQuarter] [date] NOT NULL,
[LastDayOfQuarter] [date] NOT NULL,
[FirstDayOfYear] [date] NOT NULL,
[LastDayOfYear] [date] NOT NULL,
[FirstDayOfNextMonth] [date] NOT NULL,
[FirstDayOfNextYear] [date] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DateDimension] ADD CONSTRAINT [PK__DateDime__40DF45E3DAE4C4B8] PRIMARY KEY CLUSTERED  ([DateKey]) ON [PRIMARY]
GO
