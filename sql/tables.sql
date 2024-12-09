CREATE TABLE `anh_mon_an` (
  `maMonAn` VARCHAR(15) NOT NULL,
  `anhMonAn` VARCHAR(256) NOT NULL,
);


CREATE TABLE `anh_nha_hang` (
  `tenDangNhap` VARCHAR(15) NOT NULL,
  `anhNhaHang` VARCHAR(100) NOT NULL
);


CREATE TABLE `cong_ty_giao_hang` (
  `tenCongTy` VARCHAR(50) NOT NULL,
  `maCongTy` VARCHAR(15) NOT NULL
);


CREATE TABLE `danh_gia_mon_an` (
  `khachHang` VARCHAR(256) NOT NULL,
  `maMonAn` VARCHAR(256) NOT NULL,
  `ngayDanhGia` date DEFAULT NULL,
  `soSao` int(11) DEFAULT NULL,
  `moTa` VARCHAR(1024) DEFAULT NULL
);


CREATE TABLE `doi_diem` (
  `khachHang` VARCHAR(256) NOT NULL,
  `maPhieu` VARCHAR(256) NOT NULL,
  `loaiPhieu` VARCHAR(256) NOT NULL,
  `ngayKetThuc` date DEFAULT NULL
);


CREATE TABLE `don_hang` (
  `maDon` VARCHAR(256) NOT NULL,
  `thoiGianLapDon` date DEFAULT NULL,
  `tinhTrangDonHang` VARCHAR(256) DEFAULT NULL,
  `diaChiNhan` VARCHAR(256) NOT NULL,
  `khachHang` VARCHAR(256) NOT NULL,
  `giaThanhToan` int(11) NOT NULL
);


CREATE TABLE `khach_hang` (
  `tenDangNhap` VARCHAR(15) NOT NULL,
  `tenKhachHang` VARCHAR(256) NOT NULL,
  `diaChi` VARCHAR(256) NOT NULL,
  `sdt` VARCHAR(256) NOT NULL,
  `anhDaiDien` VARCHAR(256) DEFAULT NULL,
  `diemTichLuy` int(11) DEFAULT NULL
);


CREATE TABLE `mon_an` (
  `tenMonAn` VARCHAR(50) NOT NULL,
  `maMonAn` VARCHAR(15) NOT NULL,
  `moTaMonan` VARCHAR(100) NOT NULL,
  `giaNiemYet` int(11) NOT NULL
);


CREATE TABLE `mon_an_thuoc_nhom` (
  `maMonAn` VARCHAR(256) NOT NULL,
  `maNhomMonAn` VARCHAR(256) NOT NULL
);


CREATE TABLE `nguoi_giao_hang` (
  `maDonHang` VARCHAR(15) NOT NULL,
  `maCongTy` VARCHAR(15) NOT NULL,
  `tenTaiXe` VARCHAR(50) NOT NULL,
  `ngayGiaoHang` date NOT NULL,
  `soDienThoai` char(10) NOT NULL,
  `phiShip` int(11) NOT NULL
);


CREATE TABLE `nguoi_nhan` (
  `maDonHang` VARCHAR(15) NOT NULL,
  `tenNguoiNhan` VARCHAR(50) NOT NULL,
  `diaChiNhan` VARCHAR(256) NOT NULL
);


CREATE TABLE `nha_hang` (
  `tenDangNhap` VARCHAR(15) NOT NULL,
  `tenNhaHang` VARCHAR(50) NOT NULL,
  `diaChi` VARCHAR(50) NOT NULL,
  `moTaNhaHang` VARCHAR(1000) DEFAULT NULL
);


CREATE TABLE `nhom_mon_an` (
  `tenNhomMonAn` VARCHAR(30) NOT NULL,
  `maNhomMonAn` VARCHAR(15) NOT NULL,
  `moTaNhomMonAn` VARCHAR(100) NOT NULL
);


CREATE TABLE `phieu_giam_gia` (
  `nhaHang` VARCHAR(15) NOT NULL,
  `tenPhieu` VARCHAR(256) DEFAULT NULL,
  `maPhieu` VARCHAR(256) NOT NULL,
  `tienGiam` int(11) DEFAULT NULL,
  `phanTramGiam` float DEFAULT NULL
);


CREATE TABLE `phieu_thanh_toan` (
  `maPhieu` VARCHAR(256) NOT NULL,
  `tinhTrang` VARCHAR(256) DEFAULT NULL
);


CREATE TABLE `quan_li_mon_an` (
  `nhaHang` VARCHAR(256) NOT NULL,
  `maMonAn` VARCHAR(256) NOT NULL,
  `giaBan` int(11) DEFAULT NULL,
  `ngayDatGia` date DEFAULT NULL
);


CREATE TABLE `tai_khoan` (
  `tenDangNhap` VARCHAR(15) NOT NULL,
  `matKhau` VARCHAR(256) NOT NULL
);


CREATE TABLE `tao_don_hang` (
  `maDonHang` VARCHAR(256) NOT NULL,
  `maGiamGia` VARCHAR(256) DEFAULT NULL,
  `maPhieuThanhToan` VARCHAR(256) DEFAULT NULL,
  `maMonAn` VARCHAR(256) NOT NULL,
  `ngayTaoDon` date DEFAULT NULL
);