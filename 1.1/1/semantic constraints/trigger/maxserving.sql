CREATE TRIGGER trg_MATN_MaxServingsPerDish
ON MonAn_TrongNgay
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @ID_mon_an VARCHAR(6);
    DECLARE @Ngay DATE;
    SELECT @ID_mon_an = INSERTED.ID_mon_an, @Ngay = INSERTED.Ngay FROM INSERTED;

    IF (SELECT So_luong_con FROM MonAn_TrongNgay WHERE ID_mon_an = @ID_mon_an AND Ngay = @Ngay) > 70
    BEGIN
        RAISERROR ('Cannot have more than 70 servings per dish.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;
