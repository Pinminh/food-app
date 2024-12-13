ALTER TABLE `dish`
ADD CONSTRAINT `fk_dish_restaurant`
FOREIGN KEY (`restaurant`)
REFERENCES `restaurant` (`username`)
ON DELETE CASCADE;

ALTER TABLE `order`
ADD CONSTRAINT `fk_order_customer`
FOREIGN KEY (`customer`)
REFERENCES `customer` (`username`)
ON DELETE CASCADE;

ALTER TABLE `order`
ADD CONSTRAINT `fk_order_recipient`
FOREIGN KEY (`recipient_phone`)
REFERENCES `recipient` (`phone`)
ON DELETE CASCADE;

ALTER TABLE `order`
ADD CONSTRAINT `fk_order_delivery_company`
FOREIGN KEY (`delivery_company`)
REFERENCES `delivery_company` (`id`)
ON DELETE SET NULL;

ALTER TABLE `bill`
ADD CONSTRAINT `fk_bill_customer`
FOREIGN KEY (`customer`)
REFERENCES `customer` (`username`)
ON DELETE CASCADE;

ALTER TABLE `discount`
ADD CONSTRAINT `fk_discount_restaurant`
FOREIGN KEY (`restaurant`)
REFERENCES `restaurant` (`username`)
ON DELETE CASCADE;

ALTER TABLE `recipient`
ADD CONSTRAINT `fk_recipient_customer`
FOREIGN KEY (`customer`)
REFERENCES `customer` (`username`)
ON DELETE CASCADE;

ALTER TABLE `feedback`
ADD CONSTRAINT `fk_feedback_customer`
FOREIGN KEY (`customer`)
REFERENCES `customer` (`username`)
ON DELETE CASCADE;

ALTER TABLE `feedback`
ADD CONSTRAINT `fk_feedback_dish`
FOREIGN KEY (`dish`)
REFERENCES `dish` (`id`)
ON DELETE CASCADE;

ALTER TABLE `restaurant_image`
ADD CONSTRAINT `fk_restaurant_image_restaurant`
FOREIGN KEY (`restaurant`)
REFERENCES `restaurant` (`username`)
ON DELETE CASCADE;

ALTER TABLE `dish_group_image`
ADD CONSTRAINT `fk_dish_group_image_dish_group`
FOREIGN KEY (`dish_group`)
REFERENCES `dish_group` (`id`)
ON DELETE CASCADE;

ALTER TABLE `dish_image`
ADD CONSTRAINT `fk_dish_image_dish`
FOREIGN KEY (`dish`)
REFERENCES `dish` (`id`)
ON DELETE CASCADE;

ALTER TABLE `dish_dish_group`
ADD CONSTRAINT `fk_dish_dish_group_dish`
FOREIGN KEY (`dish`)
REFERENCES `dish` (`id`)
ON DELETE CASCADE;

ALTER TABLE `dish_dish_group`
ADD CONSTRAINT `fk_dish_dish_group_dish_group`
FOREIGN KEY (`dish_group`)
REFERENCES `dish_group` (`id`)
ON DELETE CASCADE;

ALTER TABLE `point_discount`
ADD CONSTRAINT `fk_point_discount_customer`
FOREIGN KEY (`customer`)
REFERENCES `customer` (`username`)
ON DELETE CASCADE;

ALTER TABLE `point_discount`
ADD CONSTRAINT `fk_point_discount_discount`
FOREIGN KEY (`discount`)
REFERENCES `discount` (`id`)
ON DELETE CASCADE;

ALTER TABLE `order_bill_discount`
ADD CONSTRAINT `fk_order_bill_discount_order`
FOREIGN KEY (`order`)
REFERENCES `order` (`id`)
ON DELETE CASCADE;

ALTER TABLE `order_bill_discount`
ADD CONSTRAINT `fk_order_bill_discount_bill`
FOREIGN KEY (`bill`)
REFERENCES `bill` (`id`)
ON DELETE CASCADE;

ALTER TABLE `order_bill_discount`
ADD CONSTRAINT `fk_order_bill_discount_discount`
FOREIGN KEY (`discount`)
REFERENCES `discount` (`id`)
ON DELETE CASCADE;

ALTER TABLE `customer_discount`
ADD CONSTRAINT `fk_customer_discount_customer`
FOREIGN KEY (`customer`)
REFERENCES `customer` (`username`)
ON DELETE CASCADE;

ALTER TABLE `customer_discount`
ADD CONSTRAINT `fk_customer_discount_discount`
FOREIGN KEY (`discount`)
REFERENCES `discount` (`id`)
ON DELETE CASCADE;

ALTER TABLE `order_delivery`
ADD CONSTRAINT `fk_order_delivery_order`
FOREIGN KEY (`order`)
REFERENCES `order` (`id`)
ON DELETE CASCADE;

ALTER TABLE `order_delivery`
ADD CONSTRAINT `fk_order_delivery_delivery_company`
FOREIGN KEY (`delivery_company`)
REFERENCES `delivery_company` (`id`)
ON DELETE CASCADE;

ALTER TABLE `order_dish`
ADD CONSTRAINT `fk_order_dish_order`
FOREIGN KEY (`order`)
REFERENCES `order` (`id`)
ON DELETE CASCADE;

ALTER TABLE `order_dish`
ADD CONSTRAINT `fk_order_dish_dish`
FOREIGN KEY (`dish`)
REFERENCES `dish` (`id`)
ON DELETE CASCADE;