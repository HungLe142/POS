CREATE TABLE KhachHang (
    ID_KhachHang VARCHAR(20) PRIMARY KEY,
    Ten VARCHAR(30) NOT NULL,
    SDT_KhachHang VARCHAR(15) NOT NULL,
    Loai_KH VARCHAR(20) NOT NULL, 
    Tong_HoaDon DECIMAL(18, 2),
);

CREATE TABLE NhanVien(
    ID_NhanVien VARCHAR(20) PRIMARY KEY,
    Ten VARCHAR(30) NOT NULL,
    SDT_Nhanvien VARCHAR(15),
    Trang_thai VARCHAR(20) NOT NULL, --ENUM('Tích cực', 'Bình thường', 'Không tích cực', 'Nghỉ làm'),
    Vi_tri VARCHAR(20) NOT NULL, --ENUM('Quản lý', 'Thu ngân', 'Bồi bàn', 'Đầu bếp'), 
    He_so_luong DECIMAL(10, 2) NOT NULL,
    Bang_cap VARCHAR(50),
    Ngay_bat_dau DATE,
    ID_buttoan VARCHAR(20) NOT NULL
);

CREATE TABLE CongTyThucPham(
    ID_congty VARCHAR(20) PRIMARY KEY,
    Ten VARCHAR(30) NOT NULL,
    SDT VARCHAR(15),
    Email VARCHAR(30) NOT NULL,
    ID_buttoan VARCHAR(20) NOT NULL
);

CREATE TABLE CongTyVanChuyen(
    ID_congty VARCHAR(20) PRIMARY KEY,
    Ten VARCHAR(30) NOT NULL,
    SDT VARCHAR(15),
    Email VARCHAR(30) NOT NULL,
    ID_buttoan VARCHAR(20) NOT NULL
);

CREATE TABLE CaLam(
    ID_calam INT PRIMARY KEY IDENTITY(1,1),
    Ngay DATE NOT NULL,
    GioBatDau TIME NOT NULL, 
    GioKetThuc TIME NOT NULL,
);

CREATE TABLE QuanLyCaLam (
    ID_calam INT NOT NULL,
    ID_NhanVien VARCHAR(20) NOT NULL,
    GioVaoLam TIME ,
    GioRaVe TIME,
    PRIMARY KEY(ID_calam, ID_NhanVien)
);

CREATE TABLE MonAn (
    ID_mon_an VARCHAR(6) PRIMARY KEY,
    Ten VARCHAR(20) NOT NULL,
    Loai VARCHAR(20) NOT NULL, --ENUM('Khai vị', 'Món chính', 'Tráng miệng', 'Đồ uống',), 
    Mota VARCHAR(500),
    Giagoc DECIMAL(10, 2),
);

CREATE TABLE MonAn_TrongNgay (
    ID_mon_an VARCHAR(6) NOT NULL,
    Ngay DATE NOT NULL,
    So_luong_con INT NOT NULL,
    Giam_gia DECIMAL(5, 2) NOT NULL,
    Gia_ban_trong_ngay DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (ID_mon_an, Ngay)
);

CREATE TABLE ButToan (
    ID_but_toan INT PRIMARY KEY IDENTITY(1,1),
    Ngay DATE NOT NULL,
    Gio TIME NOT NULL, 
    SoTien DECIMAL(18, 2) NOT NULL,
    NoiDung VARCHAR(500),
    ID_quanly VARCHAR(20) NOT NULL
);

CREATE TABLE ButToanThu (
    ID_but_toan INT PRIMARY KEY,
    ID_don_hang VARCHAR(10)  NOT NULL
);

CREATE TABLE ButToanChi (
    ID_but_toan INT PRIMARY KEY,
    Loai_but_toan VARCHAR(10)  NOT NULL,
    ID_ben_nhan VARCHAR(20)
);

CREATE TABLE DonHang(
    ID_don_hang VARCHAR(10) PRIMARY KEY,
    ID_KhachHang VARCHAR(20),
    ID_NhanVien VARCHAR(20) NOT NULL,
    Trang_thai VARCHAR(20) NOT NULL, --ENUM('Pending', 'Not_paid', 'Paid', 'Success', 'Cancel') NOT NULL,
    Ghi_chu_trang_thai VARCHAR(200) NOT NULL, --ENUM('Chờ xử lý', 'Đã nhận đơn (chưa thanh toán)', 'Đã thanh toán (chưa hoàn thành món)', 'Thành công', 'Đặt nhầm', 'Ship quá lâu', 'Món ăn bị hỏng') NOT NULL, 
    Gio_tao_don TIME NOT NULL,
    Gio_hoan_thanh TIME,
    Ghi_chu_don_hang VARCHAR(500),
    Tong_tien DECIMAL(18, 2) NOT NULL
);

CREATE TABLE DonHang_Taicho(
    ID_don_hang VARCHAR(10) PRIMARY KEY,
    So_ban INT
);

CREATE TABLE DonHang_Tructuyen(
    ID_don_hang VARCHAR(10) PRIMARY KEY,
    Gia_ship DECIMAL(18, 2) NOT NULL,
    Dia_chi_ship VARCHAR(500),
    ID_congty VARCHAR(20)
);

CREATE TABLE Quan_ly_mon_an_trong_DonHang(
    ID_don_hang VARCHAR(10) NOT NULL,
    ID_mon_an VARCHAR(6) NOT NULL,
    Ngay DATE NOT NULL,
    So_luong INT NOT NULL,
    PRIMARY KEY (ID_don_hang, ID_mon_an, Ngay)
);

CREATE TABLE Vi_pham(
    ID_vi_pham INT PRIMARY KEY IDENTITY(1,1),
    ID_NhanVien VARCHAR(20) NOT NULL,
    Ngay DATE NOT NULL,
    Gio TIME NOT NULL,
    Loi VARCHAR(500) NOT NULL,
    Tien_phat INT
);

CREATE TABLE Ben_Nhan(
    ID_ben_nhan VARCHAR(20) PRIMARY KEY
);