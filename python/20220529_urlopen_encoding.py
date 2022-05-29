#!/usr/bin/env python
# coding: utf-8
import sys
import urllib
from urllib.request import urlopen

url = "https://gihyo.jp/dp"
headers = {
"User-Agent": "Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:47.0) Gecko/20100101 Firefox/47.0"
}

request = urllib.request.Request(url, headers=headers)
f = urlopen(request)

# gihyoはutf-8を使用、charsetが明示されていなければutf-8
f.getheader('ConTent-Type')
encoding = f.info().get_content_charset(failobj="utf-8")
text = f.read().decode(encoding)

with open('bbbbb.txt',encoding='utf-8', mode='w') as f:
    f.write(text)
