class config:
    class tablica_ogloszeniowa_definition:
        number_of_rows = 20
    class tablica_ogloszeniowa_uzytkownik_definition:
        number_of_rows = 150
    class uzytkownik_definition:
        number_of_rows = 300
    class rodzina_definition:
        number_of_rows = 10
    class parafia_definition:
        number_of_rows = 100
    class modlitwa_definition:
        number_of_rows = 35

    tablica_ogloszeniowa = tablica_ogloszeniowa_definition()
    tablica_ogloszeniowa_uzytkownik = tablica_ogloszeniowa_uzytkownik_definition()
    uzytkownik = uzytkownik_definition()
    rodzina = rodzina_definition()
    parafia = parafia_definition()
    modlitwa = modlitwa_definition()