CREATE OR ALTER PROCEDURE TaoCaLamNV
	@IdNV VARCHAR(50),
	@IdCaLamStart VARCHAR(50),
	@IdCaLamEnd VARCHAR(50),
	@StartTime TIME,
	@EndTime TIME
AS
BEGIN
	DECLARE @Current INT = CAST(@IdCaLamStart AS INT);
	DECLARE @End INT = CAST(@IdCaLamEnd AS INT);

	PRINT @IdNV;

	IF EXISTS (SELECT 1 FROM NhanVien WHERE ID_NhanVien = @IdNV)
	WHILE @Current <= @End
	BEGIN
		INSERT INTO QuanLyCaLam (ID_calam, ID_NhanVien, GioVaoLam, GioRaVe)
		VALUES
			(CAST(@Current AS VARCHAR), @IdNV, @StartTime, @EndTime)

		SET @Current = @Current + 3;
	END;
	ELSE
    BEGIN
        RAISERROR('ID_NhanVien not found in NhanVien table', 16, 1);
    END;
END;