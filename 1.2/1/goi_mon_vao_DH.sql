CREATE OR ALTER PROCEDURE GoiMonVaoDonHang
	@ID_DH VARCHAR(9),
	@TenMon VARCHAR(50),
	@SoLuong INT
AS
BEGIN
	DECLARE @Ngay DATE = GETDATE();
	DECLARE @ID_MonAn VARCHAR(4);
	SELECT @ID_MonAn = ID_mon_an
	FROM MonAn
	WHERE Ten = @TenMon

	-- Neu da co thi update so luong
	IF EXISTS (SELECT 1 FROM Quan_ly_mon_an_trong_DonHang
				WHERE @ID_DH = ID_don_hang AND @ID_MonAn = ID_mon_an AND @Ngay = Ngay)
	BEGIN
		UPDATE Quan_ly_mon_an_trong_DonHang
		SET So_luong = So_luong + @SoLuong
		WHERE @ID_DH = ID_don_hang AND @ID_MonAn = ID_mon_an AND @Ngay = Ngay;
		RETURN;
	END;

	-- Neu chua co thi them tuple moi
	INSERT INTO Quan_ly_mon_an_trong_DonHang(ID_don_hang, ID_mon_an, Ngay, So_luong)
	VALUES
	(@ID_DH, @ID_MonAn, @Ngay, @SoLuong)
END;