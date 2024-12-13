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