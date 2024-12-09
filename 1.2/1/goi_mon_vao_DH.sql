CREATE OR ALTER PROCEDURE GoiMonVaoDonHang
	@ID_DH VARCHAR(9),
	@TenMon VARCHAR(50),
	@SoLuongDat INT
AS
BEGIN
	DECLARE @Ngay DATE = GETDATE();
	DECLARE @ID_MonAn VARCHAR(4);
	SELECT @ID_MonAn = ID_mon_an
	FROM MonAn
	WHERE Ten = @TenMon

	IF NOT EXISTS (SELECT 1 FROM MonAn WHERE Ten = @TenMon)
	BEGIN
		RAISERROR('Khong tim thay ten thuc an trong thuc don', 16, 1);
		RETURN;
	END;
	
	DECLARE @SoLuongDangCo INT;
	SELECT @SoLuongDangCo = So_luong FROM Quan_ly_mon_an_trong_DonHang
		WHERE @ID_DH = ID_don_hang AND @ID_MonAn = ID_mon_an AND @Ngay = Ngay;
	
	IF @SoLuongDat > @SoLuongDangCo
	BEGIN
		RAISERROR('So luong dat nhieu hon so luong mon an dang co', 16, 1);
		RETURN;
	END;

	UPDATE MonAn_TrongNgay
	SET So_luong_con = So_luong_con - @SoLuongDat
	WHERE ID_mon_an = @ID_MonAn AND Ngay = @Ngay

	-- Neu da dat mon do roi thi update so luong
	IF EXISTS (SELECT 1 FROM Quan_ly_mon_an_trong_DonHang
				WHERE @ID_DH = ID_don_hang AND @ID_MonAn = ID_mon_an AND @Ngay = Ngay)
	BEGIN
		UPDATE Quan_ly_mon_an_trong_DonHang
		SET So_luong = So_luong + @SoLuongDat
		WHERE @ID_DH = ID_don_hang AND @ID_MonAn = ID_mon_an AND @Ngay = Ngay;
		RETURN;
	END;

	-- Neu chua co thi them tuple moi
	INSERT INTO Quan_ly_mon_an_trong_DonHang(ID_don_hang, ID_mon_an, Ngay, So_luong)
	VALUES
	(@ID_DH, @ID_MonAn, @Ngay, @SoLuongDat)
END;