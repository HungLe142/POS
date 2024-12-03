ALTER TABLE KhachHang
ADD CONSTRAINT CHK_KH_Loai CHECK (Loai_KH IN ('Thong thuong', 'Than thiet'));

ALTER TABLE NhanVien
ADD CONSTRAINT CHK_TrangThai CHECK (Trang_thai IN ('Tich cuc', 'Binh thuong', 'Khong tich cuc', 'Nghi lam'));

ALTER TABLE NhanVien
ADD CONSTRAINT CHK_ViTri CHECK (Vi_tri IN ('Quan ly', 'Thu ngan', 'Boi ban', 'Dau bep'));

ALTER TABLE MonAn
ADD CONSTRAINT CHK_Loai CHECK (Loai IN ('Khai vi', 'Mon chinh', 'Trang mieng', 'Do uong'))
ALTER TABLE DonHang
ADD CONSTRAINT CHK_Trang_thai CHECK (Trang_thai IN (N'Pending', N'Not_paid', N'Paid', N'Success', N'Cancel'));

ALTER TABLE DonHang
ADD CONSTRAINT CHK_Ghi_chu_trang_thai 
    CHECK (Ghi_chu_trang_thai IN 
    ('Cho xu ly', 'Da nhan don (chua thanh toan)', 
    'Da thanh toan (chua hoan thanh mon)', 
    'Thanh cong', 'Ship qua lau', 'Mon an bi hong'));
