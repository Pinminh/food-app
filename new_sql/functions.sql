DELIMITER $$

CREATE FUNCTION `price_classification` (
    `dish_code` VARCHAR(5),
    `dish_price` DECIMAL(10, 2)
) 
RETURNS VARCHAR(12) CHARSET utf8mb4 DETERMINISTIC
BEGIN
    DECLARE price_level VARCHAR(12);

    IF (
        LENGTH(dish_code) <> 5 || dish_code NOT REGEXP "^[a-zA-Z0-9]{5}"
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Mã món ăn bao gồm 5 ký tự chữ hoặc số';
    ELSEIF NOT EXISTS (
        SELECT 1 
        FROM dish 
        WHERE id = dish_code
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Mã món ăn không tồn tại';
    ELSEIF (
        dish_price < 0
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Giá món ăn tối thiểu là 0';
    ELSEIF NOT EXISTS (
        SELECT 1 
        FROM dish 
        WHERE id = dish_code AND price = dish_price
    ) THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Mã món ăn và giá không trùng khớp';
    ELSE
        IF (
            (SELECT COUNT(*) 
            FROM dish 
            WHERE dish.id <> dish_code AND dish.price <= dish_price) < 
            (SELECT FLOOR(COUNT(*)/3) 
            FROM dish)
        ) THEN
            SET price_level = "Thấp";                
        ELSEIF (
            (SELECT COUNT(*) 
            FROM dish 
            WHERE dish.id <> dish_code AND dish.price >= dish_price) < 
            (SELECT FLOOR(COUNT(*)/3) 
            FROM dish)
        ) THEN
            SET price_level = "Cao";
        ELSE
            SET price_level = "Trung bình"; 
            END IF;
        RETURN price_level;
    END IF;
END$$


CREATE FUNCTION `get_dish_category` (`dish_id` VARCHAR(15), `price` INT) RETURNS VARCHAR(12)
BEGIN
	DECLARE dish_category VARCHAR(12);
	IF (SELECT LENGTH(dish_id) <> 5 || dish_id NOT REGEXP "^[a-zA-Z0-9]{5}") THEN
 		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mã món ăn bao gồm 5 ký tự chữ hoặc số';
    ELSEIF price < 0 THEN
    	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Giá món ăn không thể âm';
    ELSEIF (NOT EXISTS (SELECT * FROM dish WHERE dish.id = dish_id)) THEN
    	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mã món ăn không tồn tại';
    ELSEIF (NOT EXISTS (SELECT * FROM dish WHERE dish.id = dish_id AND dish.price = price)) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Mã món ăn và giá món ăn không trùng khớp';
    ELSE
    	BEGIN
        	IF ((SELECT COUNT(*) FROM dish WHERE dish.id <> dish_id AND dish.price <= price) < (SELECT FLOOR(COUNT(*)/3) FROM dish)) THEN
                SET dish_category = "Thấp";                
            ELSEIF ((SELECT COUNT(*) FROM dish WHERE dish.id <> dish_id AND dish.price >= price) < (SELECT FLOOR(COUNT(*)/3) FROM dish)) THEN
                SET dish_category = "Cao";
            ELSE
            	SET dish_category = "Trung bình"; 
            END IF;
            RETURN (dish_category);
    	END;
 	END IF;
END$$

DELIMITER ;