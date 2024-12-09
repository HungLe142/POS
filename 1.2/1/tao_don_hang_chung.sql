-- Cái này kh có xài nha tui nháp th

CREATE OR ALTER PROCEDURE TaoDonHang
	@SdtKhachHang VARCHAR(10),
	@ID_NV VARCHAR(8),
	@LoaiDH VARCHAR(10)
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

	-- Check LoaiDH, bao gom 'tai cho' va 'truc tuyen'
	SET @LoaiDH = LOWER(@LoaiDH)
	IF @LoaiDH != 'tai cho' AND @LoaiDH != 'truc tuyen'
		RAISERROR('Loai don hang chi co 2 gia tri "tai cho" va "truc tuyen"', 16, 1)

	-- Bat dau xu ly dieu kien ban dau
	DECLARE @ID_DH VARCHAR(9)
	DECLARE @NextID INT = 0
	IF @LoaiDH = 'tai cho'
	BEGIN
		SELECT TOP 1 @ID_DH = ID_don_hang
		FROM DonHang_Taicho
		ORDER BY ID_don_hang DESC;
		SET @NextID = CAST(RIGHT(@ID_DH, 6) AS INT) + 1;
		SET @ID_DH = 'OD' + CAST(@NextID AS VARCHAR);
	END;
	ELSE
	BEGIN
		SELECT TOP 1 @ID_DH = ID_don_hang
		FROM DonHang_Tructuyen
		ORDER BY ID_don_hang DESC;
		SET @NextID = CAST(RIGHT(@ID_DH, 6) AS INT) + 1;
		SET @ID_DH = 'ODS' + CAST(@NextID AS VARCHAR);
	END;

	DECLARE @TrangThai VARCHAR(10) = 'Pending';
	DECLARE @GhiChuTT VARCHAR(10) = 'Cho xu ly';
	DECLARE @HourOffset INT = 7 -- Mui gio GMT+7 minh som hon 7 tieng
	DECLARE @GioTaoDon TIME = DATEADD(hour, @HourOffset, CAST(GETDATE() AS TIME));
	DECLARE @GioHoanThanh TIME = null;
	DECLARE @GhiChuDonHang VARCHAR(10) = '';
	DECLARE @TongTien INT = 0;

	-- Them vao bang
	INSERT INTO DonHang(ID_don_hang, SDT_KhachHang, ID_NhanVien, Trang_thai, Ghi_chu_trang_thai, Gio_tao_don, Gio_hoan_thanh, Ghi_chu_don_hang, Tong_tien)
	VALUES
	(@ID_DH, @SdtKhachHang, @ID_NV, @TrangThai, @GhiChuTT, @GioTaoDon, @GioHoanThanh, @GhiChuDonHang, @TongTien);
END;