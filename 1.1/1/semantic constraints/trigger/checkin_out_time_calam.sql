CREATE TRIGGER trg_QuanLyCaLam_CheckTime
ON QuanLyCaLam
INSTEAD OF INSERT, UPDATE
AS
BEGIN
    -- Kiểm tra ràng buộc thời gian vào làm và ra về
    IF EXISTS (
        SELECT 1
        FROM inserted i
        JOIN CaLam c ON i.ID_calam = c.ID_calam
        WHERE (i.GioVaoLam IS NOT NULL AND i.GioVaoLam < c.GioBatDau)
          OR (i.GioRaVe IS NOT NULL AND i.GioRaVe > c.GioKetThuc)
    )
    BEGIN
        RAISERROR ('Thời gian vào làm hoặc ra về của nhân viên phải nằm trong khoảng thời gian của ca làm.', 16, 1);
        ROLLBACK;
        RETURN;
    END

    -- Thêm hoặc cập nhật dữ liệu vào bảng QuanLyCaLam
    INSERT INTO QuanLyCaLam (ID_calam, ID_NhanVien, GioVaoLam, GioRaVe)
    SELECT ID_calam, ID_NhanVien, GioVaoLam, GioRaVe
    FROM inserted;
END;
