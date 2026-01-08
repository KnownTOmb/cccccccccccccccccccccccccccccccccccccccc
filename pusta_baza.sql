SET FOREIGN_KEY_CHECKS=0;

CREATE DATABASE IF NOT EXISTS mydb CHARACTER SET utf8mb4;
USE mydb;

-- =========================
-- UZYTKOWNIK
-- =========================
CREATE TABLE uzytkownik (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  login VARCHAR(128) NOT NULL UNIQUE,
  haslo BLOB(50) NOT NULL,
  ip VARBINARY(16) NOT NULL UNIQUE
) ENGINE=InnoDB;

-- =========================
-- ADRES
-- =========================
CREATE TABLE adres (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  rejon VARCHAR(64) NOT NULL,
  kod_pocztowy SMALLINT UNSIGNED ZEROFILL NOT NULL,
  ulica VARCHAR(64) NOT NULL,
  numer_budynku SMALLINT NOT NULL,
  numer_mieszkania SMALLINT NULL
) ENGINE=InnoDB;

-- =========================
-- DANE UZYTKOWNIKA
-- =========================
CREATE TABLE dane_uzytkownika (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  imie VARCHAR(64) NOT NULL,
  nazwisko VARCHAR(64) NOT NULL,
  numer_telefonu VARCHAR(16) NOT NULL,
  data_urodzenia DATE NOT NULL,
  data_smierci DATE NULL,
  adres_id INT UNSIGNED NOT NULL,
  uzytkownik_id INT UNSIGNED NOT NULL,
  FOREIGN KEY (adres_id) REFERENCES adres(id),
  FOREIGN KEY (uzytkownik_id) REFERENCES uzytkownik(id)
) ENGINE=InnoDB;

-- =========================
-- RODZINA
-- =========================
CREATE TABLE rodzina (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nazwa VARCHAR(128) NOT NULL,
  opis VARCHAR(1024)
) ENGINE=InnoDB;

-- =========================
-- OBRAZEK
-- =========================
CREATE TABLE obrazek (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  tekst_alternatywny VARCHAR(128)
) ENGINE=InnoDB;

-- =========================
-- MODLITWA
-- =========================
CREATE TABLE modlitwa (
  id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nazwa VARCHAR(128),
  tresc VARCHAR(2048) NOT NULL,
  efekt VARCHAR(128)
) ENGINE=InnoDB;

-- =========================
-- PROBOSZCZ
-- =========================
CREATE TABLE proboszcz (
  id TINYINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  imie VARCHAR(64) NOT NULL,
  nazwisko VARCHAR(64) NOT NULL
) ENGINE=InnoDB;

-- =========================
-- PARAFIA
-- =========================
CREATE TABLE parafia (
  id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nazwa VARCHAR(256) NOT NULL,
  proboszcz_id TINYINT UNSIGNED NOT NULL,
  FOREIGN KEY (proboszcz_id) REFERENCES proboszcz(id)
) ENGINE=InnoDB;

-- =========================
-- OPIS UZYTKOWNIKA
-- =========================
CREATE TABLE opis_uzytkownika (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  uzytkownik_id INT UNSIGNED NOT NULL,
  plec CHAR(1),
  pseudonim VARCHAR(64),
  opis VARCHAR(1024),
  rodzina_id INT UNSIGNED NOT NULL,
  zdjecie_profilowe_id INT UNSIGNED NOT NULL,
  ulubiona_modlitwa_id SMALLINT UNSIGNED NOT NULL,
  parafia_id SMALLINT UNSIGNED NOT NULL,
  FOREIGN KEY (uzytkownik_id) REFERENCES uzytkownik(id),
  FOREIGN KEY (rodzina_id) REFERENCES rodzina(id),
  FOREIGN KEY (zdjecie_profilowe_id) REFERENCES obrazek(id),
  FOREIGN KEY (ulubiona_modlitwa_id) REFERENCES modlitwa(id),
  FOREIGN KEY (parafia_id) REFERENCES parafia(id)
) ENGINE=InnoDB;

-- =========================
-- POKREWIENSTWO
-- =========================
CREATE TABLE pokrewienstwo (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  typ_relacji ENUM(
    'mama','ojciec','córka','syn','siostra','brat','ciotka','wujek',
    'siostrzenica','bratanica','siostrzeniec','bratanek',
    'kuzyn','kuzynka','babcia','dziadek','wnuczka','wnuk',
    'rodzeństwo','rodzic','ojczym','macocha','pasierb','pasierbica',
    'szwagier','szwagierka','teść','tesciowa','ziec','synowa'
  ) NOT NULL,
  widzi_dane_osobowe TINYINT,
  spokrewiniony_uzytkownik_id INT UNSIGNED NOT NULL,
  uzytkownik_id INT UNSIGNED NOT NULL,
  FOREIGN KEY (spokrewiniony_uzytkownik_id) REFERENCES uzytkownik(id),
  FOREIGN KEY (uzytkownik_id) REFERENCES uzytkownik(id)
) ENGINE=InnoDB;

-- =========================
-- TABLICA OGLOSZENIOWA
-- =========================
CREATE TABLE tablica_ogloszeniowa (
  id SMALLINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nazwa VARCHAR(256) NOT NULL,
  opis VARCHAR(2048)
) ENGINE=InnoDB;

-- =========================
-- OGLOSZENIE
-- =========================
CREATE TABLE ogloszenie (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  tytul VARCHAR(128) NOT NULL,
  data_wstawienia DATE NOT NULL,
  tresc VARCHAR(512) NOT NULL,
  tablica_ogloszeniowa_id SMALLINT UNSIGNED NOT NULL,
  obrazek_id INT UNSIGNED NOT NULL,
  autor_id INT UNSIGNED NOT NULL,
  archiwalny TINYINT,
  FOREIGN KEY (tablica_ogloszeniowa_id) REFERENCES tablica_ogloszeniowa(id),
  FOREIGN KEY (obrazek_id) REFERENCES obrazek(id),
  FOREIGN KEY (autor_id) REFERENCES uzytkownik(id)
) ENGINE=InnoDB;

-- =========================
-- UPRAWNIENIA
-- =========================
CREATE TABLE uprawnienia (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  rola ENUM(
    'zarządzanie użytkownikami',
    'kreator postów',
    'moderator postów',
    'obserwator postów'
  ) NOT NULL,
  tablica_ogloszeniowa_id SMALLINT UNSIGNED NOT NULL,
  uzytkownik_id INT UNSIGNED NOT NULL,
  FOREIGN KEY (tablica_ogloszeniowa_id) REFERENCES tablica_ogloszeniowa(id),
  FOREIGN KEY (uzytkownik_id) REFERENCES uzytkownik(id)
) ENGINE=InnoDB;

-- =========================
-- TABLICA - UZYTKOWNIK
-- =========================
CREATE TABLE tablica_ogloszeniowa_uzytkownik (
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  uzytkownik_id INT UNSIGNED NOT NULL,
  tablica_ogloszeniowa_id SMALLINT UNSIGNED NOT NULL,
  FOREIGN KEY (uzytkownik_id) REFERENCES uzytkownik(id),
  FOREIGN KEY (tablica_ogloszeniowa_id) REFERENCES tablica_ogloszeniowa(id)
) ENGINE=InnoDB;

SET FOREIGN_KEY_CHECKS=1;