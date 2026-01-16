import scripts.tables_internal_data as tables_internal_data
import scripts.data_filler as data_filler


class methods:
    table_names = list(tables_internal_data.tables.keys())
    tables_filled_data = tables_internal_data.tables
    additional_sqls = {}

    def fill(self):
        for table_name in self.table_names:
            self.tables_filled_data[table_name]["data"].append(
                data_filler.fill_table_with_data(table_name, self.additional_sqls)
            )
    
    def generate(self):
        sql_lines = []
        for table_name, table_info in self.tables_filled_data.items():
            columns = table_info["column"]
            columns_str = ", ".join(columns)

            def get_additional_sql(table_name):
                current_additional_sql = ''
                if table_name in self.additional_sqls:
                    current_additional_sql = self.additional_sqls[table_name]
                return current_additional_sql

            if not table_info.get("data"):  # jeśli brak danych, pomijamy tabelę
                continue

            all_values = []
            for row in table_info["data"]:
                # Jeśli row jest listą list (jak u Ciebie)
                if all(isinstance(r, list) for r in row):
                    rows_to_process = row
                else:
                    rows_to_process = [row]

                for single_row in rows_to_process:
                    values = []
                    for val in single_row:
                        if val is None:
                            values.append("NULL")
                        elif isinstance(val, str):
                            escaped = val.replace("'", "''").replace('\n', " ")
                            values.append(f"'{escaped}'")
                        else:
                            values.append(str(val))
                    values_str = ", ".join(values)
                    all_values.append(f"({values_str})")

            
            if all_values:  # tylko jeśli są jakieś wiersze
                sql_lines.append(f"INSERT INTO {table_name} ({columns_str}) VALUES\n" + ",\n".join(all_values) + "\n" + get_additional_sql(table_name) + ";")
            
        with open("../2_initial_data_with_generated_data.sql", "w", encoding="utf-8") as f:
            with open("../domyslne_operacje.sql", encoding="utf-8") as infile:
                for line in infile:
                    f.write(line)
            f.write("\n\n".join(sql_lines))
