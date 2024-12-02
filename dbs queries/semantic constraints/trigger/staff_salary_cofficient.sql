CREATE TRIGGER trg_NV_UpdateHeSoLuong
ON NhanVien
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE NhanVien
    SET He_so_luong = CASE 
                        WHEN inserted.Vi_tri = N'Quản lý' THEN 150.00
                        WHEN inserted.Vi_tri = N'Đầu bếp' THEN 100.00
                        WHEN inserted.Vi_tri = N'Thu ngân' THEN 30.00
                        WHEN inserted.Vi_tri = N'Bồi bàn' THEN 25.00
                      END
    FROM NhanVien
    INNER JOIN inserted 
    ON NhanVien.ID_NhanVien = inserted.ID_NhanVien;
END;
