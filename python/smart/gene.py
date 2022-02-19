def generator_sample():
    yield 1
    yield 2
    yield 3 

def main():
    # ジェネレータからイテレータオブジェクトを生成 
    it = generator_sample()
    for i in it:
        print( i, end =' ')
    print()

if __name__ == '__main__':
    main()