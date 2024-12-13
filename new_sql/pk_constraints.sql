ALTER TABLE `customer`
ADD CONSTRAINT `pk_customer`
PRIMARY KEY (`username`);

ALTER TABLE `restaurant`
ADD CONSTRAINT `pk_restaurant`
PRIMARY KEY (`username`);

ALTER TABLE `dish`
ADD CONSTRAINT `pk_dish`
PRIMARY KEY (`id`);

ALTER TABLE `dish_group`
ADD CONSTRAINT `pk_dish_group`
PRIMARY KEY (`id`);

ALTER TABLE `order`
ADD CONSTRAINT `pk_order`
PRIMARY KEY (`id`);

ALTER TABLE `bill`
ADD CONSTRAINT `pk_bill`
PRIMARY KEY (`id`);

ALTER TABLE `discount`
ADD CONSTRAINT `pk_discount`
PRIMARY KEY (`id`);

ALTER TABLE `recipient`
ADD CONSTRAINT `pk_recipient`
PRIMARY KEY (`phone`);

ALTER TABLE `feedback`
ADD CONSTRAINT `pk_feedback`
PRIMARY KEY (`customer`, `dish`, `ordinal`);

ALTER TABLE `delivery_company`
ADD CONSTRAINT `pk_delivery_company`
PRIMARY KEY (`id`);

ALTER TABLE `restaurant_image`
ADD CONSTRAINT `pk_restaurant_image`
PRIMARY KEY (`restaurant`, `image`);

ALTER TABLE `dish_group_image`
ADD CONSTRAINT `pk_dish_group_image`
PRIMARY KEY (`dish_group`, `image`);

ALTER TABLE `dish_image`
ADD CONSTRAINT `pk_dish_image`
PRIMARY KEY (`dish`, `image`);

ALTER TABLE `dish_dish_group`
ADD CONSTRAINT `pk_dish_dish_group`
PRIMARY KEY (`dish`, `dish_group`);

ALTER TABLE `point_discount`
ADD CONSTRAINT `pk_point_discount`
PRIMARY KEY (`customer`, `discount`);

ALTER TABLE `order_bill_discount`
ADD CONSTRAINT `pk_order_bill_discount`
PRIMARY KEY (`bill`, `discount`);

ALTER TABLE `customer_discount`
ADD CONSTRAINT `pk_customer_discount`
PRIMARY KEY (`customer`, `discount`);

ALTER TABLE `order_delivery`
ADD CONSTRAINT `pk_order_delivery`
PRIMARY KEY (`order`, `delivery_company`);

ALTER TABLE `order_dish`
ADD CONSTRAINT `pk_order_dish`
PRIMARY KEY (`order`, `dish`);