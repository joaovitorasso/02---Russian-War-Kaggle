import pandas as pd


EXPECTED_COLUMNS = [
    "date",
    "day",
    "aircraft",
    "helicopter",
    "tank",
    "APC",
    "field artillery",
    "MRL",
    "military auto",
    "fuel tank",
    "drone",
    "naval ship",
    "anti-aircraft warfare",
    "special equipment",
    "mobile SRBM system",
    "greatest losses direction",
    "vehicles and fuel tanks",
    "cruise missiles",
    "submarines",
    "ground robotic systems",
]


COLUMN_MAPPING = {
    "date": "loss_date",
    "day": "war_day",
    "aircraft": "aircraft",
    "helicopter": "helicopter",
    "tank": "tank",
    "APC": "apc",
    "field artillery": "field_artillery",
    "MRL": "mrl",
    "military auto": "military_auto",
    "fuel tank": "fuel_tank",
    "drone": "drone",
    "naval ship": "naval_ship",
    "anti-aircraft warfare": "anti_aircraft_warfare",
    "special equipment": "special_equipment",
    "mobile SRBM system": "mobile_srbm_system",
    "greatest losses direction": "greatest_losses_direction",
    "vehicles and fuel tanks": "vehicles_and_fuel_tanks",
    "cruise missiles": "cruise_missiles",
    "submarines": "submarines",
    "ground robotic systems": "ground_robotic_systems",
}


NUMERIC_COLUMNS = [
    "war_day",
    "aircraft",
    "helicopter",
    "tank",
    "apc",
    "field_artillery",
    "mrl",
    "military_auto",
    "fuel_tank",
    "drone",
    "naval_ship",
    "anti_aircraft_warfare",
    "special_equipment",
    "mobile_srbm_system",
    "vehicles_and_fuel_tanks",
    "cruise_missiles",
    "submarines",
    "ground_robotic_systems",
]


TEXT_COLUMNS = [
    "greatest_losses_direction",
]


def validate_raw_columns(df: pd.DataFrame) -> None:
    """Validate if the raw DataFrame has the expected columns."""

    missing_columns = [
        column for column in EXPECTED_COLUMNS
        if column not in df.columns
    ]

    extra_columns = [
        column for column in df.columns
        if column not in EXPECTED_COLUMNS
    ]

    if missing_columns:
        raise ValueError(f"Colunas ausentes no CSV: {missing_columns}")

    if extra_columns:
        raise ValueError(f"Colunas inesperadas no CSV: {extra_columns}")


def validate_transformed_columns(df: pd.DataFrame) -> None:
    """Validate if the transformed DataFrame has the expected final columns."""

    expected_transformed_columns = list(COLUMN_MAPPING.values())

    missing_columns = [
        column for column in expected_transformed_columns
        if column not in df.columns
    ]

    extra_columns = [
        column for column in df.columns
        if column not in expected_transformed_columns
    ]

    if missing_columns:
        raise ValueError(f"Colunas transformadas ausentes: {missing_columns}")

    if extra_columns:
        raise ValueError(f"Colunas transformadas inesperadas: {extra_columns}")


def validate_transformed_types(df: pd.DataFrame) -> None:
    """Validate final DataFrame column types."""

    if not pd.api.types.is_datetime64_any_dtype(df["loss_date"]):
        raise TypeError("A coluna 'loss_date' deveria ser datetime.")

    for column in NUMERIC_COLUMNS:
        if not pd.api.types.is_integer_dtype(df[column]):
            raise TypeError(f"A coluna '{column}' deveria ser inteiro.")

    for column in TEXT_COLUMNS:
        if not pd.api.types.is_string_dtype(df[column]):
            raise TypeError(f"A coluna '{column}' deveria ser texto.")