-- MySQL Workbench Synchronization
-- Generated: 2025-02-12 17:54
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: isaac

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `Culdampolla` DEFAULT CHARACTER SET utf8 COLLATE utf8_spanish_ci ;

CREATE TABLE IF NOT EXISTS `Culdampolla`.`glasses` (
  `glasses_id` INT(11) NOT NULL AUTO_INCREMENT,
  `glasses_prescription` FLOAT(11) NOT NULL,
  `glasses_frameType` ENUM('metallic', 'acetate', 'floating') NOT NULL,
  `glasses_frameColor` VARCHAR(45) NOT NULL,
  `glasses_glassColor` VARCHAR(45) NOT NULL,
  `glasses_price` FLOAT(11) NOT NULL,
  `glasses_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `glasses_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `suppliers_suppliers_id` INT(11) NOT NULL,
  PRIMARY KEY (`glasses_id`, `suppliers_suppliers_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

CREATE TABLE IF NOT EXISTS `Culdampolla`.`suppliers` (
  `suppliers_id` INT(11) NOT NULL AUTO_INCREMENT,
  `suppliers_name` VARCHAR(45) NOT NULL,
  `suppliers_address` VARCHAR(60) NOT NULL,
  `suppliers_phone` VARCHAR(15) NOT NULL,
  `suppliers_fax` VARCHAR(15) NOT NULL,
  `suppliers_taxId` VARCHAR(10) NOT NULL,
  `suppliers_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `suppliers_modified` DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`suppliers_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

CREATE TABLE IF NOT EXISTS `Culdampolla`.`customers` (
  `customers_id` INT(11) NOT NULL AUTO_INCREMENT,
  `customers_name` VARCHAR(45) NOT NULL,
  `customers_address` VARCHAR(60) NULL DEFAULT NULL,
  `customers_phone` VARCHAR(15) NOT NULL,
  `customers_email` VARCHAR(255) NOT NULL,
  `customers_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `customers_referral` VARCHAR(45) NULL DEFAULT NULL,
  `customers_salesRep` VARCHAR(45) NOT NULL,
  `customers_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`customers_id`),
  UNIQUE INDEX `customers_email_UNIQUE` (`customers_email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

CREATE TABLE IF NOT EXISTS `Culdampolla`.`orders` (
  `orders_id` INT(11) NOT NULL AUTO_INCREMENT,
  `orders_created` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `orders_total_price` DECIMAL(10,2) NOT NULL,
  `orders_status` ENUM('pending', 'processing', 'shipped', 'delivered', 'cancelled') NOT NULL,
  `orders_type` ENUM('purchase', 'sale') NOT NULL,
  `customers_customers_id` INT(11) NULL DEFAULT NULL,
  `suppliers_suppliers_id` INT(11) NULL DEFAULT NULL,
  `orders_salesperson` ENUM('Mark', 'Mary', 'Roy', 'Lilly') NULL DEFAULT NULL,
  PRIMARY KEY (`orders_id`),
  INDEX `fk_orders_customers1_idx` (`customers_customers_id` ASC) VISIBLE,
  INDEX `fk_orders_suppliers1_idx` (`suppliers_suppliers_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customers1`
    FOREIGN KEY (`customers_customers_id`)
    REFERENCES `Culdampolla`.`customers` (`customers_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_orders_suppliers1`
    FOREIGN KEY (`suppliers_suppliers_id`)
    REFERENCES `Culdampolla`.`suppliers` (`suppliers_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

CREATE TABLE IF NOT EXISTS `Culdampolla`.`order_items` (
  `order_items_id` INT(11) NOT NULL AUTO_INCREMENT,
  `order_items_quantity` INT(11) NOT NULL,
  `order_items_unit_price` DECIMAL(10,2) NOT NULL,
  `order_items_subtotal` DECIMAL(10,2) GENERATED ALWAYS AS (`order_items_quantity` * `order_items_unit_price`) STORED,
  `orders_orders_id` INT(11) NOT NULL,
  `glasses_glasses_id` INT(11) NOT NULL,
  PRIMARY KEY (`order_items_id`),
  INDEX `fk_order_items_orders1_idx` (`orders_orders_id` ASC) VISIBLE,
  INDEX `fk_order_items_glasses1_idx` (`glasses_glasses_id` ASC) VISIBLE,
  CONSTRAINT `fk_order_items_saleOrders1`
    FOREIGN KEY (`orders_orders_id`)
    REFERENCES `Culdampolla`.`orders` (`orders_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_order_items_glasses1`
    FOREIGN KEY (`glasses_glasses_id`)
    REFERENCES `Culdampolla`.`glasses` (`glasses_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


DELIMITER $$

USE `Culdampolla`$$
CREATE TRIGGER before_insert_orders
BEFORE INSERT ON `Culdampolla`.`orders`
FOR EACH ROW
BEGIN
  IF (NEW.orders_type = 'purchase' AND NEW.suppliers_suppliers_id IS NULL) OR 
     (NEW.orders_type = 'sale' AND NEW.customers_customers_id IS NULL) OR 
     (NEW.orders_type = 'purchase' AND NEW.customers_customers_id IS NOT NULL) OR
     (NEW.orders_type = 'sale' AND NEW.suppliers_suppliers_id IS NOT NULL) THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Invalid order: A purchase must have a supplier, and a sale must have a customer.';
  END IF;
END$$


DELIMITER ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
