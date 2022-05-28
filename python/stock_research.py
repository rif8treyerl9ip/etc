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
import plotly.graph_objects as go

from arelle.ModelValue import qname
from arelle import Cntlr


# タクソノミ用ソリストの下記は営業利益とあるが、本当はOperatingIncomeらしい。
# まじで意味わからぬ。
# 'Operating profit (loss)':'営業利益'

taiouhyou = {'NetSalesSummaryOfBusinessResults':'売上高',
             'OperatingIncome':'営業利益',
             'NetCashProvidedByUsedInOperatingActivitiesSummaryOfBusinessResults':'営業キャッシュフロー'
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

def read_xbrl(file_path,stock_code) -> pd.DataFrame:
    ctrl = Cntlr.Cntlr(logFileName='logToPrint')
    modelXbrl = ctrl.modelManager.load(file_path)
    
    fact_df = pd.DataFrame(
    data=[(
        fact.concept.qname.localName, 
        fact.value,
        fact.isNumeric, 
        fact.contextID,
        fact.concept.label(preferredLabel=None, lang='ja', linkroleHint=None),
        fact.concept.label(preferredLabel=None, lang='en', linkroleHint=None),
        fact.context.startDatetime,
        fact.context.endDatetime,
        fact.context.instantDatetime,
        fact.decimals,
    ) for fact in modelXbrl.facts],
    columns=[
        "element_id", 
        "value",
        "isNumeric", 
        "contextID",
        "Ja_item_name",
        "en_item_name",     
        "startDatetime",
        "endDatetime",
        "instantDatetime",
        "decimals",
    ])
    return fact_df

def calc_fiscal_year(prior_year, asof):
    print(prior_year,asof)
    print(int(asof.year - prior_year),asof.month, asof.day)
    print(date(int(asof.year - prior_year),asof.month, asof.day))
    # return datetime.date(int(asof.year - prior_year),asof.month, asof.day)
    return date(int(asof.year - prior_year),asof.month, asof.day)
    


def get_key(df,key):
    df = df.query(f'element_id == "{key}"')

    if key == 'OperatingIncome':
        df = exclusion(df)
    
    # plotのためにfloat型に変換
    df['value'] = df['value'].astype(float)

    return df

def exclusion(df):
    mask = df['contextID'].str.contains('jpcrp')
    df = df[~mask]
    mask = df['contextID'].str.contains('TotalOf')
    df = df[~mask]
    mask = df['contextID'].str.contains('Rep')
    df = df[~mask]
    return df

# def get_OperatingIncome(df,key):
#     tmp = df.query(f'element_id == "{key}"')
#     mask = tmp['contextID'].str.match('^(?!.*\_).+$')
#     mask = mask.astype(int)
#     tmp['value'] = tmp['value'].astype(float)

#     return tmp

# def get_get_eigyo_cashflow(df,key):
#     tmp = df.query(f'element_id == "{key}"')
#     tmp['value'] = tmp['value'].astype(float)

#     return tmp

def save_stock_statistics(df):
    '''csvとして保存するための後処理'''
    df = df.drop_duplicates()
    min_date = df.endDatetime.min().strftime('%Y%m%d')
    max_date = df.endDatetime.max().strftime('%Y%m%d')
    
    df['lag'] = df.groupby(['secCode','element_id','NonConsolidated'])['value'].shift(1)
    # 「100%」などと整形する
    df['Yoy'] = ((df['value']/df['lag']*100).astype(str).str[:3]+'%').replace('nan%','').replace('\.', '', regex=True)    

    # df.to_csv(f'../warehouse/stock/created/result_statistics/stock_statistics_{min_date}_{max_date}.csv',index=False)
    
    return df

def make_ratio(df,x,y,z):
    df[f'{z}'] = ((df[f'{x}']/df[f'{y}']*100).astype(str).str[:3]+'%').replace('nan%','').replace('\.', '', regex=True)
    return df

def make_operatingincome_margin(df):
    a = df.query('element_id == "NetSalesSummaryOfBusinessResults"').rename(columns={'value': 'value_sales'})
    a = a[['element_id','value_sales','endDatetime','NonConsolidated']]
    b = df.query('element_id == "NetCashProvidedByUsedInOperatingActivitiesSummaryOfBusinessResults"').rename(columns={'value': 'value_operatingincome'})
    b = b[['value_operatingincome','endDatetime','NonConsolidated']]
    tmp = pd.merge(a,b, on=['endDatetime','NonConsolidated'],how='left')
    tmp = make_ratio(tmp,'value_operatingincome','value_sales','operatingincome_margin')
    tmp.drop('value_operatingincome',axis=1,inplace=True)

    df = pd.merge(df,tmp,on=['element_id','endDatetime','NonConsolidated'],how='left')
    df['operatingincome_margin'].replace(np.nan,'',inplace=True)
    
    return df

def plotly_plot(x,y,title,YoY=None):
    fig = go.Figure()
    if YoY is not None:
        fig.add_trace(go.Bar(x=x,y=y,text=YoY,marker_color='#ffffff'))
        fig.update_layout(title=f'{title}')
    else:
        fig.add_trace(go.Bar(x=x,y=y,marker_color='#ffffff'))
        fig.update_layout(title=f'{title}')
    fig.show()

def make_YoY(y):
    # yがvalueなので昨年のvalueを求めて昨対比を計算
    '''
    y_lag:当年のvalue
    y_lag:昨年のvalue
    '''
    y_lag = y.shift(1)
    YoY = ((y/y_lag*100//1).astype(str)+'%').reset_index(drop=True)
    YoY[0] = ""

    return YoY