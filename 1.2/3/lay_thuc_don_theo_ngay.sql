CREATE OR ALTER PROCEDURE LayThucDonTrongNgay
	@Ngay DATE
AS
BEGIN
	SELECT MA.ID_mon_an, MA.Ten, MA.Loai, TN.So_luong_con, TN.Gia_ban_trong_ngay
	FROM MonAn_TrongNgay AS TN
	JOIN MonAn AS MA ON TN.ID_mon_an = MA.ID_mon_an
	WHERE TN.Ngay = @Ngay
END;