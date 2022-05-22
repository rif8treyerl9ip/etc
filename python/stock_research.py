from datetime import datetime, timedelta
import os
import requests
import sys
# sys.path.append('./')
import zipfile

import numpy as np
import pandas as pd
pd.set_option('display.max_columns',100)
pd.set_option('display.max_rows',1000)
import matplotlib.pyplot as plt
plt.style.use('ggplot')
import seaborn as sns; sns.set();

# タクソノミ用ソリストの下記は営業利益とあるが、本当はOperatingIncomeらしい。
# まじで意味わからぬ。
# 'Operating profit (loss)':'営業利益'

taiouhyou = {'NetSalesSummaryOfBusinessResults':'売上高',
             'OperatingIncome':'営業利益'
}






def date_range(start_date: datetime, end_date: datetime):
    diff = (end_date - start_date).days + 1
    return (start_date + timedelta(i) for i in range(diff))

def get_submitted_summary(params, edinet_url):
    '''
    提出書類一覧を取得
    '''
    url = edinet_url + '/documents.json'
    print(url)
    response = requests.get(url, params=params)
    # responseが200でなければエラーを出力
    assert response.status_code==200
    return response.json()

def get_document(doc_id, params,edinet_url):
    url = edinet_url + '/documents/' + doc_id
    response = requests.get(url, params)
    return response

def download_document(doc_id, save_path, edinet_url):
    '''typeは1が本文書、2がPDF、1の本文書を取得'''
    params = {'type': 1}
    doc = get_document(doc_id, params, edinet_url)
    if doc.status_code == 200:
        with open(save_path + doc_id + '.zip', 'wb') as f:
            for chunk in doc.iter_content(chunk_size=1024):
                f.write(chunk)

def download_all_documents(date, save_path, edinet_url, SUMMARY_TYPE,
                           doc_type_codes=['120', '130', '140', '150', '160', '170']):
    params = {'date': date, 'type': SUMMARY_TYPE}
    doc_summary = get_submitted_summary(params, edinet_url)
    df_doc_summary = pd.DataFrame(doc_summary['results'])
    df_meta = pd.DataFrame(doc_summary['metadata'])
     
    # 対象とする報告書のみ抽出
    if len(df_doc_summary) >= 1:
        df_doc_summary = df_doc_summary.loc[df_doc_summary['docTypeCode'].isin(doc_type_codes)]
 
        # 一覧を保存
        if not os.path.exists(save_path + date):
            os.makedirs(save_path + date)
        df_doc_summary.to_csv(save_path + date + '/doc_summary.csv', index=False)
 
        # 書類を保存
        for _, doc in df_doc_summary.iterrows():
            download_document(doc['docID'], save_path + date + '/', edinet_url)
            open_zip_file(doc['docID'], save_path + date + '/')
        return df_doc_summary
     
    return df_doc_summary                
def open_zip_file(doc_id, save_path):
    if not os.path.exists(save_path):
        os.makedirs(save_path + doc_id)

    with zipfile.ZipFile(save_path + doc_id + '.zip') as zip_f:
        zip_f.extractall(save_path + doc_id)


from edinet_xbrl.edinet_xbrl_parser import EdinetXbrlParser
 
def get_one_xbrl_data(path, key, context_ref) -> str:
    parser = EdinetXbrlParser()
 
    ## 指定したxbrlファイルをパースする
    xbrl_file_path = path
    edinet_xbrl_object = parser.parse_file(xbrl_file_path)
 
    ## データの取得
    data = edinet_xbrl_object.get_data_by_context_ref(key, context_ref)
    if data is not None:
        return data.get_value()    

def get_xbrl_data(path, account_df) -> pd.DataFrame:
    parser = EdinetXbrlParser()
 
    ## parse xbrl file and get data container
    edinet_xbrl_object = parser.parse_file(path)
 
    ## データの取得
    account_df['value'] = ''
    for idx, account in account_df.iterrows():
        key = account['key']
        context_ref = account['context_ref']
        data = edinet_xbrl_object.get_data_by_context_ref(key,context_ref)
         
        if data is not None:
            account_df.loc[idx, 'value'] = data.get_value() 
 
    return account_df

def calc_fiscal_year(prior_year, asof):
    print(prior_year,asof)
    print(int(asof.year - prior_year),asof.month, asof.day)
    print(date(int(asof.year - prior_year),asof.month, asof.day))
    # return datetime.date(int(asof.year - prior_year),asof.month, asof.day)
    return date(int(asof.year - prior_year),asof.month, asof.day)
    