SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `Telemetria` ;
USE `Telemetria` ;

-- -----------------------------------------------------
-- Table `Telemetria`.`location`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Telemetria`.`location` (
  `idlocation` INT NOT NULL AUTO_INCREMENT ,
  `location` VARCHAR(100) NOT NULL ,
  `locateCoordinate` VARCHAR(100) NULL ,
  PRIMARY KEY (`idlocation`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `Telemetria`.`kp`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Telemetria`.`kp` (
  `idkp` INT NOT NULL AUTO_INCREMENT ,
  `location_idlocation` INT NOT NULL ,
  `indeteficate` VARCHAR(100) NOT NULL ,
  `dateBegin` TIMESTAMP NULL ,
  `dateEnd` TIMESTAMP NULL ,
  PRIMARY KEY (`idkp`) ,
  INDEX `fk_kp_locate` (`location_idlocation` ASC) ,
  CONSTRAINT `fk_kp_locate`
    FOREIGN KEY (`location_idlocation` )
    REFERENCES `Telemetria`.`location` (`idlocation` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `Telemetria`.`nameCurrent`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Telemetria`.`nameCurrent` (
  `idnameCurrent` INT NOT NULL AUTO_INCREMENT ,
  `nameCurrent` VARCHAR(200) NOT NULL ,
  PRIMARY KEY (`idnameCurrent`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Telemetria`.`CurrentValues`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Telemetria`.`CurrentValues` (
  `idCurrentOptions` INT NOT NULL AUTO_INCREMENT ,
  `kp_idkp` INT NOT NULL ,
  `Nitka` INT NOT NULL ,
  `CurrentTime` TIMESTAMP NOT NULL ,
  `timeCorrektor` TIMESTAMP NULL ,
  `nameCurrent_idnameCurrent` INT NOT NULL ,
  `CurrentValues` DECIMAL(16,4) NOT NULL ,
  PRIMARY KEY (`idCurrentOptions`) ,
  INDEX `fk_CurrentValues_kp1` (`kp_idkp` ASC) ,
  INDEX `fk_CurrentValues_nameCurrent1` (`nameCurrent_idnameCurrent` ASC) ,
  CONSTRAINT `fk_CurrentValues_kp1`
    FOREIGN KEY (`kp_idkp` )
    REFERENCES `Telemetria`.`kp` (`idkp` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CurrentValues_nameCurrent1`
    FOREIGN KEY (`nameCurrent_idnameCurrent` )
    REFERENCES `Telemetria`.`nameCurrent` (`idnameCurrent` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `Telemetria`.`nameCorrektor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Telemetria`.`nameCorrektor` (
  `idnameCorrektor` INT NOT NULL ,
  `nameCorrektor` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`idnameCorrektor`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `Telemetria`.`Correktor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Telemetria`.`Correktor` (
  `idCorrektor` INT NOT NULL ,
  `kp_idkp` INT NOT NULL ,
  `nameCorrektor_idnameCorrektor` INT NOT NULL ,
  `Nitka` INT NOT NULL ,
  `dateBegin` TIMESTAMP NOT NULL ,
  `dateEnd` TIMESTAMP NULL ,
  `SNCorr` VARCHAR(45) NOT NULL ,
  `DateOfCalibrate` DATETIME NOT NULL ,
  `PeriodVerification` INT NOT NULL ,
  `SubstitTemp` DECIMAL(6,2) NULL ,
  `SubstitPressure` DECIMAL(16,4) NULL ,
  `SubstitDensity` VARCHAR(45) NULL ,
  `SubstitCompress` DECIMAL(10,4) NULL ,
  PRIMARY KEY (`idCorrektor`) ,
  INDEX `fk_Correktor_kp1` (`kp_idkp` ASC) ,
  INDEX `fk_Correktor_nameCorrektor1` (`nameCorrektor_idnameCorrektor` ASC) ,
  CONSTRAINT `fk_Correktor_kp1`
    FOREIGN KEY (`kp_idkp` )
    REFERENCES `Telemetria`.`kp` (`idkp` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Correktor_nameCorrektor1`
    FOREIGN KEY (`nameCorrektor_idnameCorrektor` )
    REFERENCES `Telemetria`.`nameCorrektor` (`idnameCorrektor` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `Telemetria`.`HourlyArchive`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Telemetria`.`HourlyArchive` (
  `idHourlyArchive` INT NOT NULL AUTO_INCREMENT ,
  `kp_idkp` INT NOT NULL ,
  `Nitka` INT NOT NULL ,
  `HourlyDateBegin` TIMESTAMP NOT NULL ,
  `HourlyDateEnd` TIMESTAMP NULL ,
  `HourlyWorkVolume` DECIMAL(16,4) NOT NULL ,
  `HourlyNormalVolume` DECIMAL(16,4) NOT NULL ,
  `HourlyWorkConsum` DECIMAL(16,4) NOT NULL ,
  `HourlyNormalConsum` DECIMAL(16,4) NOT NULL ,
  `HourlyIncreasWV` DECIMAL(16,4) NULL ,
  `HourlyIncreasNV` DECIMAL(16,4) NULL ,
  `HourlyIncreasWC` DECIMAL(16,4) NULL ,
  `HourlyIncreasNC` DECIMAL(16,4) NULL ,
  `HourlyPressure` DECIMAL(16,4) NOT NULL ,
  `HourlyTemper` DECIMAL(6,2) NOT NULL ,
  `HourlyCompress` DECIMAL(10,4) NULL ,
  `HourlyDensity` VARCHAR(45) NULL ,
  `HourlySubstitutWV` DECIMAL(16,4) NULL ,
  `HourlySubstitutNV` DECIMAL(16,4) NULL ,
  PRIMARY KEY (`idHourlyArchive`) ,
  INDEX `fk_HourlyArchive_kp1` (`kp_idkp` ASC) ,
  CONSTRAINT `fk_HourlyArchive_kp1`
    FOREIGN KEY (`kp_idkp` )
    REFERENCES `Telemetria`.`kp` (`idkp` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `Telemetria`.`DayArchive`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Telemetria`.`DayArchive` (
  `idDayArchive` INT NOT NULL ,
  `kp_idkp` INT NOT NULL ,
  `Nitka` INT NOT NULL ,
  `DayDateBegin` TIMESTAMP NOT NULL ,
  `DayDateEnd` TIMESTAMP NULL ,
  `DayWorkVolume` DECIMAL(16,4) NOT NULL ,
  `DayNormalValue` DECIMAL(16,4) NOT NULL ,
  `DayWorkConsum` DECIMAL(16,4) NOT NULL ,
  `DayNormalConsum` DECIMAL(16,4) NOT NULL ,
  `DayIncreasWV` DECIMAL(16,4) NULL ,
  `DayIncreasNV` DECIMAL(16,4) NULL ,
  `DayIncreasWC` DECIMAL(16,4) NULL ,
  `DayIncreasNC` DECIMAL(16,4) NULL ,
  `DayPressure` DECIMAL(16,4) NOT NULL ,
  `DayTemper` DECIMAL(6,2) NOT NULL ,
  `DayCompress` DECIMAL(10,4) NULL ,
  `DayDensity` VARCHAR(45) NULL ,
  `DaySubstitutWV` DECIMAL(16,4) NULL ,
  `DaySubstitutNV` DECIMAL(16,4) NULL ,
  PRIMARY KEY (`idDayArchive`) ,
  INDEX `fk_DayArchive_kp1` (`kp_idkp` ASC) ,
  CONSTRAINT `fk_DayArchive_kp1`
    FOREIGN KEY (`kp_idkp` )
    REFERENCES `Telemetria`.`kp` (`idkp` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `Telemetria`.`AlarmTag`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Telemetria`.`AlarmTag` (
  `idAlarmTag` INT NOT NULL ,
  `AlarmTag` VARCHAR(200) NOT NULL ,
  PRIMARY KEY (`idAlarmTag`) )
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;


-- -----------------------------------------------------
-- Table `Telemetria`.`Alarm`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `Telemetria`.`Alarm` (
  `idAlarm` INT NOT NULL ,
  `kp_idkp` INT NOT NULL ,
  `AlarmTag_idAlarmTag` INT NOT NULL ,
  `AlarmDateBegin` TIMESTAMP NOT NULL ,
  `AlarmDateEnd` TIMESTAMP NULL ,
  PRIMARY KEY (`idAlarm`) ,
  INDEX `fk_Alarm_kp1` (`kp_idkp` ASC) ,
  INDEX `fk_Alarm_AlarmTag1` (`AlarmTag_idAlarmTag` ASC) ,
  CONSTRAINT `fk_Alarm_kp1`
    FOREIGN KEY (`kp_idkp` )
    REFERENCES `Telemetria`.`kp` (`idkp` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Alarm_AlarmTag1`
    FOREIGN KEY (`AlarmTag_idAlarmTag` )
    REFERENCES `Telemetria`.`AlarmTag` (`idAlarmTag` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COLLATE = utf8_general_ci;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
