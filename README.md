# Russian War Losses ETL

Projeto de engenharia de dados desenvolvido em Python para extrair, transformar e carregar dados de perdas de equipamentos na guerra Rússia-Ucrânia.

## Objetivo

Construir um pipeline ETL simples, organizado em camadas, que lê um arquivo CSV, aplica transformações com pandas e carrega o resultado em um banco SQLite.

## Tecnologias utilizadas

- Python
- Pandas
- SQLite
- UV
- PyYAML

## Estrutura do projeto

```text
RussianWar/
├── configs/
│   └── config.yaml
├── data/
│   └── .gitkeep
├── database/
│   └── .gitkeep
├── src/
│   ├── __init__.py
│   ├── extract.py
│   ├── transform.py
│   ├── load.py
│   ├── models.py
│   ├── schema.py
│   └── helpers.py
├── main.py
├── .gitignore
├── README.md
├── pyproject.toml
└── uv.lock