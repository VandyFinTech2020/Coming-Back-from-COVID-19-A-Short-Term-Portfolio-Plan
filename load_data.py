import pandas as pd
from sqlalchemy import create_engine

# connectionString = "dbname='project01' user='pgadmin@fintech-postgres' host='fintech-postgres.postgres.database.azure.com' password='CgYRz!)[4pfB' port='5432' sslmode='true'"

engine = create_engine(
    "postgresql://pgadmin@fintech-postgres:CgYRz!)[4pfB@fintech-postgres.postgres.database.azure.com:5432/project01")

query = "select * from portfolio;"

df = pd.read_sql(query, engine, index_col='portfolio_id')
print(df.head())
