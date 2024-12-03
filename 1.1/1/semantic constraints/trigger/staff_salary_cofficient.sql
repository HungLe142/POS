CREATE TRIGGER trg_NV_UpdateHeSoLuong
ON NhanVien
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE NhanVien
    SET He_so_luong = CASE 
                        WHEN inserted.Vi_tri = 'Quan ly' THEN 150.00
                        WHEN inserted.Vi_tri = 'Dau bep' THEN 100.00
                        WHEN inserted.Vi_tri = 'Thu ngan' THEN 30.00
                        WHEN inserted.Vi_tri = 'Boi ban' THEN 25.00
                      END
    FROM NhanVien
    INNER JOIN inserted 
    ON NhanVien.ID_NhanVien = inserted.ID_NhanVien;
END;
