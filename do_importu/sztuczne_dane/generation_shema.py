from faker import Faker
import random
import datetime

import config

generation_config = config.config()
def generated_table_data(table_name, generate_table_row_data, fill_table_row_with_column_data, column_to_replace, already_generated_column_data):
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
    
    def check_if_already_filled_table_data_exists(table_name):
        return table_name in already_generated_column_data
    
    def get_already_generated_table(table_name):
        return already_generated_column_data[table_name]
        

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

        case "opis_uzytkownika":
            def pseudonim():
                return fake.simple_profile()["username"]
            def opis():
                return fake_pl.text(max_nb_chars=random.randint(5, 1024+1))
            def parafia_id():
                return random.randint(1, generation_config.proboszcz.number_of_rows+1)
            def rodzina_id():
                return random.randint(1, generation_config.rodzina.number_of_rows+1)
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
                column_to_replace,
                ulubiona_modlitwa_id
            )

            image_alt_texts = []

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
            
            def generate_zdjecie_profilowe():
                profile_pictures = []

                for row_index in range(0, generation_config.uzytkownik.number_of_rows):
                    current_profile_picture = None
                    if random.random() <= 0.25:
                        current_profile_picture = 1
                    else:
                        image_alt_texts.append(fake_pl.text(max_nb_chars=random.randint(5, 128+1)))
                        current_profile_picture = len(image_alt_texts) + 1
                    
                    profile_pictures.append(current_profile_picture)

                update_row_with_column_data(
                    0,
                    profile_pictures
                )

            
            def generate_obrazek():
                generate_data_for_later_table(
                    'obrazek',
                    0,
                    image_alt_texts
                )

            generate_uzytkownik_id()
            generate_plec()
            generate_zdjecie_profilowe()
            generate_obrazek()

        case "tablica_ogloszeniowa_uzytkownik":
            def check_if_user_already_is_in_the_board(user_id, board_id):
                tablica_ogloszeniowa_uzytkownik_number_of_rows = 0
                if check_if_already_filled_table_data_exists(table_name):
                    tablica_ogloszeniowa_uzytkownik_number_of_rows = len(get_already_generated_table(table_name)[0])

                user_exists_in_board = False
                for row_index in range(tablica_ogloszeniowa_uzytkownik_number_of_rows):
                    current_user_id = get_already_generated_table(table_name)[0][row_index]
                    current_board_id = get_already_generated_table(table_name)[1][row_index]

                    user_exists_in_board = user_id == current_user_id and board_id == current_board_id
                    if user_exists_in_board:
                        break
                return user_exists_in_board         
            def check_if_user_is_first_user_in_the_board(user_id, board_id):
                tablica_ogloszeniowa_uzytkownik_number_of_rows = 0
                if check_if_already_filled_table_data_exists(table_name):
                    tablica_ogloszeniowa_uzytkownik_number_of_rows = len(get_already_generated_table(table_name)[0])

                user_is_first_user_in_the_board = False
                for row_index in range(tablica_ogloszeniowa_uzytkownik_number_of_rows):
                    current_user_id = get_already_generated_table(table_name)[0][row_index]
                    current_board_id = get_already_generated_table(table_name)[1][row_index]

                    user_is_first_user_in_the_board = user_id == current_user_id and board_id == current_board_id
                    if user_is_first_user_in_the_board:
                        break
                return user_is_first_user_in_the_board
            
            def uzytkownik_id():
                return random.randint(1, generation_config.uzytkownik.number_of_rows)
            def tablica_ogloszeniowa_id():
                return random.randint(2, generation_config.tablica_ogloszeniowa.number_of_rows)
            
            row_data_to_return = generate_table_row_data(
                generation_config.tablica_ogloszeniowa_uzytkownik.number_of_rows,
                column_to_replace,
                column_to_replace
            )

            users_id = []
            boards_id = []
            permissions = {
                "rola": [],
                "tablica_ogloszeniowa_id": [],
                "uzytkownik_id": []
            }
            posts = {
                "autor_id": [],
                "tablica_ogloszeniowa_id": [],
                "obrazek_id": []
            }
            for row_index in range(generation_config.tablica_ogloszeniowa_uzytkownik.number_of_rows):
                current_user_id = None
                current_board_id = None
                user_exists_in_table = True
                while user_exists_in_table:                  
                    current_user_id = uzytkownik_id()
                    current_board_id = tablica_ogloszeniowa_id()
                    user_exists_in_table = check_if_user_already_is_in_the_board(current_user_id, current_board_id)

                current_permission_role = None
                if check_if_user_is_first_user_in_the_board(current_user_id, current_board_id):
                    current_permission_role = 'zarządzanie postami i użytkownikami'
                elif random.random() <= 0.05:
                    current_permission_role = 'moderator postów'
                elif random.random() <= 0.25:
                    current_permission_role ='kreator postów'
                    for row_index in range(1, random(1, 6)+1):
                        posts["autor_id"].append(current_user_id)
                        posts["tablica_ogloszeniowa_id"].append(current_board_id)
                        
                else:
                    current_permission_role = 'obserwator postów'

                users_id.append(current_user_id)
                boards_id.append(current_board_id)
            
                permissions["rola"].append(current_permission_role)
                permissions["tablica_ogloszeniowa_id"].append(current_board_id)
                permissions["uzytkownik_id"].append(current_user_id)

            def generate_uzytkownik_id(users_id):
                update_row_with_column_data(
                    0,
                    users_id
                )
            def generate_tablica_ogloszeniowa_id(boards_id):
                update_row_with_column_data(
                    1,
                    boards_id
                )
            def generate_uprawnienie(permissions):
                generate_data_for_later_table(
                    'uprawnienie',
                    0,
                    permissions['rola']
                )
                generate_data_for_later_table(
                    'uprawnienie',
                    1,
                    permissions['tablica_ogloszeniowa_id']
                )
                generate_data_for_later_table(
                    'uprawnienie',
                    2,
                    permissions['uzytkownik_id']
                )

            generate_uzytkownik_id(users_id)
            generate_tablica_ogloszeniowa_id(boards_id)

            generate_uprawnienie(permissions)
                
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

        case "obrazek":
            row_data_to_return = generate_table_row_data(
                len(get_already_generated_table(table_name)[0]),
                column_to_replace,
            )

            def generate_alt_text():
                update_row_with_column_data(
                    0,
                    get_already_generated_column_data(table_name, 0)
                )

            generate_alt_text()

        case "uprawnienie":
            row_data_to_return = generate_table_row_data(
                len(get_already_generated_table(table_name)[0]),
                column_to_replace,
                column_to_replace,
                column_to_replace
            )

            def generate_rola():
                update_row_with_column_data(
                    0,
                    get_already_generated_column_data(table_name, 0)
                )
            def generate_tablica_ogloszeniowa_id():
                update_row_with_column_data(
                    1,
                    get_already_generated_column_data(table_name, 1)
                )
            def generate_uzytkownik_id():
                update_row_with_column_data(
                    2,
                    get_already_generated_column_data(table_name, 2)
                )

            generate_rola()
            generate_tablica_ogloszeniowa_id()
            generate_uzytkownik_id()

    return row_data_to_return