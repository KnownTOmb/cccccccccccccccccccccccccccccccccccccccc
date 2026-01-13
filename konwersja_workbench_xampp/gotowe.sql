SET FOREIGN_KEY_CHECKS = 0;

-- Tue Jan 13 01:51:46 2026

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema smipegs_lublin
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema smipegs_lublin
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `smipegs_lublin` DEFAULT CHARACTER SET utf8 ;
USE `smipegs_lublin` ;

-- -----------------------------------------------------
-- Table `smipegs_lublin`.`uzytkownik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smipegs_lublin`.`uzytkownik` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(128) NOT NULL,
  `haslo` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `iduzytkownik_UNIQUE` (`id`),
  UNIQUE INDEX `login_UNIQUE` (`login`));

-- -----------------------------------------------------
-- Table `smipegs_lublin`.`adres`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smipegs_lublin`.`adres` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `rejon` VARCHAR(64) NOT NULL,
  `kod_pocztowy` SMALLINT ZEROFILL UNSIGNED NOT NULL,
  `ulica` VARCHAR(64) NOT NULL,
  `numer_budynku` SMALLINT NOT NULL,
  `numer_mieszkania` SMALLINT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id`));

-- -----------------------------------------------------
-- Table `smipegs_lublin`.`dane_uzytkownika`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smipegs_lublin`.`dane_uzytkownika` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `imie` VARCHAR(64) NOT NULL,
  `nazwisko` VARCHAR(64) NOT NULL,
  `numer_telefonu` VARCHAR(16) NOT NULL,
  `data_urodzenia` DATE NOT NULL,
  `data_smierci` DATE NULL,
  `adres_id` INT UNSIGNED NOT NULL,
  `uzytkownik_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id`),
  INDEX `fk_dane_uzytkownika_adres1_idx` (`adres_id`),
  INDEX `fk_dane_uzytkownika_uzytkownik1_idx` (`uzytkownik_id`),
  CONSTRAINT `fk_dane_uzytkownika_adres1`
    FOREIGN KEY (`adres_id`)
    REFERENCES `smipegs_lublin`.`adres` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dane_uzytkownika_uzytkownik1`
    FOREIGN KEY (`uzytkownik_id`)
    REFERENCES `smipegs_lublin`.`uzytkownik` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `smipegs_lublin`.`rodzina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smipegs_lublin`.`rodzina` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nazwa` VARCHAR(128) NOT NULL,
  `opis` VARCHAR(1024) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id`));

-- -----------------------------------------------------
-- Table `smipegs_lublin`.`obrazek`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smipegs_lublin`.`obrazek` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `tekst_alternatywny` VARCHAR(128) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id`));

-- -----------------------------------------------------
-- Table `smipegs_lublin`.`modlitwa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smipegs_lublin`.`modlitwa` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nazwa` VARCHAR(128) NULL,
  `tresc` VARCHAR(2048) NOT NULL,
  `efekt` VARCHAR(128) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id`));

-- -----------------------------------------------------
-- Table `smipegs_lublin`.`proboszcz`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smipegs_lublin`.`proboszcz` (
  `id` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `imie` VARCHAR(64) NOT NULL,
  `nazwisko` VARCHAR(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id`));

-- -----------------------------------------------------
-- Table `smipegs_lublin`.`parafia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smipegs_lublin`.`parafia` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nazwa` VARCHAR(256) NOT NULL,
  `proboszcz_id` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `proboszcz_id`),
  UNIQUE INDEX `id_UNIQUE` (`id`),
  INDEX `fk_parafia_proboszcz1_idx` (`proboszcz_id`),
  CONSTRAINT `fk_parafia_proboszcz1`
    FOREIGN KEY (`proboszcz_id`)
    REFERENCES `smipegs_lublin`.`proboszcz` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `smipegs_lublin`.`opis_uzytkownika`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smipegs_lublin`.`opis_uzytkownika` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uzytkownik_id` INT UNSIGNED NOT NULL,
  `plec` CHAR(1) NULL,
  `pseudonim` VARCHAR(64) NULL,
  `opis` VARCHAR(1024) NULL,
  `rodzina_id` INT UNSIGNED NOT NULL,
  `zdjecie_profilowe_id` INT UNSIGNED NOT NULL,
  `ulubiona_modlitwa_id` SMALLINT UNSIGNED NOT NULL,
  `parafia_id` SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `rodzina_id`),
  UNIQUE INDEX `id_UNIQUE` (`id`),
  INDEX `fk_opis_uzytkownika_rodzina1_idx` (`rodzina_id`),
  INDEX `fk_opis_uzytkownika_obrazek1_idx` (`zdjecie_profilowe_id`),
  INDEX `fk_opis_uzytkownika_modlitwa1_idx` (`ulubiona_modlitwa_id`),
  INDEX `fk_opis_uzytkownika_parafia1_idx` (`parafia_id`),
  INDEX `fk_opis_uzytkownika_uzytkownik1_idx` (`uzytkownik_id`),
  CONSTRAINT `fk_opis_uzytkownika_rodzina1`
    FOREIGN KEY (`rodzina_id`)
    REFERENCES `smipegs_lublin`.`rodzina` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_opis_uzytkownika_obrazek1`
    FOREIGN KEY (`zdjecie_profilowe_id`)
    REFERENCES `smipegs_lublin`.`obrazek` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_opis_uzytkownika_modlitwa1`
    FOREIGN KEY (`ulubiona_modlitwa_id`)
    REFERENCES `smipegs_lublin`.`modlitwa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_opis_uzytkownika_parafia1`
    FOREIGN KEY (`parafia_id`)
    REFERENCES `smipegs_lublin`.`parafia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_opis_uzytkownika_uzytkownik1`
    FOREIGN KEY (`uzytkownik_id`)
    REFERENCES `smipegs_lublin`.`uzytkownik` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `smipegs_lublin`.`pokrewienstwo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smipegs_lublin`.`pokrewienstwo` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `typ_relacji` ENUM('mama', 'ojciec', 'córka', 'syn', 'siostra', 'brat', 'ciotka', 'wujek', 'siostrzenica', 'bratanica', 'siostrzeniec', 'bratanek', 'kuzyn', 'kuzynka', 'babcia', 'dziadek', 'wnuczka', 'wnuk', 'ojczym', 'macocha', 'pasierb', 'pasierbica', 'szwagier', 'szwagierka', 'teść', 'teściowa', 'zięć', 'synowa', 'mąż', 'żona') NOT NULL,
  `widzi_dane_osobowe` TINYINT NULL,
  `spokrewiniony_uzytkownik_id` INT UNSIGNED NOT NULL,
  `uzytkownik_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `spokrewiniony_uzytkownik_id`, `uzytkownik_id`),
  UNIQUE INDEX `id_UNIQUE` (`id`),
  INDEX `fk_pokrewienstwo_uzytkownik2_idx` (`spokrewiniony_uzytkownik_id`),
  INDEX `fk_pokrewienstwo_uzytkownik1_idx` (`uzytkownik_id`),
  CONSTRAINT `fk_pokrewienstwo_uzytkownik2`
    FOREIGN KEY (`spokrewiniony_uzytkownik_id`)
    REFERENCES `smipegs_lublin`.`uzytkownik` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pokrewienstwo_uzytkownik1`
    FOREIGN KEY (`uzytkownik_id`)
    REFERENCES `smipegs_lublin`.`uzytkownik` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `smipegs_lublin`.`tablica_ogloszeniowa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smipegs_lublin`.`tablica_ogloszeniowa` (
  `id` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nazwa` VARCHAR(256) NOT NULL,
  `opis` VARCHAR(2048) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id`));

-- -----------------------------------------------------
-- Table `smipegs_lublin`.`ogloszenie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smipegs_lublin`.`ogloszenie` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `tytul` VARCHAR(128) NOT NULL,
  `data_wstawienia` DATE NOT NULL,
  `tresc` VARCHAR(512) NOT NULL,
  `tablica_ogloszeniowa_id` SMALLINT UNSIGNED NOT NULL,
  `obrazek_id` INT UNSIGNED NOT NULL,
  `autor_id` INT UNSIGNED NOT NULL,
  `archiwalny` TINYINT NULL,
  PRIMARY KEY (`id`, `tablica_ogloszeniowa_id`, `autor_id`),
  UNIQUE INDEX `id_UNIQUE` (`id`),
  INDEX `fk_ogloszenie_tablica_ogloszeniowa1_idx` (`tablica_ogloszeniowa_id`),
  INDEX `fk_ogloszenie_obrazek1_idx` (`obrazek_id`),
  INDEX `fk_ogloszenie_uzytkownik1_idx` (`autor_id`),
  CONSTRAINT `fk_ogloszenie_tablica_ogloszeniowa1`
    FOREIGN KEY (`tablica_ogloszeniowa_id`)
    REFERENCES `smipegs_lublin`.`tablica_ogloszeniowa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ogloszenie_obrazek1`
    FOREIGN KEY (`obrazek_id`)
    REFERENCES `smipegs_lublin`.`obrazek` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ogloszenie_uzytkownik1`
    FOREIGN KEY (`autor_id`)
    REFERENCES `smipegs_lublin`.`uzytkownik` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `smipegs_lublin`.`uprawnienia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smipegs_lublin`.`uprawnienia` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `rola` ENUM('zarządzanie użytkownikami', 'kreator postów', 'moderator postów', 'obserwator postów') NOT NULL,
  `tablica_ogloszeniowa_id` SMALLINT UNSIGNED NOT NULL,
  `uzytkownik_id` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id`, `tablica_ogloszeniowa_id`, `uzytkownik_id`),
  UNIQUE INDEX `id_UNIQUE` (`id`),
  INDEX `fk_uprawnienia_tablica_ogloszeniowa1_idx` (`tablica_ogloszeniowa_id`),
  INDEX `fk_uprawnienia_uzytkownik1_idx` (`uzytkownik_id`),
  CONSTRAINT `fk_uprawnienia_tablica_ogloszeniowa1`
    FOREIGN KEY (`tablica_ogloszeniowa_id`)
    REFERENCES `smipegs_lublin`.`tablica_ogloszeniowa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_uprawnienia_uzytkownik1`
    FOREIGN KEY (`uzytkownik_id`)
    REFERENCES `smipegs_lublin`.`uzytkownik` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

-- -----------------------------------------------------
-- Table `smipegs_lublin`.`tablica_ogloszeniowa_uzytkownik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `smipegs_lublin`.`tablica_ogloszeniowa_uzytkownik` (
  `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `uzytkownik_id` INT UNSIGNED NOT NULL,
  `tablica_ogloszeniowa_id` SMALLINT UNSIGNED NOT NULL,
  UNIQUE INDEX `id_UNIQUE` (`id`),
  PRIMARY KEY (`id`, `uzytkownik_id`, `tablica_ogloszeniowa_id`),
  INDEX `fk_tablica_ogloszeniowa_uzytkownik_uzytkownik1_idx` (`uzytkownik_id`),
  INDEX `fk_tablica_ogloszeniowa_uzytkownik_tablica_ogloszeniowa1_idx` (`tablica_ogloszeniowa_id`),
  CONSTRAINT `fk_tablica_ogloszeniowa_uzytkownik_uzytkownik1`
    FOREIGN KEY (`uzytkownik_id`)
    REFERENCES `smipegs_lublin`.`uzytkownik` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tablica_ogloszeniowa_uzytkownik_tablica_ogloszeniowa1`
    FOREIGN KEY (`tablica_ogloszeniowa_id`)
    REFERENCES `smipegs_lublin`.`tablica_ogloszeniowa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

USE `smipegs_lublin` ;

-- -----------------------------------------------------
-- View `smipegs_lublin`.`wiek`
-- -----------------------------------------------------
USE `smipegs_lublin`;
CREATE  OR REPLACE VIEW wiek AS
SELECT dane_uzytkownika.id dane_uzytkownika_id, 
CASE
    WHEN data_smierci IS NULL THEN TIMESTAMPDIFF(YEAR, dane_uzytkownika.data_urodzenia, CURDATE())
    ELSE TIMESTAMPDIFF(YEAR, dane_uzytkownika.data_urodzenia, dane_uzytkownika.data_smierci)
END wiek
FROM dane_uzytkownika;

-- -----------------------------------------------------
-- View `smipegs_lublin`.`rodzina_wzeniona`
-- -----------------------------------------------------
USE `smipegs_lublin`;
CREATE  OR REPLACE VIEW rodzina_wzeniona AS 
SELECT o.rodzina_id rodzina_id, u.id uzytkownik_id
FROM uzytkownik u
JOIN pokrewienstwo p ON p.uzytkownik_id = u.id
JOIN uzytkownik wspolmalzonek ON wspolmalzonek.id = p.spokrewiniony_uzytkownik_id
JOIN opis_uzytkownika o ON o.uzytkownik_id = wspolmalzonek.id
WHERE p.typ_relacji IN ('mąż', 'żona');

-- -----------------------------------------------------
-- View `smipegs_lublin`.`liczba_uzytkownikow_i_ogloszen_w_tablicy`
-- -----------------------------------------------------
USE `smipegs_lublin`;
CREATE  OR REPLACE VIEW liczba_uzytkownikow_i_ogloszen_w_tablicy AS
SELECT t.id, t.nazwa, 
COUNT(DISTINCT(tou.uzytkownik_id)) AS liczba_uzytkownikow, 
COUNT(DISTINCT(o.id)) AS liczba_postow FROM tablica_ogloszeniowa t 
LEFT JOIN tablica_ogloszeniowa_uzytkownik tou ON t.id = tou.tablica_ogloszeniowa_id 
LEFT JOIN ogloszenie o ON o.tablica_ogloszeniowa_id = t.id 
GROUP BY t.id, t.nazwa 
ORDER BY liczba_uzytkownikow DESC;

-- -----------------------------------------------------
-- View `smipegs_lublin`.`najplodniejsze_parafie`
-- -----------------------------------------------------
USE `smipegs_lublin`;
CREATE  OR REPLACE VIEW najplodniejsze_parafie AS
SELECT parafia.id, parafia.nazwa, 
COUNT(opis_uzytkownika.id) AS liczba_wiernych
FROM parafia
JOIN opis_uzytkownika ON opis_uzytkownika.parafia_id = parafia.id
GROUP BY parafia.id  
ORDER BY `parafia`.`id`;

-- -----------------------------------------------------
-- View `smipegs_lublin`.`najplodniejsze_modlitwy`
-- -----------------------------------------------------
USE `smipegs_lublin`;
CREATE  OR REPLACE VIEW najplodniejsze_modlitwy AS 
SELECT modlitwa.id, modlitwa.nazwa, 
COUNT(opis_uzytkownika.id) AS liczba_polubien
FROM modlitwa
JOIN opis_uzytkownika ON opis_uzytkownika.ulubiona_modlitwa_id = modlitwa.id
GROUP BY modlitwa.id, modlitwa.nazwa 
ORDER BY `modlitwa`.`id`;

-- -----------------------------------------------------
-- View `smipegs_lublin`.`najplodniejsze_rodziny`
-- -----------------------------------------------------
USE `smipegs_lublin`;
CREATE  OR REPLACE VIEW najplodniejsze_rodziny AS
SELECT rodzina.id, rodzina.nazwa, 
COUNT(opis_uzytkownika.id) AS liczba_czlonkow
FROM rodzina
JOIN opis_uzytkownika ON opis_uzytkownika.rodzina_id = rodzina.id
GROUP BY rodzina.id, rodzina.nazwa 
ORDER BY `rodzina`.`id`;

-- -----------------------------------------------------
-- View `smipegs_lublin`.`matuzal`
-- -----------------------------------------------------
USE `smipegs_lublin`;
CREATE  OR REPLACE VIEW matuzal AS
SELECT uzytkownik.id, opis_uzytkownika.pseudonim, wiek.wiek
FROM uzytkownik
JOIN opis_uzytkownika ON opis_uzytkownika.uzytkownik_id = uzytkownik.id
JOIN dane_uzytkownika ON dane_uzytkownika.uzytkownik_id = uzytkownik.id
JOIN wiek ON wiek.dane_uzytkownika_id = dane_uzytkownika.id
WHERE wiek.wiek >= 90
ORDER BY wiek.wiek DESC;

-- -----------------------------------------------------
-- View `smipegs_lublin`.`zmora`
-- -----------------------------------------------------
USE `smipegs_lublin`;
CREATE  OR REPLACE VIEW zmora AS
SELECT uzytkownik.id, opis_uzytkownika.pseudonim
FROM uzytkownik
JOIN opis_uzytkownika ON opis_uzytkownika.uzytkownik_id = uzytkownik.id
WHERE NOT EXISTS (SELECT 1 FROM tablica_ogloszeniowa_uzytkownik WHERE tablica_ogloszeniowa_uzytkownik.uzytkownik_id = uzytkownik.id AND tablica_ogloszeniowa_uzytkownik.tablica_ogloszeniowa_id = 1);

-- -----------------------------------------------------
-- View `smipegs_lublin`.`url_obrazka`
-- -----------------------------------------------------
USE `smipegs_lublin`;
CREATE  OR REPLACE VIEW url_obrazka AS
SELECT obrazek.id obrazek_id, CONCAT(CONCAT('/img/', obrazek.id), '.jpg') url
FROM obrazek;

-- -----------------------------------------------------
-- View `smipegs_lublin`.`zmarly_uzytkownik`
-- -----------------------------------------------------
USE `smipegs_lublin`;
CREATE  OR REPLACE VIEW zmarly_uzytkownik AS
SELECT uzytkownik.id, opis_uzytkownika.pseudonim, dane_uzytkownika.data_smierci
FROM uzytkownik
JOIN opis_uzytkownika ON opis_uzytkownika.uzytkownik_id = uzytkownik.id
JOIN dane_uzytkownika ON dane_uzytkownika.uzytkownik_id = uzytkownik.id
WHERE dane_uzytkownika.data_smierci IS NOT NULL
ORDER BY dane_uzytkownika.data_smierci;
USE `smipegs_lublin`;

DELIMITER $$
USE `smipegs_lublin`$$
CREATE TRIGGER po_wstawieniu_do_uzytkownik
AFTER INSERT ON uzytkownik
FOR EACH ROW
INSERT INTO tablica_ogloszeniowa_uzytkownik (uzytkownik_id, tablica_ogloszeniowa_id)
VALUES (NEW.id, 1);$$

USE `smipegs_lublin`$$
CREATE TRIGGER po_wstawieniu_do_tablica_ogloszeniowa_uzytkownik
AFTER INSERT ON tablica_ogloszeniowa_uzytkownik
FOR EACH ROW 
INSERT INTO uprawnienia (rola,tablica_ogloszeniowa_id,uzytkownik_id)
VALUES ('obserwator postow',NEW.tablica_ogloszeniowa_id,NEW.uzytkownik_id)$$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

SET FOREIGN_KEY_CHECKS = 1;
