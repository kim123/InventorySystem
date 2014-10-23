#Create DATABASE
CREATE DATABASE `is` /*!40100 DEFAULT CHARACTER SET utf8 */;

#TABLES
CREATE TABLE `category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(45) DEFAULT 'SYSTEM',
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

CREATE TABLE `rank` (
  `rank_id` int(11) NOT NULL AUTO_INCREMENT,
  `rank` varchar(45) NOT NULL,
  `permission` varchar(150) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(45) DEFAULT 'SYSTEM',
  PRIMARY KEY (`rank_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_name` varchar(45) NOT NULL,
  `full_name` varchar(45) DEFAULT NULL,
  `pasword` varchar(100) NOT NULL,
  `rank_id` int(11) NOT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(45) DEFAULT 'SYSTEM',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT '0-enabled; 1-disabled',
  `bank_account_num` varchar(70) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `rank_id_idx` (`rank_id`),
  CONSTRAINT `rank_id` FOREIGN KEY (`rank_id`) REFERENCES `rank` (`rank_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COMMENT='0-enabled; 1-disabled';

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(45) NOT NULL,
  `category_id` int(11) NOT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(45) DEFAULT 'SYSTEM',
  `is_history` int(2) NOT NULL DEFAULT '0' COMMENT '0 - not history, 1 - history',
  PRIMARY KEY (`product_id`),
  KEY `category_id_idx` (`category_id`),
  CONSTRAINT `category_id` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

CREATE TABLE `price` (
  `price_product_id` int(11) NOT NULL,
  `retail_price` decimal(22,2) NOT NULL,
  `selling_max_price` decimal(22,2) NOT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(45) DEFAULT 'SYSTEM',
  `selling_min_price` decimal(22,2) DEFAULT '0.00',
  PRIMARY KEY (`price_product_id`),
  CONSTRAINT `price_product_id` FOREIGN KEY (`price_product_id`) REFERENCES `product` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


CREATE TABLE `other_expenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `amount` decimal(22,2) NOT NULL DEFAULT '0.00',
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(45) DEFAULT 'SYSTEM',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

CREATE TABLE `on_duty` (
  `on_duty_id` int(11) NOT NULL AUTO_INCREMENT,
  `login_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int(11) NOT NULL,
  `starting_cash` decimal(22,2) NOT NULL,
  `total_cash` decimal(22,2) NOT NULL DEFAULT '0.00',
  `cash_hand_over` decimal(22,2) NOT NULL DEFAULT '0.00',
  `ending_cash` decimal(22,2) NOT NULL DEFAULT '0.00',
  `logout_date` timestamp NULL DEFAULT NULL,
  `duty_status` int(11) NOT NULL DEFAULT '1' COMMENT '0-checked in is DONE; 1-checked in is NOT DONE',
  `journal_entry` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`on_duty_id`),
  KEY `user_id_idx` (`user_id`),
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COMMENT='0-checked in is DONE; 1-checked in is NOT DONE';

CREATE TABLE `inventory` (
  `inventory_id` int(11) NOT NULL AUTO_INCREMENT,
  `inventory_product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT '0',
  `total` int(11) NOT NULL DEFAULT '0',
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(45) DEFAULT 'SYSTEM',
  PRIMARY KEY (`inventory_id`),
  KEY `product_id_idx` (`inventory_product_id`),
  CONSTRAINT `inventory_product_id` FOREIGN KEY (`inventory_product_id`) REFERENCES `product` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='	';

CREATE TABLE `eload_daily_sales` (
  `eload_sales_id` int(11) NOT NULL AUTO_INCREMENT,
  `eload_product_id` int(11) NOT NULL,
  `price_id` int(11) NOT NULL,
  `quantity` varchar(45) NOT NULL,
  `total` decimal(22,2) DEFAULT '0.00',
  `created_by` varchar(45) DEFAULT 'SYSTEM',
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`eload_sales_id`),
  KEY `product_id_idx` (`eload_product_id`),
  KEY `price_id_idx` (`price_id`),
  CONSTRAINT `eload_product_id` FOREIGN KEY (`eload_product_id`) REFERENCES `product` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `price_id` FOREIGN KEY (`price_id`) REFERENCES `eload_daily_prices` (`prize_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2323594 DEFAULT CHARSET=utf8;

CREATE TABLE `eload_daily_prices` (
  `prize_id` int(11) NOT NULL AUTO_INCREMENT,
  `eload_product_id` int(11) NOT NULL,
  `price` decimal(22,2) NOT NULL,
  `retail_price` decimal(22,2) NOT NULL,
  `markup_price` decimal(22,2) NOT NULL,
  `enable_status` int(2) NOT NULL DEFAULT '0' COMMENT '0 - enabled',
  `created_by` varchar(50) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`prize_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

CREATE TABLE `eload_daily_balances` (
  `daily_balance_id` int(11) NOT NULL AUTO_INCREMENT,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(45) DEFAULT 'SYSTEM',
  `starting_eload_smart` decimal(22,2) NOT NULL,
  `starting_eload_globe` decimal(22,2) NOT NULL,
  `starting_eload_sun` decimal(22,2) NOT NULL,
  `additional_balance_smart` decimal(22,2) DEFAULT NULL,
  `additional_balance_globe` decimal(22,2) DEFAULT NULL,
  `additional_balance_sun` decimal(22,2) DEFAULT NULL,
  `total_eload_smart` decimal(22,2) NOT NULL,
  `total_eload_globe` decimal(22,2) NOT NULL,
  `total_eload_sun` decimal(22,2) NOT NULL,
  `ending_balance_smart` decimal(22,2) DEFAULT NULL,
  `ending_balance_globe` decimal(22,2) DEFAULT NULL,
  `ending_balance_sun` decimal(22,2) DEFAULT NULL,
  `actual_sold_out_smart` decimal(22,2) DEFAULT NULL,
  `actual_sold_out_globe` decimal(22,2) DEFAULT NULL,
  `actual_sold_out_sun` decimal(22,2) DEFAULT NULL,
  `updated_date_smart` timestamp NULL DEFAULT NULL,
  `updated_date_globe` timestamp NULL DEFAULT NULL,
  `updated_date_sun` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`daily_balance_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

CREATE TABLE `daily_sales` (
  `daily_sales_id` int(11) NOT NULL AUTO_INCREMENT,
  `daily_on_hand_id` int(11) NOT NULL,
  `daily_sales_product_id` int(11) NOT NULL,
  `before_quantity_sold` int(11) DEFAULT NULL,
  `quantity_sold` int(11) NOT NULL DEFAULT '0',
  `amount` decimal(22,2) NOT NULL DEFAULT '0.00',
  `after_quantity_sold` int(11) DEFAULT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(45) DEFAULT 'SYSTEM',
  PRIMARY KEY (`daily_sales_id`),
  KEY `daily_on_hand_id_idx` (`daily_on_hand_id`),
  KEY `product_id_idx` (`daily_sales_product_id`),
  CONSTRAINT `daily_on_hand_id` FOREIGN KEY (`daily_on_hand_id`) REFERENCES `daily_on_hand_products` (`daily_on_hand_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `daily_sales_product_id` FOREIGN KEY (`daily_sales_product_id`) REFERENCES `product` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

CREATE TABLE `daily_on_hand_products` (
  `daily_on_hand_id` int(11) NOT NULL AUTO_INCREMENT,
  `inventory_id` int(11) NOT NULL,
  `created_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` varchar(45) DEFAULT 'SYSTEM',
  `quantity` int(11) NOT NULL DEFAULT '0',
  `total_quantity` int(11) NOT NULL DEFAULT '0',
  `ending_quantity` int(11) DEFAULT '0',
  `on_hand_product_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`daily_on_hand_id`),
  KEY `inventory_id_idx` (`inventory_id`),
  KEY `on_hand_product_id_idx` (`on_hand_product_id`),
  CONSTRAINT `inventory_id` FOREIGN KEY (`inventory_id`) REFERENCES `inventory` (`inventory_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `on_hand_product_id` FOREIGN KEY (`on_hand_product_id`) REFERENCES `product` (`product_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;





