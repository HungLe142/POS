--Bước 1 : Nhập đơn hàng vào ở trạng thái Pending
INSERT INTO DonHang
( 
 [ID_don_hang], [SDT_KhachHang], [ID_NhanVien],
 [Trang_thai], [Ghi_chu_trang_thai], [Gio_tao_don],
 [Gio_hoan_thanh], [Ghi_chu_don_hang], [Tong_tien]
)
VALUES
( 'OD102201', '0948315789', 'NV000001',
  'Pending', 'Cho xu ly','12:00:00',
  NULL,NULL,0)

SELECT * FROM DonHang WHERE ID_don_hang = 'OD102201'

GO


--Bước 2 : gọi thêm món khi còn ở trạng thái Pending
INSERT INTO MonAn_TrongNgay
( 
 [ID_mon_an], [Ngay], [So_luong_con], [Giam_gia], [Gia_ban_trong_ngay]
)
VALUES
/**/
( 
 'MA01', '2020-10-10', 30, 0, 60000
),
( 
 'MA02', '2020-10-10', 30, 0, 60000
)

INSERT INTO Quan_ly_mon_an_trong_DonHang --Thêm món ăn khi trạng thái là Pending -> hợp lệ
(
    [ID_don_hang], [ID_mon_an], [Ngay], [So_luong]
)
VALUES
(
    'OD102201','MA02', '2020-10-10', 10
)

SELECT * FROM DonHang WHERE ID_don_hang = 'OD102201'

GO


--Bước 3 : Chỉnh thành Not_paid sau đó thử gọi thêm món

UPDATE DonHang SET Trang_thai = 'Not_paid', 
               Ghi_chu_trang_thai = 'Da nhan don (chua thanh toan)' 
               WHERE ID_don_hang = 'OD102201'
GO

INSERT INTO Quan_ly_mon_an_trong_DonHang --Thêm món ăn khi trạng thái là Not_paid -> không hợp lệ
(
    [ID_don_hang], [ID_mon_an], [Ngay], [So_luong]
)
VALUES
(
    'OD102201','MA01', '2020-10-10', 10
)
GO
SELECT * FROM DonHang WHERE ID_don_hang = 'OD102201'

GO

--Bước 4 : hoàn thành đơn
UPDATE DonHang SET Trang_thai = 'Success', 
               Ghi_chu_trang_thai = 'Thanh cong' 
               WHERE ID_don_hang = 'OD102201'
GO

GO
DROP TRIGGER trg_MonAn_DonHang_check
DELETE FROM Quan_ly_mon_an_trong_DonHang WHERE ID_don_hang = 'OD102201'
DELETE FROM MonAn_TrongNgay WHERE Ngay = '2020-10-10'

DELETE FROM DonHang
WHERE ID_don_hang = 'OD102201'
GO


