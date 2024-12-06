-- Lấy tổng số tiền mà nhân viên đã bán được trong tháng X, sort từ lớn đến bé


-- Lấy tổng số giờ làm của nhân viên
CREATE OR ALTER PROCEDURE LayGioLamNhanVienTheoThangNam
	@TenNV VARCHAR(50),
	@Thang INT,
	@Nam INT
AS
BEGIN
	SELECT NV.ID_NhanVien, NV.Ten, SUM(DATEDIFF(minute, QL.GioVaoLam, QL.GioRaVe)) / 60 AS TongGioLam
	FROM NhanVien AS NV
	JOIN QuanLyCaLam AS QL ON NV.ID_NhanVien = QL.ID_NhanVien
	JOIN CaLam AS CL ON CL.ID_calam = QL.ID_calam
	WHERE MONTH(CL.Ngay) = @Thang AND YEAR(CL.Ngay) = @Nam AND NV.Ten = @TenNV
	GROUP BY NV.ID_NhanVien, NV.Ten
	HAVING SUM(DATEDIFF(minute, QL.GioVaoLam, QL.GioRaVe)) / 60 >= 20
	ORDER BY TongGioLam ASC
END;