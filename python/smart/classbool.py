 
import random  
class MyClass( object):
    #  __nonzero__を介して__bool__を呼ぶとpythonの両方のバージョンに対応できる
    def __bool__( self):  # 3系では__bool__がクラスの真偽値判定に呼ばれる
        return random. choice([ True, False]) 
    def __nonzero__( self):  # 2系では__nonzero__がクラスの真偽値判定に呼ばれる
        return self.__bool__() 
      
obj = MyClass()  
print(bool(obj))
print(bool(obj))
print(bool(obj))