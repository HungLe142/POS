SELECT ID_NhanVien, SDT_KhachHang
FROM KhachHang JOIN NhanVien ON ID_KhachHang != ID_NhanVien
WHERE Vi_tri = 'Thu ngan'