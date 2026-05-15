from datetime import datetime
from pathlib import Path

from airflow.decorators import dag, task

from src.extract import extract_csv
from src.helpers import load_config
from src.load import execute_sql_file, load_dataframe_to_sqlite
from src.transform import execute_transformations


@dag(
    dag_id="russian_war_etl_by_step",
    description="ETL pipeline for Russian war equipment losses dataset",
    start_date=datetime(2024, 1, 1),
    schedule=None,
    catchup=False,
    tags=["etl", "pandas", "sqlite", "portfolio"],
)
def russian_war_etl_by_step():

    @task
    def etl_task() -> str:
        config = load_config()

        raw_df = extract_csv(config.csv_path)
        transformed_df = execute_transformations(raw_df)

        load_dataframe_to_sqlite(
            df=transformed_df,
            database_path=config.database_path,
            table_name=config.table_name,
        )

        return str(config.database_path)

    @task
    def create_views_task(database_path: str) -> None:
        config = load_config()

        execute_sql_file(
            database_path=Path(database_path),
            sql_file_path=config.sql_path,
        )

    database_path = etl_task()
    create_views_task(database_path)


russian_war_etl_by_step()
