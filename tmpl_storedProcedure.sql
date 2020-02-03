select 'script is' = '150_<srv>_p_<sproc>', 'The time is :' = getdate(), 'on server' = @@servername
go

Use <db>
go

-- before change row counts
print 'Before image'
if exists (select * from sysobjects where id = object_id(N'[dbo].[<sproc>]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
begin
	print '	exec sp_helptext <sproc>'
	exec sp_helptext 'dbo.<sproc>'
end
else
	print '	<sproc> does not exist'
GO

set XACT_ABORT ON
;
-- for testing,
-- comment out for production migration
begin tran
go

print 'Update Begin'
go

if exists (select * from sysobjects where id = object_id(N'[dbo].[<sproc>]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
begin
	print '	Dropping <sproc>'
	drop procedure if exists [dbo].[<sproc>]
end
GO

print '	Creating <sproc>'
go

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[<sproc>]
	<params>
AS
BEGIN
	<body>
END
GO

print 'Update Done'

-- after change row counts
print 'After image'
print '	exec sp_helptext <sproc>'
exec sp_helptext 'dbo.<sproc>'
go

-- for testing,
-- comment out for production migration
--rollback tran
commit
go

select 'script is' = '150_<srv>_p_<sproc>', 'The time is :' = getdate(), 'on server' = @@servername
go
