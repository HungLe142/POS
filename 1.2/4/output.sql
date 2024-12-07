DECLARE @res1 AS BIT;
EXEC @res1 = dbo.Kiem_Tra_Ngay_Ban @Ngayban = '2022-02-22'
-- EXEC dbo.Kiem_Tra_Ngay_Ban('2022-23-02')
-- EXEC dbo.Kiem_Tra_Ngay_Ban('2022-24-02')
IF @res1 = 0
PRINT 'Ngay ban that bai'
ELSE
PRINT 'Ngay ban thanh cong'