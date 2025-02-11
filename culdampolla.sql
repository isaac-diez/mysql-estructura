-- MySQL Workbench Synchronization
-- Generated: 2025-02-11 17:47
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
  `glasses_frameType` VARCHAR(45) NOT NULL,
  `glasses_frameColor` VARCHAR(45) NOT NULL,
  `glasses_glassColor` VARCHAR(45) NOT NULL,
  `glasses_price` FLOAT(11) NOT NULL,
  `glasses_modified` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `glasses_created` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `suppliers_suppliers_id` INT(11) NOT NULL,
  PRIMARY KEY (`glasses_id`, `suppliers_suppliers_id`),
  INDEX `fk_glasses_suppliers1_idx` (`suppliers_suppliers_id` ASC) VISIBLE,
  CONSTRAINT `fk_glasses_suppliers1`
    FOREIGN KEY (`suppliers_suppliers_id`)
    REFERENCES `Culdampolla`.`suppliers` (`suppliers_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;

CREATE TABLE IF NOT EXISTS `Culdampolla`.`suppliers` (
  `suppliers_id` INT(11) NOT NULL,
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

CREATE TABLE IF NOT EXISTS `Culdampolla`.`glasses_has_customers` (
  `glasses_has_customers_glasses_id` INT(11) NOT NULL,
  `glasses_has_customers_customers_id` INT(11) NOT NULL,
  PRIMARY KEY (`glasses_has_customers_glasses_id`, `glasses_has_customers_customers_id`),
  INDEX `fk_glasses_has_customers_customers1_idx` (`glasses_has_customers_customers_id` ASC) VISIBLE,
  INDEX `fk_glasses_has_customers_glasses1_idx` (`glasses_has_customers_glasses_id` ASC) VISIBLE,
  CONSTRAINT `fk_glasses_has_customers_glasses1`
    FOREIGN KEY (`glasses_has_customers_glasses_id`)
    REFERENCES `Culdampolla`.`glasses` (`glasses_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_glasses_has_customers_customers1`
    FOREIGN KEY (`glasses_has_customers_customers_id`)
    REFERENCES `Culdampolla`.`customers` (`customers_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_spanish_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
