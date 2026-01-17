```sql
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
```