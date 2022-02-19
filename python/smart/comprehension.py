print([i for i in range(10)])
print([i for i in range(10) for j in range(5)])

print({i for i in range(10)})
print({i for i in range(10) for j in range(5)})
print({i**2 for i in range(10)})

# ord 1文字のUnicode文字を表す文字列に対し、その文字のUnicodeコードポイントを表す整数を返します
# chr Unicode コードポイントが整数 i である文字を表す文字列を返す
print({i: chr(i) for i in range(ord('a'), ord('f') + 1)})

print((i for i in range(10)))
