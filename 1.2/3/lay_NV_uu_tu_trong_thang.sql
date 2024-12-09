CREATE OR ALTER PROCEDURE LayNhanVienUuTuTrongThang
	@Thang INT,
	@Nam INT
AS
BEGIN
	IF @Thang > 12 OR @Thang < 0
	BEGIN
		RAISERROR('Thang nhap vao khong hop le', 16, 1)
		RETURN
	END;
	IF @Nam < 0
	BEGIN
		RAISERROR('Nam nhap vao khong hop le', 16, 1)
		RETURN
	END;

	SELECT NV.ID_NhanVien, NV.Ten, SUM(DATEDIFF(minute, QL.GioVaoLam, QL.GioRaVe)) / 60 AS SoGioLam
	FROM NhanVien AS NV
	JOIN QuanLyCaLam AS QL ON NV.ID_NhanVien = QL.ID_NhanVien
	JOIN CaLam AS CL ON CL.ID_calam = QL.ID_calam
	WHERE MONTH(CL.Ngay) = @Thang AND YEAR(CL.Ngay) = @Nam
	GROUP BY NV.ID_NhanVien, NV.Ten
	HAVING SUM(DATEDIFF(minute, QL.GioVaoLam, QL.GioRaVe)) / 60 > 100
END;