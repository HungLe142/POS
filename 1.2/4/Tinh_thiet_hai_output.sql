DECLARE @result AS DECIMAL (20,2)

EXEC @result = dbo.Tong_thiet_hai @Thang = 2, @Nam = 2022

PRINT 'Thiet hai thang nay la :'
PRINT @result