import scripts.tables_internal_data as tables_internal_data
import scripts.data_filler as data_filler


class methods:
    table_names = list(tables_internal_data.tables.keys())
    tables_filled_data = tables_internal_data.tables

    def fill(self):
        for table in self.table_names:
            self.tables_filled_data[table]["data"].append(
                data_filler.fill_table_with_data(table)
            )
    
    def generate(self):
        sql_lines = []
        for table_name, table_info in self.tables_filled_data.items():
            columns = table_info["column"]
            for row in table_info["data"]:
                values = []
                for val in row:
                    if val is None:
                        values.append("NULL")
                    elif isinstance(val, str):
                        escaped = val.replace("'", "''")
                        values.append(f"'{escaped}'")
                    else:
                        values.append(str(val))
                values_str = ", ".join(values)
                columns_str = ", ".join(columns)
                sql_lines.append(f"INSERT INTO {table_name} ({columns_str}) VALUES ({values_str});")

        with open("generated_data.sql", "w", encoding="utf-8") as f:
            f.write("\n".join(sql_lines))