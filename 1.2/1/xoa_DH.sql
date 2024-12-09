CREATE OR ALTER PROCEDURE XoaDonHang
	@ID_DH VARCHAR(9)
AS
BEGIN
	IF LEN(@ID_DH) < 8
		RAISERROR('ID don hang phai it nhat 8 ky tu', 16, 1);
	IF LEFT(@ID_DH, 2) != 'OD' AND LEFT(@ID_DH, 3) != 'ODS'
		RAISERROR('Sai dinh dang! ID don hang phai bat dau la "OD" hoac "ODS"', 16, 1);
	IF ISNUMERIC(RIGHT(@ID_DH, 6)) = 0
		RAISERROR('Sai dinh dang! ID don hang 6 ky tu cuoi phai la ma so tu 0-9', 16, 1);
	IF NOT EXISTS (SELECT 1 FROM DonHang WHERE ID_don_hang = @ID_DH)
		RAISERROR('Khong tim thay ID don hang trong Database', 16, 1);

	DELETE FROM DonHang
	WHERE ID_don_hang = @ID_DH;
END;