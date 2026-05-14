import yaml
from pathlib import Path

from src.models import AppConfig

CONFIG_FILE = Path("configs/config.yaml")


def load_config() -> AppConfig:
    with CONFIG_FILE.open("r", encoding="utf-8") as file:
        config_data = yaml.safe_load(file)
        
        return AppConfig(
            csv_path=Path(config_data["paths"]["csv_path"]),
            database_path=Path(config_data["paths"]["database_path"]),
            table_name=config_data["database"]["table_name"]
        )


def get_csv_path() -> Path:
    config = load_config()
    return Path(config["paths"]["csv_path"])


def get_database_path() -> Path:
    config = load_config()
    return Path(config["paths"]["database_path"])


def get_table_name() -> str:
    config = load_config()
    return config["database"]["table_name"]