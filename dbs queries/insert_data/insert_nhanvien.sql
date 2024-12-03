/*
    - Mặc định hệ số lương = 0
    - Đã thêm hàm trigger, tùy theo vị trí, tự động cập nhật hệ số lương
    - Có hàm trigger tự động tạo bảng Bên nhận trước khi tạo nhân viên mới.
*/
INSERT INTO NhanVien
( 
 [ID_NhanVien], [Ten], [SDT_Nhanvien], [Vi_tri], [ID_buttoan]
)
VALUES
/**/
( 
 'NV000001', 'Nguyen Van Lam', '0998315789', 'Quan ly', 'BTNV000001'
),
( 
 'NV000002', 'Nguyen Thi Nga', '0948315658', 'Thu ngan', 'BTNV000002'
),
( 
 'NV000003', 'Tran Van Ben', '0948255758', 'Dau bep', 'BTNV000003'
);
