DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Add_khach_hang` (IN `userKH` VARCHAR(15), IN `nameKH` VARCHAR(256), IN `adKH` VARCHAR(256), IN `phoneKH` VARCHAR(256), IN `imgKH` VARCHAR(256), IN `pointKH` INT(11))   proc_label:BEGIN
    IF (EXISTS (SELECT * FROM khach_hang WHERE tenDangNhap = userKH) || EXISTS (SELECT * FROM nha_hang WHERE tenDangNhap = userKH)) 		THEN
    	signal sqlstate '45000' set message_text = 'Tên đăng nhập đã tồn tại';
    ELSEIF (SELECT LENGTH(phoneKH) <> 10 || phoneKH NOT REGEXP "^0[0-9]{9}") THEN
    	signal sqlstate '45000' set message_text = 'Số điện thoại phải bắt đầu với số 0 và bao gồm 10 chữ số';
    ELSE
    	INSERT INTO khach_hang (tenDangNhap, tenKhachHang, diaChi, sdt, anhDaiDien, diemTichLuy) VALUES (userKH, nameKH, adKH, phoneKH, imgKH, pointKH);
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Add_mon_an` (IN `nameMA` VARCHAR(50), IN `codeMA` VARCHAR(15), IN `desMA` VARCHAR(100), IN `priceMA` INT(11))   proc_label:BEGIN
IF (EXISTS (SELECT * FROM mon_an WHERE codeMA = maMonAn)) THEN
 signal sqlstate '45000' set message_text = 'Mã món ăn đã tồn tại';
 ELSEIF (SELECT LENGTH(codeMA) <> 4 || codeMA NOT REGEXP "^[a-zA-Z0-9]{4}") 
THEN
 signal sqlstate '45000' set message_text = 'Mã món ăn bao gồm 4 ký tự chữ hoặc số';
 ELSEIF (priceMA < 0) THEN
 signal sqlstate '45000' set message_text = 'Giá món ăn tối thiểu là 0';
 ELSE
 INSERT INTO mon_an (tenMonAn, maMonAn, moTaMonAn, giaNiemYet) VALUES 
(nameMA, codeMA, desMA, priceMA);
 END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Add_tai_khoan` (IN `userKH` VARCHAR(15), IN `passKH` VARCHAR(256))   proc_label:BEGIN
	IF(EXISTS (SELECT * FROM tai_khoan WHERE tenDangNhap = userKH)) THEN
    	signal sqlstate '45000' set message_text = 'Tên đăng nhập đã tồn tại';
    ELSEIF(SELECT LENGTH(passKH) < 8) THEN
    	signal sqlstate '45000' set message_text = 'Mật khẩu ít nhất 8 ký tự';
    ELSE
            INSERT INTO tai_khoan (tenDangNhap, matKhau) VALUES (userKH, passKH);
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `count_mon_an` (IN `Gia_lon_hon` INT(11))   proc_label:BEGIN
	SELECT nhom_mon_an.tenNhomMonAn, Gia_lon_hon, COUNT(*) AS soLuong
    FROM (nhom_mon_an LEFT JOIN mon_an_thuoc_nhom ON mon_an_thuoc_nhom.maNhomMonAn = nhom_mon_an.maNhomMonAn)
    LEFT JOIN mon_an ON mon_an.maMonAn = mon_an_thuoc_nhom.maMonAn     
    WHERE mon_an.giaNiemYet >= Gia_lon_hon
    GROUP BY nhom_mon_an.tenNhomMonAn
    HAVING soLuong >= 1 
    ORDER BY soLuong, nhom_mon_an.tenNhomMonAn;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Delete_khach_hang` (IN `userKH` VARCHAR(15))   proc_label:BEGIN
	IF (NOT EXISTS (SELECT * FROM khach_hang WHERE tenDangNhap = userKH)) THEN
    	signal sqlstate '45000' set message_text = 'Ten dang nhap khong ton tai';
    ELSE
    	DELETE FROM khach_hang WHERE tenDangNhap = userKH;
        DELETE FROM tai_khoan WHERE tenDangNhap = userKH;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Delete_mon_an` (IN `codeMA` VARCHAR(15))   proc_label:BEGIN
IF (NOT EXISTS (SELECT * FROM mon_an WHERE maMonAn = codeMA)) 
THEN
 signal sqlstate '45000' set message_text = 'Mã món ăn không tồn tại';
 ELSE
 DELETE FROM mon_an WHERE maMonAn = codeMA;
 END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Delete_tai_khoan` (IN `userKH` VARCHAR(15), IN `passKH` VARCHAR(256))   proc_label:BEGIN
	IF(NOT EXISTS (SELECT * FROM tai_khoan WHERE tenDangNhap <> userKH)) THEN
    	signal sqlstate '45000' set message_text = 'Tên đăng nhập không tồn tại';
    ELSE
    	DELETE FROM tai_khoan WHERE tenDangNhap = userKH;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Phan_loai_auto` ()   SELECT tenMonAn, giaNiemYet, Phan_loai(giaNiemYet) AS Phan_loai
FROM mon_an$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `point_khach_hang` (IN `point` INT(11))   proc_label:BEGIN
	SELECT tai_khoan.tenDangNhap, matKhau, tenKhachHang, diaChi, sdt, anhDaiDien, diemTichLuy from tai_khoan, khach_hang
    where tai_khoan.tenDangNhap = khach_hang.tenDangNhap AND point <= diemTichLuy
    order by diemTichLuy;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_khach_hang` (IN `userKH` VARCHAR(15), IN `nameKH` VARCHAR(256), IN `adKH` VARCHAR(256), IN `phoneKH` VARCHAR(256), IN `imgKH` VARCHAR(256), IN `pointKH` INT(11))   proc_label:BEGIN
	IF (NOT EXISTS (SELECT * FROM khach_hang WHERE tenDangNhap = userKH)) THEN
    	signal sqlstate '45000' set message_text = 'Ten dang nhap khong ton tai';
    ELSEIF(SELECT LENGTH(phoneKH) <> 10 || phoneKH NOT REGEXP "^0[0-9]{9}") THEN
    	signal sqlstate '45000' set message_text = 'So dien thoai bat dau bang so 0 dinh dang 10 chu so';
    ELSE
    	UPDATE khach_hang SET tenKhachHang = nameKH, diaChi = adKH, sdt = phoneKH, anhDaiDien = imgKH, diemTichLuy = pointKH WHERE tenDangNhap = userKH;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_mon_an` (IN `nameMA` VARCHAR(50), IN `codeMA` VARCHAR(15), IN `desMA` VARCHAR(100), IN `priceMA` INT(11))   proc_label:BEGIN
IF (NOT EXISTS (SELECT * FROM mon_an WHERE maMonAn = codeMA)) THEN
 signal sqlstate '45000' set message_text = 'Mã món ăn không tồn tại';
 ELSEIF (priceMA < 0) THEN
 signal sqlstate '45000' set message_text = 'Giá món ăn tối thiểu là 0';
 ELSE
 UPDATE mon_an SET tenMonAn = nameMA, moTaMonAn = desMA, giaNiemYet = 
priceMA where maMonAn = codeMA;
 END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_tai_khoan` (IN `userKH` VARCHAR(15), IN `passKH` VARCHAR(256))   proc_label:BEGIN
	IF(NOT EXISTS (SELECT * FROM tai_khoan WHERE tenDangNhap <> userKH)) THEN
    	signal sqlstate '45000' set message_text = 'Tên đăng nhập không tồn tại';
    ELSEIF(SELECT LENGTH(passKH) < 8) THEN
    	signal sqlstate '45000' set message_text = 'Mật khẩu mới ít nhất 8 ký tự';
    ELSE
    	UPDATE tai_khoan SET matKhau = passKH WHERE tenDangNhap = userKH;
    END IF;
END$$

DELIMITER ;