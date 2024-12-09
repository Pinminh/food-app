DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Add_khach_hang` (
    IN `userKH` VARCHAR(15), 
    IN `nameKH` VARCHAR(256), 
    IN `adKH` VARCHAR(256), 
    IN `phoneKH` VARCHAR(256), 
    IN `imgKH` VARCHAR(256), 
    IN `pointKH` INT
)
BEGIN
    -- Kiểm tra nếu tên đăng nhập không tồn tại trong bảng tai_khoan
    IF NOT EXISTS (SELECT 1 FROM tai_khoan WHERE tenDangNhap = userKH) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Khách hàng chưa có tên đăng nhập';
    
    -- Kiểm tra nếu tên đăng nhập đã tồn tại trong bảng khach_hang hoặc nha_hang
    ELSEIF EXISTS (SELECT 1 FROM khach_hang WHERE tenDangNhap = userKH) 
        OR EXISTS (SELECT 1 FROM nha_hang WHERE tenDangNhap = userKH) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tên đăng nhập đã tồn tại';

    -- Kiểm tra định dạng số điện thoại: 10 chữ số và bắt đầu bằng 0
    ELSEIF LENGTH(phoneKH) <> 10 OR phoneKH NOT REGEXP '^0[0-9]{9}$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Số điện thoại phải bắt đầu bằng số 0 và có 10 chữ số';

    -- Nếu tất cả điều kiện đều đúng, thêm dữ liệu vào bảng khach_hang
    ELSE
        INSERT INTO khach_hang (tenDangNhap, tenKhachHang, diaChi, sdt, anhDaiDien, diemTichLuy)
        VALUES (userKH, nameKH, adKH, phoneKH, imgKH, pointKH);
    END IF;
END$$

DELIMITER ;


DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Add_mon_an` (
    IN `nameMA` VARCHAR(50), 
    IN `codeMA` VARCHAR(15), 
    IN `desMA` VARCHAR(100), 
    IN `priceMA` INT
)
BEGIN
    -- Kiểm tra nếu mã món ăn đã tồn tại
    IF EXISTS (SELECT 1 FROM mon_an WHERE maMonAn = codeMA) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mã món ăn đã tồn tại';

    -- Kiểm tra độ dài và định dạng của mã món ăn (4 ký tự chữ hoặc số)
    ELSEIF LENGTH(codeMA) <> 4 OR codeMA NOT REGEXP '^[a-zA-Z0-9]{4}$' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mã món ăn bao gồm 4 ký tự chữ hoặc số';

    -- Kiểm tra giá món ăn không được nhỏ hơn 0
    ELSEIF priceMA < 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Giá món ăn tối thiểu là 0';

    -- Thêm món ăn vào bảng mon_an
    ELSE
        INSERT INTO mon_an (tenMonAn, maMonAn, moTaMonAn, giaNiemYet)
        VALUES (nameMA, codeMA, desMA, priceMA);
    END IF;
END$$

DELIMITER ;


DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Add_tai_khoan` (
    IN `userKH` VARCHAR(15), 
    IN `passKH` VARCHAR(256)
)
BEGIN
    -- Kiểm tra nếu tên đăng nhập đã tồn tại trong bảng tai_khoan
    IF EXISTS (SELECT 1 FROM tai_khoan WHERE tenDangNhap = userKH) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tên đăng nhập đã tồn tại';

    -- Kiểm tra độ dài mật khẩu phải ít nhất 8 ký tự
    ELSEIF LENGTH(passKH) < 8 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mật khẩu ít nhất 8 ký tự';

    -- Nếu điều kiện hợp lệ, thêm tài khoản mới vào bảng tai_khoan
    ELSE
        INSERT INTO tai_khoan (tenDangNhap, matKhau)
        VALUES (userKH, passKH);
    END IF;
END$$

DELIMITER ;


DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `count_mon_an` (
    IN `Gia_lon_hon` INT
)
BEGIN
    -- Truy vấn thống kê số lượng món ăn có giá niêm yết lớn hơn hoặc bằng tham số đầu vào
    SELECT 
        nhom_mon_an.tenNhomMonAn AS TenNhomMonAn,
        Gia_lon_hon AS GiaLonHon,
        COUNT(mon_an.maMonAn) AS soLuong
    FROM 
        nhom_mon_an
    LEFT JOIN 
        mon_an_thuoc_nhom ON mon_an_thuoc_nhom.maNhomMonAn = nhom_mon_an.maNhomMonAn
    LEFT JOIN 
        mon_an ON mon_an.maMonAn = mon_an_thuoc_nhom.maMonAn
    WHERE 
        mon_an.giaNiemYet >= Gia_lon_hon
    GROUP BY 
        nhom_mon_an.tenNhomMonAn
    HAVING 
        soLuong >= 1
    ORDER BY 
        soLuong ASC, nhom_mon_an.tenNhomMonAn ASC;
END$$

DELIMITER ;


DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Delete_khach_hang` (
    IN `userKH` VARCHAR(15)
)
BEGIN
    -- Kiểm tra nếu tài khoản khách hàng có tồn tại hay không
    IF NOT EXISTS (SELECT 1 FROM khach_hang WHERE tenDangNhap = userKH) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tên đăng nhập không tồn tại';
    ELSE
        -- Xóa khách hàng khỏi bảng khach_hang
        DELETE FROM khach_hang 
        WHERE tenDangNhap = userKH;

        -- Xóa tài khoản liên quan khỏi bảng tai_khoan
        DELETE FROM tai_khoan 
        WHERE tenDangNhap = userKH;
    END IF;
END$$

DELIMITER ;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Delete_tai_khoan` (
    IN `userKH` VARCHAR(15),
    IN `passKH` VARCHAR(256)
)
BEGIN
    -- Kiểm tra nếu tên đăng nhập tồn tại và mật khẩu khớp
    IF NOT EXISTS (
        SELECT 1 
        FROM tai_khoan 
        WHERE tenDangNhap = userKH AND matKhau = passKH
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Tên đăng nhập hoặc mật khẩu không chính xác';
    ELSE
        -- Xóa tài khoản nếu điều kiện hợp lệ
        DELETE FROM tai_khoan 
        WHERE tenDangNhap = userKH AND matKhau = passKH;
    END IF;
END$$

DELIMITER ;


DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Phan_loai_auto` ()
BEGIN
    SELECT 
        tenMonAn, 
        giaNiemYet, 
        CASE 
            WHEN giaNiemYet < 50000 THEN 'Rẻ'
            WHEN giaNiemYet BETWEEN 50000 AND 100000 THEN 'Trung bình'
            WHEN giaNiemYet > 100000 THEN 'Đắt'
            ELSE 'Không xác định'
        END AS Phan_loai
    FROM 
        mon_an;
END$$

DELIMITER ;

DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `point_khach_hang` (
    IN `point` INT
)
BEGIN
    SELECT 
        tai_khoan.tenDangNhap, 
        tai_khoan.matKhau, 
        khach_hang.tenKhachHang, 
        khach_hang.diaChi, 
        khach_hang.sdt, 
        khach_hang.anhDaiDien, 
        khach_hang.diemTichLuy
    FROM 
        tai_khoan
    INNER JOIN 
        khach_hang ON tai_khoan.tenDangNhap = khach_hang.tenDangNhap
    WHERE 
        khach_hang.diemTichLuy >= point
    ORDER BY 
        khach_hang.diemTichLuy ASC;
END$$

DELIMITER ;


DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_khach_hang` (
    IN `userKH` VARCHAR(15), 
    IN `nameKH` VARCHAR(256), 
    IN `adKH` VARCHAR(256), 
    IN `phoneKH` VARCHAR(256), 
    IN `imgKH` VARCHAR(256), 
    IN `pointKH` INT
)
BEGIN
    -- Kiểm tra sự tồn tại của tên đăng nhập
    IF NOT EXISTS (
        SELECT 1 
        FROM khach_hang 
        WHERE tenDangNhap = userKH
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Tên đăng nhập không tồn tại';

    -- Kiểm tra định dạng số điện thoại
    ELSEIF LENGTH(phoneKH) <> 10 OR phoneKH NOT REGEXP '^0[0-9]{9}' THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Số điện thoại phải bắt đầu bằng số 0 và có 10 chữ số';

    -- Thực hiện cập nhật thông tin
    ELSE
        UPDATE khach_hang 
        SET 
            tenKhachHang = nameKH, 
            diaChi = adKH, 
            sdt = phoneKH, 
            anhDaiDien = imgKH, 
            diemTichLuy = pointKH 
        WHERE 
            tenDangNhap = userKH;
    END IF;
END$$

DELIMITER ;


DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_mon_an` (
    IN `nameMA` VARCHAR(50), 
    IN `codeMA` VARCHAR(15), 
    IN `desMA` VARCHAR(100), 
    IN `priceMA` INT
)
BEGIN
    -- Kiểm tra xem mã món ăn có tồn tại hay không
    IF NOT EXISTS (
        SELECT 1 
        FROM mon_an 
        WHERE maMonAn = codeMA
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Mã món ăn không tồn tại';

    -- Kiểm tra giá món ăn không được âm
    ELSEIF priceMA < 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Giá món ăn tối thiểu là 0';

    -- Thực hiện cập nhật thông tin món ăn
    ELSE
        UPDATE mon_an 
        SET 
            tenMonAn = nameMA, 
            moTaMonAn = desMA, 
            giaNiemYet = priceMA
        WHERE 
            maMonAn = codeMA;
    END IF;
END$$

DELIMITER ;


DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_tai_khoan` (
    IN `userKH` VARCHAR(15), 
    IN `passKH` VARCHAR(256)
)
BEGIN
    -- Kiểm tra sự tồn tại của tên đăng nhập
    IF NOT EXISTS (
        SELECT 1 
        FROM tai_khoan 
        WHERE tenDangNhap = userKH
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Tên đăng nhập không tồn tại';

    -- Kiểm tra độ dài của mật khẩu
    ELSEIF LENGTH(passKH) < 8 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Mật khẩu mới ít nhất 8 ký tự';

    -- Thực hiện cập nhật mật khẩu
    ELSE
        UPDATE tai_khoan 
        SET matKhau = passKH 
        WHERE tenDangNhap = userKH;
    END IF;
END$$

DELIMITER ;
