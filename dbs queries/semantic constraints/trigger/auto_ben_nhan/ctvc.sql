CREATE TRIGGER trg_CTVC_bn_Insert
ON CongTyVanChuyen
INSTEAD OF INSERT
AS
BEGIN
    -- Tạo dữ liệu trong bảng Ben_Nhan trước
    INSERT INTO Ben_Nhan (ID_ben_nhan)
    SELECT 
        i.ID_buttoan
    FROM inserted i;
    
    -- Thêm dữ liệu vào bảng CongTyThucPham
    INSERT INTO CongTyVanChuyen (ID_congty, Ten, SDT, Email, ID_buttoan)
    SELECT 
        i.ID_congty, i.Ten, i.SDT, i.Email, i.ID_buttoan
    FROM inserted i;
END;
