import pandas as pd


arquivo = "data/russia_losses_equipment.csv"

df = pd.read_csv(arquivo)

print(df.columns)