DECLARE @res1 AS BIT;
-- EXEC @res1 = dbo.Kiem_Tra_Ngay_Ban @Ngayban = '2022-02-22'
-- EXEC @res1 = dbo.Kiem_Tra_Ngay_Ban @Ngayban = '2022-02-23'
EXEC @res1 = dbo.Kiem_Tra_Ngay_Ban @Ngayban = '2022-02-24'
IF @res1 = 0
PRINT 'Ngay ban that bai'
ELSE
PRINT 'Ngay ban thanh cong'