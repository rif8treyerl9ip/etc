'''
作成物直下のyyyymmddから始まるファイルの日付を今日の日付に置き換えるスクリプト。
yyyymmddと1文字以上含むディレクトリも取得してしまうが、そのようなディレクトリが存在するケースで使用不可。

'''

import glob
import re
import os
import datetime


today = datetime.datetime.today().strftime('%Y%m%d')
FILE_DIR = 'C:/Users/thyt/SELF_S/shellscrpt/test/日本語ディレクトリ'  # 作成物へのパス
filepath = glob.glob(f'{FILE_DIR}/*')
pattern = re.compile(r'[0-9]{8}.*') # yyyymmddと1文字以上で構成されるファイルとディレクトリにマッチ

for file in filepath:
    # print(file.split('\\')[1])
    filename = file.split('\\')[1]

    if None != pattern.match(filename):
        filepath_ = (file.split('\\')[0]+'/'+file.split('\\')[1])
        savename = today+filename[8:]  # yyyymmdd以降の文字列
        os.rename(f'{filepath_}', f'{FILE_DIR}/{savename}')
        print(f'{filename}を{savename}に変更した')
