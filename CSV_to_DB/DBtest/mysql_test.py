import csv
import pandas as pd
from sqlalchemy import create_engine, types
import pymysql
pymysql.install_as_MySQLdb()

engine = create_engine('mysql://root:q@localhost:3306/test')

df = pd.read_csv("test1.csv")
print(df)
df.to_sql('testdemo',con=engine,index=False,if_exists='replace')
print('导入成功')