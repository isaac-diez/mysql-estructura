-- MySQL Workbench Synchronization
-- Generated: 2025-02-13 16:36
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: isaac

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`cities` (
  `cities_id` INT(11) NOT NULL AUTO_INCREMENT,
  `cities_name` VARCHAR(60) NOT NULL,
  `provinces_provinces_id` INT(11) NOT NULL,
  PRIMARY KEY (`cities_id`),
  INDEX `fk_cities_provinces1_idx` (`provinces_provinces_id` ASC) VISIBLE,
  CONSTRAINT `fk_cities_provinces1`
    FOREIGN KEY (`provinces_provinces_id`)
    REFERENCES `Pizzeria`.`provinces` (`provinces_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`customers` (
  `customers_id` INT(11) NOT NULL AUTO_INCREMENT,
  `customers_name` VARCHAR(45) NOT NULL,
  `customers_lastName` VARCHAR(45) NOT NULL,
  `customers_address` VARCHAR(60) NULL DEFAULT NULL,
  `customers_phone` VARCHAR(15) NOT NULL,
  `customers_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customers_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cities_cities_id` INT(11) NOT NULL,
  PRIMARY KEY (`customers_id`),
  INDEX `fk_customers_cities1_idx` (`cities_cities_id` ASC) VISIBLE,
  CONSTRAINT `fk_customers_cities1`
    FOREIGN KEY (`cities_cities_id`)
    REFERENCES `Pizzeria`.`cities` (`cities_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`provinces` (
  `provinces_id` INT(11) NOT NULL AUTO_INCREMENT,
  `provinces_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`provinces_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`orders` (
  `orders_id` INT(11) NOT NULL AUTO_INCREMENT,
  `orders_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `orders_type` VARCHAR(8) NOT NULL,
  `orders_productQty` INT(11) NOT NULL,
  `orders_price` DECIMAL(10,2) NOT NULL,
  `orders_timeOfDelivery` VARCHAR(45) NULL DEFAULT NULL,
  `orders_employees_id` INT(11) NOT NULL,
  `orders_customers_id` INT(11) NOT NULL,
  PRIMARY KEY (`orders_id`),
  INDEX `fk_orders_employees1_idx` (`orders_employees_id` ASC) VISIBLE,
  INDEX `fk_orders_customers1_idx` (`orders_customers_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_employees1`
    FOREIGN KEY (`orders_employees_id`)
    REFERENCES `Pizzeria`.`employees` (`employees_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_customers1`
    FOREIGN KEY (`orders_customers_id`)
    REFERENCES `Pizzeria`.`customers` (`customers_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`products` (
  `products_id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '\n',
  `products_name` VARCHAR(45) NOT NULL,
  `products_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `products_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `products_image` VARCHAR(255) NULL DEFAULT NULL COMMENT '\n',
  `products_description` VARCHAR(255) NULL DEFAULT NULL,
  `products_price` DECIMAL(10,2) NOT NULL,
  `products_type` ENUM('pizza', 'burger', 'drink') NOT NULL,
  `category_category_id` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`products_id`),
  INDEX `fk_products_category1_idx` (`category_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_products_category1`
    FOREIGN KEY (`category_category_id`)
    REFERENCES `Pizzeria`.`categories` (`categories_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`categories` (
  `categories_id` INT(11) NOT NULL AUTO_INCREMENT,
  `categories_name` VARCHAR(45) NOT NULL,
  `categories_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `categories_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`categories_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`stores` (
  `stores_id` INT(11) NOT NULL AUTO_INCREMENT,
  `stores_address` VARCHAR(60) NOT NULL,
  `stores_zipcode` VARCHAR(5) NOT NULL,
  `stores_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `stores_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `cities_cities_id` INT(11) NOT NULL,
  PRIMARY KEY (`stores_id`),
  INDEX `fk_stores_cities1_idx` (`cities_cities_id` ASC) VISIBLE,
  CONSTRAINT `fk_stores_cities1`
    FOREIGN KEY (`cities_cities_id`)
    REFERENCES `Pizzeria`.`cities` (`cities_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`employees` (
  `employees_id` INT(11) NOT NULL AUTO_INCREMENT,
  `employees_name` VARCHAR(45) NOT NULL,
  `employees_lastName` VARCHAR(45) NOT NULL,
  `employees_idDocument` VARCHAR(10) NOT NULL,
  `employees_phone` VARCHAR(25) NOT NULL,
  `employees_position` VARCHAR(45) NOT NULL,
  `employees_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `employees_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `stores_stores_id` INT(11) NOT NULL,
  PRIMARY KEY (`employees_id`),
  UNIQUE INDEX `employees_idDocument_UNIQUE` (`employees_idDocument` ASC) VISIBLE,
  INDEX `fk_employees_stores_idx` (`stores_stores_id` ASC) VISIBLE,
  CONSTRAINT `fk_employees_stores`
    FOREIGN KEY (`stores_stores_id`)
    REFERENCES `Pizzeria`.`stores` (`stores_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `Pizzeria`.`order_items` (
  `order_items_id` INT(11) NOT NULL AUTO_INCREMENT,
  `orders_orders_id` INT(11) NOT NULL,
  `products_products_id` INT(11) NOT NULL,
  `order_quantity` INT(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`order_items_id`),
  INDEX `fk_order_items_orders1_idx` (`orders_orders_id` ASC) VISIBLE,
  INDEX `fk_order_items_products1_idx` (`products_products_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_items_orders1`
    FOREIGN KEY (`orders_orders_id`)
    REFERENCES `Pizzeria`.`orders` (`orders_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_items_products1`
    FOREIGN KEY (`products_products_id`)
    REFERENCES `Pizzeria`.`products` (`products_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
