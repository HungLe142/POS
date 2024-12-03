CREATE TRIGGER trg_NhanVien_Insert
ON NhanVien
INSTEAD OF INSERT
AS
BEGIN
    -- Tạo dữ liệu trong bảng Ben_Nhan trước
    INSERT INTO Ben_Nhan (ID_ben_nhan)
    SELECT 
        i.ID_buttoan
    FROM inserted i;
    
    -- Thêm dữ liệu vào bảng NhanVien
    INSERT INTO NhanVien (ID_NhanVien, Ten, SDT_Nhanvien, Trang_thai, Vi_tri, He_so_luong, Bang_cap, Ngay_bat_dau, ID_buttoan)
    SELECT 
        i.ID_NhanVien, i.Ten, i.SDT_Nhanvien, i.Trang_thai, i.Vi_tri, i.He_so_luong, i.Bang_cap, i.Ngay_bat_dau, i.ID_buttoan
    FROM inserted i;
END;
