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
                profile_pictures_id = []

                for row_index in range(0, generation_config.uzytkownik.number_of_rows):
                    current_profile_picture_id = None
                    if random.random() <= 0.25:
                        current_profile_picture_id = 1
                    else:
                        if random.random() <= 0.25:
                            image_alt_texts.append(None)
                        else:
                            image_alt_texts.append(fake_pl.text(max_nb_chars=random.randint(5, 128+1)))
                        current_profile_picture_id = len(image_alt_texts) + 1
                    
                    profile_pictures_id.append(current_profile_picture_id)

                update_row_with_column_data(
                    0,
                    profile_pictures_id
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

        case "pokrewienstwo":
            def get_user_gender(user_id):
                user_gender = get_already_generated_column_data(
                    "opis_uzytkownika",
                    1
                )[user_id].replace("X", "F")

                return user_gender
            def generate_user_relation_type(user_id):
                possible_relation_types = {
                    "M": [
                        "ojciec",
                        "syn",
                        "brat",
                        "wujek",
                        "siostrzeniec",
                        "bratanek",
                        "kuzyn",
                        "dziadek",
                        "wnuk",
                        "ojczym",
                        "pasierb",
                        "szwagier",
                        "teść",
                        "zięć",
                        "mąż",
                    ],
                    "F": [
                        "mama",
                        "córka",
                        "siostra",
                        "ciotka",
                        "siostrzenica",
                        "bratanica",
                        "kuzynka",
                        "babcia",
                        "wnuczka",
                        "macocha",
                        "pasierbica",
                        "szwagierka",
                        "teściowa",
                        "synowa",
                        "żona"
                    ]
                }

                number_of_posible_relation_types = {
                    "M": len(possible_relation_types["M"]),
                    "F": len(possible_relation_types["F"])
                }

                user_gender = get_user_gender(user_id)
                return possible_relation_types[user_gender][random.randint(0, number_of_posible_relation_types[user_gender])]
            def get_reflection_of_relation_type(gender_of_reflected_relation_type, unreflected_relation_type):
                reflection_of_relation_type = {
                    "mama":        {"M": "syn",         "F": "córka"},
                    "ojciec":      {"M": "syn",         "F": "córka"},
                    "córka":       {"M": "ojciec",      "F": "matka"},
                    "syn":         {"M": "ojciec",      "F": "matka"},
                    "siostra":     {"M": "brat",        "F": "siostra"},
                    "brat":        {"M": "brat",        "F": "siostra"},
                    "ciotka":      {"M": "siostrzeniec","F": "siostrzenica"},
                    "wujek":       {"M": "bratanek",    "F": "bratanica"},
                    "siostrzenica":{"M": "wujek",       "F": "ciotka"},
                    "bratanica":   {"M": "wujek",       "F": "ciotka"},
                    "siostrzeniec":{"M": "wujek",       "F": "ciotka"},
                    "bratanek":    {"M": "wujek",       "F": "ciotka"},
                    "kuzyn":       {"M": "kuzyn",       "F": "kuzynka"},
                    "kuzynka":     {"M": "kuzyn",       "F": "kuzynka"},
                    "babcia":      {"M": "wnuk",        "F": "wnuczka"},
                    "dziadek":     {"M": "wnuk",        "F": "wnuczka"},
                    "wnuczka":     {"M": "dziadek",     "F": "babcia"},
                    "wnuk":        {"M": "dziadek",     "F": "babcia"},
                    "ojczym":      {"M": "pasierb",     "F": "pasierbica"},
                    "macocha":     {"M": "pasierb",     "F": "pasierbica"},
                    "pasierb":     {"M": "ojczym",      "F": "macocha"},
                    "pasierbica":  {"M": "ojczym",      "F": "macocha"},
                    "szwagier":    {"M": "szwagier",    "F": "szwagierka"},
                    "szwagierka":  {"M": "szwagier",    "F": "szwagierka"},
                    "teść":        {"M": "zięć",        "F": "synowa"},
                    "teściowa":    {"M": "zięć",        "F": "synowa"},
                    "zięć":        {"M": "teść",        "F": "teściowa"},
                    "synowa":      {"M": "teść",        "F": "teściowa"},
                    "mąż":         {"M": "mąż",         "F": "żona"},
                    "żona":        {"M": "mąż",         "F": "żona"}
                }

                return reflection_of_relation_type[unreflected_relation_type][gender_of_reflected_relation_type]

            relation_types = []
            related_users_id = []

            users_id = list(range(1, generation_config.uzytkownik.number_of_rows))
            random.shuffle(users_id)

            for current_row in range(0, generation_config.uzytkownik.number_of_rows-1, 2):
                current_user = users_id[current_row]
                current_relation_type = generate_user_relation_type(current_user)
                current_related_user_id = users_id[current_row+1]

                next_user_id = current_related_user_id
                next_related_user_id = current_user
                next_relation_type = get_reflection_of_relation_type(
                    get_user_gender(next_user_id),
                    current_relation_type
                )

                relation_types.append(current_relation_type)
                related_users_id.append(current_related_user_id)
                
                relation_types.append(next_relation_type)
                related_users_id.append(next_related_user_id)

            row_data_to_return = generate_table_row_data(
                column_to_replace,
                column_to_replace,
                column_to_replace
            )

            def generate_relation_type():
                update_row_with_column_data(
                    0,
                    relation_types
                )
            def generate_user_id():
                update_row_with_column_data(
                    0,
                    users_id
                )
            def generate_related_user_id():
                update_row_with_column_data(
                    0,
                    related_users_id
                )

            generate_relation_type()
            generate_user_id()
            generate_related_user_id()

        
        case "tablica_ogloszeniowa_uzytkownik":
            def check_if_user_already_is_in_the_board(user_id, board_id, users_id, boards_id):
                user_exists_in_board = False
                for row_index in range(len(users_id)):
                    current_user_id = users_id[row_index]
                    current_board_id = boards_id[row_index]

                    user_exists_in_board = user_id == current_user_id and board_id == current_board_id
                    if user_exists_in_board:
                        return True       
            def check_if_user_is_first_user_in_the_board(user_id, board_id, users_id, boards_id):
                user_is_first_user_in_the_board = False
                for row_index in range(len(users_id)):
                    current_user_id = users_id[row_index]
                    current_board_id = boards_id[row_index]

                    another_user_is_first_user_in_the_board = user_id != current_user_id and board_id == current_board_id
                    if another_user_is_first_user_in_the_board:
                        return False
                    
                    user_is_first_user_in_the_board = user_id == current_user_id and board_id == current_board_id
                    if user_is_first_user_in_the_board:
                        return True
            
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
            }
            for row_index in range(generation_config.tablica_ogloszeniowa_uzytkownik.number_of_rows):
                current_user_id = None
                current_board_id = None
                user_exists_in_table = True
                while user_exists_in_table:                  
                    current_user_id = uzytkownik_id()
                    current_board_id = tablica_ogloszeniowa_id()
                    user_exists_in_table = check_if_user_already_is_in_the_board(current_user_id, current_board_id, users_id, boards_id)

                users_id.append(current_user_id)
                boards_id.append(current_board_id)

                current_permission_role = None
                if check_if_user_is_first_user_in_the_board(current_user_id, current_board_id, users_id, boards_id):
                    current_permission_role = 'zarządzanie użytkownikami'
                elif random.random() <= 0.05:
                    current_permission_role = 'moderator postów'
                elif random.random() <= 0.25:
                    current_permission_role ='kreator postów'
                    for posts_row_index in range(random.randint(1, 6)):
                        posts["autor_id"].append(current_user_id)
                        posts["tablica_ogloszeniowa_id"].append(current_board_id)

                else:
                    current_permission_role = 'obserwator postów'
            
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
            def generate_ogloszenie(posts):
                generate_data_for_later_table(
                    'ogloszenie',
                    0,
                    posts['autor_id']
                )
                generate_data_for_later_table(
                    'ogloszenie',
                    1,
                    posts['tablica_ogloszeniowa_id']
                )

            generate_uzytkownik_id(users_id)
            generate_tablica_ogloszeniowa_id(boards_id)

            generate_uprawnienie(permissions)
            generate_ogloszenie(posts)
                
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

        case "ogloszenie":
            def tytul():
                return fake_pl.sentence(nb_words=random.randint(3, 7))
            def data_wstawienia():
                return fake_pl.date_between(
                    start_date='-10y',

                ).strftime('%Y-%m-%d')
            def tresc():
                return fake_pl.text(
                    max_nb_chars=random.randint(20, 1024)
                )
            def archiwalny():
                return 1 if random.random() <= 0.1 else 0

            row_data_to_return = generate_table_row_data(
                len(get_already_generated_table(table_name)[0]),
                tytul,
                data_wstawienia,
                tresc,
                column_to_replace,
                column_to_replace,
                column_to_replace,
                archiwalny
            )

            image_alt_texts = get_already_generated_column_data('obrazek', 0)

            def generate_autor_id():
                update_row_with_column_data(
                    3,
                    get_already_generated_column_data(
                        table_name,
                        0
                    )
                )
            def generate_tablica_ogloszeniowa_id():
                update_row_with_column_data(
                    4,
                    get_already_generated_column_data(
                        table_name,
                        1
                    )
                )
            def generate_obrazek_id():
                images_id = []

                for row_index in range(0, generation_config.uzytkownik.number_of_rows):
                    current_image_id = None
                    if random.random() <= 0.25:
                        current_profile_picture_id = 1
                    else:
                        if random.random() <= 0.25:
                            image_alt_texts.append(None)
                        else:
                            image_alt_texts.append(fake_pl.text(max_nb_chars=random.randint(5, 128+1)))
                        current_image_id = len(image_alt_texts) + 1
                    
                    images_id.append(current_image_id)

                update_row_with_column_data(
                    5,
                    images_id
                )

            def generate_obrazek():
                generate_data_for_later_table(
                    'obrazek',
                    0,
                    image_alt_texts
                )

            generate_autor_id()
            generate_tablica_ogloszeniowa_id()
            generate_obrazek_id()

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

    return row_data_to_return