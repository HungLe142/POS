CREATE OR ALTER FUNCTION Tong_thiet_hai --IN tổng thiệt hại (các phần ăn trong ngày không bán hết)
(@Thang as INT,                         --trong tháng @Thang và năm @Nam
@Nam as INT)
RETURNS DECIMAL(20, 2)
AS
BEGIN
    DECLARE @Thiet_hai AS DECIMAL(20, 2);
    DECLARE @ID_mon AS VARCHAR(6);
    DECLARE @Gia_tien AS DECIMAL(10, 2);
    DECLARE @So_luong AS INT;
    SET @Thiet_hai = 0

    DECLARE Mon_an_trong_thang CURSOR
    FOR
    (SELECT K.ID_mon_an, SUM(So_luong_con), Giagoc AS Tong_so_con
    FROM 
    (SELECT N.ID_mon_an, Ngay, So_luong_con, Giagoc 
    FROM MonAn_TrongNgay AS N JOIN MonAn AS M ON N.ID_mon_an = M.ID_mon_an
    WHERE (MONTH(N.Ngay) = @Thang AND YEAR(N.Ngay) = @Nam)) AS K
    GROUP BY K.ID_mon_an,Giagoc)
    OPEN Mon_an_trong_thang
    FETCH NEXT FROM Mon_an_trong_thang INTO @ID_mon, @So_luong, @Gia_tien
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @Thiet_hai = @Thiet_hai + @So_luong*@Gia_tien
        FETCH NEXT FROM Mon_an_trong_thang INTO @ID_mon, @So_luong, @Gia_tien
    END;
    CLOSE Mon_an_trong_thang
    DEALLOCATE Mon_an_trong_thang
    RETURN @Thiet_hai
END;