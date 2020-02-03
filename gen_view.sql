USE <db>
GO

select replace('CREATE VIEW [dbo].[vw_&tbl&] AS select * from [dbo].[&tbl&]
GO
GRANT SELECT ON [dbo].[vw_&tbl&] to [rl_Report_Writer]
GO
'
	,'&tbl&',[name])
from [dbo].[sysobjects]
where 1=1
and [xtype] = 'U'
and [name] not in (
'Key_Store'
)
order by [name]
