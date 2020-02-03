select 'script is' = '020_<srv>_f_<fn>', 'The time is :' = getdate(), 'on server' = @@servername
go

Use <db>
go

-- before change row counts
print 'Before image'
if exists (select * from sysobjects where id = object_id(N'[dbo].[<fn>]') and OBJECTPROPERTY(id, N'IsScalarFunction') in (0, 1))
begin
	print '	exec sp_helptext <fn>'
	exec sp_helptext '<fn>'
end
else
	print '	<fn> does not exist'
GO

set XACT_ABORT ON
;
-- for testing,
-- comment out for production migration
begin tran
go

print 'Update Begin'
go

if exists (select * from sysobjects where id = object_id(N'[dbo].[<fn>]') and OBJECTPROPERTY(id, N'IsScalarFunction') in (0, 1))
begin
	print '	Dropping <fn>'
	drop function if exists [dbo].[<fn>]
end
GO

print '	Creating <fn>'
go

SET QUOTED_IDENTIFIER  OFF    SET ANSI_NULLS  ON 
GO

CREATE FUNCTION [dbo].[<fn>] (
	<params>
)
RETURNS int
AS
/*
** Purpose:
**
** Parameters:
**
** Return:	
**
** Usage:	
**
** Note:	
**
** Revision History:
**	Date:	
**	Author:	
**	Purpose: 
*/
BEGIN
	<body>
END
go

SET QUOTED_IDENTIFIER  OFF    SET ANSI_NULLS  ON 
GO

GRANT  EXECUTE  ON [dbo].[<fn>] TO [public]
GO

print 'Update Done'

-- after change row counts
print 'After image'
print '	exec sp_helptext <fn>'
exec sp_helptext '<fn>'
go

-- for testing,
-- comment out for production migration
--rollback tran
commit
go

select 'script is' = '020_<srv>_f_<fn>', 'The time is :' = getdate(), 'on server' = @@servername
go
