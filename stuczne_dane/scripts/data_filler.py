import generation_shema

def fill_table_with_data(table_name):
    def generate_table_row_data(current_table_name, number_of_rows, *current_column_data_generation_methods):
        current_table_rows_to_return = []
        for i in range(1, number_of_rows+1):
            column_data_to_put_into_current_table_row = []
            for current_column_data_generation_method in current_column_data_generation_methods:
                column_data_to_put_into_current_table_row.append(
                    current_column_data_generation_method()
                )
                
            current_table_rows_to_return.append(
                column_data_to_put_into_current_table_row
            )

        return current_table_rows_to_return

    return generation_shema.generated_table_data(table_name, generate_table_row_data)
            



            