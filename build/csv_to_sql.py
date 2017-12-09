from sqlalchemy import create_engine
import pandas as pd

engine = create_engine('postgresql://postgres@localhost/postgres')
df = pd.read_csv('file')
df.to_sql('dp_tract_2010', engine)