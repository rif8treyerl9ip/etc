def append_print(item, list_= None):
    # 変数 が None だっ た とき は 空 の リスト を 代入 し 直す
        list_ = []          # list_ = list_ or [] といった 書き方 も できる 
        list_.append(item)
        print(list_)

def main(): 
    append_print('A')
    append_print('B')
    append_print('C')

if __name__ == '__main__': main()