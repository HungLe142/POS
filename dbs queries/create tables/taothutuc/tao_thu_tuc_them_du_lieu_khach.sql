-- Hàm thêm dữ liệu mẫu cho bảng KhachHang
CREATE PROCEDURE ThemDuLieuMauChoKhachHang
AS
BEGIN
    -- Thêm dữ liệu mẫu
    INSERT INTO KhachHang (ID_KhachHang, SDT_KhachHang, Ten)
    VALUES 
        (1, '0909123456', N'Nguyen Van A'),
        (2, '0911123456', N'Tran Thi B'),
        (3, '0922123456', N'Le Van C'),
        (4, '0933123456', N'Pham Thi D'),
        (5, '0944123456', N'Hoang Van E');
    
    -- In thông báo thành công
    PRINT 'Đã thêm dữ liệu mẫu thành công vào bảng KhachHang';
END;
GO
