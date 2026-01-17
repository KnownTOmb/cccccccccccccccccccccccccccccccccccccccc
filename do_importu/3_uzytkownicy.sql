-- Usuwanie istniejących użytkowników

DROP USER IF EXISTS 'admin'@'localhost';
DROP USER IF EXISTS 'admin_kreator'@'localhost';
DROP USER IF EXISTS 'admin_moderator'@'localhost';
DROP USER IF EXISTS 'admin_kierownik'@'localhost';
DROP USER IF EXISTS 'analityk'@'localhost';
DROP USER IF EXISTS 'uzytkownik'@'localhost';

-- Tworzenie użytkowników

CREATE USER 'admin'@'localhost' IDENTIFIED BY '`\\-_PI[Q[`j#qU5)4zbW1Zw';
CREATE USER 'admin_kreator'@'localhost' IDENTIFIED BY 'Z^2p_$}[C\8R-D`WS5[kYyJe'
WITH MAX_QUERIES_PER_HOUR 50
MAX_UPDATES_PER_HOUR 25
MAX_CONNECTIONS_PER_HOUR 10
MAX_USER_CONNECTIONS 1;
CREATE USER 'admin_moderator'@'localhost' IDENTIFIED BY 'pz)-46C2d5x)Y`Z%naDOIcF_'
WITH MAX_QUERIES_PER_HOUR 50
MAX_UPDATES_PER_HOUR 25
MAX_CONNECTIONS_PER_HOUR 10
MAX_USER_CONNECTIONS 1;
CREATE USER 'admin_kierownik'@'localhost' IDENTIFIED BY 'Ej_]lwYG)@#0{%F%-;\q+Kqr'
WITH MAX_QUERIES_PER_HOUR 50
MAX_UPDATES_PER_HOUR 25
MAX_CONNECTIONS_PER_HOUR 10
MAX_USER_CONNECTIONS 1;
CREATE USER 'analityk'@'localhost' IDENTIFIED BY 'V*KFV/_3?B94@7H-cM}zgif'
WITH MAX_QUERIES_PER_HOUR 100
MAX_UPDATES_PER_HOUR 0
MAX_CONNECTIONS_PER_HOUR 10
MAX_USER_CONNECTIONS 1;
CREATE USER 'uzytkownik'@'localhost' IDENTIFIED BY 'Od}s$CFP]6W_k5#Es2Z-`VQW'
WITH MAX_QUERIES_PER_HOUR 5000
MAX_UPDATES_PER_HOUR 0
MAX_CONNECTIONS_PER_HOUR 500
MAX_USER_CONNECTIONS 500;

-- Przyznawanie uprawnień

GRANT ALL PRIVILEGES ON *.*
TO 'admin'@'localhost';

GRANT SELECT ON smipegs_lublin.matuzal TO 'analityk'@'localhost';
GRANT SELECT ON smipegs_lublin.plodnosc_kreatorow_postow TO 'analityk'@'localhost';
GRANT SELECT ON smipegs_lublin.plodnosc_parafii TO 'analityk'@'localhost';
GRANT SELECT ON smipegs_lublin.plodnosc_tablicy TO 'analityk'@'localhost';
GRANT SELECT ON smipegs_lublin.pozycja_modlitwy TO 'analityk'@'localhost';
GRANT SELECT ON smipegs_lublin.pozycja_rodziny TO 'analityk'@'localhost';
GRANT SELECT ON smipegs_lublin.zmora TO 'analityk'@'localhost';
GRANT SELECT ON smipegs_lublin.zmarly_uzytkownik TO 'analityk'@'localhost';

GRANT INSERT, SELECT ON smipegs_lublin.ogloszenie TO 'admin_kreator'@'localhost';

GRANT DELETE, UPDATE, SELECT ON smipegs_lublin.ogloszenie TO 'admin_moderator'@'localhost';

GRANT SELECT ON smipegs_lublin.tablica_ogloszeniowa TO 'admin_kierownik'@'localhost';
GRANT INSERT, UPDATE, DELETE, SELECT ON smipegs_lublin.tablica_ogloszeniowa_uzytkownik TO 'admin_kierownik'@'localhost';
GRANT INSERT, UPDATE, DELETE, SELECT ON smipegs_lublin.uprawnienie TO 'admin_kierownik'@'localhost';


GRANT SELECT ON smipegs_lublin.adres TO 'uzytkownik'@'localhost';
GRANT SELECT ON smipegs_lublin.dane_uzytkownika TO 'uzytkownik'@'localhost';
GRANT SELECT ON smipegs_lublin.kod_pocztowy TO 'uzytkownik'@'localhost';
GRANT SELECT ON smipegs_lublin.modlitwa TO 'uzytkownik'@'localhost';
GRANT SELECT ON smipegs_lublin.obrazek TO 'uzytkownik'@'localhost';
GRANT SELECT ON smipegs_lublin.ogloszenie TO 'uzytkownik'@'localhost';
GRANT SELECT ON smipegs_lublin.opis_uzytkownika TO 'uzytkownik'@'localhost';
GRANT SELECT ON smipegs_lublin.parafia TO 'uzytkownik'@'localhost';
GRANT SELECT ON smipegs_lublin.pokrewienstwo TO 'uzytkownik'@'localhost';
GRANT SELECT ON smipegs_lublin.proboszcz TO 'uzytkownik'@'localhost';
GRANT SELECT ON smipegs_lublin.rodzina TO 'uzytkownik'@'localhost';
GRANT SELECT ON smipegs_lublin.rodzina_wzeniona TO 'uzytkownik'@'localhost';
GRANT SELECT ON smipegs_lublin.tablica_ogloszeniowa TO 'uzytkownik'@'localhost';
GRANT SELECT ON smipegs_lublin.tablica_ogloszeniowa_uzytkownik TO 'uzytkownik'@'localhost';
GRANT SELECT ON smipegs_lublin.uprawnienie TO 'uzytkownik'@'localhost';
GRANT SELECT ON smipegs_lublin.url_obrazka TO 'uzytkownik'@'localhost';
GRANT SELECT ON smipegs_lublin.uzytkownik TO 'uzytkownik'@'localhost';
GRANT SELECT ON smipegs_lublin.wiek TO 'uzytkownik'@'localhost';
GRANT SELECT ON smipegs_lublin.sygnatura TO 'uzytkownik'@'localhost';

-- Zastosowanie zmian

FLUSH PRIVILEGES;
