INSERT INTO DonHang
( 
 [ID_don_hang], [SDT_KhachHang], [ID_NhanVien],
 [Trang_thai], [Ghi_chu_trang_thai], [Gio_tao_don],
 [Gio_hoan_thanh], [Ghi_chu_don_hang], [Tong_tien]
)
VALUES
( 'OD100001', '0948315789', 'NV000001',
  'Success', 'Thanh cong','12:00:00',
  NULL,NULL,0)
GO

INSERT INTO DonHang
( 
 [ID_don_hang], [SDT_KhachHang], [ID_NhanVien],
 [Trang_thai], [Ghi_chu_trang_thai], [Gio_tao_don],
 [Gio_hoan_thanh], [Ghi_chu_don_hang], [Tong_tien]
)
VALUES
( 'OD100001', '0948315789', 'NV000001',
  'Pending', 'Cho xu ly','12:00:00',
  NULL,NULL,0)
GO

UPDATE DonHang SET Trang_thai = 'Success', 
               Ghi_chu_trang_thai = 'Thanh cong' 
               WHERE ID_don_hang = 'OD100001'
GO

UPDATE DonHang SET Trang_thai = 'Not_paid', 
               Ghi_chu_trang_thai = 'Da nhan don (chua thanh toan)' 
               WHERE ID_don_hang = 'OD100001'
GO

DELETE FROM DonHang
WHERE ID_don_hang = 'OD100001'
GO