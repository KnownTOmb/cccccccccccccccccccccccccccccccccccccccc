import config

def generated_table_data(table_name, generate_table_row_data):
    row_data_to_return = []
    match table_name:

        # Nie można edytować nic poza:
        # * kod wewnątrz caseów
        # * nazw utworzonych metod w rod_data_to_return po config.(...)
        case "tablica_ogloszeniowa":
            def login():
                return "A"
            def haslo():
                return "B"

            row_data_to_return = generate_table_row_data(
                table_name,
                config.number_of_rows,
                login,
                haslo
            )
    
    return row_data_to_return