import argparse

# if __name__ == '__main__':
#     parser = argparse.ArgumentParser()
#     parser.add_argument('date',help='ここには日付を入力してください')
#     parser.add_argument('Lang',choices=['Eng','Jap'])
#     parser.add_argument('words',nargs=3,help='3つの値をリストとして受け取ります')
#     args = parser.parse_args()
#     print(args.date)
#     print(args.Lang)
#     print(args.words)

# if __name__ == '__main__':
#     parser = argparse.ArgumentParser()
#     parser.add_argument('-t','--target')
#     parser.add_argument('-t2','--target2',default='defaultdesu')
#     parser.add_argument('-mt','--must_target',required=True)
#     args = parser.parse_args()
#     print(args.target)
#     print(args.target2)
#     print(args.must_target)
    
#     # PS C:\Users\thyt\arakus_kensyu\python\自習\normal> python .\argparse_tuto.py -t hoge -t2 hoge -mt hoge
#     # hoge
#     # hoge
#     # hoge

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-t','--target')
    parser.add_argument('-t2','--target2',default='defaultdesu')
    print(type(parser.parse_args()))
    print(parser.parse_args())
    args = parser.parse_args()
    print(args.target)
    
    # PS C:\Users\thyt\arakus_kensyu\python\自習\normal> python .\argparse_tuto.py -t hoge -t2 hoge -mt hoge
    # hoge
    # hoge
    # hoge