

CREATE OR ALTER PROCEDURE proc_tong_tien_hoa_don
@ID_DH AS VARCHAR(10)
AS
    DECLARE @Tong_tien AS INT
    SET @Tong_tien = 
    (SELECT Tong_tien FROM
        (SELECT ID_don_hang, SUM(Gia_tien) AS Tong_tien FROM
            (SELECT ID_don_hang, QL_MA_DH.ID_mon_an, QL_MA_DH.Ngay, (Gia_ban_trong_ngay*So_luong) AS Gia_tien FROM
                Quan_ly_mon_an_trong_DonHang AS QL_MA_DH
                JOIN MonAn_TrongNgay AS MA_Ngay 
                ON (QL_MA_DH.ID_mon_an = MA_Ngay.ID_mon_an
                AND QL_MA_DH.Ngay = MA_Ngay.Ngay)) AS K
            GROUP BY K.ID_don_hang) AS T
        WHERE T.ID_don_hang = @ID_DH)
    UPDATE DonHang SET Tong_tien = @Tong_tien
                 WHERE ID_don_hang = @ID_DH
GO




CREATE OR ALTER TRIGGER trg_MonAn_DonHang_check
ON Quan_ly_mon_an_trong_DonHang
AFTER INSERT,UPDATE,DELETE
AS
BEGIN
    
    IF EXISTS (
        SELECT 1
        FROM inserted AS i
        JOIN DonHang AS DH ON i.ID_don_hang = DH.ID_don_hang
        WHERE DH.Trang_thai IN ('Not_paid', 'Paid', 'Success', 'Cancel')
    )
    BEGIN
        RAISERROR ('Không được thêm món ăn khi đơn hàng không ở trạng thái Pending', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN
    END;

    IF EXISTS (
        SELECT 1
        FROM deleted AS d
        JOIN DonHang AS DH ON d.ID_don_hang = DH.ID_don_hang
        WHERE DH.Trang_thai IN ('Not_paid', 'Paid', 'Success', 'Cancel') 
    )
    BEGIN
        RAISERROR ('Không được hủy bớt món ăn khi đơn hàng không ở trạng thái Pending', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN
    END;

    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE So_luong <= 0
    )
    BEGIN
        RAISERROR ('Không được thêm món ăn trong đơn có số lượng là 0', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN
    END;

    DECLARE @ID_dh AS VARCHAR(10)
    DECLARE QLMADH_cursor CURSOR
    FOR 
    (SELECT ID_don_hang FROM inserted 
    UNION 
    SELECT ID_don_hang FROM deleted)
    OPEN QLMADH_cursor
    FETCH NEXT FROM QLMADH_cursor INTO @ID_dh
    WHILE @@FETCH_STATUS = 0
    BEGIN
        EXEC proc_tong_tien_hoa_don @ID_DH = @ID_dh
        FETCH NEXT FROM QLMADH_cursor INTO @ID_dh
    END;
    CLOSE QLMADH_cursor
    DEALLOCATE QLMADH_cursor 
END;
GO