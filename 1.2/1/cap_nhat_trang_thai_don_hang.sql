CREATE OR ALTER PROCEDURE CapNhatTrangThaiDonHang
	@ID_DH VARCHAR(9),
	@TrangThai VARCHAR(20)
AS
BEGIN
	-- CHECK INPUT
	IF LEN(@ID_DH) < 8
	BEGIN
		RAISERROR('ID don hang phai co do dai tu 8 den 9 ki tu', 16, 1);
		ROLLBACK;
	END;
	IF LEFT(@ID_DH, 2) != 'OD' AND LEFT(@ID_DH, 3) != 'ODS'
	BEGIN
		RAISERROR('Sai dinh dang! Ma don hang phai bat dau la "OD" hoac "ODS"', 16, 1);
		ROLLBACK;
	END;
	IF ISNUMERIC(RIGHT(@ID_DH, 6)) = 0
	BEGIN
		RAISERROR('Sai dinh dang! 6 ky tu cuoi ma don hang phai la so tu 0-9', 16, 1);
		ROLLBACK;
	END;

	IF LOWER(@TrangThai) != 'not_paid' AND LOWER(@TrangThai) != 'paid'
		AND LOWER(@TrangThai) != 'success' AND LOWER(@TrangThai) != 'cancel'
	BEGIN
		RAISERROR('Trang thai chi co the la "Not_paid", "Paid", "Success", "Cancel"', 16, 1);
		ROLLBACK;
	END;

	SET @TrangThai = UPPER(LEFT(@TrangThai, 1)) + LOWER(RIGHT(@TrangThai, LEN(@TrangThai) - 1));
	DECLARE @GioHoanThanh TIME = null;
	DECLARE @GhiChuTrangThai VARCHAR(30);
	IF @TrangThai = 'Pending'
		SET @GhiChuTrangThai = 'Cho xu ly';
	IF @TrangThai = 'Not_paid'
		SET @GhiChuTrangThai = 'Da nhan don (chua thanh toan)';
	IF @TrangThai = 'Paid'
		SET @GhiChuTrangThai = 'Da thanh toan (chua hoan thanh mon)';
	IF @TrangThai = 'Success'
	BEGIN
		SET @GhiChuTrangThai = 'Thanh cong';
		SET @GioHoanThanh = CAST(GETDATE() AS TIME);
	END;

	UPDATE DonHang
	SET Trang_thai = @TrangThai, Gio_hoan_thanh = @GioHoanThanh
	WHERE ID_don_hang = @ID_DH;
END;