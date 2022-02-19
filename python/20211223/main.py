from google.cloud import bigquery
from pprint import pprint

from pandas.core.frame import DataFrame
import settings

# set GOOGLE_APPLICATION_CREDENTIALS=C:/Users/thyt/.Credentials/gcpyoutube-c80710c5139b.json
dataset_id = settings.dataset_id

client = bigquery.Client()
dataset = client.get_dataset(dataset_id)
tables = client.list_tables(dataset)
if tables:
    for obj in tables:
        print('-------->')
        pprint(vars(obj))
else:
    print("\tThis dataset does not contain any tables.")

table_id = 'gcpyoutube.youtubedata.yobinori_desc'
table = client.get_table(table_id)  # Make an API request.

# Specify selected fields to limit the results to certain columns.
# テーブルの情報をとる
table = client.get_table(table_id)  # Make an API request.
# 今回はスキーマすべて使うのでコメントアウト
# fields = table.schema[:2]  # First two columns.
# テーブルの行をイテレータでとる
rows_iter = client.list_rows(table_id)
# リストに入れる
rows = list(rows_iter)
set_of_tags_for_table = []
for row in rows:
    tags = row[5]
    set_of_tags_for_table.extend(tags[1:-1].split(', '))

from collections import Counter
# print(Counter(set_of_tags_for_table))
import pandas as pd
ranking = (pd.DataFrame.from_dict(Counter(set_of_tags_for_table),orient='index')).rename(columns={0:'Number_of_uses'})
ranking = ranking.sort_values('Number_of_uses',ascending=False)
ranking_top30 = ranking[:30]
ranking_top30['tag'] = (ranking_top30.index)
ranking_top30 = ranking_top30.reset_index(drop=True)
ranking_top30 = ranking_top30.reindex(columns=['tag', 'Number_of_uses'])
print(ranking_top30)

# import matplotlib.pyplot as plt
# plt.bar(x=ranking_top30.index,height=ranking_top30['使用回数'])
# plt.show()


# 目的のデータに加工できたのでテーブルを作ります。
# Creating a Table
# Create an empty table with the create_table() method:

# Construct a BigQuery client object.
client = bigquery.Client()

# TODO(developer): Set table_id to the ID of the table to create.
table_id = "gcpyoutube.youtubedata.top30_used_tag"

schema = [
    bigquery.SchemaField("tag", "STRING", mode="REQUIRED"),
    bigquery.SchemaField("Number_of_uses", "INTEGER", mode="REQUIRED"),
]

# table = bigquery.Table(table_id, schema=schema)
# table = client.create_table(table)  # Make an API request.
# print(
#     "Created table {}.{}.{}".format(table.project, table.dataset_id, table.table_id)
# )

# テーブルが作成できました。後はテーブルにdataframeを書き込むだけです。
# Construct a BigQuery client object.
table_id = "gcpyoutube.youtubedata.top30_used_tag"
client = bigquery.Client()
client.insert_rows_from_dataframe(
    table=client.get_table(table_id),dataframe=ranking_top30\
    )