ALTER TABLE NhanVien
ADD CONSTRAINT CHK_TrangThai CHECK (Trang_thai IN (N'Tích cực', N'Bình thường', N'Không tích cực', N'Nghỉ làm'));

ALTER TABLE NhanVien
ADD CONSTRAINT CHK_ViTri CHECK (Vi_tri IN (N'Quản lý', N'Thu ngân', N'Bồi bàn', N'Đầu bếp'));

ALTER TABLE MonAn
ADD CONSTRAINT CHK_Loai CHECK (Loai IN (N'Khai vị', N'Món chính', N'Tráng miệng', N'Đồ uống'));

ALTER TABLE DonHang
ADD CONSTRAINT CHK_Trang_thai CHECK (Trang_thai IN (N'Pending', N'Not_paid', N'Paid', N'Success', N'Cancel'));

ALTER TABLE DonHang
ADD CONSTRAINT CHK_Ghi_chu_trang_thai 
    CHECK (Ghi_chu_trang_thai IN 
    (N'Chờ xử lý', N'Đã nhận đơn (chưa thanh toán)', 
    N'Đã thanh toán (chưa hoàn thành món)', 
    N'Thành công', N'Ship quá lâu', N'Món ăn bị hỏng'));
