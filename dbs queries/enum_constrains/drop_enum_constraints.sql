-- Xóa các ràng buộc từ bảng NhanVien
ALTER TABLE NhanVien
DROP CONSTRAINT CHK_TrangThai;

ALTER TABLE NhanVien
DROP CONSTRAINT CHK_ViTri;

-- Xóa các ràng buộc từ bảng MonAn
ALTER TABLE MonAn
DROP CONSTRAINT CHK_Loai;

-- Xóa các ràng buộc từ bảng DonHang
ALTER TABLE DonHang
DROP CONSTRAINT CHK_Trang_thai;

ALTER TABLE DonHang
DROP CONSTRAINT CHK_Ghi_chu_trang_thai;
