tables = {
    "tablica_ogloszeniowa": {
        "column": [
            "nazwa",
            "opis"
        ],
        "data": []
    },
    
    "uzytkownik": {
        "column": [
            "login",
            "haslo"
        ],
        "data": []
    },

    "tablica_ogloszeniowa_uzytkownik": {
        "column": [
            "uzytkownik_id",
            "tablica_ogloszeniowa_id"
        ],
        "data": []
    },

    "dane_uzytkownika": {
        "column": [
            "imie",
            "nazwisko",
            "numer_telefonu",
            "data_urodzenia",
            "data_smierci",
            "adres_id",
            "uzytkownik_id"
        ],
        "data": []
    },

    "rodzina": {
        "column": [
            "nazwa",
            "opis"
        ],
        "data": []
    },

    "modlitwa": {
        "column": [
            "nazwa",
            "tresc",
            "efekt"
        ],
        "data": []
    },

    "proboszcz": {
        "column": [
            "imie",
            "nazwisko"
        ],
        "data": []
    },

    "parafia": {
        "column": [
            "nazwa",
            "proboszcz_id"
        ],
        "data": []
    },

    "opis_uzytkownika": {
        "column": [
            "uzytkownik_id",
            "plec",
            "pseudonim",
            "opis",
            "parafia_id",
            "rodzina_id",
            "zdjecie_profilowe_id",
            "ulubiona_modlitwa_id"
        ],
        "data": []
    },

    "pokrewienstwo": {
        "column": [
            "typ_relacji",
            "widzi_dane_osobowe",
            "uzytkownik_id",
            "spokrewiony_uzytkownik_id"
        ],
        "data": []
    },

    "ogloszenie": {
        "column": [
            "tytul",
            "data_wstawienia",
            "tresc",
            "autor_id",
            "tablica_ogloszeniowa_id",
            "obrazek_id",
            "archiwalny"
        ],
        "data": []
    },

    "obrazek": {
        "column": [
            "tekst_alternatywny"
        ],
        "data": []
    },

    "uprawnienie": {
        "column": [
            "rola",
            "tablica_ogloszeniowa_id",
            "uzytkownik_id"
        ],
        "data": []
    }
}
