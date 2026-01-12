## Widoki

```sql
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
JOIN opis_uzytkownika ou ON ou.id = u.id 
JOIN ogloszenie o ON o.autor_id = u.id GROUP BY u.id 
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
GROUP BY parafia.id  
ORDER BY `parafia`.`id` ASC

CREATE VIEW najplodniejsze_modlitwy AS 
SELECT modlitwa.id, modlitwa.nazwa, 
COUNT(opis_uzytkownika.id) AS liczba_polubien
FROM modlitwa
JOIN opis_uzytkownika ON opis_uzytkownika.ulubiona_modlitwa_id = modlitwa.id
GROUP BY modlitwa.id  
ORDER BY `modlitwa`.`id` ASC

CREATE VIEW najplodniejsze_rodziny AS
SELECT rodzina.id, rodzina.nazwa, 
COUNT(opis_uzytkownika.id) AS liczba_czlonkow
FROM rodzina
JOIN opis_uzytkownika ON opis_uzytkownika.rodzina_id = rodzina.id
GROUP BY rodzina.id  
ORDER BY `rodzina`.`id` ASC

CREATE VIEW matuzal AS
SELECT uzytkownik.id, opis_uzytkownika.pseudonim, wiek.wiek
FROM uzytkownik
JOIN opis_uzytkownika ON opis_uzytkownika.id = uzytkownik.id
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
JOIN dane_uzytkownika ON dane_uzytkownika.id = uzytkownik.id
WHERE dane_uzytkownika.data_smierci IS NOT NULL
ORDER BY dane_uzytkownika.data_smierci;
```