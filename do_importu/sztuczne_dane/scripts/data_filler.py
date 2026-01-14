import generation_shema

class data_filler_context:
    def __init__(self):
        self.already_generated_column_data = {}

default_context = data_filler_context()
def fill_table_with_data(table_name, context: data_filler_context = default_context):
    def generate_table_row_data(number_of_rows, *current_column_data_generation_methods):
        table_rows_to_return = []
        for i in range(1, number_of_rows+1):
            column_data_to_put_into_current_table_row = []
            for current_column_data_generation_method in current_column_data_generation_methods:
                column_data_to_put_into_current_table_row.append(
                    current_column_data_generation_method()
                )
                
            table_rows_to_return.append(
                column_data_to_put_into_current_table_row
            )

        return table_rows_to_return
    
    def fill_table_row_with_column_data(column_index, column_data, filled_table_rows):
        table_rows_to_return = []
        for filled_table_row_index in range(len(filled_table_rows)):
            current_data_column_data = column_data[filled_table_row_index]

            current_row = filled_table_rows[filled_table_row_index]
            current_row[column_index] = current_data_column_data

            table_rows_to_return.append(
                current_row
            )
        return table_rows_to_return

    return generation_shema.generated_table_data(
        table_name,
        generate_table_row_data,
        fill_table_row_with_column_data,
        lambda: None,
        context.already_generated_column_data
    )
            



            