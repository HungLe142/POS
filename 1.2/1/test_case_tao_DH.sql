-- Với tạo đơn hàng tại chỗ
-- @SdtKhachHang, @ID_NV, @SoBan
  -- Sai định dạng SĐT khách
  EXEC TaoDonHangTaiCho 'abc835789', 'NV000001', 3;
  -- Sai định dạng ID nhân viên
  EXEC TaoDonHangTaiCho '0948315789', 'DB000020', 3;
  -- Sai định dạng số bàn
  EXEC TaoDonHangTaiCho '0948315789', 'NV000002', 'abc';
  -- Kh tìm thấy SĐT khách
  EXEC TaoDonHangTaiCho '0123333323', 'NV000003', 3;
  -- Kh tìm thấy ID nhân viên
  EXEC TaoDonHangTaiCho '0948315789', 'NV000020', 3;

  -- Đúng tất cả
  EXEC TaoDonHangTaiCho '0948315789', 'NV000002', 7;

-- Với tạo đơn hàng trực tuyến
-- Sai định dạng và kh tìm thấy nhân viên giống ở trên do copy sang
-- @SdtKhachHang, @ID_NV, @DiaChi, @GiaShip, @ID_CtyShip
  -- Sai định dạng ID_CtyShip
  EXEC TaoDonHangTrucTuyen '0948315789', 'NV000002', '15 Phan Van Han, P.19, Q.Binh Thanh', 43000, 'abcdef';
  -- Không tìm thấy ID_CtyShip
  EXEC TaoDonHangTrucTuyen '0948315789', 'NV000002', '15 Phan Van Han, P.19, Q.Binh Thanh', 43000, '3VC111111';
  -- Đúng tất cả
  EXEC TaoDonHangTrucTuyen '0948315789', 'NV000002', '15 Phan Van Han, P.19, Q.Binh Thanh', 43000, '3VC000001';