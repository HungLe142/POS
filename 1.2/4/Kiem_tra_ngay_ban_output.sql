DECLARE @res1 AS BIT;
DECLARE @res2 AS BIT;
DECLARE @res3 AS BIT;
EXEC @res1 = dbo.Kiem_Tra_Ngay_Ban @Ngayban = '2022-02-22'
EXEC @res2 = dbo.Kiem_Tra_Ngay_Ban @Ngayban = '2022-02-23'
EXEC @res3 = dbo.Kiem_Tra_Ngay_Ban @Ngayban = '2022-02-24'
IF @res1 = 0
PRINT 'Ngay ban 1 that bai'
ELSE
PRINT 'Ngay ban 1 thanh cong'
IF @res2 = 0
PRINT 'Ngay ban 2 that bai'
ELSE
PRINT 'Ngay ban 2 thanh cong'
IF @res3 = 0
PRINT 'Ngay ban 3 that bai'
ELSE
PRINT 'Ngay ban 3 thanh cong'