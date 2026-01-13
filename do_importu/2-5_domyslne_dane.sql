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

