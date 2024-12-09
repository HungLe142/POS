CREATE OR ALTER PROCEDURE CapNhatTrangThaiDonHang
	@ID_DH VARCHAR(9),
	@LyDoCancel VARCHAR(20)
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

	IF LOWER(@LyDoCancel) != 'Mon an bi hong' AND LOWER(@LyDoCancel) != 'Ship qua lau'
	BEGIN
		RAISERROR('Ly do cancel chi co the do "Mon bi hu" hoac "Ship qua lau"', 16, 1);
		ROLLBACK;
	END;

	UPDATE DonHang
	SET Trang_thai = 'Cancel', Ghi_chu_trang_thai = @LyDoCancel, Gio_hoan_thanh = CAST(GETDATE() AS TIME)
	WHERE ID_don_hang = @ID_DH;
END;