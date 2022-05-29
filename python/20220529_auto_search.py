import datetime
import glob
import os

from arelle.ModelValue import qname
from arelle import Cntlr
import numpy as np

import pandas as pd

import stock_research as sr
taiouhyou = sr.taiouhyou
import warnings
warnings.filterwarnings('ignore')

result_path = '../warehouse/stock/created/result_statistics/stock_*.csv'
# print([i.split('\\')[-1] for i in glob.glob(result_path)])
RESULT_CSV = min([i.split('\\')[-1] for i in glob.glob(result_path)])
RESULT_PATH = f'../warehouse/stock/created/result_statistics/{RESULT_CSV}'
print(f'''最前期~最新期: {RESULT_CSV.split('.')[0][-8:]}~{RESULT_CSV.split('.')[0][-17:-9]}''')


result = pd.read_csv(RESULT_PATH)

today = datetime.datetime.today().strftime('%Y%m%d')
filepath = f'../warehouse/stock/created/result_statistics/{today}_report.txt'
TH_OPEMARGIN = 35
TH_SALES_CAGR = 1.20
SENTENCE = f'\n報告日 {today} 基準値\n営業CFマージン {TH_OPEMARGIN}%\tCAGR {int(TH_SALES_CAGR*100)}%'+'\n'
SENTENCE = today + SENTENCE

with open(filepath, mode='a') as f:
    f.write(SENTENCE)

res_dict = {}
for stock in result.secCode.unique():
    res_dict[f'{stock}'] = {}
    sdf = result.query(f'secCode=={stock}')
    filerName = sdf.filerName.reset_index(drop=True)[0]
    s = f'''{stock} {filerName}\n'''
    
    # 足切り 純利益が赤字
    
    # 営業キャッシュフローマージンが平均40%以上
    mean_1 = sdf.operatingincome_margin.replace('%','',regex=True).astype(float).mean()
    count_1 = sdf.operatingincome_margin.replace('%','',regex=True).astype(float).count()
    
    if mean_1 > TH_OPEMARGIN:
        s1 = f'''{s} {count_1}年 {mean_1:.2f}% > {TH_OPEMARGIN}%\n'''
        # print(s1)
        res_dict[f'{stock}']['opeCF']=[count_1,mean_1]
        # with open(filepath, mode='a') as f:
        #     f.write(s1)

    #############################################################
    # 連結会計
    tmp = sdf.query('NonConsolidated==0')
    tmp = tmp.query('element_id=="NetSalesSummaryOfBusinessResults"')
    
    if len(tmp)<2:
        continue
    
    # 幾何平均
    gmean_2 = (((tmp.Yoy.replace('%','',regex=True).astype(float)/100)[1:].cumprod(axis=0)[-1:]**(1/len((tmp.Yoy)[1:]))).values[0])
    count_2 = tmp.Yoy.replace('%','',regex=True).astype(float).count()
    if gmean_2 > TH_SALES_CAGR:
        s2 = f'''{s} CAGR({count_2}) {gmean_2:.3f}% > {TH_SALES_CAGR}%\n'''
        # print(s2)
        res_dict[f'{stock}']['CAGR']=[count_2,gmean_2]
        # with open(filepath, mode='a') as f:
        #     f.write(s2)
    #############################################################
    
    if (gmean_2 > TH_SALES_CAGR) and (mean_1 > TH_OPEMARGIN):
        ss = f'''{s}CAGR({count_2}) > {gmean_2:.3f}\n営業CFマージン{TH_OPEMARGIN} {count_1}年 {mean_1:.2f}% > {TH_SALES_CAGR}%\n'''
        with open(filepath, mode='a') as f:
            f.write(ss)
    
    res_dict

import winsound
winsound.Beep(frequency=500, duration=200)