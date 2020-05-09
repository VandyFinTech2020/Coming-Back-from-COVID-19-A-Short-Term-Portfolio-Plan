import numpy as np
import pandas as pd
from sqlalchemy import create_engine

# connectionString = "dbname='project01' user='pgadmin@fintech-postgres' host='fintech-postgres.postgres.database.azure.com' password='CgYRz!)[4pfB' port='5432' sslmode='true'"

engine = create_engine(
    "postgresql://pgadmin@fintech-postgres:CgYRz!)[4pfB@fintech-postgres.postgres.database.azure.com:5432/project01")

query = """
select portfolio_name, weight, "date" as close_date,
	close_price, ticker_name, covidineffect
from portfolio p
    inner join portfolio_tickers pt
	on p.portfolio_id = pt.portfolio_id
	inner join price
	on pt.ticker_id = price.ticker_id
;"""

df = pd.read_sql(query, engine, index_col='_id')
print(df.head())

df2 = df.pivot(index="close_date", columns=['portfolio_name', 'ticker_name'], values="close_price")
print(df2.head())