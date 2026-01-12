import re
from pathlib import Path


def normalize_types(sql: str) -> str:
    sql = re.sub(r'SMALLINT\(\d+\)', 'SMALLINT', sql)
    sql = re.sub(r'TINYINT\(\d+\)', 'TINYINT', sql)
    return sql


def extract_tables(sql: str):
    """
    Zwraca:
    {
      table_name: {
        "columns": [(name, definition)],
        "raw": "..."
      }
    }
    """
    tables = {}
    pattern = re.compile(
        r'CREATE TABLE IF NOT EXISTS\s+`?(\w+)`?\.`?(\w+)`?\s*\((.*?)\)\s*ENGINE',
        re.S | re.I
    )

    for schema, table, body in pattern.findall(sql):
        columns = []
        for line in body.splitlines():
            line = line.strip().rstrip(',')
            if not line or line.upper().startswith(("PRIMARY", "UNIQUE", "INDEX", "KEY")):
                continue
            col = re.match(r'`?(\w+)`?\s+(.*)', line)
            if col:
                columns.append((col.group(1), col.group(2)))
        tables[table] = {"columns": columns}

    return tables


def build_foreign_keys(table, columns, known_tables):
    fks = []
    for name, _ in columns:
        if name.endswith("_id") and name != "id":
            ref = name[:-3]
            if ref in known_tables:
                fks.append(
                    f"  FOREIGN KEY ({name}) REFERENCES {ref}(id)"
                )
    return fks


def convert_mysql_to_mariadb(sql: str) -> str:
    sql = normalize_types(sql)

    sql = re.sub(r'--.*\n', '', sql)
    sql = re.sub(r'`', '', sql)
    sql = re.sub(
        r'CREATE SCHEMA IF NOT EXISTS (\w+) DEFAULT CHARACTER SET \w+ ;',
        r'CREATE DATABASE IF NOT EXISTS \1 CHARACTER SET utf8mb4;',
        sql
    )
    sql = re.sub(r'USE (\w+) ;', r'USE \1;', sql)

    tables = extract_tables(sql)
    known_tables = set(tables.keys())

    output = []
    output.append("CREATE DATABASE IF NOT EXISTS mydb CHARACTER SET utf8mb4;")
    output.append("USE mydb;")
    output.append("SET FOREIGN_KEY_CHECKS=0;\n")

    for table, data in tables.items():
        output.append(f"-- -----------------------------------------------------")
        output.append(f"-- Table mydb.{table}")
        output.append(f"-- -----------------------------------------------------")
        output.append(f"CREATE TABLE IF NOT EXISTS mydb.{table} (")

        col_lines = [
            f"  {name} {definition}"
            for name, definition in data["columns"]
        ]

        col_lines.append("  PRIMARY KEY (id)")

        fk_lines = build_foreign_keys(table, data["columns"], known_tables)
        col_lines.extend(fk_lines)

        output.append(",\n".join(col_lines))
        output.append(") ENGINE = InnoDB;\n")

    output.append("SET FOREIGN_KEY_CHECKS=1;")
    return "\n".join(output)


def main():
    input_file = Path("test.sql")
    output_file = Path("gotowe.sql")

    sql = input_file.read_text(encoding="utf-8")
    converted = convert_mysql_to_mariadb(sql)
    output_file.write_text(converted, encoding="utf-8")

    print("Konwersja zakonczona: mariadb.sql")


if __name__ == "__main__":
    main()
