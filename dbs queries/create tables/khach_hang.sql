CREATE TABLE KhachHang (
    ID_KhachHang INT NOT NULL,
    SDT_KhachHang VARCHAR(15) NOT NULL,
    Ten NVARCHAR(100),
    Loai_KH NVARCHAR(50),
    Tong_HoaDon DECIMAL(18, 2),
    PRIMARY KEY (ID_KhachHang, SDT_KhachHang)
);
