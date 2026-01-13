class config:
    class tablica_ogloszeniowa_definition:
        number_of_rows = 20
    class tablica_ogloszeniowa_uzytkownik_definition:
        number_of_rows = 150
    class uzytkownik_definition:
        number_of_rows = 300

    tablica_ogloszeniowa = tablica_ogloszeniowa_definition()
    tablica_ogloszeniowa_uzytkownik = tablica_ogloszeniowa_uzytkownik_definition()
    uzytkownik = uzytkownik_definition()