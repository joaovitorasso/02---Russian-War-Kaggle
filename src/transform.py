import pandas as pd

from src.schema import (
    COLUMN_MAPPING,
    NUMERIC_COLUMNS,
    TEXT_COLUMNS,
    validate_raw_columns,
    validate_transformed_columns,
    validate_transformed_types,
)


def transform_date(df: pd.DataFrame, date_column: str) -> pd.DataFrame:
    """Convert a date column to datetime format."""

    df[date_column] = pd.to_datetime(
        df[date_column],
        format="%Y-%m-%d",
        errors="raise"
    )

    return df


def rename_columns(df: pd.DataFrame, column_mapping: dict) -> pd.DataFrame:
    """Rename columns using a dictionary."""

    return df.rename(columns=column_mapping)


def transform_numeric_columns(
    df: pd.DataFrame,
    numeric_columns: list[str]
) -> pd.DataFrame:
    """Convert numeric columns to integer type."""

    for column in numeric_columns:
        df[column] = pd.to_numeric(
            df[column],
            errors="raise"
        ).astype("Int64")

    return df


def transform_text_columns(
    df: pd.DataFrame,
    text_columns: list[str]
) -> pd.DataFrame:
    """Convert text columns to string type."""

    for column in text_columns:
        df[column] = df[column].astype("string")

    return df


def execute_transformations(df: pd.DataFrame) -> pd.DataFrame:
    """Execute data transformations."""

    validate_raw_columns(df)

    df = transform_date(df, "date")

    df = rename_columns(df, COLUMN_MAPPING)

    df = transform_numeric_columns(df, NUMERIC_COLUMNS)

    df = transform_text_columns(df, TEXT_COLUMNS)

    validate_transformed_columns(df)

    validate_transformed_types(df)

    return df
