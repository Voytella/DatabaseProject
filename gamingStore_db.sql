-- MySQL Script generated by MySQL Workbench
-- Tue Dec  4 14:15:39 2018
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema gamingStore_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `gamingStore_db` ;

-- -----------------------------------------------------
-- Schema gamingStore_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gamingStore_db` DEFAULT CHARACTER SET utf8 ;
USE `gamingStore_db` ;

-- -----------------------------------------------------
-- Table `gamingStore_db`.`shipping_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gamingStore_db`.`shipping_info` ;

CREATE TABLE IF NOT EXISTS `gamingStore_db`.`shipping_info` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(60) NOT NULL,
  `street` VARCHAR(255) NOT NULL,
  `zip` INT(5) NULL,
  `state` VARCHAR(50) NULL,
  `country` VARCHAR(165) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamingStore_db`.`member`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gamingStore_db`.`member` ;

CREATE TABLE IF NOT EXISTS `gamingStore_db`.`member` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  `email` VARCHAR(254) NOT NULL,
  `phone` VARCHAR(50) NOT NULL,
  `primary_shipping_address` BIGINT UNSIGNED NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_member_primary_shipping_address_idx` (`primary_shipping_address` ASC) VISIBLE,
  CONSTRAINT `fk_member_primary_shipping_address`
    FOREIGN KEY (`primary_shipping_address`)
    REFERENCES `gamingStore_db`.`shipping_info` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamingStore_db`.`membership_info`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gamingStore_db`.`membership_info` ;

CREATE TABLE IF NOT EXISTS `gamingStore_db`.`membership_info` (
  `userid` BIGINT UNSIGNED NOT NULL,
  `date_purchased` INT UNSIGNED NOT NULL,
  `duration` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`userid`),
  CONSTRAINT `fk_membership_info_userid`
    FOREIGN KEY (`userid`)
    REFERENCES `gamingStore_db`.`member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamingStore_db`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gamingStore_db`.`order` ;

CREATE TABLE IF NOT EXISTS `gamingStore_db`.`order` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `userid` BIGINT UNSIGNED NOT NULL,
  `date_created` INT UNSIGNED NOT NULL,
  `shippinginfo` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_order_userid_idx` (`userid` ASC) VISIBLE,
  INDEX `fk_order_shippinginfo_idx` (`shippinginfo` ASC) VISIBLE,
  CONSTRAINT `fk_order_userid`
    FOREIGN KEY (`userid`)
    REFERENCES `gamingStore_db`.`member` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_shippinginfo`
    FOREIGN KEY (`shippinginfo`)
    REFERENCES `gamingStore_db`.`shipping_info` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamingStore_db`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gamingStore_db`.`product` ;

CREATE TABLE IF NOT EXISTS `gamingStore_db`.`product` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `desc` TEXT NOT NULL,
  `price` DECIMAL(10,2) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamingStore_db`.`orderitem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gamingStore_db`.`orderitem` ;

CREATE TABLE IF NOT EXISTS `gamingStore_db`.`orderitem` (
  `orderid` BIGINT UNSIGNED NOT NULL,
  `productid` INT UNSIGNED NOT NULL,
  `quantity` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`orderid`, `productid`),
  INDEX `fk_link_the_flame_idx` (`productid` ASC) VISIBLE,
  CONSTRAINT `fk_orderitem_orderid`
    FOREIGN KEY (`orderid`)
    REFERENCES `gamingStore_db`.`order` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_link_the_flame`
    FOREIGN KEY (`productid`)
    REFERENCES `gamingStore_db`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamingStore_db`.`tracking`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gamingStore_db`.`tracking` ;

CREATE TABLE IF NOT EXISTS `gamingStore_db`.`tracking` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `date` INT UNSIGNED NOT NULL,
  `event` TEXT NOT NULL,
  `orderitem` BIGINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_tracking_orderitem_idx` (`orderitem` ASC) VISIBLE,
  CONSTRAINT `fk_tracking_orderitem`
    FOREIGN KEY (`orderitem`)
    REFERENCES `gamingStore_db`.`orderitem` (`orderid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamingStore_db`.`platform`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gamingStore_db`.`platform` ;

CREATE TABLE IF NOT EXISTS `gamingStore_db`.`platform` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gamingStore_db`.`product_platform_compatibility`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gamingStore_db`.`product_platform_compatibility` ;

CREATE TABLE IF NOT EXISTS `gamingStore_db`.`product_platform_compatibility` (
  `productid` INT UNSIGNED NOT NULL,
  `platformid` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`productid`, `platformid`),
  INDEX `fk_fatrolling_idx` (`platformid` ASC) VISIBLE,
  CONSTRAINT `fk_justroll`
    FOREIGN KEY (`productid`)
    REFERENCES `gamingStore_db`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_fatrolling`
    FOREIGN KEY (`platformid`)
    REFERENCES `gamingStore_db`.`platform` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
