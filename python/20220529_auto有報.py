from datetime import datetime, timedelta
from datetime import date
from dateutil.relativedelta import relativedelta
import glob
import os

import pandas as pd
pd.reset_option('display.max_rows')
print(pd.options.display.max_rows)
pd.reset_option('display.max_columns')
print(pd.options.display.max_columns)
import numpy as np
import stock_research as sr

EDINET_API_URL = "https://disclosure.edinet-fsa.go.jp/api/v1"
ORIGNAL_DATA_PATH = '../warehouse/stock/original_data/'
ymd_list = [i.split('\\')[-1] for i in glob.glob(ORIGNAL_DATA_PATH+'2*')]
last_ym = (datetime.strptime(min(ymd_list),'%Y-%m-%d') + relativedelta(months=-1)).strftime('%Y%m')
last_ymd_first = last_ym +'01'
last_ymd_last = (datetime.strptime(last_ym,'%Y%m') + relativedelta(months=1,days=-1)).strftime('%Y%m%d')
last_ymd_first,last_ymd_last

DOC_TYPE_CODE=['120']
SUMMARY_TYPE = 2
# start_date = datetime(
#     int(last_ymd_first[:4]),
#     int(last_ymd_first[4:6]),
#     int(last_ymd_first[-2:]))
# end_date = datetime(
#     int(last_ymd_last[:4]),
#     int(last_ymd_last[4:6]),
#     int(last_ymd_last[-2:]))
start_date = datetime(2021,11,16)
end_date = datetime(2021,11,30)

print(f'{start_date}~{end_date}間の有価証券報告書取得')
i = -1
SAVE_PATH = '../warehouse/stock/created/'
for i, date in enumerate(sr.date_range(start_date, end_date)):
    date_str = str(date)[:10]
    df_doc_summary = sr.download_all_documents(date_str, ORIGNAL_DATA_PATH, EDINET_API_URL,
                                                   SUMMARY_TYPE, DOC_TYPE_CODE)
    if i == 0:
        df_doc_summary_all = df_doc_summary.copy()
    else:
        df_doc_summary_all = pd.concat([df_doc_summary_all, df_doc_summary])
    print(date_str,df_doc_summary_all.shape)


print('original_data配下のすべてのcsvをconcat')
ymd_list = [i.split('\\')[-1] for i in glob.glob(ORIGNAL_DATA_PATH+'2*')]
start_date = datetime(int(min(ymd_list)[:4]),int(min(ymd_list)[5:7]),int(min(ymd_list)[8:]),)
end_date = datetime(int(max(ymd_list)[:4]),int(max(ymd_list)[5:7]),int(max(ymd_list)[8:]))

print(min(ymd_list),max(ymd_list))
sdate = start_date.strftime('%Y%m%d')
edate = end_date.strftime('%Y%m%d')
CSV_NAME = f'submitted_doc_list_{sdate}_{edate}.csv'

for date in sr.date_range(start_date, end_date):
    date_str = str(date)[:10]
    tmppath = ORIGNAL_DATA_PATH + date_str + '/doc_summary.csv'
    if os.path.exists(tmppath):
        i+=1
        df_doc_summary = pd.read_csv(ORIGNAL_DATA_PATH + date_str + '/doc_summary.csv')
        if i == 0:
            df_doc_summary_all = df_doc_summary.copy()
        else:
            df_doc_summary_all = pd.concat([df_doc_summary_all, df_doc_summary])
df_doc_summary_all.to_csv(SAVE_PATH+CSV_NAME,index=False)   

print('銘柄以外の情報を落とし、業種などの情報を付与')
SAVE_PATH = '../warehouse/stock/created/'
STOCK_MST_PATH = '../warehouse/stock/original_data/stock_code_list/data_j(202204_last).csv'
stock_mst = pd.read_csv(STOCK_MST_PATH)
stock_mst.rename(columns={'コード': 'secCode'},inplace=True)
df = pd.read_csv(SAVE_PATH+CSV_NAME)
df = df.dropna(subset=['secCode'])
df.secCode = df.secCode.astype(int)//10
df = pd.merge(df,stock_mst,how='left')

CSV_NAME_STOCK_ONLY = f'submitted_doc_list_only_stock_{sdate}_{edate}.csv'
df.to_csv(SAVE_PATH+CSV_NAME_STOCK_ONLY,index=False)
print(SAVE_PATH+CSV_NAME_STOCK_ONLY)
df = pd.read_csv(SAVE_PATH+CSV_NAME_STOCK_ONLY)

import winsound
winsound.Beep(frequency=500, duration=10000)