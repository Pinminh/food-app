DELIMITER $$

CREATE TRIGGER trg_order_delivary_date BEFORE INSERT ON order_delivery
FOR EACH ROW
BEGIN
    DECLARE order_date DATE;

    SELECT o.order_date into order_date
    FROM `order` AS o
    WHERE o.id = NEW.order;

    IF (NEW.arrival < order_date) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ngày dự kiến giao hàng không thể trước ngày đặt hàng';
    END IF;
END$$


CREATE TRIGGER trg_point_to_discount BEFORE INSERT ON point_discount
FOR EACH ROW
BEGIN
    DECLARE current_points INT;

    SELECT points INTO current_points
    FROM customer
    WHERE username = NEW.customer;

    IF (current_points < NEW.points) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Không đủ điểm để đổi thành phiếu giảm giá';
    END IF;

    UPDATE customer
    SET points = points - NEW.points
    WHERE username = NEW.customer;
END$$

DELIMITER ;