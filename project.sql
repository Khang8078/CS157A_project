DROP DATABASE IF EXISTS `tiktok_shop`;
CREATE DATABASE `tiktok_shop`; 
USE `tiktok_shop`;

SET NAMES utf8 ;
SET character_set_client = utf8mb4 ;

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `category` varchar(50) NOT NULL,
  `brand` varchar(50) NOT NULL,
  PRIMARY KEY (`product_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `products` (`product_id`, `name`, `category`, `brand`)
VALUES
  (1, 'Classic Cotton T-shirt', 'T-shirts', 'Nike'),
  (2, 'Sporty Jogging Pants', 'Pants', 'Adidas'),
  (3, 'Running Shoes', 'Shoes', 'Nike'),
  (4, 'Casual Denim Jacket', 'Jackets', 'Levis'),
  (5, 'Cozy Hoodie', 'Hoodies', 'Puma'),
  (6, 'Slim Fit Jeans', 'Pants', 'Calvin Klein'),
  (7, 'Running Shorts', 'Shorts', 'Under Armour');

  CREATE TABLE `advertiser` (
  `advertiser_id` int(11) NOT NULL AUTO_INCREMENT,
  `tiktok_id` varchar(50) NOT NULL,
  PRIMARY KEY (`advertiser_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- Insert data into `advertiser` table
INSERT INTO `advertiser` (`advertiser_id`, `tiktok_id`)
VALUES
  (1, '@tiktok_advertiser1'),
  (2, '@tiktok_advertiser2'),
  (3, '@tiktok_advertiser3'),
  (4, '@tiktok_advertiser4'),
  (5, '@tiktok_advertiser5');

CREATE TABLE `videos` (
  `video_id` int(11) NOT NULL AUTO_INCREMENT,
  `advertiser_id` int(11) NOT NULL,
  `link_URL` varchar(255) NOT NULL,
  `product_id` int(11) NOT NULL,
  PRIMARY KEY (`video_id`),
  CONSTRAINT `fk_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_advertiser` FOREIGN KEY (`advertiser_id`) REFERENCES `advertiser` (`advertiser_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- Insert data into `videos` table
INSERT INTO `videos` (`video_id`, `advertiser_id`, `link_URL`, `product_id`)
VALUES
  (1, 1, 'https://example.com/video1', 1),
  (2, 2, 'https://example.com/video2', 2),
  (3, 3, 'https://example.com/video3', 3),
  (4, 4, 'https://example.com/video4', 4),
  (5, 5, 'https://example.com/video5', 5);



CREATE TABLE `products_in_stock` (
  `stock_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_id` int(11) NOT NULL,
  `size` varchar(8) NOT NULL,
  `color` varchar(50) NOT NULL,
  `quantity_in_stock` int(11) NOT NULL,
  `unit_price` decimal(4,2) NOT NULL,
  PRIMARY KEY (`stock_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `products_in_stock` (`stock_id`, `product_id`, `size`, `color`, `quantity_in_stock`, `unit_price`)
VALUES
  (1, 1, 'M', 'Blue', 50, 19.99),
  (2, 2, 'L', 'Black', 30, 29.99),
  (3, 3, '9', 'White', 20, 79.99),
  (4, 4, 'M', 'Blue', 15, 59.99),
  (5, 5, 'XL', 'Gray', 25, 49.99),
  (6, 6, '32', 'Black', 35, 69.99),
  (7, 7, 'S', 'Red', 40, 24.99);



-- Create `customers` table
CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `birth_date` date DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Insert data into `customers` table
INSERT INTO `customers` (`customer_id`, `first_name`, `last_name`, `birth_date`, `phone`)
VALUES
  (1, 'John', 'Doe', '1990-05-15', '+1234567890'),
  (2, 'Alice', 'Johnson', '1985-08-20', '+9876543210'),
  (3, 'Bob', 'Smith', '1995-03-12', '+1122334455'),
  (4, 'Emily', 'Williams', '1988-12-15', '+9876543211'),
  (5, 'David', 'Miller', '1992-07-22', '+1122334456');


-- Create `address` table
CREATE TABLE `address` (
  `address_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `street` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` char(2) NOT NULL,
  `postal_code` VARCHAR(10) NOT NULL,
  `country` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`address_id`),
  CONSTRAINT `fk_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- Insert data into `address` table
INSERT INTO `address` (`address_id`,`customer_id`, `street`, `city`, `state`, `postal_code`, `country`)
VALUES
  (1, 1, '123 Main St', 'Anytown', 'NY', '12345', 'USA'),
  (2, 2, '456 Oak St', 'Somewhere', 'CA', '54321', 'USA'),
  (3, 3, '789 Pine St', 'Nowhere', 'TX', '67890', 'USA'),
  (4, 4, '987 Pine St', 'Anytown', 'CA', '54321', 'USA'),
  (5, 5, '654 Oak St', 'Nowhere', 'TX', '67890', 'USA');

-- Create `shipping` table
CREATE TABLE `shipping` (
  `shipping_id` int(11) NOT NULL AUTO_INCREMENT,
  `address_id` int(11) NOT NULL,
  `shipper` varchar(50) NOT NULL,
  `method` varchar(50) NOT NULL,
  `shipped_date` date DEFAULT NULL,
  PRIMARY KEY (`shipping_id`),
  CONSTRAINT `fk_address_shipping` FOREIGN KEY (`address_id`) REFERENCES `address` (`address_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- Insert data into `shipping` table
INSERT INTO `shipping` (`shipping_id`,`address_id`, `shipper`, `method`, `shipped_date`)
VALUES
  (1, 1, 'Express Shipping', 'Air', '2023-11-10'),
  (2, 2, 'Standard Shipping', 'Ground', '2023-11-05'),
  (3, 3, 'Express Shipping', 'Air', '2023-11-08'),
  (4, 4, 'Standard Shipping', 'Ground', '2023-11-12'),
  (5, 5, 'Express Shipping', 'Air', '2023-11-15');

  CREATE TABLE `customer_payment_method` (
  `payment_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL,
  `provider` varchar(50) NOT NULL,
  `number` varchar(16) NOT NULL,
  `expires` int(11) NOT NULL,
  `is_default` tinyint(1) NOT NULL,
  PRIMARY KEY (`payment_id`),
  CONSTRAINT `fk_payment_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
-- Insert data into `customer_payment_method` table
INSERT INTO `customer_payment_method` (`payment_id`, `customer_id`, `type`, `provider`, `number`, `expires`, `is_default`)
VALUES
  (1, 1, 'Credit Card', 'Visa', 1234567890123456, 1225, 1),
  (2, 2, 'PayPal', 'PayPal', 'paypal@example.com', 1125, 0),
  (3, 3, 'Debit Card', 'MasterCard', 9876543210123456, 0324, 1),
  (4, 4, 'Credit Card', 'MasterCard', 1234567890123456, 0625, 1),
  (5, 5, 'PayPal', 'PayPal', 'paypal@example.com', 0924, 0);


CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `status` varchar(50) NOT NULL,
  `shipping_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  KEY `fk_orders_customers_idx` (`customer_id`),
  KEY `fk_orders_order_statuses_idx` (`status`),
  CONSTRAINT `fk_orders_customers` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_shippers` FOREIGN KEY (`shipping_id`) REFERENCES `shipping` (`shipping_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `orders` (`order_id`, `customer_id`, `order_date`, `status`, `shipping_id`)
VALUES
  (1, 1, '2023-11-01', 'Processing', 1),
  (2, 2, '2023-11-03', 'Shipped', 2),
  (3, 3, '2023-11-06', 'Delivered', 3),
  (4, 4, '2023-11-10', 'Processing', 4),
  (5, 5, '2023-11-13', 'Shipped', 5);


CREATE TABLE `order_items` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `products_in_stock_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unit_price` decimal(4,2) NOT NULL,
  PRIMARY KEY (`order_id`,`products_in_stock_id`),
  KEY `fk_order_items_products_idx` (`products_in_stock_id`),
  CONSTRAINT `fk_order_items_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON UPDATE CASCADE,
  CONSTRAINT `fk_order_items_products` FOREIGN KEY (`products_in_stock_id`) REFERENCES `products_in_stock` (`stock_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
INSERT INTO `order_items` (`order_id`, `products_in_stock_id`, `quantity`, `unit_price`)
VALUES
  (1, 1, 2, 19.99),
  (2, 2, 1, 29.99),
  (3, 3, 2, 79.99),
  (3, 4, 1, 59.99),
  (4, 5, 2, 49.99),
  (5, 6, 1, 69.99),
  (5, 7, 3, 24.99);




