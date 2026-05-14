from dataclasses import dataclass
from pathlib import Path


@dataclass(frozen=True)
class AppConfig:
    csv_path: Path
    database_path: Path
    table_name: str