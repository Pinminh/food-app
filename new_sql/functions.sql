DELIMITER $$


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
