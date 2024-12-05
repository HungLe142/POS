CREATE TRIGGER trg_NhanVien_CheckState
ON NhanVien
INSTEAD OF DELETE
AS
BEGIN
    -- Kiểm tra ràng buộc : Chỉ được xóa nhân viên đã nghỉ làm 
    -- và ca làm cuối cùng của nhân viên đó cách hiện tại ít nhất là 6 tháng
    IF EXISTS (
        SELECT 1
        FROM ((deleted i
        JOIN QuanLyCaLam q ON i.ID_NhanVien = q.ID_NhanVien) JOIN CaLam c ON q.ID_calam = c.ID_calam)
        WHERE ( i.Trang_thai IN ('Tich cuc', 'Binh thuong', 'Khong tich cuc') OR 
        DATEDIFF(month, GETDATE(), c.Ngay)<6 )
    )
    BEGIN
        RAISERROR ('Nhân viên được xóa phải là nhân viên đã nghỉ việc ít nhất 6 tháng.', 16, 1);
        ROLLBACK;
        RETURN;
    END

    -- Thêm hoặc cập nhật dữ liệu vào bảng NhanVien
    DELETE FROM NhanVien
    WHERE ID_NhanVien IN (SELECT ID_NhanVien FROM deleted)
END;