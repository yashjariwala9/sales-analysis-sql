import pandas as pd
import os
import subprocess
import getpass

def convert_excel_to_csv(file_path):
    csv_file = file_path.rsplit(".", 1)[0] + ".csv"
    try:
        df = pd.read_excel(file_path)
        df.to_csv(csv_file, index=False)
        print(f"✅ Converted {file_path} to {csv_file}")
        return csv_file
    except Exception as e:
        print(f"❌ Error converting Excel to CSV: {e}")
        exit(1)

def convert_to_utf8(csv_file):
    utf8_file = csv_file.rsplit(".", 1)[0] + "_utf8.csv"
    try:
        with open(csv_file, 'r', encoding='latin1') as f_in:
            with open(utf8_file, 'w', encoding='utf8') as f_out:
                f_out.write(f_in.read())
        print(f"✅ Converted {csv_file} to UTF-8 as {utf8_file}")
        return utf8_file
    except Exception as e:
        print(f"❌ Error converting CSV to UTF-8: {e}")
        exit(1)

def create_table_and_import(db_user, db_password, db_name, csv_file, table_name):
    # Read the CSV to get the header
    header = pd.read_csv(csv_file, nrows=0).columns
    # Quote column names that contain spaces or other special characters
    columns = ", ".join([f'"{col}" TEXT' for col in header])

    create_table_query = f"CREATE TABLE IF NOT EXISTS {table_name} ({columns});"
    copy_query = f"\\COPY {table_name} FROM '{csv_file}' WITH CSV HEADER DELIMITER ',' ENCODING 'UTF8';"

    os.environ["PGPASSWORD"] = db_password

    try:
        subprocess.run(
            ["psql", "-U", db_user, "-d", db_name, "-c", create_table_query],
            check=True,
        )
        subprocess.run(
            ["psql", "-U", db_user, "-d", db_name, "-c", copy_query],
            check=True,
        )
        print(f"✅ Data imported successfully into the table '{table_name}'.")
    except subprocess.CalledProcessError as e:
        print(f"❌ PostgreSQL error: {e}")
        exit(1)

if __name__ == "__main__":

    db_user = input("Enter PostgreSQL username: ")
    db_password = input("Enter PostgreSQL password: ")
    db_name = input("Enter PostgreSQL database name: ")
    file_path = input("Enter file path (CSV or Excel): ")
    table_name = input("Enter target table name: ")

    if file_path.endswith((".xlsx", ".xls")):
        csv_file = convert_excel_to_csv(file_path)
    else:
        csv_file = file_path

    if not os.path.isfile(csv_file):
        print(f"❌ Error: File '{csv_file}' not found!")
        exit(1)

    # Convert CSV file to UTF-8 if needed
    csv_file = convert_to_utf8(csv_file)

    create_table_and_import(db_user, db_password, db_name, csv_file, table_name)
