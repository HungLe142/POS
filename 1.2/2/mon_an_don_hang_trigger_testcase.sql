EXEC TaoDonHangTaiCho '0948315789', 'NV000002', 7;





UPDATE DonHang SET Trang_thai = 'Not_paid', 
               Ghi_chu_trang_thai = 'Da nhan don (chua thanh toan)' 
               WHERE ID_don_hang = 'OD000001'
GO

