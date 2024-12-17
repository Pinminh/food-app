DELIMITER $$

CREATE PROCEDURE `add_customer` ( 
    IN `cus_user` VARCHAR(16), 
    IN `cus_pass` VARCHAR(255),    
    IN `cus_name` VARCHAR(255), 
    IN `cus_add` VARCHAR(255), 
    IN `cus_phone` VARCHAR(10), 
    IN `cus_img` VARCHAR(255), 
    IN `cus_point` INT
)
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM customer 
        WHERE username = cus_user
    ) OR EXISTS (
        SELECT 1 
        FROM restaurant 
        WHERE username = cus_user
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Tên đăng nhập đã tồn tại';
    ELSEIF (
        LENGTH(cus_phone) <> 10 || cus_phone NOT REGEXP "^0[0-9]{9}$"
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Số điện thoại phải bắt đầu với số 0 và bao gồm 10 chữ số';
    ELSE
        INSERT INTO customer (username, password, name, address, phone, avatar, points)
        VALUES (cus_user, cus_pass, cus_name, cus_add, cus_phone, cus_img, cus_point);
    END IF;
END$$


CREATE PROCEDURE `add_restaurant` ( 
    IN `res_user` VARCHAR(16), 
    IN `res_pass` VARCHAR(255),
    IN `res_name` VARCHAR(255), 
    IN `res_add` VARCHAR(255), 
    IN `res_phone` VARCHAR(10), 
    IN `res_img` VARCHAR(255), 
    IN `res_des` TEXT
)
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM customer 
        WHERE username = res_user
    ) OR EXISTS (
        SELECT 1 
        FROM restaurant 
        WHERE username = res_user
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Tên đăng nhập đã tồn tại';
    ELSEIF (
        LENGTH(res_phone) <> 10 || res_phone NOT REGEXP "^0[0-9]{9}$"
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Số điện thoại phải bắt đầu với số 0 và bao gồm 10 chữ số';
    ELSE
        INSERT INTO restaurant (username, password, name, address, phone, avatar, description)
        VALUES (res_user, res_pass, res_name, res_add, res_phone, res_img, res_des);
    END IF;
END$$


CREATE PROCEDURE `add_dish` ( 
    IN `dish_code` VARCHAR(5), 
    IN `dish_name` VARCHAR(255), 
    IN `dish_price` DECIMAL(10, 2), 
    IN `restaurant_name` VARCHAR(16),
    IN `dish_des` TEXT
)
BEGIN
    IF EXISTS (
        SELECT 1 
        FROM dish 
        WHERE id = dish_code
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Mã món ăn đã tồn tại';
    ELSEIF (
        LENGTH(dish_code) <> 5 || dish_code NOT REGEXP "^[a-zA-Z0-9]{5}"
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Mã món ăn bao gồm 5 ký tự chữ hoặc số';
    ELSEIF (
        dish_price < 0
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Giá món ăn tối thiểu là 0';
    ELSEIF NOT EXISTS (
        SELECT 1 
        FROM restaurant 
        WHERE name = restaurant_name
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Nhà hàng không tồn tại';
    ELSE
        INSERT INTO dish (id, name, price, restaurant, description)
        VALUES (dish_code, dish_name, dish_price, restaurant_name, dish_des);
    END IF;
END$$


CREATE PROCEDURE `delete_customer` ( 
    IN `cus_user` VARCHAR(16)
)
BEGIN
    IF NOT EXISTS (
        SELECT 1
        FROM customer 
        WHERE username = cus_user
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Tên đăng nhập không tồn tại';
    ELSE
        DELETE FROM customer 
        WHERE username = cus_user;
    END IF;
END$$

CREATE PROCEDURE `delete_restaurant` (
    IN `res_user` VARCHAR(16)
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM restaurant 
        WHERE username = res_user
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Tên đăng nhập không tồn tại';
    ELSE
        DELETE FROM customer 
        WHERE username = res_user;
    END IF;
END $$


CREATE PROCEDURE `delete_dish` ( 
    IN `dish_code` VARCHAR(5)
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM dish 
        WHERE id = dish_code
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Mã món ăn không tồn tại';
    ELSE
        DELETE FROM dish 
        WHERE id = dish_code;
    END IF;
END$$


CREATE PROCEDURE `update_customer` ( 
    IN `cus_user` VARCHAR(16), 
    IN `cus_name` VARCHAR(255), 
    IN `cus_add` VARCHAR(255), 
    IN `cus_phone` VARCHAR(10), 
    IN `cus_img` VARCHAR(255), 
    IN `cus_point` INT
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM customer 
        WHERE username = cus_user
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Tên đăng nhập không tồn tại';
    ELSEIF (
        LENGTH(cus_phone) <> 10 || cus_phone NOT REGEXP "^0[0-9]{9}$"
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Số điện thoại bắt đầu với số 0 và bao gồm 10 chữ số';
    ELSE
        UPDATE customer 
        SET 
            name = cus_name, 
            address = cus_add, 
            phone = cus_phone, 
            avatar = cus_img, 
            points = cus_point 
        WHERE username = cus_user;
    END IF;
END$$


CREATE PROCEDURE `update_restaurant` (
    IN `res_user` VARCHAR(16), 
    IN `res_name` VARCHAR(255), 
    IN `res_add` VARCHAR(255), 
    IN `res_phone` VARCHAR(10), 
    IN `res_img` VARCHAR(255), 
    IN `res_des` TEXT
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 
        FROM restaurant 
        WHERE username = res_user
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Tên đăng nhập không tồn tại';
    ELSEIF (
        LENGTH(res_phone) <> 10 || res_phone NOT REGEXP "^0[0-9]{9}$"
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Số điện thoại bắt đầu với số 0 và bao gồm 10 chữ số';
    ELSE
        UPDATE restaurant 
        SET 
            name = res_name, 
            address = res_add, 
            phone = res_phone, 
            avatar = res_img, 
            description = res_des 
        WHERE username = res_user;
    END IF;
END $$


CREATE PROCEDURE `update_dish` ( 
    IN `d_name` VARCHAR(255), 
    IN `d_code` VARCHAR(5), 
    IN `d_des` TEXT, 
    IN `d_price` DECIMAL(10, 2), 
    IN `r_name` VARCHAR(16)
)
BEGIN
    IF (NOT EXISTS (SELECT * FROM `dish` WHERE `id` = `d_code`)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mã món ăn không tồn tại';
    ELSEIF (`d_price` < 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Giá món ăn tối thiểu là 0';
    ELSEIF (NOT EXISTS (SELECT * FROM `restaurant` WHERE `username` = `r_name`)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Nhà hàng không tồn tại';
    ELSE
        UPDATE `dish` 
        SET name = `d_name`, description = `d_des`, `price` = `d_price`, `restaurant` = `r_name` 
        WHERE `id` = `d_code`;
    END IF;
END$$


CREATE PROCEDURE `get_all_customers` ()
BEGIN
    SELECT * FROM `customer`;
END$$


CREATE PROCEDURE `get_customers_by_point` (
    IN `threshold_point` INT
)
BEGIN
    IF (`threshold_point` < 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Điểm giới hạn không thể âm';
    ELSE
        SELECT * FROM `customer`
        WHERE `customer`.`points` >= `threshold_point`;
    END IF;
END$$


CREATE PROCEDURE `get_all_restaurants` ()
BEGIN
    SELECT * FROM `restaurant`;
END$$


CREATE PROCEDURE `get_all_dishes` ()
BEGIN
    SELECT * FROM `dish`;
END$$


CREATE PROCEDURE `get_dishes_by_price` (
    IN `threshold_price` INT
)
BEGIN
    IF (`threshold_price` < 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Giá giới hạn không thể âm';
    ELSE
        SELECT * FROM `dish`
        WHERE `dish`.`price` >= `threshold_price`
        ORDER BY `dish`.`price`;
    END IF;
END$$


CREATE PROCEDURE `count_dish_per_group_by_price` (IN `threshold_price` INT)
BEGIN
    IF (threshold_price < 0) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Giá giới hạn không thể âm';
    ELSE
        SELECT dish_group.name, COUNT(*) AS amount
        FROM (dish_group LEFT JOIN dish_dish_group ON dish_dish_group.dish_group = dish_group.id)
        LEFT JOIN dish ON dish.id = dish_dish_group.dish     
        WHERE dish.price >= threshold_price
        GROUP BY dish_group.name
        HAVING amount >= 1 
        ORDER BY amount, dish_group.name;
    END IF;
END$$


CREATE PROCEDURE `auto_categorize_dish` ()
BEGIN
    SELECT `name`, price, get_dish_category(id, price) AS category
    FROM dish
    ORDER BY price;
END$$

DELIMITER ;
