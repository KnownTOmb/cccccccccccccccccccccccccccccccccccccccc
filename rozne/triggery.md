```sql
CREATE TRIGGER po_wstawieniu_do_uzytkownik
AFTER INSERT ON uzytkownik
FOR EACH ROW
INSERT INTO tablica_ogloszeniowa_uzytkownik (uzytkownik_id, tablica_ogloszeniowa_id)
VALUES (NEW.id, 1);

CREATE TRIGGER po_wstawieniu_do_tablica_ogloszeniowa_uzytkownik
AFTER INSERT ON tablica_ogloszeniowa_uzytkownik
FOR EACH ROW 
INSERT INTO uprawnienie (rola,tablica_ogloszeniowa_id,uzytkownik_id)
VALUES ('obserwator postow',NEW.tablica_ogloszeniowa_id,NEW.uzytkownik_id)
```
