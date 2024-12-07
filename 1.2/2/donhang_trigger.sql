CREATE OR ALTER TRIGGER trg_DonHang_CheckCreateState
ON DonHang
AFTER INSERT --Đơn hàng vừa được tạo chỉ có thể bắt đầu ở trạng thái Pending
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM inserted AS i
        WHERE i.Trang_thai IN ('Not_paid', 'Paid', 'Success', 'Cancel')
    )
    BEGIN
        RAISERROR ('Đơn hàng vừa tạo chỉ có thể ở trạng thái Pending', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN
    END;
END;
GO

CREATE OR ALTER TRIGGER trg_DonHang_CheckChangeState
ON DonHang
AFTER UPDATE -- Đơn hàng được cập nhật phải tuân theo 1 số quy định sau :
             -- Pending -> Not-paid -> Paid -> Success
             -- Pending -> Cancel
             -- Không được cập nhật đơn hàng đã Success hoặc Cancel
AS
IF EXISTS (
    SELECT 1
    FROM inserted AS i JOIN deleted AS d ON i.ID_don_hang = d.ID_don_hang
    WHERE (i.Trang_thai IN ('Pending','Cancel') AND d.Trang_thai IN('Not-paid'))
        OR(i.Trang_thai IN ('Pending','Not-paid','Cancel') AND d.Trang_thai IN('Paid'))
        OR(d.Trang_thai IN('Success'))
        OR(d.Trang_thai IN('Cancel'))
)
BEGIN
    RAISERROR ('Vi phạm điều kiện của chỉnh sửa đơn hàng', 16, 1);
    ROLLBACK TRANSACTION;
    RETURN
END;
GO

CREATE OR ALTER TRIGGER trg_DonHang_CheckDeleteState
ON DonHang
AFTER DELETE
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM deleted AS d
        WHERE d.Trang_thai IN ('Pending','Not_paid', 'Paid')
    )
    BEGIN
        RAISERROR ('Đơn hàng bị xóa khỏi dữ liệu chỉ có thể là đơn Success hoặc đã bị Cancel', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN
    END;
END;
GO

