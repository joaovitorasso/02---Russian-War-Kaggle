import pandas as pd
from pathlib import Path

def extract_csv(file_path: Path) -> pd.DataFrame:
    """Extract data from a CSV file and return it as a pandas DataFrame."""
    return pd.read_csv(file_path)
