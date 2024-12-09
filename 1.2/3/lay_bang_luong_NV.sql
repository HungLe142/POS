CREATE OR ALTER PROCEDURE LayBangLuongNV
	@Thang INT,
	@Nam INT
AS
BEGIN
	DECLARE @Date VARCHAR(8) = CAST(@Thang AS VARCHAR) + '-' + CAST(@Nam AS VARCHAR);

	WITH LuongDuKien AS (
		SELECT NV.ID_NhanVien, NV.Ten,
			SUM(DATEDIFF(minute, QL.GioVaoLam, QL.GioRaVe)) / 60 * NV.He_so_luong * 1000 AS TongLuongDuKien
		FROM NhanVien AS NV
		JOIN QuanLyCaLam AS QL ON NV.ID_NhanVien = QL.ID_NhanVien
		JOIN CaLam AS CL ON CL.ID_calam = QL.ID_calam
		WHERE MONTH(CL.Ngay) = @Thang AND YEAR(CL.Ngay) = @Nam
		GROUP BY NV.ID_NhanVien, NV.Ten, NV.He_so_luong
	),
	TienPhat AS (
		SELECT ID_NhanVien, SUM(Tien_phat) AS TongTienPhat
		FROM Vi_pham
		GROUP BY ID_NhanVien
	)
	SELECT LDK.ID_NhanVien, LDK.Ten, @Date AS Thang, LDK.TongLuongDuKien, TP.TongTienPhat,
		LDK.TongLuongDuKien - TP.TongTienPhat AS TongLuongChinhThuc
	FROM LuongDuKien AS LDK
	JOIN TienPhat AS TP ON LDK.ID_NhanVien = TP.ID_NhanVien
END;