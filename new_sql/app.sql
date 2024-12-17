--
-- TABLE CREATIONS
--

CREATE TABLE `customer` (
    `username` VARCHAR(16) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `address` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(10) NOT NULL,
    `avatar` VARCHAR(255),
    `points` INT NOT NULL DEFAULT 0
);

CREATE TABLE `restaurant` (
    `username` VARCHAR(16) NOT NULL,
    `password` VARCHAR(255) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `address` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(10) NOT NULL,
    `avatar` VARCHAR(255),
    `description` TEXT
);

CREATE TABLE `dish` (
    `id` VARCHAR(5) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `price` DECIMAL(10, 2) NOT NULL,
    `restaurant` VARCHAR(16) NOT NULL,
    `description` TEXT
);

CREATE TABLE `dish_group` (
    `id` VARCHAR(5) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `description` TEXT
);

CREATE TABLE `order` (
    `id` VARCHAR(5) NOT NULL,
    `order_date` DATE NOT NULL DEFAULT CURRENT_DATE(),
    `status` VARCHAR(16) DEFAULT NULL,
    `delivery_address` VARCHAR(255) NOT NULL,
    `customer` VARCHAR(16) NOT NULL,
    `total_price` DECIMAL(10, 2) NOT NULL,
    `recipient_phone` VARCHAR(10) NOT NULL,
    `delivery_company` VARCHAR(5)
);

CREATE TABLE `bill` (
    `id` VARCHAR(5) NOT NULL,
    `date` DATE NOT NULL DEFAULT CURRENT_DATE(),
    `status` VARCHAR(16) DEFAULT NULL,
    `customer` VARCHAR(16) NOT NULL
);

CREATE TABLE `discount` (
    `id` VARCHAR(5) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `type` VARCHAR(10) NOT NULL,
    `discount_amount` DECIMAL(10, 2),
    `discount_percentage` DECIMAL(3, 2),
    `restaurant` VARCHAR(16) NOT NULL,
    `start_date` DATE NOT NULL,
    `end_date` DATE NOT NULL
);

CREATE TABLE `recipient` (
    `phone` VARCHAR(10) NOT NULL,
    `name` VARCHAR(255) NOT NULL,
    `customer` VARCHAR(16) NOT NULL
);

CREATE TABLE `feedback` (
    `customer` VARCHAR(16) NOT NULL,
    `dish` VARCHAR(5) NOT NULL,
    `ordinal` INT NOT NULL,
    `rating` INT NOT NULL,
    `comment` TEXT NOT NULL,
    `date` DATE NOT NULL DEFAULT CURRENT_DATE()
);

CREATE TABLE `delivery_company` (
    `id` VARCHAR(5) NOT NULL,
    `name` VARCHAR(255) NOT NULL
);

CREATE TABLE `restaurant_image` (
    `restaurant` VARCHAR(16) NOT NULL,
    `image` VARCHAR(255) NOT NULL
);

CREATE TABLE `dish_group_image` (
    `dish_group` VARCHAR(5) NOT NULL,
    `image` VARCHAR(255) NOT NULL
);

CREATE TABLE `dish_image` (
    `dish` VARCHAR(5) NOT NULL,
    `image` VARCHAR(255) NOT NULL
);

CREATE TABLE `dish_dish_group` (
    `dish` VARCHAR(5) NOT NULL,
    `dish_group` VARCHAR(5) NOT NULL
);

CREATE TABLE `point_discount` (
    `customer` VARCHAR(16) NOT NULL,
    `discount` VARCHAR(5) NOT NULL,
    `points` INT NOT NULL,
    `discount_type` VARCHAR(10) NOT NULL,
    `start_date` DATE NOT NULL DEFAULT CURRENT_DATE(),
    `end_date` DATE NOT NULL
);

CREATE TABLE `order_bill_discount` (
    `order` VARCHAR(5) NOT NULL,
    `bill` VARCHAR(5) NOT NULL,
    `discount` VARCHAR(5) NOT NULL,
    `paid_price` DECIMAL(10, 2) NOT NULL
);

CREATE TABLE `customer_discount` (
    `customer` VARCHAR(16) NOT NULL,
    `discount` VARCHAR(5) NOT NULL
);

CREATE TABLE `order_delivery` (
    `order` VARCHAR(5) NOT NULL,
    `delivery_company` VARCHAR(5) NOT NULL,
    `shipper_name` VARCHAR(255) NOT NULL,
    `shipper_phone` VARCHAR(10) NOT NULL,
    `arrival` DATE NOT NULL,
    `cost` DECIMAL(10, 2) NOT NULL
);

CREATE TABLE `order_dish` (
    `order` VARCHAR(5) NOT NULL,
    `dish` VARCHAR(5) NOT NULL,
    `amount` INT NOT NULL,
    `current_price` DECIMAL(10, 2) NOT NULL
);

--
-- PRIMARY KEY CONSTRAINTS
--

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

--
-- FOREIGN KEY CONSTRAINTS
--

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