import sqlite3
from pathlib import Path

import pandas as pd


def create_connection(database_path: Path):
    """Create a SQLite database connection."""

    database_path.parent.mkdir(parents=True, exist_ok=True)
    return sqlite3.connect(database_path)


def load_dataframe_to_sqlite(
    df: pd.DataFrame,
    database_path: Path,
    table_name: str
) -> None:
    """Load a pandas DataFrame into a SQLite table."""
    
    conn = create_connection(database_path)

    try:
        df.to_sql(
            name=table_name,
            con=conn,
            if_exists="replace",
            index=False
        )

        print(f"Dados carregados com sucesso na tabela '{table_name}'.")
        print(f"Total de linhas carregadas: {len(df)}")
        print(f"Banco SQLite: {database_path}")

    finally:
        conn.close()