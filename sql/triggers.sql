DELIMITER $$

CREATE TRIGGER `log_new_order`
AFTER INSERT ON `don_hang`
FOR EACH ROW
BEGIN
    INSERT INTO `log_don_hang` (maDon, thoiGianLapDon, tinhTrangDonHang, diaChiNhan, khachHang, giaThanhToan)
    VALUES (NEW.maDon, NEW.thoiGianLapDon, NEW.tinhTrangDonHang, NEW.diaChiNhan, NEW.khachHang, NEW.giaThanhToan);
END $$

DELIMITER ;
