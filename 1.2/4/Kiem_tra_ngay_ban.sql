CREATE OR ALTER FUNCTION Kiem_Tra_Ngay_Ban --Kiểm tra ngày bán đạt yêu cầu chưa
(@Ngayban AS DATE)                           --YÊU CẦU : Không món ăn nào trong ngày có số lượng còn >5
RETURNS BIT                               --          Và tổng số lượng còn không vượt quá 20
AS
BEGIN
    DECLARE @Check_result AS BIT;
    DECLARE @Mot_mon AS INT;
    SET @Mot_mon = 5;
    IF EXISTS(SELECT 1 FROM MonAn_TrongNgay WHERE Ngay = @Ngayban)
    BEGIN
        IF(@Mot_mon < ANY (SELECT So_luong_con FROM MonAn_TrongNgay WHERE Ngay = @Ngayban))
            SET @Check_result = 0;
        ELSE
            BEGIN
                DECLARE @Tat_ca_mon AS INT
                SET @Tat_ca_mon = (SELECT So_luong_tong_con FROM 
                (SELECT Ngay, SUM(So_luong_con) AS So_luong_tong_con FROM 
                (SELECT Ngay, So_luong_con FROM MonAn_TrongNgay WHERE Ngay = @Ngayban) AS T
                GROUP BY T.Ngay) AS K)
                IF(@Tat_ca_mon >20) 
                SET @Check_result = 0;
                ELSE 
                SET @Check_result = 1;
            END;
    END;
    ELSE
    BEGIN
        SET @Check_result = 0;
    END;
    RETURN @Check_result
END;




