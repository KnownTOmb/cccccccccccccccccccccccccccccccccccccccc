CREATE USER 'admin'@'localhost' IDENTIFIED BY RANDOM_PASSWORD();
CREATE USER 'admin_kreator'@'localhost' IDENTIFIED BY RANDOM_PASSWORD();
CREATE USER 'admin_moderator'@'localhost' IDENTIFIED BY RANDOM_PASSWORD();
CREATE USER 'admin_kierownik'@'localhost' IDENTIFIED BY RANDOM_PASSWORD();
CREATE USER 'analityk'@'localhost' IDENTIFIED BY RANDOM_PASSWORD();
CREATE USER 'uzytkownik'@'localhost' IDENTIFIED BY RANDOM_PASSWORD();

GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost';
GRANT SELECT ON matuzal,
    plodnosc_kreatorow_postow,
    plodnosc_parafii,
    plodnosc_tablicy,
    pozycja_modlitwy,
    pozycja_rodziny,
    zmora,
    zmarly_uzytkownik
TO 'analityk'@'localhost';