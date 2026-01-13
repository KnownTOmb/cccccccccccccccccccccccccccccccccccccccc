from faker import Faker
import random
import datetime

import config

generation_config = config.config()
def generated_table_data(table_name, tables_filled_data, generate_table_row_data, fill_table_row_with_column_data, column_to_replace, already_generated_column_data):
    row_data_to_return = []
    def update_row_with_column_data(column_index, column_data):
        nonlocal  row_data_to_return
        row_data_to_return = fill_table_row_with_column_data(
            column_index,
            column_data,
            row_data_to_return
        )

    def generate_data_for_later_table(later_table_name, later_table_column_index, later_table_column_data):
        already_generated_column_data.setdefault(later_table_name, {})
        already_generated_column_data[later_table_name][later_table_column_index] = later_table_column_data
        
    def get_already_generated_column_data(later_table_name, later_table_column_index):
        return already_generated_column_data[later_table_name][later_table_column_index]
        

    fake = Faker()
    fake_pl = Faker('pl_PL')
    Faker.seed()

    match table_name:

        # Nie można edytować nic poza:
        # * Kodu wewnątrz caseów.
        # * Nazw utworzonych metod w row_data_to_return po config.(...).
        # * Kodu po fragmencie przypisywania danych do row_data_to_return.

        case "tablica_ogloszeniowa":
            def nazwa():
                return f"{fake_pl.domain_word()} {fake_pl.street_name()}"
            def opis():
                return fake_pl.text(max_nb_chars=random.randint(5, 2048+1))

            row_data_to_return = generate_table_row_data(
                generation_config.tablica_ogloszeniowa.number_of_rows,
                nazwa,
                opis
            )
        
        case "uzytkownik":
            def haslo():
                return fake.password()

            row_data_to_return = generate_table_row_data(
                generation_config.uzytkownik.number_of_rows,
                column_to_replace,
                haslo
            )

            def generate_login():
                logins = []
                for i in range(generation_config.uzytkownik.number_of_rows):
                    current_login = ''
                    regenerate = True
                    while regenerate:
                        current_login = fake.unique.simple_profile()["username"]
                        regenerate = current_login in logins

                    logins.append(current_login)

                update_row_with_column_data(
                    0,
                    logins
                )
            
            generate_login()

        case "tablica_ogloszeniowa_uzytkownik":
            def uzytkownik_id():
                return random.randint(1, generation_config.uzytkownik.number_of_rows)
            def tablica_ogloszeniowa_id():
                return random.randint(1, generation_config.tablica_ogloszeniowa.number_of_rows)

            row_data_to_return = generate_table_row_data(
                generation_config.tablica_ogloszeniowa_uzytkownik.number_of_rows,
                uzytkownik_id,
                tablica_ogloszeniowa_id
            )
        
        case "dane_uzytkownika":
            def nazwisko():
                return fake_pl.last_name()
            def numer_telefonu():
                return fake_pl.phone_number()
            
            row_data_to_return = generate_table_row_data(
                generation_config.uzytkownik.number_of_rows,
                column_to_replace,
                nazwisko,
                numer_telefonu,
                column_to_replace,
                column_to_replace,
                column_to_replace,
                column_to_replace
            )

            def generate_imie():
                names = []
                genders = []
                for i in range(generation_config.uzytkownik.number_of_rows):
                    current_name = ''
                    current_gender = fake.passport_gender()
                    match current_gender:
                        case 'K':
                            current_name = fake_pl.first_name_female()
                        
                        case 'M':
                            current_name = fake_pl.first_name_male()

                        case _:
                            current_name = fake_pl.first_name()

                    genders.append(current_gender)
                    names.append(current_name)

                generate_data_for_later_table(
                    "opis_uzytkownika",
                    1,
                    genders
                )
                update_row_with_column_data(
                    0,
                    names
                )

            def generate_data_urodzenia_and_data_smierci():
                def string_to_daytime(string_date):
                    return datetime.datetime.strptime(string_date, '%Y-%m-%d')
                def daytime_to_string(daytime):
                    return daytime.strftime('%Y-%m-%d')
                
                dates_of_birth = []
                dates_of_death = []
                for i in range(generation_config.uzytkownik.number_of_rows):
                    current_date_of_birth = fake_pl.date_of_birth(
                        minimum_age = 40,
                        maximum_age = 120
                    )

                    if random.randint(0, 1):
                        current_date_of_death = daytime_to_string(fake_pl.date_between_dates(
                            current_date_of_birth
                        ))
                    else:
                        current_date_of_death = None

                    dates_of_birth.append(daytime_to_string(current_date_of_birth))
                    dates_of_death.append(current_date_of_death)

                update_row_with_column_data(
                    3,
                    dates_of_birth
                )
                update_row_with_column_data(
                    4,
                    dates_of_death
                )

            def generate_adres_id():
                update_row_with_column_data(
                    5,
                    range(1, generation_config.uzytkownik.number_of_rows+1)
                )
                     
            def generate_uzytkownik_id():
                update_row_with_column_data(
                    6,
                    range(1, generation_config.uzytkownik.number_of_rows+1)
                )

            generate_imie()
            generate_data_urodzenia_and_data_smierci()
            generate_adres_id()
            generate_uzytkownik_id()

        case "rodzina":
            def nazwa():
                return fake_pl.street_name()
            def opis():
                return fake_pl.text(max_nb_chars=random.randint(5, 1024+1))
            
            row_data_to_return = generate_table_row_data(
                generation_config.rodzina.number_of_rows,
                nazwa,
                opis,
            )

        case "modlitwa":
            def nazwa():
                name_to_return = ''
                if random.randint(0, 1):
                    name_to_return = fake_pl.first_name_female()[:-1:]
                    if name_to_return[-1::] in "tdżn":
                        name_to_return += "y"
                    else:
                        name_to_return += "i"
                else:
                     name_to_return = fake_pl.first_name_male()+"a"

                name_to_return = "Do św. "+name_to_return
                return name_to_return
            def tresc():
                return  fake_pl.text(max_nb_chars=random.randint(5, 2048+1)).replace('. ', '.\\n')
            def efekt():
                return fake_pl.text(max_nb_chars=random.randint(5, 128+1))
            
            row_data_to_return = generate_table_row_data(
                generation_config.modlitwa.number_of_rows,
                nazwa,
                tresc,
                efekt,
            )
            
        case "adres":
            def rejon():
                dzielnice = [
                    "Abramowice",
                    "Bronowice",
                    "Czechów Południowy",
                    "Czechów Północny",
                    "Czuby Południowe",
                    "Czuby Północne",
                    "Dziesiąta",
                    "Felin",
                    "Głusk",
                    "Hajdów-Zadębie",
                    "Kalinowszczyzna",
                    "Konstantynów",
                    "Kośminek",
                    "Ponikwoda",
                    "Rury",
                    "Sławin",
                    "Sławinek",
                    "Stare Miasto",
                    "Szerokie",
                    "Śródmieście",
                    "Tatary",
                    "Węglin Południowy",
                    "Węglin Północny",
                    "Wieniawa",
                    "Wrotków",
                    "Za Cukrownią",
                    "Zemborzyce"
                ]

                return random.choice(dzielnice)
            def kod_pocztowy():
                return random.randint(0, 999)
            def ulica():
                street_name = fake_pl.street_prefix_short()
                street_name += ' '+fake_pl.street_name()

                return street_name
            def numer_budynku():
                return random.randint(0, 999)
            def numer_mieszkania():
                apartment_number = 0
                if random.randint(0, 1):
                    apartment_number = None
                else:
                    apartment_number = random.randint(0, 100)
                
                return apartment_number

            row_data_to_return = generate_table_row_data(
                generation_config.uzytkownik.number_of_rows,
                rejon,
                kod_pocztowy,
                ulica,
                numer_budynku,
                numer_mieszkania,
            )

        case "proboszcz":
            def imie():
                return fake_pl.first_name_male()
            def nazwisko():
                return fake_pl.last_name_male()
            
            row_data_to_return = generate_table_row_data(
                generation_config.proboszcz.number_of_rows,
                imie,
                nazwisko,
            )
            
        case "parafia":
            row_data_to_return = generate_table_row_data(
                generation_config.proboszcz.number_of_rows,
                column_to_replace,
                column_to_replace,
            )

            def generate_nazwa():
                names = []
                for i in range(generation_config.proboszcz.number_of_rows):
                    name_prefix = [
                        "Parafia",
                        "Parafia Rzymskokatolicka",
                        "Kościół",
                        "Kościół Rzymskokatolicki",
                        "Sanktuarium",
                        "Bazylika",
                        "Archikatedra",
                        "Katedra",
                        "Kolegiata",
                        "Kaplica",
                        "Klasztor",
                        "Opactwo",
                        "Dom Zakonny",
                        "Zgromadzenie",
                        "Misja",
                        "Rektorat"
                    ]

                    name = ''
                    if random.randint(0, 1):
                        name = fake_pl.first_name_female()[:-1:]
                        if name[-1::] in "tdżn":
                            name += "y"
                        else:
                            name += "i"
                    else:
                        name = fake_pl.first_name_male()+"a"

                    name = "św. "+name
                    name = random.choice(name_prefix)+" "+name

                    names.append(name)
                
                update_row_with_column_data(
                    0,
                    names
                )
            def generate_proboszcz_id():
                update_row_with_column_data(
                    1,
                    range(1, generation_config.proboszcz.number_of_rows+1)
                )

            generate_nazwa()
            generate_proboszcz_id()

        case "opis_uzytkownika":
            def pseudonim():
                return fake.simple_profile()["username"]
            def opis():
                return fake_pl.text(max_nb_chars=random.randint(5, 1024+1))
            def parafia_id():
                return random.randint(1, generation_config.proboszcz.number_of_rows+1)
            def rodzina_id():
                return random.randint(1, generation_config.rodzina.number_of_rows+1)
            def zdjecie_profilowe():
                return 1
            def ulubiona_modlitwa_id():
                return random.randint(1, generation_config.modlitwa.number_of_rows+1)
            
            row_data_to_return = generate_table_row_data(
                generation_config.uzytkownik.number_of_rows,
                column_to_replace,
                column_to_replace,
                pseudonim,
                opis,
                parafia_id,
                rodzina_id,
                zdjecie_profilowe,
                ulubiona_modlitwa_id
            )

            def generate_uzytkownik_id():
                update_row_with_column_data(
                    0,
                    range(0, generation_config.uzytkownik.number_of_rows+1)
                )
            def generate_plec():
                update_row_with_column_data(
                    1,
                    get_already_generated_column_data(table_name, 1,)
                )

            generate_uzytkownik_id()
            generate_plec()
    
    return row_data_to_return