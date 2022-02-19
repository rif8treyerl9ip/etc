# Python 2.x で print() 関数 を 使う のに 必要
from __future__ import print_function
class MyIterator(object):
    """連続した整数を返すイテレータクラス"""
    def __init__(self, stop =- 1, start = 0): 
        self.stop = stop
        self._current = start 


    def __iter__(self):
        """イテレータオブジェクトを返すここでは自分自身(self)を返している """
        return self 


    def __next__(self):
        """次に取り出す要素を返すもう次の要素がないときにはStopIteration例外を上げる """
        if self._current >= self.stop:
            raise StopIteration()
        result = self._current
        self._current += 1
        return result 


    def next(self): # Python2.xでは__next__()の代わりにnext()メソッドが必要
        return self.__next__() 



def main():
    it = MyIterator(10)
    # print(it.__iter__())
    for i in it:
        print(i.next())
        # print(i, end =' ')
    print()


if __name__ == '__main__':
    main()