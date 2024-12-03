CREATE TRIGGER trg_MATN_MaxDishesPerDay
ON MonAn_TrongNgay
AFTER INSERT, UPDATE
AS
BEGIN
    DECLARE @Ngay DATE;
    SELECT @Ngay = INSERTED.Ngay FROM INSERTED;

    IF (SELECT COUNT(*) FROM MonAn_TrongNgay WHERE Ngay = @Ngay) > 30
    BEGIN
        RAISERROR ('Cannot have more than 30 dishes per day.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;


