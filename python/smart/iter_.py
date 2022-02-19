# リスト などから イテレータ を 取得 する には 組み込み 関数 iter()
l = [1, 2, 3] 
it = iter(l) 
# iter() 関数 で イテレータ が 得 られる オブジェクト の こと を、 イテラブル な オブジェクト 
print(it)
print(iter(dict()))
print(iter(set()))
print(iter(' abc'))
l = [1, 2, 3] 
it = iter(l) 
print(next(it))
print(next(it))
print(next(it))
print(next(it))