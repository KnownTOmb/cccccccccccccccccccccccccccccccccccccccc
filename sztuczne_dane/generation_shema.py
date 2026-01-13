from faker import Faker
import random

import config

generation_config = config.config()
def generated_table_data(table_name, generate_table_row_data):
    row_data_to_return = []  
    match table_name:

        # Nie można edytować nic poza:
        # * kod wewnątrz caseów
        # * nazw utworzonych metod w rod_data_to_return po config.(...)
        case "tablica_ogloszeniowa":
            def nazwa():
                fake = Faker()
                Faker.seed()
                return fake.simple_profile()["username"]
            def opis():
                fake = Faker()
                Faker.seed()
                return fake.password()

            row_data_to_return = generate_table_row_data(
                table_name,
                generation_config.tablica_ogloszeniowa.number_of_rows,
                nazwa,
                opis
            )
        
        case "uzytkownik":
            def login():
                fake = Faker()
                Faker.seed()
                return fake.simple_profile()["username"]
            def haslo():
                fake = Faker()
                Faker.seed()
                return fake.password()

            row_data_to_return = generate_table_row_data(
                table_name,
                generation_config.uzytkownik.number_of_rows,
                login,
                haslo
            )

        case "tablica_ogloszeniowa_uzytkownik":
            def uzytkownik_id():
                return random.randint(1, generation_config.uzytkownik.number_of_rows)
            def tablica_ogloszeniowa_id():
                return random.randint(1, generation_config.tablica_ogloszeniowa.number_of_rows)

            row_data_to_return = generate_table_row_data(
                table_name,
                generation_config.tablica_ogloszeniowa_uzytkownik.number_of_rows,
                uzytkownik_id,
                tablica_ogloszeniowa_id
            )
    
    return row_data_to_return