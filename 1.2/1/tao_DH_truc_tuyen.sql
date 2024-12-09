CREATE OR ALTER PROCEDURE TaoDonHangTrucTuyen
	@SdtKhachHang VARCHAR(10),
	@ID_NV VARCHAR(8),
	@DiaChiShip VARCHAR(100),
	@GiaShip INT,
	@ID_CongTy VARCHAR(9)
AS
BEGIN
	-- Check dieu kien SDT
	IF ISNUMERIC(@SdtKhachHang) = 0
		RAISERROR('SDT phai la mot day so', 16, 1)
	IF LEFT(@SdtKhachHang, 1) != '0'
		RAISERROR('SDT phai co so dau tien la "0"', 16, 1)
	IF LEN(@SdtKhachHang) != 10
		RAISERROR('SDT phai bao gom 10 chu so', 16, 1)

	-- Check dieu kien ID NV
	IF LEN(@ID_NV) != 8
		RAISERROR('ID nhan vien phai bao gom 8 ky tu', 16, 1);
	IF LEFT(@ID_NV, 2) != 'NV'
		RAISERROR('ID nhan vien 2 ky tu dau phai la "NV"', 16, 1);
	IF ISNUMERIC(RIGHT(@ID_NV, 6)) = 0
		RAISERROR('ID nhan vien 6 ky tu cuoi phai la ma so tu 0-9', 16, 1);
	IF NOT EXISTS (SELECT 1 FROM NhanVien WHERE ID_NhanVien = @ID_NV)
		RAISERROR('Khong tim thay ID nhan vien trong Database', 16, 1);

	-- Check ID cong ty van chuyen
	IF LEN(@ID_CongTy) != 9
		RAISERROR('ID cong ty van chuyen phai bao gom 9 ky tu', 16, 1);
	IF LEFT(@ID_CongTy, 3) != '3VC'
		RAISERROR('Sai dinh dang! 3 ky tu dau cua ID phai la 3VC', 16, 1);
	IF ISNUMERIC(RIGHT(@ID_CongTy, 6)) = 0
		RAISERROR('Sai dinh dang! 6 ky tu sau cua ID phai la so', 16, 1);
	IF NOT EXISTS (SELECT 1 FROM CongTyVanChuyen WHERE ID_congty = @ID_CongTy)
		RAISERROR('Khong tim thay ID cong ty van chuyen trong Database', 16, 1);

	-- Bat dau xu ly dieu kien ban dau
	DECLARE @ID_DH VARCHAR(9)
	DECLARE @NextID INT = 0
	IF NOT EXISTS (SELECT 1 FROM DonHang_Tructuyen)
		SET @ID_DH = 'ODS000001'
	ELSE
	BEGIN
		SELECT TOP 1 @ID_DH = ID_don_hang
		FROM DonHang_Tructuyen
		ORDER BY ID_don_hang DESC;
		SET @NextID = CAST(RIGHT(@ID_DH, 6) AS INT) + 1;
		SET @ID_DH = 'ODS' + RIGHT('000000' + CAST(@NextID AS VARCHAR), 6);
	END;
		
	DECLARE @TrangThai VARCHAR(10) = 'Pending';
	DECLARE @GhiChuTT VARCHAR(10) = 'Cho xu ly';
	DECLARE @HourOffset INT = 7 -- Mui gio GMT+7 minh som hon 7 tieng
	DECLARE @GioTaoDon TIME = DATEADD(hour, @HourOffset, CAST(GETDATE() AS TIME));
	DECLARE @GioHoanThanh TIME = null;
	DECLARE @GhiChuDonHang VARCHAR(10) = '';
	DECLARE @TongTien INT = 0;

	-- Them vao bang DonHang chinh
	INSERT INTO DonHang(ID_don_hang, SDT_KhachHang, ID_NhanVien, Trang_thai, Ghi_chu_trang_thai, Gio_tao_don, Gio_hoan_thanh, Ghi_chu_don_hang, Tong_tien)
	VALUES
	(@ID_DH, @SdtKhachHang, @ID_NV, @TrangThai, @GhiChuTT, @GioTaoDon, @GioHoanThanh, @GhiChuDonHang, @TongTien);
	-- Them vao bang DonHang_Tructuyen
	INSERT INTO DonHang_Tructuyen(ID_don_hang, Gia_ship, Dia_chi_ship, ID_congty)
	VALUES
	(@ID_DH, @GiaShip, @DiaChiShip, @ID_CongTy)
END;