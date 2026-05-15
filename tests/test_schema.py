import pandas as pd

from src.schema import validate_raw_columns


def test_validate_raw_columns_success():
    df = pd.DataFrame(columns=[
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
    ])

    validate_raw_columns(df)