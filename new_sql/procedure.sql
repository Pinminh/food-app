DELIMITER $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Add_Customer` ( 
    IN `cus_user` VARCHAR(15), 
    IN `cus_name` VARCHAR(256), 
    IN `cus_add` VARCHAR(256), 
    IN `cus_phone` VARCHAR(256), 
    IN `cus_img` VARCHAR(256), 
    IN `cus_point` INT(11),
    IN `cus_pass` VARCHAR(255)
)
BEGIN
    IF (EXISTS (SELECT * FROM customer WHERE username = cus_user)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tên đăng nhập đã tồn tại';
    ELSEIF (LENGTH(cus_phone) <> 10 OR cus_phone NOT REGEXP "^0[0-9]{9}$") THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Số điện thoại phải bắt đầu với số 0 và bao gồm 10 chữ số';
    ELSE
        INSERT INTO customer (username, password, name, address, phone, avatar, points)
        VALUES (cus_user, cus_pass, cus_name, cus_add, cus_phone, cus_img, cus_point);
    END IF;
END$$

CREATE PROCEDURE add_restaurant (
    IN p_username VARCHAR(16),
    IN p_password VARCHAR(255),
    IN p_name VARCHAR(255),
    IN p_address VARCHAR(255),
    IN p_phone VARCHAR(10),
    IN p_avatar VARCHAR(255),
    IN p_description TEXT
)
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM customer 
        WHERE username = p_username
    ) OR EXISTS (
        SELECT 1 
        FROM restaurant 
        WHERE username = p_username
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên đăng nhập đã tồn tại.';
    END IF;
    IF p_phone NOT REGEXP '^0[0-9]{9}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số điện thoại không hợp lệ. Số điện thoại phải bắt đầu bằng số 0 và có đúng 10 chữ số.';
    END IF;

    INSERT INTO restaurant (username, password, name, address, phone, avatar, description)
    VALUES (p_username, p_password, p_name, p_address, p_phone, p_avatar, p_description);
END $$


CREATE DEFINER=`root`@`localhost` PROCEDURE `Add_Dish` ( 
    IN `Dish_name` VARCHAR(255), 
    IN `Dish_code` VARCHAR(5), 
    IN `Dish_des` TEXT, 
    IN `Dish_price` DECIMAL(10, 2), 
    IN `Restaurant_username` VARCHAR(16)
)
BEGIN
    IF (EXISTS (SELECT * FROM dish WHERE id = Dish_code)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mã món ăn đã tồn tại';
    ELSEIF (LENGTH(Dish_code) <> 5 OR Dish_code NOT REGEXP "^[a-zA-Z0-9]{5}") THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mã món ăn bao gồm 5 ký tự chữ hoặc số';
    ELSEIF (Dish_price < 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Giá món ăn tối thiểu là 0';
    ELSEIF (NOT EXISTS (SELECT * FROM restaurant WHERE username = Restaurant_username)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nhà hàng không tồn tại';
    ELSE
        INSERT INTO dish (id, name, price, restaurant, description)
        VALUES (Dish_code, Dish_name, Dish_price, Restaurant_username, Dish_des);
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Delete_Customer` ( 
    IN `cus_user` VARCHAR(15)
)
BEGIN
    IF (NOT EXISTS (SELECT * FROM customer WHERE username = cus_user)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tên đăng nhập không tồn tại';
    ELSE
        DELETE FROM customer WHERE username = cus_user;
    END IF;
END$$

CREATE PROCEDURE delete_restaurant (
    IN p_username VARCHAR(16)
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM restaurant 
        WHERE username = p_username
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên đăng nhập không tồn tại.';
    END IF;

    DELETE FROM restaurant WHERE username = p_username;
END $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Delete_Dish` ( 
    IN `dish_code` VARCHAR(15)
)
BEGIN
    IF (NOT EXISTS (SELECT * FROM dish WHERE id = dish_code)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mã món ăn không tồn tại';
    ELSE
        DELETE FROM dish WHERE id = dish_code;
    END IF;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_Customer` ( 
    IN `cus_user` VARCHAR(15), 
    IN `cus_name` VARCHAR(256), 
    IN `cus_add` VARCHAR(256), 
    IN `cus_phone` VARCHAR(256), 
    IN `cus_img` VARCHAR(256), 
    IN `cus_point` INT(11)
)
BEGIN
    IF (NOT EXISTS (SELECT * FROM customer WHERE username = cus_user)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Tên đăng nhập không tồn tại';
    ELSEIF (LENGTH(cus_phone) <> 10 OR cus_phone NOT REGEXP "^0[0-9]{9}$") THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Số điện thoại bắt đầu với số 0 và bao gồm 10 chữ số';
    ELSE
        UPDATE customer 
        SET name = cus_name, address = cus_add, phone = cus_phone, avatar = cus_img, points = cus_point 
        WHERE username = cus_user;
    END IF;
END$$

CREATE PROCEDURE update_restaurant (
    IN p_username VARCHAR(16),
    IN p_password VARCHAR(255),
    IN p_name VARCHAR(255),
    IN p_address VARCHAR(255),
    IN p_phone VARCHAR(10),
    IN p_avatar VARCHAR(255),
    IN p_description TEXT
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM restaurant 
        WHERE username = p_username
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên đăng nhập không tồn tại.';
    END IF;
    IF p_phone NOT REGEXP '^0[0-9]{9}$' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Số điện thoại không hợp lệ. Số điện thoại phải bắt đầu bằng số 0 và có đúng 10 chữ số.';
    END IF;

    UPDATE restaurant
    SET
        password = p_password,
        name = p_name,
        address = p_address,
        phone = p_phone,
        avatar = p_avatar,
        description = p_description
    WHERE username = p_username;
END $$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_Dish` ( 
    IN `dish_name` VARCHAR(255), 
    IN `dish_code` VARCHAR(5), 
    IN `dish_des` TEXT, 
    IN `dish_price` DECIMAL(10, 2), 
    IN `restaurant_username` VARCHAR(16)
)
BEGIN
    IF (NOT EXISTS (SELECT * FROM dish WHERE id = dish_code)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mã món ăn không tồn tại';
    ELSEIF (dish_price < 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Giá món ăn tối thiểu là 0';
    ELSEIF (NOT EXISTS (SELECT * FROM restaurant WHERE username = restaurant_username)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nhà hàng không tồn tại';
    ELSE
        UPDATE dish 
        SET name = dish_name, description = dish_des, price = dish_price, restaurant = restaurant_username 
        WHERE id = dish_code;
    END IF;
END$$

DELIMITER ;
