from src.extract import extract_csv
from src.transform import execute_transformations
from src.load import load_dataframe_to_sqlite, execute_sql_file
from src.helpers import load_config


def main():
    """
    Main function to orchestrate the ETL process.

    Steps: 1. Load configuration
           2. Extract data from CSV
           3. Transform the data
           4. Load the transformed data into SQLite

    """
    
    config = load_config()

    raw_df = extract_csv(config.csv_path)

    transformed_df = execute_transformations(raw_df)

    load_dataframe_to_sqlite(
        df=transformed_df,
        database_path=config.database_path,
        table_name=config.table_name
    )

    execute_sql_file(
        database_path=config.database_path,
        sql_file_path=config.sql_path
    )

if __name__ == "__main__":
    main()