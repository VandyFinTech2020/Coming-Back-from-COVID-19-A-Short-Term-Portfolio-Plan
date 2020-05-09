import numpy as np
import pandas as pd
from sqlalchemy import create_engine

# connectionString = "dbname='project01' user='pgadmin@fintech-postgres' host='fintech-postgres.postgres.database.azure.com' password='CgYRz!)[4pfB' port='5432' sslmode='true'"

engine = create_engine(
    "postgresql://pgadmin@fintech-postgres:CgYRz!)[4pfB@fintech-postgres.postgres.database.azure.com:5432/project01")

query = "select * from portfolio;"
dfPortfolios = pd.read_sql(query, engine, index_col='portfolio_id')


def LoadCsvs(row):
    dfResult = pd.DataFrame()
    portfolio = row["portfolio_name"]
    path = "f:/_GIT/FinTech/Project01/"
    csvFeb = path + portfolio + "_feb.csv"
    csvApr = path + portfolio + "_apr.csv"
    dfFeb = pd.read_csv(csvFeb)
    dfApr = pd.read_csv(csvApr)
    inCovid = False
    for df_ in [dfFeb, dfApr]:
        for column in df_:
            if column == "Date":
                continue
            dfTmp = pd.DataFrame()
            dfTmp["date"] = df_["Date"].values
            dfTmp[column] = df_[column].values
            dfTmp = dfTmp.rename(columns={column: "close_price"})
            query = f"select * from ticker where ticker_name = '{column}';"
            dfTickers = pd.read_sql(query, engine)
            ticker_id = dfTickers["ticker_id"][0]
            dfTmp["ticker_id"] = ticker_id
            dfTmp["ticker_name"] = column
            dfTmp["covidineffect"] = inCovid
            print(dfTmp.head(2))
            dfResult = dfResult.append(dfTmp, ignore_index=True)
        inCovid = True
    return dfResult


dfMain = pd.DataFrame()
for i, row in dfPortfolios.iterrows():
    dfMain = dfMain.append(LoadCsvs(row), ignore_index=True)
print(dfMain.count())
print(dfMain.head())


dfMain = dfMain[["ticker_id", "date",
                 "close_price", "ticker_name", "covidineffect"]]
print(dfMain.head())
print(dfMain.count(2))

# dfMain.to_sql('price', engine, if_exists='replace', index = False)
dfMain.to_sql('price', engine, if_exists='append', index=False)
