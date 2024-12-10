DELIMITER $$
CREATE TRIGGER `diem_sau_danh_gia` BEFORE INSERT ON `danh_gia_mon_an` FOR EACH ROW IF(EXISTS(SELECT * FROM khach_hang WHERE tenDangNhap = new.khachHang)) THEN
   BEGIN
   IF(EXISTS(SELECT * FROM mon_an WHERE maMonAn = new.maMonAn)) THEN
       IF(new.soSao = 5) THEN
       BEGIN
       	UPDATE khach_hang
        SET diemTichLuy := diemTichLuy + 10
        WHERE tenDangNhap = new.khachHang;
       END;
       END IF;
        ELSE 
    		SIGNAL SQLSTATE	'45000' SET MESSAGE_TEXT = "Không có món ăn đó";
        END IF;
   END;
ELSE 
    SIGNAL SQLSTATE	'45000' SET MESSAGE_TEXT = "Không có khách hàng đó";
END IF
$$

DELIMITER ;


DELIMITER $$
CREATE TRIGGER `cap_nhat_gia_mon_an` AFTER INSERT ON `quan_li_mon_an` FOR EACH ROW UPDATE mon_an SET giaNiemYet = new.giaBan WHERE maMonAn = new.maMonAn
$$
DELIMITER ;


-- DELIMITER $$
-- CREATE TRIGGER `cap_nhat_don_hang` BEFORE INSERT ON `tao_don_hang` FOR EACH ROW IF(EXISTS(SELECT * FROM `don_hang` WHERE `maDon` = new.maDonHang)) THEN
-- BEGIN
-- IF(EXISTS(SELECT * FROM `mon_an` WHERE `maMonAn` = new.maMonAn)) THEN
-- BEGIN
-- IF(EXISTS(SELECT * FROM `phieu_giam_gia` WHERE `maPhieu` = new.maGiamGia)) THEN
--     BEGIN
--     	DECLARE tang_them INT DEFAULT 0;
--         SELECT `giaNiemYet` INTO tang_them
--         FROM `mon_an`
--         WHERE new.`maMonAn` = `maMonAn`;
        
--     	IF(EXISTS(SELECT maPhieu FROM `phieu_giam_gia` INNER JOIN `quan_li_mon_an` ON `quan_li_mon_an`.nhaHang = `phieu_giam_gia`.nhaHang WHERE `quan_li_mon_an`.`maMonAn` =new.maMonAn AND maPhieu = new.maGiamGia)) THEN
--         BEGIN
--             IF((SELECT `tienGiam` FROM `phieu_giam_gia` WHERE new.`maGiamGia` = `maPhieu`) > 0 ) THEN
--             BEGIN
            
--                	DECLARE giam_di INT DEFAULT 0;
--                 SELECT `tienGiam` INTO giam_di
--                 FROM `phieu_giam_gia` 
--                 WHERE new.`maGiamGia` = `maPhieu`;
                
--                 UPDATE `don_hang`
--                 SET `giaThanhToan` := `giaThanhToan` + tang_them - giam_di
--                 WHERE `maDon` = new.`maDonHang`;
--             END;
--             END IF;
--             IF((SELECT `phanTramGiam` FROM `phieu_giam_gia` WHERE new.`maGiamGia` = `maPhieu`) > 0 ) THEN
--             BEGIN
--                	DECLARE giam_di FLOAT(3, 2) DEFAULT 0;
--                 SELECT `phanTramGiam` INTO giam_di
--                 FROM `phieu_giam_gia` 
--                 WHERE new.`maGiamGia` = `maPhieu`;
                
--                 UPDATE `don_hang`
--                 SET `giaThanhToan` := `giaThanhToan` + tang_them - tang_them * giam_di
--                 WHERE `maDon` = new.`maDonHang`;
--             END;
--             END IF;
--         END;
--         ELSE 
--     		SIGNAL SQLSTATE	'45000' SET MESSAGE_TEXT = "Phiếu giảm giá không tồn tại cho món ăn này";
--         END IF;
--     END;

-- ELSEIF(NOT EXISTS(SELECT new.maGiamGia)) THEN
--     BEGIN
--         DECLARE tang_them INT DEFAULT 0;
--         SELECT `giaNiemYet` INTO tang_them
--         FROM `mon_an`
--         WHERE new.`maMonAn` = `maMonAn`;
        
--         UPDATE `don_hang`
--         SET `giaThanhToan` := `giaThanhToan` + tang_them
--         WHERE `maDon` = new.`maDonHang`;
--     END;
-- ELSE
-- 	SIGNAL SQLSTATE	'45000' SET MESSAGE_TEXT = "Không có phiếu đó đó";
-- END IF;
--     END;
-- ELSE 
-- 	SIGNAL SQLSTATE	'45000' SET MESSAGE_TEXT = "Không có món ăn đó";
-- END IF;
--     END;
-- ELSE 
-- 	SIGNAL SQLSTATE	'45000' SET MESSAGE_TEXT = "Không có đơn hàng đó";
-- END IF
-- $$
-- DELIMITER ;