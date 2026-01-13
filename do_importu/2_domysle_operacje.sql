-- -----------------------------------------------------
-- Widoki
-- -----------------------------------------------------

CREATE VIEW wiek AS
SELECT dane_uzytkownika.id dane_uzytkownika_id, 
CASE
    WHEN data_smierci IS NULL THEN TIMESTAMPDIFF(YEAR, dane_uzytkownika.data_urodzenia, CURDATE())
    ELSE TIMESTAMPDIFF(YEAR, dane_uzytkownika.data_urodzenia, dane_uzytkownika.data_smierci)
END wiek
FROM dane_uzytkownika;


CREATE VIEW najplodniejsi_kreatorzy_postow AS 
SELECT ou.pseudonim, 
COUNT(o.id) AS liczba_postow 
FROM uzytkownik u 
JOIN opis_uzytkownika ou ON ou.uzytkownik_id = u.id 
JOIN ogloszenie o ON o.autor_id = u.id
GROUP BY ou.pseudonim 
ORDER BY liczba_postow DESC;

CREATE VIEW rodzina_wzeniona AS 
SELECT o.rodzina_id rodzina_id, u.id uzytkownik_id
FROM uzytkownik u
JOIN pokrewienstwo p ON p.uzytkownik_id = u.id
JOIN uzytkownik wspolmalzonek ON wspolmalzonek.id = p.spokrewiniony_uzytkownik_id
JOIN opis_uzytkownika o ON o.uzytkownik_id = wspolmalzonek.id
WHERE p.typ_relacji IN ('mąż', 'żona');

CREATE VIEW liczba_uzytkownikow_i_ogloszen_w_tablicy AS
SELECT t.id, t.nazwa, 
COUNT(DISTINCT(tou.uzytkownik_id)) AS liczba_uzytkownikow, 
COUNT(DISTINCT(o.id)) AS liczba_postow FROM tablica_ogloszeniowa t 
LEFT JOIN tablica_ogloszeniowa_uzytkownik tou ON t.id = tou.tablica_ogloszeniowa_id 
LEFT JOIN ogloszenie o ON o.tablica_ogloszeniowa_id = t.id 
GROUP BY t.id, t.nazwa 
ORDER BY liczba_uzytkownikow DESC;

CREATE VIEW najplodniejsze_parafie AS
SELECT parafia.id, parafia.nazwa, 
COUNT(opis_uzytkownika.id) AS liczba_wiernych
FROM parafia
JOIN opis_uzytkownika ON opis_uzytkownika.parafia_id = parafia.id
GROUP BY parafia.id, parafia.nazwa
ORDER BY `parafia`.`id` ASC;

CREATE VIEW najplodniejsze_modlitwy AS 
SELECT modlitwa.id, modlitwa.nazwa, 
COUNT(opis_uzytkownika.id) AS liczba_polubien
FROM modlitwa
JOIN opis_uzytkownika ON opis_uzytkownika.ulubiona_modlitwa_id = modlitwa.id
GROUP BY modlitwa.id, modlitwa.nazwa 
ORDER BY `modlitwa`.`id` ASC;

CREATE VIEW najplodniejsze_rodziny AS
SELECT rodzina.id, rodzina.nazwa, 
COUNT(opis_uzytkownika.id) AS liczba_czlonkow
FROM rodzina
JOIN opis_uzytkownika ON opis_uzytkownika.rodzina_id = rodzina.id
GROUP BY rodzina.id, rodzina.nazwa 
ORDER BY `rodzina`.`id` ASC;

CREATE VIEW matuzal AS
SELECT uzytkownik.id, opis_uzytkownika.pseudonim, wiek.wiek
FROM uzytkownik
JOIN opis_uzytkownika ON opis_uzytkownika.uzytkownik_id = uzytkownik.id
JOIN dane_uzytkownika ON dane_uzytkownika.uzytkownik_id = uzytkownik.id
JOIN wiek ON wiek.dane_uzytkownika_id = dane_uzytkownika.id
WHERE wiek.wiek >= 90
ORDER BY wiek.wiek DESC;

CREATE VIEW url_obrazka AS
SELECT obrazek.id obrazek_id, CONCAT(CONCAT('/img/', obrazek.id), '.jpg') url
FROM obrazek;

CREATE VIEW zmora AS
SELECT uzytkownik.id, opis_uzytkownika.pseudonim
FROM uzytkownik
JOIN opis_uzytkownika ON opis_uzytkownika.uzytkownik_id = uzytkownik.id
WHERE NOT EXISTS (SELECT 1 FROM tablica_ogloszeniowa_uzytkownik WHERE tablica_ogloszeniowa_uzytkownik.uzytkownik_id = uzytkownik.id AND tablica_ogloszeniowa_uzytkownik.tablica_ogloszeniowa_id = 1);

CREATE VIEW zmarly_uzytkownik AS
SELECT uzytkownik.id, opis_uzytkownika.pseudonim, dane_uzytkownika.data_smierci
FROM uzytkownik
JOIN opis_uzytkownika ON opis_uzytkownika.uzytkownik_id = uzytkownik.id
JOIN dane_uzytkownika ON dane_uzytkownika.uzytkownik_id = uzytkownik.id
WHERE dane_uzytkownika.data_smierci IS NOT NULL
ORDER BY dane_uzytkownika.data_smierci;

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


INSERT INTO tablica_ogloszeniowa (nazwa, opis) VALUES
('Tablica glówna','Witaj na naszym portalu!');

INSERT INTO rodzina (id,nazwa) VALUES ('1','Nieznana');

INSERT INTO obrazek (id,tekst_alternatywny) VALUES ('1','Default')

-- -----------------------------------------------------
-- Procedura
-- -----------------------------------------------------

DELIMITER $$

CREATE PROCEDURE usun_stare_ogloszenia(
IN ile_lat INT,
IN do_kiedy DATE
)
BEGIN
DECLARE data_graniczna DATE;

IF (ile_lat IS NOT NULL AND ile_lat > 0)
AND (do_kiedy IS NOT NULL AND do_kiedy <> '0000-00-00') THEN

-- przerywanie dzialania procedury
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

DELETE FROM ogloszenie
WHERE data_wstawienia < data_graniczna
AND (archiwalny IS NULL OR archiwalny = 0);

END$$

DELIMITER ;