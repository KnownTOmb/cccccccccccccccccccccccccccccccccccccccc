-- -----------------------------------------------------
-- Widoki
-- -----------------------------------------------------

DROP VIEW IF EXISTS wiek;
CREATE VIEW wiek AS
SELECT 
    dane_uzytkownika.id AS dane_uzytkownika_id, 
    CASE
        WHEN data_smierci IS NULL THEN TIMESTAMPDIFF(YEAR, dane_uzytkownika.data_urodzenia, CURDATE())
        ELSE TIMESTAMPDIFF(YEAR, dane_uzytkownika.data_urodzenia, dane_uzytkownika.data_smierci)
    END AS wiek
FROM dane_uzytkownika;


DROP VIEW IF EXISTS plodnosc_kreatorow_postow;
CREATE VIEW plodnosc_kreatorow_postow AS 
SELECT ou.pseudonim, COUNT(o.id) AS liczba_postow 
FROM uzytkownik u 
LEFT JOIN opis_uzytkownika ou ON ou.uzytkownik_id = u.id 
LEFT JOIN ogloszenie o ON o.autor_id = u.id
GROUP BY ou.pseudonim 
ORDER BY liczba_postow DESC;


DROP VIEW IF EXISTS rodzina_wzeniona;
CREATE VIEW rodzina_wzeniona AS 
SELECT o.rodzina_id AS rodzina_id, u.id AS uzytkownik_id
FROM uzytkownik u
JOIN pokrewienstwo p ON p.uzytkownik_id = u.id
JOIN uzytkownik wspolmalzonek ON wspolmalzonek.id = p.spokrewiniony_uzytkownik_id
JOIN opis_uzytkownika o ON o.uzytkownik_id = wspolmalzonek.id
WHERE p.typ_relacji IN ('mąż', 'żona');


DROP VIEW IF EXISTS plodnosc_tablicy;
CREATE VIEW plodnosc_tablicy AS
SELECT 
    t.id, 
    t.nazwa, 
    COUNT(DISTINCT tou.uzytkownik_id) AS liczba_uzytkownikow, 
    COUNT(DISTINCT o.id) AS liczba_postow
FROM tablica_ogloszeniowa t 
LEFT JOIN tablica_ogloszeniowa_uzytkownik tou 
    ON t.id = tou.tablica_ogloszeniowa_id 
LEFT JOIN ogloszenie o 
    ON o.tablica_ogloszeniowa_id = t.id 
GROUP BY t.id, t.nazwa
ORDER BY liczba_uzytkownikow DESC;


DROP VIEW IF EXISTS plodnosc_parafii;
CREATE VIEW plodnosc_parafii AS
SELECT p.id, p.nazwa, COUNT(ou.id) AS liczba_wiernych
FROM parafia p
JOIN opis_uzytkownika ou ON ou.parafia_id = p.id
GROUP BY p.id, p.nazwa;


DROP VIEW IF EXISTS pozycja_modlitwy;
CREATE VIEW pozycja_modlitwy AS 
SELECT m.id, m.nazwa, COUNT(ou.id) AS liczba_polubien
FROM modlitwa m
JOIN opis_uzytkownika ou ON ou.ulubiona_modlitwa_id = m.id
GROUP BY m.id, m.nazwa;


DROP VIEW IF EXISTS pozycja_rodziny;
CREATE VIEW pozycja_rodziny AS
SELECT r.id, r.nazwa, COUNT(ou.id) AS liczba_czlonkow
FROM rodzina r
JOIN opis_uzytkownika ou ON ou.rodzina_id = r.id
GROUP BY r.id, r.nazwa;


DROP VIEW IF EXISTS matuzal;
CREATE VIEW matuzal AS
SELECT u.id, ou.pseudonim, w.wiek
FROM uzytkownik u
JOIN opis_uzytkownika ou ON ou.uzytkownik_id = u.id
JOIN dane_uzytkownika du ON du.uzytkownik_id = u.id
JOIN wiek w ON w.dane_uzytkownika_id = du.id
WHERE w.wiek >= 90
ORDER BY w.wiek DESC;


DROP VIEW IF EXISTS url_obrazka;
CREATE VIEW url_obrazka AS
SELECT o.id AS obrazek_id, CONCAT('/img/', o.id, '.jpg') AS url
FROM obrazek o;


DROP VIEW IF EXISTS zmora;
CREATE VIEW zmora AS
SELECT u.id, ou.pseudonim
FROM uzytkownik u
JOIN opis_uzytkownika ou ON ou.uzytkownik_id = u.id
WHERE NOT EXISTS (
    SELECT 1 
    FROM tablica_ogloszeniowa_uzytkownik tou
    WHERE tou.uzytkownik_id = u.id
      AND tou.tablica_ogloszeniowa_id = 1
);


DROP VIEW IF EXISTS zmarly_uzytkownik;
CREATE VIEW zmarly_uzytkownik AS
SELECT u.id, ou.pseudonim, du.data_smierci
FROM uzytkownik u
JOIN opis_uzytkownika ou ON ou.uzytkownik_id = u.id
JOIN dane_uzytkownika du ON du.uzytkownik_id = u.id
WHERE du.data_smierci IS NOT NULL;

-- -----------------------------------------------------
-- Domysle dane
-- -----------------------------------------------------

TRUNCATE TABLE tablica_ogloszeniowa_uzytkownik;
TRUNCATE TABLE uprawnienie;
TRUNCATE TABLE ogloszenie;
TRUNCATE TABLE tablica_ogloszeniowa;
TRUNCATE TABLE obrazek;
TRUNCATE TABLE pokrewienstwo;
TRUNCATE TABLE opis_uzytkownika;
TRUNCATE TABLE dane_uzytkownika;
TRUNCATE TABLE uzytkownik;
TRUNCATE TABLE rodzina;
TRUNCATE TABLE adres;
TRUNCATE TABLE modlitwa;
TRUNCATE TABLE parafia;
TRUNCATE TABLE proboszcz;


INSERT IGNORE INTO tablica_ogloszeniowa (id, nazwa, opis)
VALUES (1, 'Tablica główna', 'Witaj na naszym portalu!');

INSERT IGNORE INTO rodzina (id, nazwa)
VALUES (1, 'Nieznana');

INSERT IGNORE INTO obrazek (id, tekst_alternatywny)
VALUES (1, 'Default');

-- -----------------------------------------------------
-- Procedura
-- -----------------------------------------------------

DROP PROCEDURE IF EXISTS usun_stare_ogloszenia;

DELIMITER $$

CREATE PROCEDURE usun_stare_ogloszenia(
    IN ile_lat INT,
    IN do_kiedy DATE
)
BEGIN
    DECLARE data_graniczna DATE;

    IF (ile_lat IS NOT NULL AND ile_lat > 0)
       AND (do_kiedy IS NOT NULL AND do_kiedy <> '0000-00-00') THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Nie można podać obu parametrów jednocześnie';

    ELSEIF ile_lat IS NOT NULL AND ile_lat > 0 THEN
        SET data_graniczna = DATE_SUB(CURDATE(), INTERVAL ile_lat YEAR);

    ELSEIF do_kiedy IS NOT NULL AND do_kiedy <> '0000-00-00' THEN
        SET data_graniczna = do_kiedy;

    ELSE
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Nie podano poprawnego parametru';
    END IF;

    SELECT *
    FROM ogloszenie
    WHERE data_wstawienia < data_graniczna
      AND (archiwalny IS NULL OR archiwalny = 0);

    DELETE
    FROM ogloszenie
    WHERE data_wstawienia < data_graniczna
      AND (archiwalny IS NULL OR archiwalny = 0);
END$$

DELIMITER ;
